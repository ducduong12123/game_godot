extends Node2D

const GameData = preload("res://scripts/content/game_data.gd")
const MapData = preload("res://scripts/content/map_data.gd")
const StoryRules = preload("res://scripts/content/story_rules.gd")
const SurvivalSystem = preload("res://scripts/systems/survival_system.gd")
const EventSystem = preload("res://scripts/systems/event_system.gd")
const AITutorService = preload("res://scripts/systems/ai_tutor_service.gd")

const WorldModule = preload("res://scripts/modules/world_module.gd")
const GameplayModule = preload("res://scripts/modules/gameplay_module.gd")
const UIModule = preload("res://scripts/modules/ui_module.gd")
const AIModuleStub = preload("res://scripts/modules/ai_module_stub.gd")

const WORLD_RECT := MapData.WORLD_RECT
const INTERACT_RANGE := 42.0
const AI_TIMEOUT_SEC := 12.0

var turn := 1
var max_turns := 18

var battery := SurvivalSystem.BATTERY_MAX
var temp := 20.0
var ambient_temp := -30.0
var o2 := 70.0
var hydration := 75.0
var satiety := 70.0
var hp := SurvivalSystem.HP_MAX

var repair_progress := 0.0
var repair_stage_index := 0
var repair_stages := StoryRules.repair_stages()

var actions_left := 3
var game_over := false
var win := false
var death_reason := ""
var mission_started := false
var status_line := StoryRules.WAITING_STATUS

var last_event_title := "Ổn định"
var last_event_description := "Chưa có sự cố nào."

var allocation := {"heater": 0, "oxygen": 0, "water": 0, "food": 0}

var player_pos := Vector2(120, 120)
var player_speed := 240.0
var terminal_pos := MapData.TERMINAL_POS
var near_item_index := -1
var inventory: Array[String] = []

var rooms := MapData.room_rects()
var doors := MapData.create_doors()
var items := GameData.create_items()
var puzzles := GameData.create_puzzles()
var craft_recipes := GameData.craft_recipes()
var current_puzzle_index := 0
var puzzle_open := false
var active_modules := {}

var rng := RandomNumberGenerator.new()

var ai_api_key := ""
var ai_model := AITutorService.DEFAULT_MODEL
var ai_pending := false
var ai_last_topic := "formula"
var ai_last_fallback := ""
var ai_topics := AITutorService.TOPICS.duplicate()

var allocation_spins := {}
var puzzle_option_buttons: Array[Button] = []

var status_label: Label
var alloc_hint_label: Label
var inventory_label: Label
var craft_recipe_option: OptionButton
var craft_recipe_desc_label: Label
var prompt_label: Label
var objective_label: Label

var ai_state_label: Label
var ai_key_input: LineEdit
var ai_topic_option: OptionButton
var ai_log: RichTextLabel

var puzzle_panel: Panel
var puzzle_question_label: Label
var ui_root: Control
var start_overlay: ColorRect
var rules_popup: Panel
var rules_popup_text: RichTextLabel
var http: HTTPRequest

var world_controller := WorldModule.new()
var gameplay_controller := GameplayModule.new()
var ui_controller := UIModule.new()
var ai_controller = null
var _draw_debug_once := false


func _ready() -> void:
	print("[main] _ready begin")
	print("[main] renderer=", RenderingServer.get_current_rendering_method())
	rng.randomize()
	_ensure_input_actions()

	world_controller.setup(self)
	gameplay_controller.setup(self)
	ui_controller.setup(self)
	ui_controller.build_ui()
	print("[main] UI built")

	# Build UI first so a broken AI module can't blank-screen the whole game.
	ai_controller = _create_ai_controller()
	ai_controller.setup(self)
	ai_controller.init_http()
	ai_controller.load_ai_config()
	print("[main] AI controller ready")

	world_controller.update_near_item()
	status_line = StoryRules.WAITING_STATUS
	ui_controller.update_ui()
	ui_controller.show_start_overlay()
	print("[main] overlay shown, queue redraw")

	ai_controller.log_ai(
		"Hệ thống",
		"Trợ giảng đã sẵn sàng. Dùng nút Hỏi AI hoặc phím tắt H/J/K/L.",
		"system"
	)
	if ai_api_key.strip_edges() == "":
		ai_controller.log_ai(
			"Hệ thống", "Gemini đang ngoại tuyến (chưa có API key).", "system"
		)
	else:
		ai_controller.log_ai(
			"Hệ thống", "Gemini trực tuyến | model: %s" % ai_model, "system"
		)

	queue_redraw()


func _create_ai_controller():
	# Use runtime load so the project can still open even if ai_module.gd fails to load
	# (version mismatch, parse error, missing file, etc.).
	var script_res = load("res://scripts/modules/ai_module.gd")
	if script_res == null or script_res is not Script:
		push_error("AI module failed to load. Falling back to stub (offline only).")
		return AIModuleStub.new()

	# `load()` returns a Script *resource* (not a class reference like `preload()`),
	# so we attach it to a base RefCounted instance.
	var controller := RefCounted.new()
	controller.set_script(script_res)
	return controller


func _process(delta: float) -> void:
	if not mission_started:
		if (
			Input.is_action_just_pressed("ui_accept")
			and start_overlay != null
			and start_overlay.visible
		):
			_on_start_mission_pressed()
		ui_controller.update_prompt_label()
		return

	if not game_over and not puzzle_open:
		var move := Vector2.ZERO
		var move_left := _is_move_left()
		var move_right := _is_move_right()
		var move_up := _is_move_up()
		var move_down := _is_move_down()

		if move_left:
			move.x -= 1.0
		if move_right:
			move.x += 1.0
		if move_up:
			move.y -= 1.0
		if move_down:
			move.y += 1.0

		if move.length() > 0.0:
			if get_viewport().gui_get_focus_owner() != null:
				get_viewport().gui_release_focus()
			world_controller.try_move_player(move.normalized() * player_speed * delta)

		if Input.is_action_just_pressed("interact"):
			gameplay_controller.interact()

	if Input.is_action_just_pressed("ai_formula"):
		ai_controller.ask_ai_topic("formula")
	if Input.is_action_just_pressed("ai_risk"):
		ai_controller.ask_ai_topic("risk")
	if Input.is_action_just_pressed("ai_alloc"):
		ai_controller.ask_ai_topic("allocation")
	if Input.is_action_just_pressed("ai_puzzle"):
		ai_controller.ask_ai_topic("puzzle")

	world_controller.update_near_item()
	ui_controller.update_prompt_label()
	queue_redraw()


func _draw() -> void:
	if not _draw_debug_once:
		_draw_debug_once = true
		print("[main] first _draw viewport=", get_viewport_rect().size)
	world_controller.draw()


func _is_move_left() -> bool:
	return (
		Input.is_action_pressed("move_left")
		or Input.is_physical_key_pressed(KEY_A)
		or Input.is_physical_key_pressed(KEY_LEFT)
	)


func _is_move_right() -> bool:
	return (
		Input.is_action_pressed("move_right")
		or Input.is_physical_key_pressed(KEY_D)
		or Input.is_physical_key_pressed(KEY_RIGHT)
	)


func _is_move_up() -> bool:
	return (
		Input.is_action_pressed("move_up")
		or Input.is_physical_key_pressed(KEY_W)
		or Input.is_physical_key_pressed(KEY_UP)
	)


func _is_move_down() -> bool:
	return (
		Input.is_action_pressed("move_down")
		or Input.is_physical_key_pressed(KEY_S)
		or Input.is_physical_key_pressed(KEY_DOWN)
	)


func _ensure_input_actions() -> void:
	_ensure_action("move_left", KEY_A)
	_ensure_action("move_right", KEY_D)
	_ensure_action("move_up", KEY_W)
	_ensure_action("move_down", KEY_S)
	_ensure_action("move_left", KEY_LEFT)
	_ensure_action("move_right", KEY_RIGHT)
	_ensure_action("move_up", KEY_UP)
	_ensure_action("move_down", KEY_DOWN)
	_ensure_action("interact", KEY_E)
	_ensure_action("ai_formula", KEY_H)
	_ensure_action("ai_risk", KEY_J)
	_ensure_action("ai_alloc", KEY_K)
	_ensure_action("ai_puzzle", KEY_L)


func _ensure_action(action: String, keycode: Key) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)

	for event in InputMap.action_get_events(action):
		if event is InputEventKey and (event as InputEventKey).physical_keycode == keycode:
			return

	var new_event := InputEventKey.new()
	new_event.physical_keycode = keycode
	InputMap.action_add_event(action, new_event)


func _on_apply_turn_pressed() -> void:
	gameplay_controller.on_apply_turn_pressed()


func _on_use_kit_pressed() -> void:
	gameplay_controller.on_use_kit_pressed()


func _on_craft_pressed() -> void:
	gameplay_controller.on_craft_pressed()


func _on_craft_recipe_selected(_index: int) -> void:
	ui_controller.update_ui()


func _on_alloc_changed(value: float, key: String) -> void:
	gameplay_controller.on_alloc_changed(value, key)


func _on_puzzle_choice(index: int) -> void:
	gameplay_controller.on_puzzle_choice(index)


func _on_close_puzzle_pressed() -> void:
	gameplay_controller.on_close_puzzle_pressed()


func _on_show_rules_pressed() -> void:
	ui_controller.show_rules()


func _on_close_rules_pressed() -> void:
	ui_controller.hide_rules()


func _on_start_mission_pressed() -> void:
	gameplay_controller.start_mission()


func _on_save_key_pressed() -> void:
	ai_controller.on_save_key_pressed()


func _on_ask_ai_pressed() -> void:
	ai_controller.on_ask_ai_pressed()


func _on_ai_log_gui_input(event: InputEvent) -> void:
	ai_controller.on_ai_log_gui_input(event)


func _on_http_request_completed(
	result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray
) -> void:
	ai_controller.on_http_request_completed(result, response_code, headers, body)

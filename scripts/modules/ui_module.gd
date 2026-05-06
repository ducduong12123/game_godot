extends RefCounted
 
var game

const UI_FONT_REGULAR := "res://assets/fonts/BeVietnamPro-Regular.ttf"
const HARD_DEBUG_OVERLAY := false


func setup(game_ref) -> void:
	game = game_ref


func build_ui() -> void:
	var canvas = CanvasLayer.new()
	game.add_child(canvas)

	var root = Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(root)
	game.ui_root = root

	_apply_ui_theme(root)
	if HARD_DEBUG_OVERLAY:
		_add_hard_debug_overlay(root)

	var map_title = Label.new()
	map_title.text = "Khu khám phá (WASD di chuyển, E tương tác)"
	map_title.position = Vector2(24, 6)
	root.add_child(map_title)

	game.objective_label = Label.new()
	game.objective_label.position = Vector2(24, 700)
	game.objective_label.size = Vector2(700, 34)
	game.objective_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	root.add_child(game.objective_label)

	var status_panel = _create_panel(root, "Trạng thái sinh tồn", Rect2(740, 20, 290, 318))
	game.status_label = Label.new()
	game.status_label.position = Vector2(12, 34)
	game.status_label.size = Vector2(266, 270)
	game.status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_panel.add_child(game.status_label)

	var alloc_panel = _create_panel(root, "Phân bổ + Chế tạo", Rect2(1042, 20, 304, 318))
	var alloc_v = VBoxContainer.new()
	alloc_v.position = Vector2(12, 34)
	alloc_v.size = Vector2(280, 240)
	alloc_v.add_theme_constant_override("separation", 4)
	alloc_panel.add_child(alloc_v)

	_make_alloc_row(alloc_v, "Máy sưởi", "heater")
	_make_alloc_row(alloc_v, "Oxy", "oxygen")
	_make_alloc_row(alloc_v, "Nước", "water")
	_make_alloc_row(alloc_v, "Thức ăn", "food")

	var apply_btn = Button.new()
	apply_btn.text = "Áp dụng lượt"
	apply_btn.pressed.connect(game._on_apply_turn_pressed)
	alloc_v.add_child(apply_btn)

	var kit_btn = Button.new()
	kit_btn.text = "Cứu trợ khẩn cấp"
	kit_btn.pressed.connect(game._on_use_kit_pressed)
	alloc_v.add_child(kit_btn)

	game.craft_recipe_option = OptionButton.new()
	for recipe in game.craft_recipes:
		game.craft_recipe_option.add_item(str(recipe.get("name", "Recipe")))
	game.craft_recipe_option.item_selected.connect(game._on_craft_recipe_selected)
	alloc_v.add_child(game.craft_recipe_option)

	var craft_btn = Button.new()
	craft_btn.text = "Chế tạo"
	craft_btn.pressed.connect(game._on_craft_pressed)
	alloc_v.add_child(craft_btn)

	game.craft_recipe_desc_label = Label.new()
	game.craft_recipe_desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.craft_recipe_desc_label.custom_minimum_size = Vector2(0, 56)
	alloc_v.add_child(game.craft_recipe_desc_label)

	game.alloc_hint_label = Label.new()
	game.alloc_hint_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.alloc_hint_label.custom_minimum_size = Vector2(0, 36)
	alloc_v.add_child(game.alloc_hint_label)

	game.inventory_label = Label.new()
	game.inventory_label.position = Vector2(12, 294)
	game.inventory_label.size = Vector2(280, 20)
	game.inventory_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	alloc_panel.add_child(game.inventory_label)

	var ai_panel = _create_panel(root, "AI Tutor", Rect2(740, 350, 606, 398))

	game.ai_state_label = Label.new()
	game.ai_state_label.position = Vector2(12, 34)
	game.ai_state_label.size = Vector2(582, 28)
	ai_panel.add_child(game.ai_state_label)

	game.ai_key_input = LineEdit.new()
	game.ai_key_input.position = Vector2(12, 66)
	game.ai_key_input.size = Vector2(430, 28)
	game.ai_key_input.placeholder_text = "Dán Gemini API key vào đây (AIza...)"
	ai_panel.add_child(game.ai_key_input)

	var save_btn = Button.new()
	save_btn.text = "Lưu key"
	save_btn.position = Vector2(448, 66)
	save_btn.size = Vector2(146, 28)
	save_btn.pressed.connect(game._on_save_key_pressed)
	ai_panel.add_child(save_btn)

	game.ai_topic_option = OptionButton.new()
	game.ai_topic_option.position = Vector2(12, 100)
	game.ai_topic_option.size = Vector2(220, 28)
	for title in game.AITutorService.topic_labels_vi():
		game.ai_topic_option.add_item(title)
	ai_panel.add_child(game.ai_topic_option)

	var ask_btn = Button.new()
	ask_btn.text = "Hỏi AI"
	ask_btn.position = Vector2(238, 100)
	ask_btn.size = Vector2(120, 28)
	ask_btn.pressed.connect(game._on_ask_ai_pressed)
	ai_panel.add_child(ask_btn)

	game.ai_log = RichTextLabel.new()
	game.ai_log.position = Vector2(12, 136)
	game.ai_log.size = Vector2(582, 226)
	game.ai_log.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	game.ai_log.scroll_active = true
	game.ai_log.scroll_following = false
	game.ai_log.mouse_filter = Control.MOUSE_FILTER_STOP
	game.ai_log.clip_contents = true
	game.ai_log.gui_input.connect(game._on_ai_log_gui_input)
	game.ai_log.bbcode_enabled = true
	ai_panel.add_child(game.ai_log)

	var ai_hint = Label.new()
	ai_hint.position = Vector2(12, 366)
	ai_hint.size = Vector2(582, 20)
	ai_hint.text = "Phím tắt: H công thức | J rủi ro | K phân bổ | L gợi ý câu đố"
	ai_panel.add_child(ai_hint)

	game.prompt_label = Label.new()
	game.prompt_label.position = Vector2(24, 736)
	game.prompt_label.size = Vector2(700, 30)
	game.prompt_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	root.add_child(game.prompt_label)

	game.puzzle_panel = _create_panel(root, "Trạm câu đố STEM", Rect2(430, 160, 520, 360))
	game.puzzle_panel.visible = false

	var puzzle_v = VBoxContainer.new()
	puzzle_v.position = Vector2(12, 34)
	puzzle_v.size = Vector2(496, 314)
	puzzle_v.add_theme_constant_override("separation", 8)
	game.puzzle_panel.add_child(puzzle_v)

	game.puzzle_question_label = Label.new()
	game.puzzle_question_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.puzzle_question_label.custom_minimum_size = Vector2(0, 92)
	puzzle_v.add_child(game.puzzle_question_label)

	for i in range(4):
		var button = Button.new()
		button.text = "%d) -" % (i + 1)
		button.pressed.connect(game._on_puzzle_choice.bind(i))
		game.puzzle_option_buttons.append(button)
		puzzle_v.add_child(button)

	var close_btn = Button.new()
	close_btn.text = "Đóng câu đố"
	close_btn.pressed.connect(game._on_close_puzzle_pressed)
	puzzle_v.add_child(close_btn)

	_create_start_overlay(root)


func _create_panel(parent: Control, title: String, rect: Rect2) -> Panel:
	var panel = Panel.new()
	panel.position = rect.position
	panel.size = rect.size
	parent.add_child(panel)

	var title_label = Label.new()
	title_label.text = title
	title_label.position = Vector2(12, 8)
	panel.add_child(title_label)

	return panel


func _make_alloc_row(container: VBoxContainer, title: String, key: String) -> void:
	var row = HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)

	var label = Label.new()
	label.text = title
	label.custom_minimum_size = Vector2(120, 0)
	row.add_child(label)

	var spin = SpinBox.new()
	spin.min_value = 0
	spin.max_value = game.SurvivalSystem.ALLOCATION_LIMIT_EACH
	spin.step = 1
	spin.rounded = true
	spin.value = 0
	spin.custom_minimum_size = Vector2(120, 0)
	spin.value_changed.connect(game._on_alloc_changed.bind(key))
	row.add_child(spin)

	game.allocation_spins[key] = spin
	container.add_child(row)


func _create_start_overlay(root: Control) -> void:
	game.start_overlay = ColorRect.new()
	game.start_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	game.start_overlay.color = Color(0.0, 0.0, 0.0, 0.72)
	game.start_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	game.start_overlay.visible = false
	root.add_child(game.start_overlay)

	var panel = Panel.new()
	panel.size = Vector2(860, 540)
	panel.position = Vector2(253, 114)
	game.start_overlay.add_child(panel)

	var title = Label.new()
	title.text = "MISSION ORION-17"
	title.position = Vector2(18, 12)
	title.size = Vector2(824, 32)
	panel.add_child(title)

	var intro = RichTextLabel.new()
	intro.position = Vector2(18, 50)
	intro.size = Vector2(824, 336)
	intro.bbcode_enabled = false
	intro.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	intro.scroll_active = true
	intro.text = game.StoryRules.intro_text()
	panel.add_child(intro)

	var objective = Label.new()
	objective.position = Vector2(18, 392)
	objective.size = Vector2(824, 44)
	objective.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	objective.text = game.StoryRules.objective_text()
	panel.add_child(objective)

	var buttons = HBoxContainer.new()
	buttons.position = Vector2(18, 452)
	buttons.size = Vector2(824, 40)
	buttons.add_theme_constant_override("separation", 12)
	panel.add_child(buttons)

	var rule_btn = Button.new()
	rule_btn.text = "Xem luật chơi"
	rule_btn.custom_minimum_size = Vector2(220, 40)
	rule_btn.pressed.connect(game._on_show_rules_pressed)
	buttons.add_child(rule_btn)

	var start_btn = Button.new()
	start_btn.text = "Bắt đầu nhiệm vụ"
	start_btn.custom_minimum_size = Vector2(220, 40)
	start_btn.pressed.connect(game._on_start_mission_pressed)
	buttons.add_child(start_btn)

	var enter_hint = Label.new()
	enter_hint.position = Vector2(18, 500)
	enter_hint.size = Vector2(824, 24)
	enter_hint.text = "Phím Enter cũng có thể bắt đầu nhiệm vụ."
	panel.add_child(enter_hint)

	_create_rules_popup(game.start_overlay)


func _create_rules_popup(parent: Control) -> void:
	game.rules_popup = Panel.new()
	game.rules_popup.size = Vector2(760, 540)
	game.rules_popup.position = Vector2(303, 114)
	game.rules_popup.visible = false
	parent.add_child(game.rules_popup)

	var title = Label.new()
	title.position = Vector2(12, 8)
	title.size = Vector2(736, 24)
	title.text = "Luật chơi và mục tiêu"
	game.rules_popup.add_child(title)

	game.rules_popup_text = RichTextLabel.new()
	game.rules_popup_text.position = Vector2(12, 36)
	game.rules_popup_text.size = Vector2(736, 454)
	game.rules_popup_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.rules_popup_text.scroll_active = true
	game.rules_popup_text.bbcode_enabled = false
	game.rules_popup_text.text = game.StoryRules.rules_text()
	game.rules_popup.add_child(game.rules_popup_text)

	var close_btn = Button.new()
	close_btn.position = Vector2(12, 498)
	close_btn.size = Vector2(180, 32)
	close_btn.text = "Đóng luật chơi"
	close_btn.pressed.connect(game._on_close_rules_pressed)
	game.rules_popup.add_child(close_btn)


func show_rules() -> void:
	if game.rules_popup != null:
		game.rules_popup.visible = true


func hide_rules() -> void:
	if game.rules_popup != null:
		game.rules_popup.visible = false


func show_start_overlay() -> void:
	if game.start_overlay != null:
		game.start_overlay.visible = true
	if game.rules_popup != null:
		game.rules_popup.visible = false


func hide_start_overlay() -> void:
	if game.start_overlay != null:
		game.start_overlay.visible = false
	if game.rules_popup != null:
		game.rules_popup.visible = false


func update_ui() -> void:
	var total_alloc = game.SurvivalSystem.allocation_total(game.allocation)
	var current_room = game.world_controller.room_name_at_player()
	var summary := (
		(
			"Lượt %d/%d\nKhoang: %s\nPin: %.0f\nNhiệt độ: %.1f C\n"
			+ "Oxy: %.1f\nNước cơ thể: %.1f\nĐộ no: %.1f\nHP: %.1f\n"
			+ "Lượt hành động: %d\nSửa tàu: %.0f%%\nMốc hiện tại: %s\n"
			+ "Module: %s\nSự cố gần nhất: %s"
		)
		% [
			game.turn,
			game.max_turns,
			current_room,
			game.battery,
			game.temp,
			game.o2,
			game.hydration,
			game.satiety,
			game.hp,
			game.actions_left,
			game.repair_progress,
			game.gameplay_controller.current_stage_goal_text(),
			game.gameplay_controller.active_modules_text(),
			game.last_event_title
		]
	)
	if game.game_over:
		if game.win:
			summary += "\nKết quả: THẮNG"
		else:
			summary += "\nKết quả: THUA"
	game.status_label.text = summary

	game.alloc_hint_label.text = (
		"Tổng phân bổ: %d/%d (<= pin %.0f)"
		% [total_alloc, game.SurvivalSystem.ALLOCATION_LIMIT_TOTAL, game.battery]
	)
	game.inventory_label.text = (
		"Túi đồ: %s" % (", ".join(game.inventory) if game.inventory.size() > 0 else "(trống)")
	)
	game.objective_label.text = (
		"%s\nTiến trình hiện tại: %s"
		% [game.StoryRules.objective_text(), game.gameplay_controller.current_stage_goal_text()]
	)

	if game.craft_recipe_desc_label != null:
		game.craft_recipe_desc_label.text = game.gameplay_controller.current_recipe_preview_text()

	if game.ai_pending:
		game.ai_state_label.text = "AI: Gemini đang xử lý..."
	elif game.ai_api_key.strip_edges() == "":
		game.ai_state_label.text = "AI: ngoại tuyến (chưa có key)"
	else:
		game.ai_state_label.text = "AI: trực tuyến (%s)" % game.ai_model

	update_prompt_label()


func update_prompt_label() -> void:
	if not game.mission_started:
		game.prompt_label.text = "Đọc luật chơi rồi bấm BẮT ĐẦU NHIỆM VỤ."
		return

	if game.game_over:
		game.prompt_label.text = "Nhấn F5 trong trình chỉnh sửa để khởi động lại màn chơi."
		return

	if game.puzzle_open:
		game.prompt_label.text = "Đang mở câu đố. Chọn một đáp án."
		return

	var near_door_id = game.world_controller.nearest_door_id()
	if near_door_id != "":
		var door: Dictionary = game.doors[near_door_id]
		if game.world_controller.door_is_open(near_door_id):
			game.prompt_label.text = "%s đã mở. Bạn có thể đi qua." % str(door.get("name", "Cửa"))
		else:
			var required_item = str(door.get("required_item", ""))
			if game.inventory.has(required_item):
				game.prompt_label.text = (
					"Nhấn E để mở %s bằng %s." % [str(door.get("name", "Cửa")), required_item]
				)
			else:
				game.prompt_label.text = (
					"%s cần vật phẩm: %s." % [str(door.get("name", "Cửa")), required_item]
				)
		return

	if game.near_item_index >= 0:
		game.prompt_label.text = (
			"Nhấn E để nhặt vật phẩm: %s" % str(game.items[game.near_item_index]["name"])
		)
		return

	if game.player_pos.distance_to(game.terminal_pos) <= game.INTERACT_RANGE:
		var missing = game.gameplay_controller.missing_terminal_items()
		if missing.size() == 0:
			game.prompt_label.text = "Nhấn E để dùng trạm câu đố STEM."
		else:
			game.prompt_label.text = "Trạm yêu cầu: %s" % ", ".join(missing)
		return

	game.prompt_label.text = game.status_line


func _apply_ui_theme(root: Control) -> void:
	var font: Font = _load_font_from_file(UI_FONT_REGULAR)
	if font == null:
		push_warning("UI font missing: %s" % UI_FONT_REGULAR)
		return

	var theme := Theme.new()
	theme.default_font = font
	theme.default_font_size = 16
	root.theme = theme


func _load_font_from_file(path: String) -> Font:
	# Avoid relying on Godot's import pipeline for .ttf in headless/debug runs.
	# Read the raw bytes and feed them into a FontFile when possible.
	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(path)
	if bytes.is_empty():
		return ThemeDB.fallback_font

	var font_file := FontFile.new()
	if font_file.has_method("load_dynamic_font"):
		var err := int(font_file.call("load_dynamic_font", path))
		if err == OK:
			return font_file

	# Fallback for engine builds that expose `data` directly.
	for prop in font_file.get_property_list():
		if typeof(prop) == TYPE_DICTIONARY and str(prop.get("name", "")) == "data":
			font_file.set("data", bytes)
			return font_file

	return ThemeDB.fallback_font


func _add_hard_debug_overlay(root: Control) -> void:
	var marker := ColorRect.new()
	marker.position = Vector2(24, 24)
	marker.size = Vector2(360, 120)
	marker.color = Color(0.85, 0.08, 0.18, 0.95)
	root.add_child(marker)

	var text := Label.new()
	text.position = Vector2(12, 12)
	text.size = Vector2(336, 96)
	text.text = "DEBUG UI ACTIVE\nNeu ban thay hop do nay,\nscene va CanvasLayer dang render."
	marker.add_child(text)

extends RefCounted

var game
var recipe_detail_popup: Panel
var recipe_detail_text: RichTextLabel
var inventory_popup: Panel
var inventory_popup_text: RichTextLabel

const UI_FONT_REGULAR := "res://assets/fonts/BeVietnamPro-Regular.ttf"


func setup(game_ref) -> void:
	game = game_ref


func build_ui() -> void:
	var canvas := CanvasLayer.new()
	game.add_child(canvas)

	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(root)
	game.ui_root = root

	_apply_ui_theme(root)

	var map_title := Label.new()
	map_title.text = "Khu khám phá (WASD di chuyển, E tương tác)"
	map_title.position = Vector2(24, 6)
	root.add_child(map_title)

	game.objective_label = Label.new()
	game.objective_label.position = Vector2(24, 728)
	game.objective_label.size = Vector2(690, 34)
	game.objective_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	root.add_child(game.objective_label)

	game.prompt_label = Label.new()
	game.prompt_label.position = Vector2(24, 696)
	game.prompt_label.size = Vector2(690, 28)
	game.prompt_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	root.add_child(game.prompt_label)

	game.mission_panel = _create_panel(root, "Tiến trình nhiệm vụ (Shift)", Rect2(24, 34, 470, 250))
	game.mission_panel.visible = false

	game.mission_detail_label = RichTextLabel.new()
	game.mission_detail_label.position = Vector2(12, 34)
	game.mission_detail_label.size = Vector2(446, 204)
	game.mission_detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.mission_detail_label.scroll_active = true
	game.mission_detail_label.bbcode_enabled = false
	game.mission_panel.add_child(game.mission_detail_label)

	game.hud_toggle_button = Button.new()
	game.hud_toggle_button.text = "Ẩn HUD"
	game.hud_toggle_button.position = Vector2(1240, 8)
	game.hud_toggle_button.size = Vector2(96, 30)
	game.hud_toggle_button.pressed.connect(game._on_toggle_hud_pressed)
	root.add_child(game.hud_toggle_button)

	game.hud_panels_root = Control.new()
	game.hud_panels_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	game.hud_panels_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(game.hud_panels_root)

	_build_status_panel()
	_build_alloc_panel()
	_build_puzzle_panel(root)
	_build_ai_overlay(root)
	_create_recipe_detail_popup(root)
	_create_inventory_popup(root)
	_create_event_toast(root)
	_create_start_overlay(root)
	_create_result_overlay(root)


func _build_status_panel() -> void:
	var status_panel := _create_panel(
		game.hud_panels_root, "Trạng thái sinh tồn", Rect2(740, 20, 294, 390)
	)
	game.status_label = Label.new()
	game.status_label.position = Vector2(12, 34)
	game.status_label.size = Vector2(270, 344)
	game.status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_panel.add_child(game.status_label)


func _build_alloc_panel() -> void:
	var alloc_panel := _create_panel(
		game.hud_panels_root, "Phân bổ + Chế tạo", Rect2(1042, 20, 304, 390)
	)
	var alloc_v := VBoxContainer.new()
	alloc_v.position = Vector2(12, 34)
	alloc_v.size = Vector2(280, 314)
	alloc_v.add_theme_constant_override("separation", 4)
	alloc_panel.add_child(alloc_v)

	_make_alloc_row(alloc_v, "Máy sưởi", "heater")
	_make_alloc_row(alloc_v, "Oxy", "oxygen")
	_make_alloc_row(alloc_v, "Nước", "water")
	_make_alloc_row(alloc_v, "Thức ăn", "food")

	var apply_btn := Button.new()
	apply_btn.text = "Áp dụng lượt"
	apply_btn.pressed.connect(game._on_apply_turn_pressed)
	alloc_v.add_child(apply_btn)

	var support_btn := Button.new()
	support_btn.text = "Dùng vật phẩm cứu nguy"
	support_btn.pressed.connect(game._on_use_kit_pressed)
	alloc_v.add_child(support_btn)

	game.craft_recipe_option = OptionButton.new()
	for recipe in game.craft_recipes:
		game.craft_recipe_option.add_item(str(recipe.get("name", "Recipe")))
	game.craft_recipe_option.item_selected.connect(game._on_craft_recipe_selected)
	alloc_v.add_child(game.craft_recipe_option)

	var craft_btn := Button.new()
	craft_btn.text = "Chế tạo"
	craft_btn.pressed.connect(game._on_craft_pressed)
	alloc_v.add_child(craft_btn)

	var detail_row := HBoxContainer.new()
	detail_row.add_theme_constant_override("separation", 8)
	alloc_v.add_child(detail_row)

	var recipe_detail_btn := Button.new()
	recipe_detail_btn.text = "Chi tiết công thức"
	recipe_detail_btn.custom_minimum_size = Vector2(136, 0)
	recipe_detail_btn.pressed.connect(_on_recipe_detail_pressed)
	detail_row.add_child(recipe_detail_btn)

	var inventory_btn := Button.new()
	inventory_btn.text = "Xem túi đồ"
	inventory_btn.custom_minimum_size = Vector2(136, 0)
	inventory_btn.pressed.connect(_on_inventory_detail_pressed)
	detail_row.add_child(inventory_btn)

	game.craft_recipe_desc_label = Label.new()
	game.craft_recipe_desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.craft_recipe_desc_label.custom_minimum_size = Vector2(0, 42)
	alloc_v.add_child(game.craft_recipe_desc_label)

	game.alloc_hint_label = Label.new()
	game.alloc_hint_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.alloc_hint_label.custom_minimum_size = Vector2(0, 42)
	alloc_v.add_child(game.alloc_hint_label)

	game.inventory_label = Label.new()
	game.inventory_label.position = Vector2(12, 346)
	game.inventory_label.size = Vector2(280, 32)
	game.inventory_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	alloc_panel.add_child(game.inventory_label)


func _build_ai_overlay(root: Control) -> void:
	game.ai_overlay = _create_panel(root, "Trợ lý AI (Ctrl)", Rect2(496, 84, 520, 560))
	game.ai_overlay.visible = false

	game.ai_state_label = Label.new()
	game.ai_state_label.position = Vector2(12, 34)
	game.ai_state_label.size = Vector2(496, 24)
	game.ai_overlay.add_child(game.ai_state_label)

	game.ai_prompt_input = TextEdit.new()
	game.ai_prompt_input.position = Vector2(12, 66)
	game.ai_prompt_input.size = Vector2(496, 90)
	game.ai_prompt_input.placeholder_text = "Nhập câu hỏi: Tôi cần làm gì tiếp theo? Tôi đang thiếu gì? Gợi ý câu đố là gì?"
	game.ai_overlay.add_child(game.ai_prompt_input)

	var ask_btn := Button.new()
	ask_btn.text = "Gửi câu hỏi"
	ask_btn.position = Vector2(12, 164)
	ask_btn.size = Vector2(140, 30)
	ask_btn.pressed.connect(game._on_ask_ai_pressed)
	game.ai_overlay.add_child(ask_btn)

	var close_btn := Button.new()
	close_btn.text = "Đóng"
	close_btn.position = Vector2(164, 164)
	close_btn.size = Vector2(100, 30)
	close_btn.pressed.connect(game._on_toggle_ai_pressed)
	game.ai_overlay.add_child(close_btn)

	game.ai_log = RichTextLabel.new()
	game.ai_log.position = Vector2(12, 204)
	game.ai_log.size = Vector2(496, 308)
	game.ai_log.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.ai_log.scroll_active = true
	game.ai_log.scroll_following = false
	game.ai_log.mouse_filter = Control.MOUSE_FILTER_STOP
	game.ai_log.clip_contents = true
	game.ai_log.gui_input.connect(game._on_ai_log_gui_input)
	game.ai_log.bbcode_enabled = true
	game.ai_overlay.add_child(game.ai_log)

	var ai_hint := Label.new()
	ai_hint.position = Vector2(12, 520)
	ai_hint.size = Vector2(496, 24)
	ai_hint.text = "Ctrl đóng | Nhập câu hỏi tự nhiên rồi bấm Gửi"
	game.ai_overlay.add_child(ai_hint)


func _build_puzzle_panel(root: Control) -> void:
	game.puzzle_panel = _create_panel(root, "Trạm câu đố STEM", Rect2(430, 160, 520, 360))
	game.puzzle_panel.visible = false

	var puzzle_v := VBoxContainer.new()
	puzzle_v.position = Vector2(12, 34)
	puzzle_v.size = Vector2(496, 314)
	puzzle_v.add_theme_constant_override("separation", 8)
	game.puzzle_panel.add_child(puzzle_v)

	game.puzzle_question_label = Label.new()
	game.puzzle_question_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.puzzle_question_label.custom_minimum_size = Vector2(0, 92)
	puzzle_v.add_child(game.puzzle_question_label)

	for i in range(4):
		var button := Button.new()
		button.text = "%d) -" % (i + 1)
		button.pressed.connect(game._on_puzzle_choice.bind(i))
		game.puzzle_option_buttons.append(button)
		puzzle_v.add_child(button)

	var close_btn := Button.new()
	close_btn.text = "Đóng câu đố"
	close_btn.pressed.connect(game._on_close_puzzle_pressed)
	puzzle_v.add_child(close_btn)


func _create_panel(parent: Control, title: String, rect: Rect2) -> Panel:
	var panel := Panel.new()
	panel.position = rect.position
	panel.size = rect.size
	parent.add_child(panel)

	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.08, 0.10, 0.12, 0.88)
	panel_style.border_color = Color(0.70, 0.78, 0.86, 0.35)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(6)
	panel.add_theme_stylebox_override("panel", panel_style)

	var title_label := Label.new()
	title_label.text = title
	title_label.position = Vector2(12, 8)
	panel.add_child(title_label)

	return panel


func _create_recipe_detail_popup(root: Control) -> void:
	recipe_detail_popup = _create_panel(root, "Chi tiết công thức", Rect2(760, 180, 520, 230))
	recipe_detail_popup.visible = false

	recipe_detail_text = RichTextLabel.new()
	recipe_detail_text.position = Vector2(12, 34)
	recipe_detail_text.size = Vector2(496, 148)
	recipe_detail_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	recipe_detail_text.scroll_active = true
	recipe_detail_text.bbcode_enabled = false
	recipe_detail_popup.add_child(recipe_detail_text)

	var close_btn := Button.new()
	close_btn.text = "Đóng"
	close_btn.position = Vector2(12, 190)
	close_btn.size = Vector2(120, 28)
	close_btn.pressed.connect(_hide_recipe_detail)
	recipe_detail_popup.add_child(close_btn)


func _create_inventory_popup(root: Control) -> void:
	inventory_popup = _create_panel(root, "Túi đồ", Rect2(760, 180, 420, 230))
	inventory_popup.visible = false

	inventory_popup_text = RichTextLabel.new()
	inventory_popup_text.position = Vector2(12, 34)
	inventory_popup_text.size = Vector2(396, 148)
	inventory_popup_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	inventory_popup_text.scroll_active = true
	inventory_popup_text.bbcode_enabled = false
	inventory_popup.add_child(inventory_popup_text)

	var close_btn := Button.new()
	close_btn.text = "Đóng"
	close_btn.position = Vector2(12, 190)
	close_btn.size = Vector2(120, 28)
	close_btn.pressed.connect(_hide_inventory_detail)
	inventory_popup.add_child(close_btn)


func _create_event_toast(root: Control) -> void:
	game.event_toast_panel = _create_panel(root, "Sự cố hệ thống", Rect2(24, 96, 470, 150))
	game.event_toast_panel.visible = false

	game.event_toast_text = RichTextLabel.new()
	game.event_toast_text.position = Vector2(12, 34)
	game.event_toast_text.size = Vector2(446, 104)
	game.event_toast_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.event_toast_text.scroll_active = false
	game.event_toast_text.bbcode_enabled = true
	game.event_toast_panel.add_child(game.event_toast_text)


func _create_result_overlay(root: Control) -> void:
	game.result_overlay = ColorRect.new()
	game.result_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	game.result_overlay.color = Color(0.0, 0.0, 0.0, 0.76)
	game.result_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	game.result_overlay.visible = false
	root.add_child(game.result_overlay)

	var panel := Panel.new()
	panel.size = Vector2(720, 390)
	panel.position = Vector2(323, 170)
	game.result_overlay.add_child(panel)

	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.07, 0.09, 0.11, 0.95)
	panel_style.border_color = Color(0.80, 0.88, 0.96, 0.45)
	panel_style.set_border_width_all(1)
	panel_style.set_corner_radius_all(6)
	panel.add_theme_stylebox_override("panel", panel_style)

	game.result_title_label = Label.new()
	game.result_title_label.position = Vector2(20, 16)
	game.result_title_label.size = Vector2(680, 38)
	game.result_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	game.result_title_label.add_theme_font_size_override("font_size", 28)
	panel.add_child(game.result_title_label)

	game.result_detail_label = RichTextLabel.new()
	game.result_detail_label.position = Vector2(24, 70)
	game.result_detail_label.size = Vector2(672, 250)
	game.result_detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	game.result_detail_label.scroll_active = true
	game.result_detail_label.bbcode_enabled = false
	panel.add_child(game.result_detail_label)

	var restart_hint := Label.new()
	restart_hint.position = Vector2(24, 338)
	restart_hint.size = Vector2(672, 30)
	restart_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	restart_hint.text = "Nhấn F5 trong Godot để chạy lại màn chơi."
	panel.add_child(restart_hint)


func _make_alloc_row(container: VBoxContainer, title: String, key: String) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)

	var label := Label.new()
	label.text = title
	label.custom_minimum_size = Vector2(120, 0)
	row.add_child(label)

	var spin := SpinBox.new()
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

	var panel := Panel.new()
	panel.size = Vector2(860, 540)
	panel.position = Vector2(253, 114)
	game.start_overlay.add_child(panel)

	var title := Label.new()
	title.text = "MISSION ORION-17"
	title.position = Vector2(18, 12)
	title.size = Vector2(824, 32)
	panel.add_child(title)

	var intro := RichTextLabel.new()
	intro.position = Vector2(18, 50)
	intro.size = Vector2(824, 336)
	intro.bbcode_enabled = false
	intro.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	intro.scroll_active = true
	intro.text = game.StoryRules.intro_text()
	panel.add_child(intro)

	var objective := Label.new()
	objective.position = Vector2(18, 392)
	objective.size = Vector2(824, 44)
	objective.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	objective.text = game.StoryRules.objective_text()
	panel.add_child(objective)

	var buttons := HBoxContainer.new()
	buttons.position = Vector2(18, 452)
	buttons.size = Vector2(824, 40)
	buttons.add_theme_constant_override("separation", 12)
	panel.add_child(buttons)

	var rule_btn := Button.new()
	rule_btn.text = "Xem luật chơi"
	rule_btn.custom_minimum_size = Vector2(220, 40)
	rule_btn.pressed.connect(game._on_show_rules_pressed)
	buttons.add_child(rule_btn)

	var start_btn := Button.new()
	start_btn.text = "Bắt đầu nhiệm vụ"
	start_btn.custom_minimum_size = Vector2(220, 40)
	start_btn.pressed.connect(game._on_start_mission_pressed)
	buttons.add_child(start_btn)

	var enter_hint := Label.new()
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

	var title := Label.new()
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

	var close_btn := Button.new()
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


func show_event_toast(
	title: String, description: String, effect_text: String, hint: String, severity: String
) -> void:
	if game.event_toast_panel == null or game.event_toast_text == null:
		return

	var color := "#F4D35E"
	if severity == "danger":
		color = "#FF8A80"
	elif severity == "good":
		color = "#8EDB8A"
	elif severity == "info":
		color = "#B7D6FF"

	game.event_toast_text.text = (
		"[color=%s][b]%s[/b][/color]\n%s\nẢnh hưởng: %s\nGợi ý: %s"
		% [color, title, description, effect_text, hint]
	)
	game.event_toast_panel.visible = true
	game.event_toast_timer = 6.0


func hide_event_toast() -> void:
	if game.event_toast_panel != null:
		game.event_toast_panel.visible = false


func show_result_overlay(is_win: bool, reason: String) -> void:
	if game.result_overlay == null:
		return

	game.result_overlay.visible = true
	if game.result_title_label != null:
		game.result_title_label.text = "CHIẾN THẮNG" if is_win else "THUA CUỘC"
	if game.result_detail_label != null:
		game.result_detail_label.text = _result_detail_text(is_win, reason)


func hide_result_overlay() -> void:
	if game.result_overlay != null:
		game.result_overlay.visible = false


func _on_recipe_detail_pressed() -> void:
	if recipe_detail_popup == null:
		return
	if inventory_popup != null:
		inventory_popup.visible = false
	_update_recipe_detail_popup()
	recipe_detail_popup.visible = true


func _on_inventory_detail_pressed() -> void:
	if inventory_popup == null:
		return
	if recipe_detail_popup != null:
		recipe_detail_popup.visible = false
	_update_inventory_popup()
	inventory_popup.visible = true


func _hide_recipe_detail() -> void:
	if recipe_detail_popup != null:
		recipe_detail_popup.visible = false


func _hide_inventory_detail() -> void:
	if inventory_popup != null:
		inventory_popup.visible = false


func _update_recipe_detail_popup() -> void:
	if recipe_detail_text == null:
		return
	recipe_detail_text.text = game.gameplay_controller.current_recipe_preview_text()


func _update_inventory_popup() -> void:
	if inventory_popup_text == null:
		return
	if game.inventory.is_empty():
		inventory_popup_text.text = "Túi đồ đang trống."
		return

	var lines: PackedStringArray = []
	for item_name in game.inventory:
		lines.append("- %s" % item_name)
	inventory_popup_text.text = "Vật phẩm hiện có:\n" + "\n".join(lines)


func update_ui() -> void:
	var total_alloc: int = game.SurvivalSystem.allocation_total(game.allocation)
	var current_room: String = game.world_controller.room_name_at_player()
	var summary := (
		(
			"Lượt %d/%d\nThời gian còn lại: %s / 08:00\nKhoang: %s\nPin: %.0f\nNhiệt độ: %.1f C\n"
			+ "Oxy: %.1f\nNước cơ thể: %.1f\nĐộ no: %.1f\nHP: %.1f\n"
			+ "Lượt hành động: %d\nSửa tàu: %.0f%%\nMốc kỹ thuật: %s\n"
			+ "Module: %s\nSự cố gần nhất: %s"
		)
		% [
			game.turn,
			game.max_turns,
			_remaining_time_text(),
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
		summary += "\nKết quả: %s" % ("THẮNG" if game.win else "THUA")
	game.status_label.text = summary

	game.alloc_hint_label.text = (
		"Tổng phân bổ: %d/%d (<= pin %.0f)"
		% [total_alloc, game.SurvivalSystem.ALLOCATION_LIMIT_TOTAL, game.battery]
	)
	game.inventory_label.text = "Túi đồ: %d vật phẩm | Bấm 'Xem túi đồ'" % game.inventory.size()
	game.objective_label.text = (
		"Tab: Ẩn/hiện HUD | Shift: Xem nhiệm vụ | Ctrl: Hỏi AI | Việc tiếp theo: %s"
		% game.mission_controller.current_stage_title()
	)

	if game.craft_recipe_desc_label != null:
		var preview_text: String = game.gameplay_controller.current_recipe_preview_text()
		game.craft_recipe_desc_label.text = preview_text.get_slice("\n", 0)

	_update_recipe_detail_popup()
	_update_inventory_popup()
	_update_mission_panel()

	if game.ai_pending:
		game.ai_state_label.text = "AI đang xử lý..."
	elif game.ai_api_key.strip_edges() == "":
		game.ai_state_label.text = "AI ngoại tuyến | thêm GROQ_API_KEY vào .env để bật trực tuyến"
	else:
		game.ai_state_label.text = "AI trực tuyến"

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

	var near_door_id: String = game.world_controller.nearest_door_id()
	if near_door_id != "":
		var door: Dictionary = game.doors[near_door_id]
		if game.world_controller.door_is_open(near_door_id):
			game.prompt_label.text = "%s đã mở. Bạn có thể đi qua." % str(door.get("name", "Cửa"))
		else:
			var required_item := str(door.get("required_item", ""))
			if game.inventory.has(required_item):
				game.prompt_label.text = "Nhấn E để mở %s bằng %s." % [str(door.get("name", "Cửa")), required_item]
			else:
				game.prompt_label.text = "%s cần vật phẩm: %s." % [str(door.get("name", "Cửa")), required_item]
		return

	if game.near_item_index >= 0:
		game.prompt_label.text = "Nhấn E để nhặt vật phẩm: %s" % str(game.items[game.near_item_index]["name"])
		return

	if game.player_pos.distance_to(game.terminal_pos) <= game.INTERACT_RANGE:
		var missing: Array[String] = game.gameplay_controller.missing_terminal_items()
		if missing.size() == 0:
			game.prompt_label.text = "Nhấn E để dùng trạm puzzle STEM."
		else:
			game.prompt_label.text = "Trạm cần: %s" % ", ".join(missing)
		return

	game.prompt_label.text = game.status_line.get_slice("\n", 0)


func _update_mission_panel() -> void:
	if game.mission_detail_label == null:
		return

	var lines: PackedStringArray = []
	lines.append("Mục tiêu lớn: %s" % game.StoryRules.objective_text())
	lines.append("")
	lines.append("Việc tiếp theo: %s" % game.mission_controller.current_stage_title())
	lines.append(game.mission_controller.current_stage_summary())
	lines.append("")
	lines.append(game.mission_controller.detail_text())
	lines.append("")
	lines.append("Tiến độ sửa tàu: %.0f%% | Lượt: %d/%d" % [game.repair_progress, game.turn, game.max_turns])
	lines.append("Thời gian còn lại: %s / 08:00" % _remaining_time_text())
	lines.append("Mốc kỹ thuật hiện tại: %s" % game.gameplay_controller.current_stage_goal_text())
	if not game.event_log.is_empty():
		lines.append("")
		lines.append("Sự cố gần đây:")
		for event_line in game.event_log:
			lines.append("- %s" % event_line)
	game.mission_detail_label.text = "\n".join(lines)


func _result_detail_text(is_win: bool, reason: String) -> String:
	var lines: PackedStringArray = []
	if is_win:
		lines.append("Bạn đã hoàn thành chuỗi sửa tàu và kích hoạt escape thành công.")
	else:
		lines.append("Lý do thất bại: %s" % reason)
		lines.append("Gợi ý: kiểm soát tài nguyên sớm hơn, ưu tiên O2/HP/pin khi chúng xuống thấp, rồi mới đẩy tiến độ sửa tàu.")
	lines.append("")
	lines.append("Tiến độ sửa tàu: %.0f%%" % game.repair_progress)
	lines.append("Thời gian đã dùng: %s / 08:00" % _format_time(game.mission_elapsed_sec))
	lines.append("Lượt: %d/%d" % [game.turn, game.max_turns])
	lines.append("Pin: %.0f | O2: %.1f | HP: %.1f" % [game.battery, game.o2, game.hp])
	lines.append("Nhiệt độ: %.1f C | Nước: %.1f | Độ no: %.1f" % [game.temp, game.hydration, game.satiety])
	if game.last_event_title != "":
		lines.append("Sự cố gần nhất: %s" % game.last_event_title)
	return "\n".join(lines)


func _format_time(seconds: float) -> String:
	var clamped := clampf(seconds, 0.0, game.SurvivalSystem.DEMO_TIME_LIMIT_SEC)
	var total := int(floor(clamped))
	var minutes := int(total / 60)
	var secs := total % 60
	return "%02d:%02d" % [minutes, secs]


func _remaining_time_text() -> String:
	return _format_time(game.SurvivalSystem.DEMO_TIME_LIMIT_SEC - game.mission_elapsed_sec)


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
	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(path)
	if bytes.is_empty():
		return ThemeDB.fallback_font

	var font_file := FontFile.new()
	if font_file.has_method("load_dynamic_font"):
		var err := int(font_file.call("load_dynamic_font", path))
		if err == OK:
			return font_file

	for prop in font_file.get_property_list():
		if typeof(prop) == TYPE_DICTIONARY and str(prop.get("name", "")) == "data":
			font_file.set("data", bytes)
			return font_file

	return ThemeDB.fallback_font

extends RefCounted

var game


func setup(game_ref) -> void:
	game = game_ref


func ensure_mission_started() -> bool:
	if game.mission_started:
		return true
	game.status_line = game.StoryRules.WAITING_STATUS
	game.ui_controller.show_start_overlay()
	game.ui_controller.update_ui()
	return false


func start_mission() -> void:
	game.mission_started = true
	game.ui_controller.hide_start_overlay()
	game.status_line = game.StoryRules.ACTIVE_STATUS
	_apply_mission_updates(game.mission_controller.start_mission())
	game.ui_controller.update_ui()


func interact() -> void:
	if not ensure_mission_started():
		return
	if game.game_over or game.puzzle_open:
		return

	var locked_door_id: String = game.world_controller.nearest_locked_door_id()
	if locked_door_id != "":
		try_unlock_door(locked_door_id)
		return

	if game.near_item_index >= 0:
		pick_item(game.near_item_index)
		return

	if game.player_pos.distance_to(game.terminal_pos) <= game.INTERACT_RANGE:
		_apply_mission_updates(game.mission_controller.notify_reach_terminal())
		if game.actions_left <= 0:
			game.status_line = "Không còn lượt hành động. Hãy áp dụng lượt mới trước."
			game.ui_controller.update_ui()
			return

		var missing := missing_terminal_items()
		if missing.size() > 0:
			game.status_line = "Trạm đang khóa. Còn thiếu: %s" % ", ".join(missing)
			game.ui_controller.update_ui()
			return

		open_puzzle()


func on_use_kit_pressed() -> void:
	if not ensure_mission_started():
		return
	if game.game_over or game.puzzle_open:
		return
	if game.actions_left <= 0:
		game.status_line = "Không còn lượt hành động để dùng vật phẩm cứu nguy."
		game.ui_controller.update_ui()
		return

	if _consume_support_item("Bio Gel"):
		game.hp = clampf(game.hp + 18.0, 0.0, game.SurvivalSystem.HP_MAX)
		game.actions_left = maxi(game.actions_left - 1, 0)
		game.status_line = "Đã dùng Bio Gel: +18 HP."
	elif _consume_support_item("Portable Oxygen"):
		game.o2 = clampf(game.o2 + 24.0, 0.0, 100.0)
		game.actions_left = maxi(game.actions_left - 1, 0)
		game.status_line = "Đã dùng Portable Oxygen: +24 O2."
	elif _consume_support_item("Backup Battery"):
		game.battery = clampf(game.battery + 18.0, 0.0, game.SurvivalSystem.BATTERY_MAX)
		game.actions_left = maxi(game.actions_left - 1, 0)
		game.status_line = "Đã dùng Backup Battery: +18 pin."
	else:
		game.status_line = "Không có vật phẩm cứu nguy khả dụng trong túi đồ."

	check_loss_from_resources("sau khi dùng vật phẩm cứu nguy")
	game.ui_controller.update_ui()


func on_craft_pressed() -> void:
	if not ensure_mission_started():
		return
	if game.game_over or game.puzzle_open:
		return

	var recipe := _selected_recipe()
	if recipe.is_empty():
		game.status_line = "Chưa có công thức nào được chọn."
		game.ui_controller.update_ui()
		return

	var action_cost := int(recipe.get("action_cost", 1))
	var battery_cost := float(recipe.get("battery_cost", 0.0))
	if game.actions_left < action_cost:
		game.status_line = "Không đủ lượt hành động để chế tạo."
		game.ui_controller.update_ui()
		return
	if game.battery < battery_cost:
		game.status_line = "Không đủ pin để chế tạo %s." % str(recipe.get("name", "vật phẩm"))
		game.ui_controller.update_ui()
		return

	var missing := _missing_recipe_ingredients(recipe)
	if missing.size() > 0:
		game.status_line = "Thiếu nguyên liệu: %s" % ", ".join(missing)
		game.ui_controller.update_ui()
		return

	_consume_recipe_ingredients(recipe)
	game.actions_left = maxi(game.actions_left - action_cost, 0)
	game.battery = clampf(game.battery - battery_cost, 0.0, game.SurvivalSystem.BATTERY_MAX)

	var output_item := str(recipe.get("output_item", ""))
	if output_item != "":
		game.inventory.append(output_item)

	if recipe.has("instant_effects"):
		_apply_instant_effects(recipe["instant_effects"])

	if recipe.has("module"):
		var module_data: Dictionary = recipe["module"]
		var module_id := str(module_data.get("id", ""))
		var turns := int(module_data.get("turns", 0))
		if module_id != "" and turns > 0:
			var current_turns := int(game.active_modules.get(module_id, 0))
			game.active_modules[module_id] = maxi(current_turns, turns)

	game.status_line = "Đã chế tạo: %s" % str(recipe.get("name", "vật phẩm"))
	_apply_mission_updates(game.mission_controller.notify_recipe_crafted(str(recipe.get("id", ""))))
	game.ai_controller.log_ai("Hệ thống", game.status_line, "system")
	game.ui_controller.update_ui()


func current_recipe_preview_text() -> String:
	var recipe := _selected_recipe()
	if recipe.is_empty():
		return "Chế tạo: (không có)"

	var ingredients: PackedStringArray = PackedStringArray(recipe.get("ingredients", []))
	var ingredient_text := ", ".join(ingredients)
	var desc := str(recipe.get("description", ""))
	var battery_cost := int(recipe.get("battery_cost", 0))
	var action_cost := int(recipe.get("action_cost", 1))

	return (
		"Chế tạo: %s | Cần: %s | Pin:%d | Lượt:%d\n%s"
		% [str(recipe.get("name", "")), ingredient_text, battery_cost, action_cost, desc]
	)


func active_modules_text() -> String:
	if game.active_modules.is_empty():
		return "(không)"

	var parts: PackedStringArray = []
	for module_id in game.active_modules.keys():
		var label: String = game.GameData.module_name(str(module_id))
		parts.append("%s:%d" % [label, int(game.active_modules[module_id])])
	return ", ".join(parts)


func _selected_recipe() -> Dictionary:
	if game.craft_recipe_option == null:
		return {}
	var idx := int(game.craft_recipe_option.selected)
	if idx < 0 or idx >= game.craft_recipes.size():
		return {}
	return game.craft_recipes[idx]


func _missing_recipe_ingredients(recipe: Dictionary) -> Array[String]:
	var need_counts := {}
	var ingredients: Array = recipe.get("ingredients", [])
	for ingredient in ingredients:
		var name := str(ingredient)
		need_counts[name] = int(need_counts.get(name, 0)) + 1

	var missing: Array[String] = []
	for name in need_counts.keys():
		var required_count := int(need_counts[name])
		var current_count := count_item_in_inventory(str(name))
		if current_count < required_count:
			missing.append("%s x%d" % [str(name), required_count - current_count])
	return missing


func _consume_recipe_ingredients(recipe: Dictionary) -> void:
	var ingredients: Array = recipe.get("ingredients", [])
	for ingredient in ingredients:
		_remove_first_inventory_item(str(ingredient))


func _remove_first_inventory_item(item_name: String) -> void:
	var idx: int = game.inventory.find(item_name)
	if idx >= 0:
		game.inventory.remove_at(idx)


func _consume_support_item(item_name: String) -> bool:
	var idx: int = game.inventory.find(item_name)
	if idx < 0:
		return false
	game.inventory.remove_at(idx)
	return true


func _apply_instant_effects(effects: Dictionary) -> void:
	game.o2 = clampf(game.o2 + float(effects.get("o2", 0.0)), 0.0, 100.0)
	game.hydration = clampf(game.hydration + float(effects.get("hydration", 0.0)), 0.0, 100.0)
	game.satiety = clampf(game.satiety + float(effects.get("satiety", 0.0)), 0.0, 100.0)
	game.hp = clampf(game.hp + float(effects.get("hp", 0.0)), 0.0, game.SurvivalSystem.HP_MAX)
	game.battery = clampf(
		game.battery + float(effects.get("battery", 0.0)), 0.0, game.SurvivalSystem.BATTERY_MAX
	)
	game.actions_left = clampi(game.actions_left + int(effects.get("actions", 0)), 0, 6)


func count_item_in_inventory(item_name: String) -> int:
	var count := 0
	for entry in game.inventory:
		if entry == item_name:
			count += 1
	return count


func try_unlock_door(door_id: String) -> void:
	var door: Dictionary = game.doors[door_id]
	var required_item := str(door.get("required_item", ""))
	if required_item == "":
		return
	if game.inventory.has(required_item):
		door["unlocked"] = true
		game.doors[door_id] = door
		game.status_line = "%s đã mở. Đường đi mới đã khả dụng." % str(door.get("name", "Cửa"))
		_apply_mission_updates(game.mission_controller.notify_door_unlocked(door_id))
		game.ai_controller.log_ai("Hệ thống", game.status_line, "system")
	else:
		game.status_line = "%s cần vật phẩm: %s." % [str(door.get("name", "Cửa")), required_item]
	game.ui_controller.update_ui()


func pick_item(index: int) -> void:
	if game.actions_left <= 0:
		game.status_line = "Không còn lượt hành động. Hãy áp dụng lượt mới trước."
		game.ui_controller.update_ui()
		return

	game.items[index]["collected"] = true
	var name := str(game.items[index]["name"])
	var item_type := str(game.items[index]["type"])
	game.inventory.append(name)
	game.actions_left = maxi(game.actions_left - 1, 0)

	if item_type == "key":
		game.status_line = "Đã nhặt %s. Có thể mở khu tiếp theo." % name
	elif item_type == "repair":
		game.status_line = "Đã nhặt repair item: %s." % name
	else:
		game.status_line = "Đã nhặt: %s" % name
	_apply_mission_updates(game.mission_controller.notify_item_collected(name))
	game.ui_controller.update_ui()


func missing_terminal_items() -> Array[String]:
	var missing: Array[String] = []
	var required_items: Array[String] = game.GameData.required_terminal_items_for_stage(
		game.repair_stage_index
	)
	for item_name in required_items:
		if not game.inventory.has(item_name):
			missing.append(item_name)
	return missing


func on_alloc_changed(value: float, key: String) -> void:
	game.allocation[key] = int(value)
	game.ui_controller.update_ui()


func on_apply_turn_pressed() -> void:
	if not ensure_mission_started():
		return
	if game.game_over:
		return

	var alloc_now := get_allocation_from_ui()
	if not game.SurvivalSystem.allocation_valid(alloc_now, game.battery):
		game.status_line = "Phân bổ không hợp lệ: mỗi hệ <= 6, tổng <= 12, tổng <= pin hiện có."
		game.ui_controller.update_ui()
		return

	apply_survival_result(game.SurvivalSystem.apply_turn(build_survival_state(), alloc_now))
	if game.game_over:
		game.ui_controller.update_ui()
		return

	apply_random_event()
	_apply_active_modules()
	check_loss_from_resources("cuối lượt")
	if game.game_over:
		game.ui_controller.update_ui()
		return

	if game.turn >= game.max_turns:
		if game.repair_progress >= 100.0:
			set_win()
		else:
			set_game_over("Hết thời gian trước khi sửa xong phi thuyền.")
		game.ui_controller.update_ui()
		return

	game.turn += 1
	game.actions_left = game.SurvivalSystem.next_actions_budget(game.o2, game.hydration, game.satiety)
	reset_allocation_ui()

	if game.last_event_title == "Ổn định":
		game.status_line = "Bắt đầu lượt %d. Không có sự cố mới." % game.turn
	else:
		game.status_line = "Bắt đầu lượt %d. Vừa qua: %s." % [game.turn, game.last_event_title]
	game.ui_controller.update_ui()


func _apply_active_modules() -> void:
	if game.active_modules.is_empty():
		return

	var notes: PackedStringArray = []
	var module_ids = game.active_modules.keys()
	for module_id in module_ids:
		var module_key := str(module_id)
		var remain := int(game.active_modules.get(module_key, 0))
		if remain <= 0:
			game.active_modules.erase(module_key)
			continue

		match module_key:
			"power_regulator":
				game.battery = minf(game.SurvivalSystem.BATTERY_MAX, game.battery + 2.0)
				notes.append("+2 pin")
			_:
				pass

		remain -= 1
		if remain <= 0:
			game.active_modules.erase(module_key)
		else:
			game.active_modules[module_key] = remain

	if notes.size() > 0:
		game.status_line = "Hiệu ứng module: %s" % ", ".join(notes)


func build_survival_state() -> Dictionary:
	return {
		"battery": game.battery,
		"temp": game.temp,
		"ambient_temp": game.ambient_temp,
		"o2": game.o2,
		"hydration": game.hydration,
		"satiety": game.satiety,
		"hp": game.hp,
		"repair_progress": game.repair_progress
	}


func apply_survival_result(result: Dictionary) -> void:
	game.battery = float(result.get("battery", game.battery))
	game.temp = float(result.get("temp", game.temp))
	game.o2 = float(result.get("o2", game.o2))
	game.hydration = float(result.get("hydration", game.hydration))
	game.satiety = float(result.get("satiety", game.satiety))
	game.hp = float(result.get("hp", game.hp))

	var damage := float(result.get("damage", 0.0))
	if not bool(result.get("game_over", false)):
		if damage > 0.0:
			game.status_line = "Lượt này bạn mất %.1f HP do cân bằng sinh tồn kém." % damage
		else:
			game.status_line = "Lượt này ổn định. Hãy tiếp tục khám phá."

	if bool(result.get("game_over", false)):
		if bool(result.get("win", false)):
			set_win()
		else:
			set_game_over(str(result.get("death_reason", "Hệ thống sinh tồn sụp đổ.")))


func apply_random_event() -> void:
	var event_result: Dictionary = game.EventSystem.roll_event(game.rng, build_survival_state())
	var event_state: Dictionary = event_result["state"]

	game.battery = float(event_state.get("battery", game.battery))
	game.temp = float(event_state.get("temp", game.temp))
	game.o2 = float(event_state.get("o2", game.o2))
	game.hydration = float(event_state.get("hydration", game.hydration))
	game.satiety = float(event_state.get("satiety", game.satiety))

	game.last_event_title = str(event_result.get("title", "Ổn định"))
	game.last_event_description = str(event_result.get("description", ""))

	if bool(event_result.get("triggered", false)):
		game.status_line = "Sự cố: %s. %s" % [game.last_event_title, game.last_event_description]
		game.ai_controller.log_ai(
			"Hệ thống",
			"Sự kiện lượt: %s - %s" % [game.last_event_title, game.last_event_description],
			"system"
		)
	else:
		game.status_line = "Lượt này không có sự cố bất thường."


func check_loss_from_resources(context: String) -> void:
	if game.o2 <= 0.0:
		set_game_over("Oxy đã cạn %s." % context)
		return
	if game.hp <= 0.0:
		set_game_over("Phi hành gia gục ngã %s." % context)
		return
	if game.battery <= 0.0 and game.repair_progress < 100.0:
		set_game_over("Pin cạn %s trước khi sửa xong phi thuyền." % context)


func get_allocation_from_ui() -> Dictionary:
	return {
		"heater": int((game.allocation_spins["heater"] as SpinBox).value),
		"oxygen": int((game.allocation_spins["oxygen"] as SpinBox).value),
		"water": int((game.allocation_spins["water"] as SpinBox).value),
		"food": int((game.allocation_spins["food"] as SpinBox).value)
	}


func reset_allocation_ui() -> void:
	for key in game.allocation_spins.keys():
		var spin: SpinBox = game.allocation_spins[key]
		spin.value = 0
		game.allocation[key] = 0


func open_puzzle() -> void:
	if game.current_puzzle_index >= game.puzzles.size():
		game.status_line = "Bạn đã giải hết câu đố. Hãy duy trì tài nguyên đến khi escape."
		game.ui_controller.update_ui()
		return

	game.puzzle_open = true
	game.puzzle_panel.visible = true
	refresh_puzzle_panel()


func refresh_puzzle_panel() -> void:
	var puzzle: Dictionary = game.puzzles[game.current_puzzle_index]
	game.puzzle_question_label.text = (
		"Câu đố %d/%d\n%s"
		% [game.current_puzzle_index + 1, game.puzzles.size(), str(puzzle["question"])]
	)

	var options: Array = puzzle["options"]
	for i in range(game.puzzle_option_buttons.size()):
		game.puzzle_option_buttons[i].text = "%d) %s" % [i + 1, str(options[i])]


func on_puzzle_choice(index: int) -> void:
	if not game.puzzle_open or game.game_over:
		return

	var puzzle_index: int = game.current_puzzle_index
	var puzzle: Dictionary = game.puzzles[puzzle_index]
	game.actions_left = maxi(game.actions_left - 1, 0)

	if index == int(puzzle["correct"]):
		var reward := float(puzzle["reward"])
		game.repair_progress = minf(100.0, game.repair_progress + reward)
		var stage_message := update_repair_stage_progress()
		game.status_line = "Đúng rồi. Tiến độ sửa tàu +%d%%." % int(reward)
		if stage_message != "":
			game.status_line += " " + stage_message
		_apply_mission_updates(game.mission_controller.notify_puzzle_solved(puzzle_index))
		_apply_mission_updates(game.mission_controller.notify_repair_progress(game.repair_progress))
		game.ai_controller.log_ai("Hệ thống", "Giải đúng câu đố. Tiến trình được mở rộng.", "system")
		game.current_puzzle_index += 1
	else:
		game.hp = clampf(game.hp - 8.0, 0.0, game.SurvivalSystem.HP_MAX)
		game.status_line = "Sai đáp án. HP -8."
		game.ai_controller.log_ai("AI", "Gợi ý: %s" % str(puzzle["hint"]), "offline")

	game.puzzle_open = false
	game.puzzle_panel.visible = false

	if game.hp <= 0.0:
		set_game_over("Phi hành gia thất bại trong quá trình sửa tàu.")
	elif game.repair_progress >= 100.0:
		set_win()

	game.ui_controller.update_ui()


func update_repair_stage_progress() -> String:
	var combined_message := ""
	while game.repair_stage_index < game.repair_stages.size():
		var stage: Dictionary = game.repair_stages[game.repair_stage_index]
		if game.repair_progress < float(stage.get("threshold", 100.0)):
			break
		var msg := "Đạt mốc sửa tàu: %s" % str(stage.get("name", "Không rõ"))
		if combined_message != "":
			combined_message += " | "
		combined_message += msg
		game.ai_controller.log_ai("Hệ thống", msg, "system")
		game.repair_stage_index += 1
	return combined_message


func on_close_puzzle_pressed() -> void:
	game.puzzle_open = false
	game.puzzle_panel.visible = false
	game.ui_controller.update_ui()


func set_game_over(reason: String) -> void:
	game.game_over = true
	game.win = false
	game.death_reason = reason
	game.status_line = "THUA CUỘC: %s" % reason
	game.ai_controller.log_ai("Hệ thống", game.status_line, "system")


func set_win() -> void:
	game.game_over = true
	game.win = true
	game.death_reason = ""
	game.status_line = "CHIẾN THẮNG: Bạn đã sửa tàu và kích hoạt escape thành công."
	game.ai_controller.log_ai("Hệ thống", game.status_line, "system")


func current_stage_goal_text() -> String:
	if game.repair_stage_index >= game.repair_stages.size():
		return "Đã hoàn thành toàn bộ mốc sửa tàu."
	var stage: Dictionary = game.repair_stages[game.repair_stage_index]
	var required_items: Array[String] = game.GameData.required_terminal_items_for_stage(
		game.repair_stage_index
	)
	if required_items.is_empty():
		return "%s (mục tiêu %.0f%%)" % [str(stage.get("name", "")), float(stage.get("threshold", 100.0))]
	return "%s (cần: %s)" % [str(stage.get("name", "")), ", ".join(required_items)]


func current_puzzle_hint() -> String:
	if game.current_puzzle_index < game.puzzles.size():
		return str(game.puzzles[game.current_puzzle_index]["hint"])
	return "Hiện không còn câu đố mở."


func _apply_mission_updates(messages: Array[String]) -> void:
	if messages.is_empty():
		return

	var mission_line := "Nhiệm vụ: " + " | ".join(messages)
	if game.status_line == "":
		game.status_line = mission_line
	else:
		game.status_line += "\n" + mission_line
	game.ai_controller.log_ai("Hệ thống", mission_line, "system")

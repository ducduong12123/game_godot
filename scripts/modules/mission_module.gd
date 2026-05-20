extends RefCounted

const MissionData = preload("res://scripts/content/mission_data.gd")

var game
var stage_definitions: Array = []
var completed_tasks := {}


func setup(game_ref) -> void:
	game = game_ref
	stage_definitions = MissionData.create_stage_definitions()
	reset()


func reset() -> void:
	completed_tasks.clear()


func start_mission() -> Array[String]:
	reset()
	return ["Nhiệm vụ bắt đầu: %s" % current_stage_title()]


func notify_item_collected(item_name: String) -> Array[String]:
	return _complete_matching("collect_item", item_name)


func notify_door_unlocked(door_id: String) -> Array[String]:
	return _complete_matching("unlock_door", door_id)


func notify_reach_terminal() -> Array[String]:
	return _complete_matching("reach_terminal", "")


func notify_recipe_crafted(recipe_id: String) -> Array[String]:
	return _complete_matching("craft_recipe", recipe_id)


func notify_puzzle_solved(puzzle_index: int) -> Array[String]:
	return _complete_matching("solve_puzzle", puzzle_index)


func notify_repair_progress(progress: float) -> Array[String]:
	var updates: Array[String] = []
	for stage in stage_definitions:
		for task in stage.get("tasks", []):
			var task_dict: Dictionary = task
			if str(task_dict.get("type", "")) != "repair_progress":
				continue
			var task_id := str(task_dict.get("id", ""))
			if bool(completed_tasks.get(task_id, false)):
				continue
			if progress >= float(task_dict.get("target", 999.0)):
				updates.append_array(_complete_task(task_dict))
	return updates


func current_stage_title() -> String:
	var stage := _current_stage()
	return str(stage.get("title", "Hoàn tất nhiệm vụ"))


func current_stage_summary() -> String:
	var stage := _current_stage()
	return str(stage.get("summary", "Toàn bộ nhiệm vụ đã hoàn tất."))


func detail_text() -> String:
	var lines: PackedStringArray = []
	var active_stage_index := _active_stage_index()
	var total_tasks := 0
	var done_tasks := 0

	for stage in stage_definitions:
		for task in stage.get("tasks", []):
			total_tasks += 1
			if bool(completed_tasks.get(str((task as Dictionary).get("id", "")), false)):
				done_tasks += 1

	lines.append("Tiến độ tổng: %d/%d nhiệm vụ con" % [done_tasks, total_tasks])
	lines.append("")

	if active_stage_index >= stage_definitions.size():
		lines.append("Tất cả nhiệm vụ đã hoàn thành.")
		return "\n".join(lines)

	for index in range(stage_definitions.size()):
		var stage: Dictionary = stage_definitions[index]
		var prefix := ">> " if index == active_stage_index else "   "
		lines.append("%s%s" % [prefix, str(stage.get("title", ""))])
		if index == active_stage_index:
			lines.append("   %s" % str(stage.get("summary", "")))
		for task in stage.get("tasks", []):
			var task_dict: Dictionary = task
			var mark := "[x]" if bool(completed_tasks.get(str(task_dict.get("id", "")), false)) else "[ ]"
			lines.append("   %s %s" % [mark, str(task_dict.get("description", ""))])
		if index >= active_stage_index + 1:
			break
		lines.append("")

	return "\n".join(lines)


func _active_stage_index() -> int:
	for index in range(stage_definitions.size()):
		if not _stage_completed(stage_definitions[index]):
			return index
	return stage_definitions.size()


func _current_stage() -> Dictionary:
	var index := _active_stage_index()
	if index >= stage_definitions.size():
		return {}
	return stage_definitions[index]


func _stage_completed(stage: Dictionary) -> bool:
	for task in stage.get("tasks", []):
		var task_dict: Dictionary = task
		if not bool(completed_tasks.get(str(task_dict.get("id", "")), false)):
			return false
	return true


func _complete_matching(task_type: String, target) -> Array[String]:
	var updates: Array[String] = []
	for stage in stage_definitions:
		for task in stage.get("tasks", []):
			var task_dict: Dictionary = task
			if str(task_dict.get("type", "")) != task_type:
				continue
			var task_id := str(task_dict.get("id", ""))
			if bool(completed_tasks.get(task_id, false)):
				continue
			if task_dict.get("target") == target:
				updates.append_array(_complete_task(task_dict))
	return updates


func _complete_task(task_dict: Dictionary) -> Array[String]:
	var updates: Array[String] = []
	var task_id := str(task_dict.get("id", ""))
	completed_tasks[task_id] = true
	updates.append("Hoàn thành: %s" % str(task_dict.get("description", "")))

	var stage_index := _find_stage_index_for_task(task_id)
	if stage_index >= 0:
		var stage: Dictionary = stage_definitions[stage_index]
		if _stage_completed(stage):
			updates.append("Xong giai đoạn: %s" % str(stage.get("title", "")))
			var next_index := stage_index + 1
			if next_index < stage_definitions.size():
				updates.append("Tiếp theo: %s" % str(stage_definitions[next_index].get("title", "")))
	return updates


func _find_stage_index_for_task(task_id: String) -> int:
	for index in range(stage_definitions.size()):
		for task in stage_definitions[index].get("tasks", []):
			var task_dict: Dictionary = task
			if str(task_dict.get("id", "")) == task_id:
				return index
	return -1

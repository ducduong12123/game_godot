extends RefCounted

var game
var _ui_font: Font = null


func setup(game_ref) -> void:
	game = game_ref
	_ui_font = _load_font_from_file("res://assets/fonts/BeVietnamPro-Regular.ttf")


func draw() -> void:
	_draw_background()
	_draw_rooms()
	_draw_grid()
	_draw_walls()
	_draw_doors()
	_draw_terminal()
	_draw_items()
	_draw_player()
	_draw_room_labels()


func try_move_player(delta_move: Vector2) -> void:
	var next_pos = game.player_pos + delta_move
	next_pos.x = clampf(
		next_pos.x,
		game.WORLD_RECT.position.x + 10.0,
		game.WORLD_RECT.position.x + game.WORLD_RECT.size.x - 10.0
	)
	next_pos.y = clampf(
		next_pos.y,
		game.WORLD_RECT.position.y + 10.0,
		game.WORLD_RECT.position.y + game.WORLD_RECT.size.y - 10.0
	)

	if _can_move_to(next_pos):
		game.player_pos = next_pos


func _can_move_to(next_pos: Vector2) -> bool:
	if _crosses_wall(game.player_pos, next_pos, game.MapData.WALL_X, true):
		return false
	if _crosses_wall(game.player_pos, next_pos, game.MapData.WALL_Y, false):
		return false
	return true


func _crosses_wall(from_pos: Vector2, to_pos: Vector2, wall_line: float, is_vertical: bool) -> bool:
	var from_coord := from_pos.x if is_vertical else from_pos.y
	var to_coord := to_pos.x if is_vertical else to_pos.y
	if is_equal_approx(from_coord, to_coord):
		return false
	var crossed := (from_coord < wall_line and to_coord >= wall_line) or (from_coord > wall_line and to_coord <= wall_line)
	if not crossed:
		return false
	var t: float = (wall_line - from_coord) / (to_coord - from_coord)
	if t < 0.0 or t > 1.0:
		return false
	var cross_at := lerpf(from_pos.y, to_pos.y, t) if is_vertical else lerpf(from_pos.x, to_pos.x, t)
	var orientation := "vertical" if is_vertical else "horizontal"
	return not _is_wall_open_at(orientation, cross_at)


func _is_wall_open_at(orientation: String, cross_value: float) -> bool:
	for door_id in game.doors.keys():
		var door: Dictionary = game.doors[door_id]
		if str(door.get("orientation", "")) != orientation:
			continue
		var start_value = float(door.get("start", 0.0))
		var end_value = float(door.get("end", 0.0))
		if cross_value >= start_value and cross_value <= end_value:
			return door_is_open(door_id)
	return false


func door_is_open(door_id: String) -> bool:
	var door: Dictionary = game.doors[door_id]
	var required_item = str(door.get("required_item", ""))
	if required_item == "":
		return true
	return bool(door.get("unlocked", false))


func nearest_door_id() -> String:
	var nearest = ""
	var best_dist = game.INTERACT_RANGE
	for door_id in game.doors.keys():
		var dist = game.player_pos.distance_to(game.MapData.door_center(game.doors[door_id]))
		if dist <= best_dist:
			best_dist = dist
			nearest = door_id
	return nearest


func nearest_locked_door_id() -> String:
	for door_id in game.doors.keys():
		if door_is_open(door_id):
			continue
		var dist = game.player_pos.distance_to(game.MapData.door_center(game.doors[door_id]))
		if dist <= game.INTERACT_RANGE:
			return door_id
	return ""


func update_near_item() -> void:
	var nearest_idx := _find_nearest_uncollected_item()
	game.near_item_index = nearest_idx


func _find_nearest_uncollected_item() -> int:
	var best_dist := INF
	var nearest := -1
	for i in range(game.items.size()):
		if bool(game.items[i]["collected"]):
			continue
		var dist: float = game.player_pos.distance_to(game.items[i]["pos"])
		if dist <= game.INTERACT_RANGE and dist < best_dist:
			best_dist = dist
			nearest = i
	return nearest


func room_name_at_player() -> String:
	return game.MapData.room_name_at(game.player_pos)


func _draw_background() -> void:
	game.draw_rect(
		Rect2(Vector2.ZERO, game.get_viewport_rect().size), Color(0.04, 0.07, 0.12), true
	)


func _draw_rooms() -> void:
	for room in game.rooms:
		var room_rect: Rect2 = room["rect"]
		game.draw_rect(room_rect, room["color"], true)
		game.draw_rect(room_rect, Color(0.35, 0.50, 0.68, 0.70), false, 1.2)


func _draw_grid() -> void:
	var grid_color := Color(0.12, 0.18, 0.28, 0.32)
	var world_rect: Rect2 = game.WORLD_RECT
	for x in range(int(world_rect.position.x) + 20, int(world_rect.position.x + world_rect.size.x), 40):
		game.draw_line(
			Vector2(x, world_rect.position.y),
			Vector2(x, world_rect.position.y + world_rect.size.y),
			grid_color,
			1.0
		)
	for y in range(int(world_rect.position.y) + 20, int(world_rect.position.y + world_rect.size.y), 40):
		game.draw_line(
			Vector2(world_rect.position.x, y),
			Vector2(world_rect.position.x + world_rect.size.x, y),
			grid_color,
			1.0
		)


func _draw_walls() -> void:
	var wall_color := Color(0.70, 0.72, 0.82, 0.85)
	game.draw_rect(game.WORLD_RECT, Color(0.50, 0.62, 0.80, 0.75), false, 2.0)
	game.draw_line(
		Vector2(game.MapData.WALL_X, game.WORLD_RECT.position.y),
		Vector2(game.MapData.WALL_X, game.WORLD_RECT.position.y + game.WORLD_RECT.size.y),
		wall_color,
		6.0
	)
	game.draw_line(
		Vector2(game.WORLD_RECT.position.x, game.MapData.WALL_Y),
		Vector2(game.WORLD_RECT.position.x + game.WORLD_RECT.size.x, game.MapData.WALL_Y),
		wall_color,
		6.0
	)


func _draw_doors() -> void:
	for door_id in game.doors.keys():
		var door: Dictionary = game.doors[door_id]
		var is_open: bool = door_is_open(door_id)
		var door_color := Color(0.24, 0.80, 0.52) if is_open else Color(0.85, 0.30, 0.30)
		var door_rect := _door_rect_from_dict(door)
		game.draw_rect(door_rect, door_color, true)

		if _ui_font != null:
			var door_center: Vector2 = game.MapData.door_center(door)
			game.draw_string(
				_ui_font,
				door_center + Vector2(12, -6),
				str(door.get("name", "")),
				HORIZONTAL_ALIGNMENT_LEFT,
				-1.0,
				12,
				Color(0.92, 0.94, 0.98)
			)


func _door_rect_from_dict(door: Dictionary) -> Rect2:
	var line_val := float(door.get("line", 0.0))
	var start_val := float(door.get("start", 0.0))
	var end_val := float(door.get("end", 0.0))
	if str(door.get("orientation", "")) == "vertical":
		return Rect2(line_val - 5.0, start_val, 10.0, end_val - start_val)
	return Rect2(start_val, line_val - 5.0, end_val - start_val, 10.0)


func _draw_terminal() -> void:
	game.draw_circle(game.terminal_pos, 12.0, Color(0.90, 0.72, 0.25))
	game.draw_circle(game.terminal_pos, 22.0, Color(0.90, 0.72, 0.25, 0.16))


func _draw_items() -> void:
	for item in game.items:
		if bool(item["collected"]):
			continue
		var p: Vector2 = item["pos"]
		var item_color := _item_color_for_type(str(item["type"]))
		game.draw_circle(p, 10.0, item_color)
		game.draw_circle(p, 18.0, Color(item_color.r, item_color.g, item_color.b, 0.15))


func _item_color_for_type(item_type: String) -> Color:
	match item_type:
		"battery":
			return Color(0.48, 0.90, 0.58)
		"key":
			return Color(0.95, 0.66, 0.30)
		"material":
			return Color(0.82, 0.62, 0.96)
		_:
			return Color(0.50, 0.82, 0.97)


func _draw_player() -> void:
	game.draw_circle(game.player_pos, 11.0, Color(0.95, 0.95, 0.98))
	game.draw_circle(game.player_pos, 22.0, Color(0.85, 0.90, 1.0, 0.12))


func _draw_room_labels() -> void:
	if _ui_font == null:
		return
	for room in game.rooms:
		var room_rect: Rect2 = room["rect"]
		game.draw_string(
			_ui_font,
			room_rect.position + Vector2(10, 18),
			str(room["name"]),
			HORIZONTAL_ALIGNMENT_LEFT,
			-1.0,
			13,
			Color(0.90, 0.95, 1.0, 0.80)
		)


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

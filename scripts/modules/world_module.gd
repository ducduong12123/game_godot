extends RefCounted

var game
var _ui_font: Font = null
var _sprite_textures: Dictionary = {}
var _item_nodes: Dictionary = {}
var _door_nodes: Dictionary = {}
var _terminal_node: Sprite2D = null
var _player_node: Sprite2D = null
var _player_facing := "down"
var _last_player_pos := Vector2.ZERO


func setup(game_ref) -> void:
	game = game_ref
	_ui_font = _load_font_from_file("res://assets/fonts/BeVietnamPro-Regular.ttf")
	_last_player_pos = game.player_pos
	_load_custom_sprites()
	_bind_editable_world_nodes()
	_sync_player_start_from_editable_node()
	_last_player_pos = game.player_pos
	_sync_data_from_editable_nodes()


func draw() -> void:
	_sync_data_from_editable_nodes()
	_sync_editable_visual_nodes()

	if game.external_map_root == null:
		_draw_background()
		_draw_rooms()
		_draw_grid()
		_draw_walls()
		_draw_room_labels()

	if _door_nodes.is_empty():
		_draw_doors()
	if _terminal_node == null:
		_draw_terminal()
	if _item_nodes.is_empty():
		_draw_items()
	if _player_node == null:
		_draw_player()


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
		_update_player_facing(delta_move)


func _can_move_to(next_pos: Vector2) -> bool:
	if _locked_door_blocks(next_pos):
		return false

	if game.external_map_root != null:
		return not _external_map_blocks(next_pos)

	if _crosses_wall(game.player_pos, next_pos, game.MapData.WALL_X, true):
		return false
	if _crosses_wall(game.player_pos, next_pos, game.MapData.WALL_Y, false):
		return false
	return true


func _locked_door_blocks(next_pos: Vector2) -> bool:
	for door_id in game.doors.keys():
		if door_is_open(door_id):
			continue
		var door: Dictionary = game.doors[door_id]
		var block_rect := _door_rect_from_dict(door).grow(18.0)
		if block_rect.has_point(next_pos):
			return true
	return false


func _external_map_blocks(next_pos: Vector2) -> bool:
	var circle := CircleShape2D.new()
	circle.radius = 14.0

	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = circle
	query.transform = Transform2D(0.0, game.to_global(next_pos))
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1

	var hits: Array[Dictionary] = game.get_world_2d().direct_space_state.intersect_shape(query, 1)
	return not hits.is_empty()


func _crosses_wall(from_pos: Vector2, to_pos: Vector2, wall_line: float, is_vertical: bool) -> bool:
	var from_coord := from_pos.x if is_vertical else from_pos.y
	var to_coord := to_pos.x if is_vertical else to_pos.y
	if is_equal_approx(from_coord, to_coord):
		return false
	var crossed := (
		(from_coord < wall_line and to_coord >= wall_line)
		or (from_coord > wall_line and to_coord <= wall_line)
	)
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
		var is_locked := str(door.get("required_item", "")) != "" and not is_open
		var door_color := Color(0.24, 0.80, 0.52) if is_open else Color(0.85, 0.30, 0.30)
		var door_rect := _door_rect_from_dict(door)
		game.draw_rect(door_rect, door_color, true)

		var door_sprite := "door_open" if is_open else ("door_locked" if is_locked else "door_closed")
		var door_center: Vector2 = game.MapData.door_center(door)
		_draw_sprite_centered(door_sprite, door_center, Vector2(58, 58))

		if _ui_font != null:
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
	game.draw_circle(game.terminal_pos, 22.0, Color(0.90, 0.72, 0.25, 0.16))
	if not _draw_sprite_centered("terminal", game.terminal_pos, Vector2(42, 42)):
		game.draw_circle(game.terminal_pos, 12.0, Color(0.90, 0.72, 0.25))


func _draw_items() -> void:
	for item in game.items:
		if bool(item["collected"]):
			continue
		var p: Vector2 = item["pos"]
		var item_color := _item_color_for_type(str(item["type"]))
		game.draw_circle(p, 18.0, Color(item_color.r, item_color.g, item_color.b, 0.15))
		var sprite_key := _sprite_key_for_item_name(str(item["name"]))
		if not _draw_sprite_centered(sprite_key, p, Vector2(36, 36)):
			game.draw_circle(p, 10.0, item_color)


func _item_color_for_type(item_type: String) -> Color:
	match item_type:
		"key":
			return Color(0.95, 0.66, 0.30)
		"material":
			return Color(0.82, 0.62, 0.96)
		"consumable":
			return Color(0.48, 0.90, 0.58)
		"repair":
			return Color(0.50, 0.82, 0.97)
		_:
			return Color(0.80, 0.80, 0.85)


func _draw_player() -> void:
	game.draw_circle(game.player_pos, 22.0, Color(0.85, 0.90, 1.0, 0.12))
	var player_sprite := _current_player_sprite()
	if not _draw_sprite_centered(player_sprite, game.player_pos, Vector2(54, 54)):
		game.draw_circle(game.player_pos, 11.0, Color(0.95, 0.95, 0.98))


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


func _load_custom_sprites() -> void:
	var sprite_names := [
		"air_filter_module",
		"alloy_plate",
		"backup_battery",
		"bio_gel",
		"door_closed",
		"door_locked",
		"door_open",
		"electrolyte_pack",
		"engineer_log",
		"level_1_access_card",
		"navigation_board",
		"player_idle_down",
		"player_idle_side",
		"player_idle_up",
		"player_walk_down_1",
		"player_walk_down_2",
		"player_walk_side_1",
		"player_walk_side_2",
		"player_walk_up_1",
		"player_walk_up_2",
		"portable_oxygen",
		"reactor_core",
		"repair_station",
		"superconductor_wire",
		"terminal"
	]

	for sprite_name in sprite_names:
		var path := "res://assets/custom_sprites/%s.png" % sprite_name
		var texture := _load_png_texture(path)
		if texture != null:
			_sprite_textures[sprite_name] = texture


func _load_png_texture(path: String) -> Texture2D:
	if ResourceLoader.exists(path):
		var resource := load(path)
		if resource is Texture2D:
			return resource

	if not FileAccess.file_exists(path):
		return null

	var image := Image.new()
	var err := image.load(path)
	if err != OK:
		return null
	return ImageTexture.create_from_image(image)


func _bind_editable_world_nodes() -> void:
	_item_nodes.clear()
	_door_nodes.clear()
	_terminal_node = game.get_node_or_null("WorldObjects/Terminal") as Sprite2D
	_player_node = game.get_node_or_null("WorldObjects/Player") as Sprite2D

	var item_root: Node = game.get_node_or_null("WorldObjects/Items")
	if item_root != null:
		var used_indices := {}
		for child in item_root.get_children():
			if child is not Node2D:
				continue
			var item_name := _item_name_for_node_name(child.name)
			if item_name == "":
				continue
			var item_index := _first_unused_item_index(item_name, used_indices)
			if item_index < 0:
				continue
			used_indices[item_index] = true
			_item_nodes[item_index] = child

	var door_root: Node = game.get_node_or_null("WorldObjects/Doors")
	if door_root != null:
		for child in door_root.get_children():
			if child is not Node2D:
				continue
			var door_id := _door_id_for_node_name(child.name)
			if door_id != "" and game.doors.has(door_id):
				_door_nodes[door_id] = child


func _sync_data_from_editable_nodes() -> void:
	for item_index in _item_nodes.keys():
		if int(item_index) < 0 or int(item_index) >= game.items.size():
			continue
		var item_node := _item_nodes[item_index] as Node2D
		if item_node != null:
			game.items[item_index]["pos"] = game.to_local(item_node.global_position)

	if _terminal_node != null:
		game.terminal_pos = game.to_local(_terminal_node.global_position)

	for door_id in _door_nodes.keys():
		var door_node := _door_nodes[door_id] as Node2D
		if door_node == null:
			continue
		var door: Dictionary = game.doors[door_id]
		var orientation := str(door.get("orientation", ""))
		var start_val := float(door.get("start", 0.0))
		var end_val := float(door.get("end", 0.0))
		var half_len := (end_val - start_val) * 0.5
		var door_pos: Vector2 = game.to_local(door_node.global_position)
		if orientation == "vertical":
			door["line"] = door_pos.x
			door["start"] = door_pos.y - half_len
			door["end"] = door_pos.y + half_len
		else:
			door["line"] = door_pos.y
			door["start"] = door_pos.x - half_len
			door["end"] = door_pos.x + half_len
		game.doors[door_id] = door


func _sync_player_start_from_editable_node() -> void:
	if _player_node == null:
		return
	game.player_pos = game.to_local(_player_node.global_position)


func _sync_editable_visual_nodes() -> void:
	for item_index in _item_nodes.keys():
		if int(item_index) < 0 or int(item_index) >= game.items.size():
			continue
		var item_node := _item_nodes[item_index] as CanvasItem
		if item_node != null:
			item_node.visible = not bool(game.items[item_index]["collected"])

	for door_id in _door_nodes.keys():
		var door_node := _door_nodes[door_id] as Sprite2D
		if door_node == null:
			continue
		var door: Dictionary = game.doors[door_id]
		var is_open := door_is_open(door_id)
		var is_locked := str(door.get("required_item", "")) != "" and not is_open
		var sprite_key := "door_open" if is_open else ("door_locked" if is_locked else "door_closed")
		_set_sprite_texture(door_node, sprite_key)

	if _terminal_node != null:
		_set_sprite_texture(_terminal_node, "terminal")

	if _player_node != null:
		_player_node.global_position = game.to_global(game.player_pos)
		_set_sprite_texture(_player_node, _current_player_sprite())


func _set_sprite_texture(node: Sprite2D, sprite_key: String) -> void:
	if node == null or not _sprite_textures.has(sprite_key):
		return
	node.texture = _sprite_textures[sprite_key]


func _first_unused_item_index(item_name: String, used_indices: Dictionary) -> int:
	for index in range(game.items.size()):
		if bool(used_indices.get(index, false)):
			continue
		if str(game.items[index].get("name", "")) == item_name:
			return index
	return -1


func _item_name_for_node_name(node_name: String) -> String:
	match node_name:
		"Item_Level1AccessCard":
			return "Level 1 Access Card"
		"Item_EngineerLog":
			return "Engineer Log"
		"Item_BackupBattery":
			return "Backup Battery"
		"Item_PortableOxygen":
			return "Portable Oxygen"
		"Item_BioGel":
			return "Bio Gel"
		"Item_AirFilterModule":
			return "Air Filter Module"
		"Item_AlloyPlate_1", "Item_AlloyPlate_2":
			return "Alloy Plate"
		"Item_ElectrolytePack_1", "Item_ElectrolytePack_2":
			return "Electrolyte Pack"
		"Item_SuperconductorWire_1", "Item_SuperconductorWire_2":
			return "Superconductor Wire"
		_:
			return ""


func _door_id_for_node_name(node_name: String) -> String:
	match node_name:
		"Door_ArchiveMedlab":
			return "door_archive_medlab"
		"Door_HallDecon":
			return "door_hall_decon"
		"Door_SpecimenHall":
			return "door_specimen_hall"
		"Door_OpsDecon":
			return "door_ops_decon"
		_:
			return ""


func _draw_sprite_centered(sprite_key: String, center: Vector2, size: Vector2) -> bool:
	if not _sprite_textures.has(sprite_key):
		return false
	var texture: Texture2D = _sprite_textures[sprite_key]
	var rect := Rect2(center - size * 0.5, size)
	game.draw_texture_rect(texture, rect, false)
	return true


func _sprite_key_for_item_name(item_name: String) -> String:
	match item_name:
		"Level 1 Access Card":
			return "level_1_access_card"
		"Engineer Log":
			return "engineer_log"
		"Backup Battery":
			return "backup_battery"
		"Portable Oxygen":
			return "portable_oxygen"
		"Bio Gel":
			return "bio_gel"
		"Air Filter Module":
			return "air_filter_module"
		"Alloy Plate":
			return "alloy_plate"
		"Electrolyte Pack":
			return "electrolyte_pack"
		"Superconductor Wire":
			return "superconductor_wire"
		"Navigation Board":
			return "navigation_board"
		"Reactor Core":
			return "reactor_core"
		_:
			return ""


func _update_player_facing(delta_move: Vector2) -> void:
	if delta_move.length_squared() <= 0.0:
		return
	if absf(delta_move.x) > absf(delta_move.y):
		_player_facing = "side"
	elif delta_move.y < 0.0:
		_player_facing = "up"
	else:
		_player_facing = "down"


func _current_player_sprite() -> String:
	var is_moving: bool = game.player_pos.distance_squared_to(_last_player_pos) > 0.1
	_last_player_pos = game.player_pos
	if not is_moving:
		return "player_idle_%s" % _player_facing

	var frame: int = 1 + int((Time.get_ticks_msec() / 220) % 2)
	return "player_walk_%s_%d" % [_player_facing, frame]

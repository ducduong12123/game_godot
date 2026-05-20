extends RefCounted

const WORLD_RECT := Rect2(-2420, -1090, 2540, 1040)
const WALL_X := -960.0
const WALL_Y := -520.0
const TERMINAL_POS := Vector2(-450, -470)


static func room_rects() -> Array:
	return [
		{
			"id": "specimen",
			"name": "Khoang mẫu vật",
			"rect": Rect2(-2360, -1030, 760, 450),
			"color": Color(0.24, 0.18, 0.26, 0.72)
		},
		{
			"id": "archive",
			"name": "Khoang lưu trữ",
			"rect": Rect2(-1600, -1030, 520, 450),
			"color": Color(0.12, 0.26, 0.24, 0.72)
		},
		{
			"id": "medlab",
			"name": "Khoang y sinh",
			"rect": Rect2(-1040, -1070, 970, 520),
			"color": Color(0.16, 0.26, 0.34, 0.72)
		},
		{
			"id": "hallway",
			"name": "Hành lang chính",
			"rect": Rect2(-2360, -600, 1770, 290),
			"color": Color(0.16, 0.20, 0.28, 0.52)
		},
		{
			"id": "operations",
			"name": "Khoang điều phối",
			"rect": Rect2(-650, -610, 330, 290),
			"color": Color(0.18, 0.24, 0.22, 0.72)
		},
		{
			"id": "decon",
			"name": "Buồng khử nhiễm",
			"rect": Rect2(-300, -700, 440, 420),
			"color": Color(0.28, 0.26, 0.18, 0.72)
		}
	]


static func create_doors() -> Dictionary:
	return {
		"door_archive_medlab":
		{
			"id": "door_archive_medlab",
			"name": "Cua A1",
			"orientation": "horizontal",
			"line": -590.0,
			"start": -1230.0,
			"end": -1110.0,
			"required_item": "Level 1 Access Card",
			"unlocked": false
		},
		"door_hall_decon":
		{
			"id": "door_hall_decon",
			"name": "Cua B2",
			"orientation": "vertical",
			"line": -300.0,
			"start": -610.0,
			"end": -480.0,
			"required_item": "Engineer Log",
			"unlocked": false
		},
		"door_specimen_hall":
		{
			"id": "door_specimen_hall",
			"name": "Cua C1",
			"orientation": "horizontal",
			"line": -600.0,
			"start": -1880.0,
			"end": -1760.0,
			"required_item": "",
			"unlocked": true
		},
		"door_ops_decon":
		{
			"id": "door_ops_decon",
			"name": "Cua C2",
			"orientation": "vertical",
			"line": -320.0,
			"start": -520.0,
			"end": -420.0,
			"required_item": "",
			"unlocked": true
		}
	}


static func door_center(door: Dictionary) -> Vector2:
	var start_val := float(door.get("start", 0.0))
	var end_val := float(door.get("end", 0.0))
	var mid: float = (start_val + end_val) * 0.5
	if str(door.get("orientation", "")) == "vertical":
		return Vector2(float(door.get("line", WALL_X)), mid)
	return Vector2(mid, float(door.get("line", WALL_Y)))


static func room_name_at(pos: Vector2) -> String:
	for room in room_rects():
		if (room["rect"] as Rect2).has_point(pos):
			return str(room["name"])
	return "Vùng chuyển tiếp"

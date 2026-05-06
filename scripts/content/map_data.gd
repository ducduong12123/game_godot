extends RefCounted

const WORLD_RECT := Rect2(20, 20, 700, 680)
const WALL_X := 370.0
const WALL_Y := 360.0
const TERMINAL_POS := Vector2(620, 520)


static func room_rects() -> Array:
	return [
		{
			"id": "bridge",
			"name": "Khoang chỉ huy",
			"rect": Rect2(20, 20, 350, 340),
			"color": Color(0.09, 0.17, 0.30, 0.80)
		},
		{
			"id": "life_support",
			"name": "Khoang hỗ trợ sống",
			"rect": Rect2(370, 20, 350, 340),
			"color": Color(0.10, 0.22, 0.27, 0.80)
		},
		{
			"id": "hydroponics",
			"name": "Khoang thủy canh",
			"rect": Rect2(20, 360, 350, 340),
			"color": Color(0.10, 0.24, 0.19, 0.80)
		},
		{
			"id": "engineering",
			"name": "Khoang kỹ thuật",
			"rect": Rect2(370, 360, 350, 340),
			"color": Color(0.18, 0.16, 0.29, 0.80)
		}
	]


static func create_doors() -> Dictionary:
	return {
		"door_bridge_life":
		{
			"id": "door_bridge_life",
			"name": "Cửa A1",
			"orientation": "vertical",
			"line": WALL_X,
			"start": 150.0,
			"end": 210.0,
			"required_item": "Thẻ kỹ thuật",
			"unlocked": false
		},
		"door_hydro_engineering":
		{
			"id": "door_hydro_engineering",
			"name": "Cửa B2",
			"orientation": "vertical",
			"line": WALL_X,
			"start": 505.0,
			"end": 565.0,
			"required_item": "Cầu chì áp suất",
			"unlocked": false
		},
		"door_bridge_hydro":
		{
			"id": "door_bridge_hydro",
			"name": "Cửa C1",
			"orientation": "horizontal",
			"line": WALL_Y,
			"start": 160.0,
			"end": 220.0,
			"required_item": "",
			"unlocked": true
		},
		"door_life_engineering":
		{
			"id": "door_life_engineering",
			"name": "Cửa C2",
			"orientation": "horizontal",
			"line": WALL_Y,
			"start": 520.0,
			"end": 580.0,
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

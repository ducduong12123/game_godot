extends RefCounted


static func create_items() -> Array:
	return [
		{"name": "Pin dự phòng", "pos": Vector2(120, 120), "type": "battery", "collected": false},
		{"name": "Thẻ kỹ thuật", "pos": Vector2(300, 120), "type": "key", "collected": false},
		{"name": "Bình oxy", "pos": Vector2(520, 120), "type": "core", "collected": false},
		{"name": "Keo cách nhiệt", "pos": Vector2(640, 290), "type": "core", "collected": false},
		{"name": "Bộ lọc nước", "pos": Vector2(180, 520), "type": "core", "collected": false},
		{"name": "Cầu chì áp suất", "pos": Vector2(320, 640), "type": "key", "collected": false},
		{"name": "Bộ mạch", "pos": Vector2(620, 620), "type": "core", "collected": false},
		{"name": "Alloy Plate", "pos": Vector2(90, 250), "type": "material", "collected": false},
		{"name": "Coolant Gel", "pos": Vector2(250, 250), "type": "material", "collected": false},
		{
			"name": "Electrolyte Pack",
			"pos": Vector2(450, 210),
			"type": "material",
			"collected": false
		},
		{"name": "Fiber Mesh", "pos": Vector2(560, 260), "type": "material", "collected": false},
		{"name": "Control Chip", "pos": Vector2(110, 430), "type": "material", "collected": false},
		{"name": "Sealant Foam", "pos": Vector2(260, 470), "type": "material", "collected": false},
		{
			"name": "Nutrient Canister",
			"pos": Vector2(450, 430),
			"type": "material",
			"collected": false
		},
		{"name": "Alloy Plate", "pos": Vector2(560, 500), "type": "material", "collected": false},
		{
			"name": "Electrolyte Pack",
			"pos": Vector2(90, 600),
			"type": "material",
			"collected": false
		},
		{"name": "Fiber Mesh", "pos": Vector2(220, 300), "type": "material", "collected": false},
		{"name": "Control Chip", "pos": Vector2(470, 600), "type": "material", "collected": false},
		{
			"name": "Nutrient Canister",
			"pos": Vector2(660, 120),
			"type": "material",
			"collected": false
		},
		{"name": "Sealant Foam", "pos": Vector2(500, 650), "type": "material", "collected": false}
	]


static func create_puzzles() -> Array:
	return [
		{
			"question":
			"Nếu O2 hiện tại là 30 và công suất oxy = 3, O2 lượt sau là bao nhiêu?\nCông thức: O2' = O2 + 2*oxygen - 6",
			"options": ["24", "30", "36", "42"],
			"correct": 1,
			"hint": "Tính 30 + 2*3 - 6.",
			"reward": 22.0
		},
		{
			"question":
			"Nhiệt độ hiện tại = 20, môi trường = -30, heater = 4.\nCông thức: T' = T + 1.6*h - 0.1*(T-ambient). T' bằng bao nhiêu?",
			"options": ["16.4", "21.4", "26.4", "31.4"],
			"correct": 1,
			"hint": "T' = 20 + 6.4 - 0.1*50",
			"reward": 28.0
		},
		{
			"question": "Khi tài nguyên thấp, cần ổn định chỉ số nào trước để tránh chết ngay?",
			"options": ["Tiến độ sửa tàu", "Chỉ thức ăn", "Oxy và nhiệt độ", "Chỉ pin"],
			"correct": 2,
			"hint": "Oxy <= 0 sẽ kết thúc game ngay lập tức.",
			"reward": 30.0
		},
		{
			"question": "Bạn có tổng 12 pin để phân bổ. Cách chia nào an toàn nhất ở đầu game?",
			"options": ["0-0-6-6", "2-4-3-3", "6-1-1-4", "1-1-5-5"],
			"correct": 1,
			"hint": "Giữ oxy và nhiệt độ ổn định trước.",
			"reward": 20.0
		}
	]


static func craft_recipes() -> Array:
	return [
		{
			"id": "emergency_kit",
			"name": "Bộ cứu hộ",
			"description": "Tạo bộ cứu hộ để dùng bằng nút Cứu trợ khẩn cấp.",
			"ingredients": ["Electrolyte Pack", "Fiber Mesh"],
			"battery_cost": 1,
			"action_cost": 1,
			"output_item": "Bộ cứu hộ"
		},
		{
			"id": "ration_gel",
			"name": "Gel dinh dưỡng",
			"description": "Hồi phục độ no và nước ngay lập tức.",
			"ingredients": ["Nutrient Canister", "Coolant Gel"],
			"battery_cost": 1,
			"action_cost": 1,
			"instant_effects": {"satiety": 10.0, "hydration": 6.0}
		},
		{
			"id": "oxygen_patch",
			"name": "Miếng vá oxy",
			"description": "Giảm nguy cơ ngất do thiếu oxy.",
			"ingredients": ["Sealant Foam", "Control Chip"],
			"battery_cost": 2,
			"action_cost": 1,
			"instant_effects": {"o2": 10.0}
		},
		{
			"id": "power_regulator",
			"name": "Mạch điều áp",
			"description": "Hoàn pin mỗi lượt trong 3 lượt.",
			"ingredients": ["Alloy Plate", "Control Chip"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "power_regulator", "turns": 3}
		},
		{
			"id": "thermal_core",
			"name": "Lõi nhiệt ổn định",
			"description": "Giữ nhiệt độ không quá thấp trong 2 lượt.",
			"ingredients": ["Coolant Gel", "Alloy Plate"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "thermal_core", "turns": 2}
		},
		{
			"id": "water_recycler",
			"name": "Bộ tái chế nước",
			"description": "Hồi phục nước mỗi lượt trong 2 lượt.",
			"ingredients": ["Sealant Foam", "Fiber Mesh"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "water_recycler", "turns": 2}
		},
		{
			"id": "micro_algae",
			"name": "Vi tảo vi sinh",
			"description": "Tăng độ no và nước mỗi lượt trong 2 lượt.",
			"ingredients": ["Nutrient Canister", "Electrolyte Pack"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "micro_algae", "turns": 2}
		},
		{
			"id": "autobalance_chip",
			"name": "Chip cân bằng",
			"description": "Tăng chỉ số thấp nhất trong O2/Nước/Độ no.",
			"ingredients": ["Control Chip", "Electrolyte Pack"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "autobalance_chip", "turns": 2}
		},
		{
			"id": "repair_drone",
			"name": "Drone sửa tàu",
			"description": "Tăng tiến độ sửa tàu mỗi lượt trong 2 lượt.",
			"ingredients": ["Alloy Plate", "Control Chip", "Sealant Foam"],
			"battery_cost": 3,
			"action_cost": 1,
			"module": {"id": "repair_drone", "turns": 2}
		},
		{
			"id": "life_patch",
			"name": "Miếng vá duy trì sự sống",
			"description": "Hồi phục HP mỗi lượt trong 2 lượt.",
			"ingredients": ["Fiber Mesh", "Nutrient Canister"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "life_patch", "turns": 2}
		},
		{
			"id": "battery_boost",
			"name": "Bộ tăng pin",
			"description": "Nạp lại pin nhanh ngay lập tức.",
			"ingredients": ["Alloy Plate", "Electrolyte Pack"],
			"battery_cost": 0,
			"action_cost": 1,
			"instant_effects": {"battery": 8.0}
		},
		{
			"id": "focus_stim",
			"name": "Kích thích tập trung",
			"description": "Hồi phục HP và tăng 1 hành động.",
			"ingredients": ["Nutrient Canister", "Control Chip"],
			"battery_cost": 1,
			"action_cost": 1,
			"instant_effects": {"hp": 6.0, "actions": 1.0}
		}
	]


static func module_name(module_id: String) -> String:
	match module_id:
		"power_regulator":
			return "Mạch điều áp"
		"thermal_core":
			return "Lõi nhiệt ổn định"
		"water_recycler":
			return "Bộ tái chế nước"
		"micro_algae":
			return "Vi tảo vi sinh"
		"autobalance_chip":
			return "Chip cân bằng"
		"repair_drone":
			return "Drone sửa tàu"
		"life_patch":
			return "Miếng vá duy trì sự sống"
		_:
			return module_id


static func emergency_kit_name() -> String:
	return "Bộ cứu hộ"


static func required_terminal_items() -> Array[String]:
	return ["Bộ mạch", "Keo cách nhiệt", "Bộ lọc nước", "Bình oxy"]

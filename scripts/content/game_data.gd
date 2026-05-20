extends RefCounted


static func create_items() -> Array:
	return [
		{"name": "Level 1 Access Card", "pos": Vector2(-1730, -450), "type": "key", "collected": false},
		{"name": "Engineer Log", "pos": Vector2(-1400, -870), "type": "key", "collected": false},
		{"name": "Backup Battery", "pos": Vector2(-2180, -890), "type": "consumable", "collected": false},
		{"name": "Portable Oxygen", "pos": Vector2(-900, -900), "type": "consumable", "collected": false},
		{"name": "Bio Gel", "pos": Vector2(-560, -520), "type": "consumable", "collected": false},
		{"name": "Air Filter Module", "pos": Vector2(-140, -890), "type": "repair", "collected": false},
		{"name": "Alloy Plate", "pos": Vector2(-2270, -930), "type": "material", "collected": false},
		{"name": "Alloy Plate", "pos": Vector2(-370, -620), "type": "material", "collected": false},
		{"name": "Electrolyte Pack", "pos": Vector2(-1000, -930), "type": "material", "collected": false},
		{"name": "Electrolyte Pack", "pos": Vector2(-1880, -900), "type": "material", "collected": false},
		{"name": "Superconductor Wire", "pos": Vector2(-1530, -860), "type": "material", "collected": false},
		{"name": "Superconductor Wire", "pos": Vector2(-230, -400), "type": "material", "collected": false}
	]


static func create_puzzles() -> Array:
	return [
		{
			"question": "Chan doan dau game: Neu O2 hien tai la 28 va oxygen = 4, O2 luot sau bang bao nhieu?\nCong thuc: O2' = O2 + 2*oxygen - 6",
			"options": ["28", "30", "32", "34"],
			"correct": 1,
			"hint": "Tinh 28 + 2*4 - 6.",
			"reward": 10.0
		},
		{
			"question": "On dinh O2: He thong can 2 van oxy mo va 1 van du phong. Tong cong bao nhieu van can kich hoat?",
			"options": ["2", "3", "4", "5"],
			"correct": 1,
			"hint": "Cong cac van bat buoc va van du phong.",
			"reward": 20.0
		},
		{
			"question": "Khoi phuc dien: Neu co 3 day den hong, sua 2 day va thay 1 bang mach moi. Tong so diem can xu ly la bao nhieu?",
			"options": ["2", "3", "4", "5"],
			"correct": 1,
			"hint": "Moi day hong hoac bang mach can 1 diem xu ly.",
			"reward": 20.0
		},
		{
			"question": "Reactor crisis: 2 bo lam mat + 1 loi phan ung + 1 day dan chinh. Tong co bao nhieu thanh phan can lap dung?",
			"options": ["3", "4", "5", "6"],
			"correct": 1,
			"hint": "Cong tat ca thanh phan trong cau hoi.",
			"reward": 25.0
		},
		{
			"question": "Escape cuoi: Neu tau can 100% sua chua va hien tai dang o 75%, can them bao nhieu phan tram nua de kich hoat escape?",
			"options": ["10%", "15%", "20%", "25%"],
			"correct": 3,
			"hint": "Lay 100 tru 75.",
			"reward": 25.0
		}
	]


static func craft_recipes() -> Array:
	return [
		{
			"id": "backup_battery",
			"name": "Backup Battery",
			"description": "Vien pin cuu nguy co the dung bang nut cuu tro khan cap.",
			"ingredients": ["Alloy Plate", "Electrolyte Pack"],
			"battery_cost": 1,
			"action_cost": 1,
			"output_item": "Backup Battery"
		},
		{
			"id": "portable_oxygen",
			"name": "Portable Oxygen",
			"description": "Binh oxy cuu nguy de dung bang nut cuu tro khan cap.",
			"ingredients": ["Electrolyte Pack", "Superconductor Wire"],
			"battery_cost": 1,
			"action_cost": 1,
			"output_item": "Portable Oxygen"
		},
		{
			"id": "bio_gel",
			"name": "Bio Gel",
			"description": "Gel y sinh giup hoi HP bang nut cuu tro khan cap.",
			"ingredients": ["Alloy Plate", "Superconductor Wire"],
			"battery_cost": 2,
			"action_cost": 1,
			"output_item": "Bio Gel"
		},
		{
			"id": "repair_patch",
			"name": "Repair Patch",
			"description": "Vat lieu sua tam de tranh mat he thong nhe.",
			"ingredients": ["Alloy Plate", "Electrolyte Pack"],
			"battery_cost": 1,
			"action_cost": 1,
			"output_item": "Repair Patch"
		},
		{
			"id": "navigation_board",
			"name": "Navigation Board",
			"description": "Bang mach dieu huong can cho stage khoi phuc he thong dieu huong.",
			"ingredients": ["Alloy Plate", "Superconductor Wire"],
			"battery_cost": 2,
			"action_cost": 1,
			"output_item": "Navigation Board"
		},
		{
			"id": "reactor_core",
			"name": "Reactor Core",
			"description": "Linh kien cuoi can de on dinh reactor va mo stage escape.",
			"ingredients": ["Alloy Plate", "Electrolyte Pack", "Superconductor Wire"],
			"battery_cost": 3,
			"action_cost": 1,
			"output_item": "Reactor Core"
		},
		{
			"id": "power_regulator",
			"name": "Power Regulator",
			"description": "Module sustain don gian, hoi 2 pin moi luot trong 3 luot.",
			"ingredients": ["Electrolyte Pack", "Superconductor Wire"],
			"battery_cost": 2,
			"action_cost": 1,
			"module": {"id": "power_regulator", "turns": 3}
		}
	]


static func module_name(module_id: String) -> String:
	match module_id:
		"power_regulator":
			return "Power Regulator"
		_:
			return module_id


static func emergency_kit_name() -> String:
	return "Bio Gel"


static func required_terminal_items_for_stage(stage_index: int) -> Array[String]:
	match stage_index:
		0:
			return []
		1:
			return ["Air Filter Module"]
		2:
			return ["Navigation Board"]
		3:
			return ["Reactor Core"]
		_:
			return []

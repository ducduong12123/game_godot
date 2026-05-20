extends RefCounted


static func create_stage_definitions() -> Array:
	return [
		{
			"id": "restore_access",
			"title": "Khôi phục quyền truy cập",
			"summary": "Tìm thẻ truy cập, mở khu đầu tiên và chạy chẩn đoán ban đầu.",
			"tasks":
			[
				{
					"id": "find_access_card",
					"type": "collect_item",
					"target": "Level 1 Access Card",
					"description": "Tìm Level 1 Access Card"
				},
				{
					"id": "unlock_a1",
					"type": "unlock_door",
					"target": "door_archive_medlab",
					"description": "Mở Cửa A1"
				},
				{
					"id": "reach_terminal",
					"type": "reach_terminal",
					"target": "",
					"description": "Tiếp cận terminal trung tâm"
				},
				{
					"id": "solve_puzzle_1",
					"type": "solve_puzzle",
					"target": 0,
					"description": "Hoàn thành câu đố chẩn đoán đầu tiên"
				}
			]
		},
		{
			"id": "life_support",
			"title": "Ổn định hỗ trợ sống",
			"summary": "Thu hồi bộ lọc không khí và dùng terminal để ổn định O2.",
			"tasks":
			[
				{
					"id": "find_air_filter",
					"type": "collect_item",
					"target": "Air Filter Module",
					"description": "Tìm Air Filter Module"
				},
				{
					"id": "solve_puzzle_2",
					"type": "solve_puzzle",
					"target": 1,
					"description": "Hoàn thành câu đố ổn định O2"
				}
			]
		},
		{
			"id": "restore_navigation",
			"title": "Khôi phục điều hướng",
			"summary": "Thu thập vật liệu chính và chế tạo Navigation Board.",
			"tasks":
			[
				{
					"id": "find_alloy_plate",
					"type": "collect_item",
					"target": "Alloy Plate",
					"description": "Nhặt ít nhất 1 Alloy Plate"
				},
				{
					"id": "find_super_wire",
					"type": "collect_item",
					"target": "Superconductor Wire",
					"description": "Nhặt ít nhất 1 Superconductor Wire"
				},
				{
					"id": "craft_nav_board",
					"type": "craft_recipe",
					"target": "navigation_board",
					"description": "Chế tạo Navigation Board"
				},
				{
					"id": "solve_puzzle_3",
					"type": "solve_puzzle",
					"target": 2,
					"description": "Hoàn thành câu đố khôi phục điện"
				}
			]
		},
		{
			"id": "stabilize_reactor",
			"title": "Ổn định reactor",
			"summary": "Tìm vật liệu còn thiếu, chế tạo Reactor Core và xử lý khủng hoảng reactor.",
			"tasks":
			[
				{
					"id": "find_electrolyte_pack",
					"type": "collect_item",
					"target": "Electrolyte Pack",
					"description": "Nhặt ít nhất 1 Electrolyte Pack"
				},
				{
					"id": "craft_reactor_core",
					"type": "craft_recipe",
					"target": "reactor_core",
					"description": "Chế tạo Reactor Core"
				},
				{
					"id": "solve_puzzle_4",
					"type": "solve_puzzle",
					"target": 3,
					"description": "Hoàn thành câu đố reactor"
				}
			]
		},
		{
			"id": "escape_sequence",
			"title": "Kích hoạt escape",
			"summary": "Hoàn tất câu đố cuối và đưa tiến độ sửa tàu lên 100%.",
			"tasks":
			[
				{
					"id": "solve_puzzle_5",
					"type": "solve_puzzle",
					"target": 4,
					"description": "Hoàn thành câu đố escape cuối"
				},
				{
					"id": "reach_full_repair",
					"type": "repair_progress",
					"target": 100,
					"description": "Đạt 100% tiến độ sửa tàu"
				}
			]
		}
	]

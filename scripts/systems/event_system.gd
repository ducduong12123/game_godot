extends RefCounted

const EVENT_CHANCE := 0.45


static func roll_event(rng: RandomNumberGenerator, state: Dictionary) -> Dictionary:
	if rng.randf() > EVENT_CHANCE:
		return {
			"triggered": false,
			"title": "Ổn định",
			"description": "Không có sự cố bất thường trong lượt này.",
			"state": state.duplicate(true)
		}

	var events := [
		{
			"id": "oxygen_leak",
			"title": "Rò rỉ oxy",
			"description": "Van phụ bị rò rỉ, oxy thất thoát mạnh.",
			"o2": -10.0
		},
		{
			"id": "cold_wave",
			"title": "Sụt nhiệt",
			"description": "Lớp cách nhiệt suy giảm, khoang lạnh đi nhanh.",
			"temp": -6.0
		},
		{
			"id": "short_circuit",
			"title": "Chập mạch",
			"description": "Cụm dây nguồn bị chập, pin tiêu hao thêm.",
			"battery": -8.0
		},
		{
			"id": "water_contamination",
			"title": "Nước nhiễm bẩn",
			"description": "Bộ lọc tạm thời mất hiệu lực, nước giảm nhanh hơn.",
			"hydration": -8.0
		},
		{
			"id": "ration_spoilage",
			"title": "Khẩu phần hỏng",
			"description": "Một phần thực phẩm bị hỏng do dao động nhiệt.",
			"satiety": -8.0
		},
		{
			"id": "supply_cache",
			"title": "Kho dự phòng",
			"description": "Tìm thấy kho tiếp tế cũ: thêm pin và nước.",
			"battery": 6.0,
			"hydration": 5.0
		}
	]

	var selected: Dictionary = events[rng.randi_range(0, events.size() - 1)]
	var next_state := state.duplicate(true)

	_apply_event_delta(next_state, "battery", 0.0, 0.0, 110.0, selected)
	_apply_event_delta(next_state, "temp", 20.0, -40.0, 60.0, selected)
	_apply_event_delta(next_state, "o2", 70.0, 0.0, 100.0, selected)
	_apply_event_delta(next_state, "hydration", 75.0, 0.0, 100.0, selected)
	_apply_event_delta(next_state, "satiety", 70.0, 0.0, 100.0, selected)

	return {
		"triggered": true,
		"title": str(selected.get("title", "sự cố")),
		"description": str(selected.get("description", "")),
		"state": next_state
	}


static func _apply_event_delta(
	state: Dictionary,
	key: String,
	default_val: float,
	min_val: float,
	max_val: float,
	event: Dictionary
) -> void:
	var current: float = float(state.get(key, default_val))
	var delta: float = float(event.get(key, 0.0))
	state[key] = clampf(current + delta, min_val, max_val)

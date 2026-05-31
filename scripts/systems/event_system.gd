extends RefCounted

const EVENT_CHANCE := 0.45


static func roll_event(rng: RandomNumberGenerator, state: Dictionary) -> Dictionary:
	if rng.randf() > EVENT_CHANCE:
		return {
			"triggered": false,
			"title": "Ổn định",
			"description": "Không có sự cố bất thường trong lượt này.",
			"hint": "Tiếp tục theo dõi tài nguyên và ưu tiên nhiệm vụ gần nhất.",
			"effect_text": "Không đổi tài nguyên",
			"severity": "info",
			"state": state.duplicate(true)
		}

	var events := [
		{
			"id": "oxygen_leak",
			"title": "Rò rỉ oxy",
			"description": "Van phụ bị rò rỉ, oxy thất thoát mạnh.",
			"hint": "Dùng Portable Oxygen nếu có, hoặc phân bổ thêm Oxy ở lượt tiếp theo.",
			"effect_text": "O2 -12",
			"severity": "danger",
			"o2": -12.0
		},
		{
			"id": "cold_wave",
			"title": "Sụt nhiệt",
			"description": "Lớp cách nhiệt suy giảm, khoang lạnh đi nhanh.",
			"hint": "Tăng phân bổ Máy sưởi trước khi nhiệt độ xuống vùng nguy hiểm.",
			"effect_text": "Nhiệt độ -7 C",
			"severity": "warning",
			"temp": -7.0
		},
		{
			"id": "short_circuit",
			"title": "Chập mạch",
			"description": "Cụm dây nguồn bị chập, pin tiêu hao thêm.",
			"hint": "Dùng Backup Battery nếu pin thấp, hoặc giảm phân bổ không cần thiết.",
			"effect_text": "Pin -10",
			"severity": "danger",
			"battery": -10.0
		},
		{
			"id": "water_contamination",
			"title": "Nước nhiễm bẩn",
			"description": "Bộ lọc tạm thời mất hiệu lực, nước cơ thể giảm nhanh.",
			"hint": "Ưu tiên phân bổ Nước trong lượt tới để tránh mất HP.",
			"effect_text": "Nước cơ thể -9",
			"severity": "warning",
			"hydration": -9.0
		},
		{
			"id": "ration_spoilage",
			"title": "Khẩu phần hỏng",
			"description": "Một phần thực phẩm bị hỏng do dao động nhiệt.",
			"hint": "Phân bổ Thức ăn nếu độ no đang thấp, đừng dồn toàn bộ pin vào sửa tàu.",
			"effect_text": "Độ no -9",
			"severity": "warning",
			"satiety": -9.0
		},
		{
			"id": "supply_cache",
			"title": "Kho dự phòng",
			"description": "Tìm thấy kho tiếp tế cũ: thêm pin và nước.",
			"hint": "Đây là cơ hội tốt để đẩy tiến độ sửa tàu hoặc mở khu mới.",
			"effect_text": "Pin +6, nước cơ thể +5",
			"severity": "good",
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
		"title": str(selected.get("title", "Sự cố")),
		"description": str(selected.get("description", "")),
		"hint": str(selected.get("hint", "")),
		"effect_text": str(selected.get("effect_text", "")),
		"severity": str(selected.get("severity", "warning")),
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

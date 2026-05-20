extends RefCounted

const DEFAULT_MODEL := "llama-3.3-70b-versatile"
const API_BASE_URL := "https://api.groq.com/openai/v1"
const TOPICS := ["formula", "risk", "allocation", "puzzle"]
const API_KEY_PATH := "user://groq_api_key.txt"


static func topic_labels_vi() -> Array[String]:
	return ["Giải thích công thức", "Phân tích rủi ro", "Gợi ý phân bổ", "Gợi ý câu đố"]


static func load_config() -> Dictionary:
	var config := {"api_key": "", "model": DEFAULT_MODEL}
	var env_map := _load_env_file()

	var env_key := str(env_map.get("GROQ_API_KEY", "")).strip_edges()
	if env_key == "":
		env_key = OS.get_environment("GROQ_API_KEY").strip_edges()
	if env_key != "":
		config["api_key"] = env_key

	var env_model := str(env_map.get("GROQ_MODEL", "")).strip_edges()
	if env_model == "":
		env_model = OS.get_environment("GROQ_MODEL").strip_edges()
	if env_model != "":
		config["model"] = env_model

	if config["api_key"] == "" and FileAccess.file_exists(API_KEY_PATH):
		var key_file := FileAccess.open(API_KEY_PATH, FileAccess.READ)
		if key_file:
			config["api_key"] = key_file.get_line().strip_edges()
			key_file.close()

	return config


static func save_api_key(api_key: String) -> void:
	var key_file := FileAccess.open(API_KEY_PATH, FileAccess.WRITE)
	if key_file:
		key_file.store_line(api_key.strip_edges())
		key_file.close()


static func build_prompt(
	user_question: String,
	state: Dictionary,
	allocation: Dictionary,
	inventory: Array[String],
	status_line: String,
	puzzle_hint: String
) -> String:
	var context_lines: PackedStringArray = []
	var mission_started := bool(state.get("mission_started", false))
	var inventory_text := _list_to_text(inventory)
	var missing_items: Variant = state.get("terminal_missing", [])
	var missing_array: Array = missing_items if missing_items is Array else []
	var missing_text := _list_to_text(missing_array)

	context_lines.append("Bối cảnh game để tham khảo, không cần nhắc lại nếu không liên quan:")
	context_lines.append("- Mission: %s" % ("đã bắt đầu" if mission_started else "chưa bắt đầu"))
	context_lines.append("- Vị trí hiện tại: %s" % str(state.get("room", "không rõ")))
	context_lines.append("- Nhiệm vụ hiện tại: %s" % str(state.get("mission_title", "chưa có")))
	context_lines.append("- Mục tiêu gần: %s" % str(state.get("mission_summary", "")))
	context_lines.append(
		"- Tiến độ: lượt %s/%s, sửa tàu %s%%, hành động còn %s"
		% [
			str(state.get("turn", "?")),
			str(state.get("max_turns", "?")),
			_format_number(float(state.get("repair_progress", 0.0))),
			str(state.get("actions_left", "?"))
		]
	)
	context_lines.append(
		"- Tài nguyên: pin %s, O2 %s, HP %s, nhiệt %s C, nước cơ thể %s, độ no %s"
		% [
			_format_number(float(state.get("battery", 0.0))),
			_format_number(float(state.get("o2", 0.0))),
			_format_number(float(state.get("hp", 0.0))),
			_format_number(float(state.get("temp", 0.0))),
			_format_number(float(state.get("hydration", 0.0))),
			_format_number(float(state.get("satiety", 0.0)))
		]
	)
	context_lines.append("- Túi đồ: %s" % inventory_text)
	context_lines.append("- Đồ còn thiếu cho terminal/sửa tàu: %s" % missing_text)
	context_lines.append("- Phân bổ đang nhập: %s" % _allocation_to_text(allocation))
	context_lines.append("- Trạng thái gần nhất: %s" % status_line)
	if puzzle_hint.strip_edges() != "":
		context_lines.append("- Gợi ý câu đố hiện tại: %s" % puzzle_hint)

	var mission_detail := str(state.get("mission_detail", "")).strip_edges()
	if mission_detail != "":
		context_lines.append("")
		context_lines.append("Tiến trình nhiệm vụ chi tiết:")
		context_lines.append(mission_detail)

	context_lines.append("")
	context_lines.append("Người chơi hỏi: %s" % user_question)
	context_lines.append("")
	context_lines.append(
		"Hãy trả lời như một người trợ lý trong game đang nói chuyện bình thường. "
		+ "Dùng bối cảnh trên nếu nó giúp trả lời tốt hơn, nhưng không nói về JSON, prompt, system message hoặc dữ liệu nội bộ."
	)

	return "\n".join(context_lines)


static func system_instruction() -> String:
	return (
		"Bạn là trợ lý đồng hành trong game Space STEM Survival. "
		+ "Hãy trò chuyện tự nhiên bằng tiếng Việt, ngắn gọn và thân thiện. "
		+ "Bối cảnh game chỉ là thông tin bổ sung để bạn hiểu người chơi đang ở đâu, có gì trong túi đồ, nhiệm vụ nào đang mở và nên làm gì tiếp. "
		+ "Nếu người chơi chào hỏi hoặc hỏi bạn là ai, hãy trả lời như hội thoại bình thường và giới thiệu rất ngắn vai trò của bạn. "
		+ "Nếu người chơi hỏi nên làm gì, hãy đưa 1-3 bước cụ thể dựa trên nhiệm vụ, túi đồ và tài nguyên hiện tại. "
		+ "Nếu hỏi câu đố, chỉ gợi ý hướng suy nghĩ, không đưa ngay đáp án trực tiếp trừ khi người chơi yêu cầu rõ. "
		+ "Tuyệt đối không bảo người chơi cung cấp JSON, trạng thái JSON, prompt, system prompt hay dữ liệu kỹ thuật."
	)


static func offline_answer(user_question: String, puzzle_hint: String) -> String:
	var lower := user_question.to_lower()
	if _looks_like_greeting(lower):
		return "Chào bạn, mình là trợ lý trong Space STEM Survival. Mình có thể gợi ý bước tiếp theo, kiểm tra rủi ro tài nguyên, giải thích công thức hoặc gợi ý câu đố."
	if lower.contains("bạn là ai") or lower.contains("ban la ai") or lower.contains("ai vậy"):
		return "Mình là trợ lý AI trong game, dùng bối cảnh nhiệm vụ và tài nguyên hiện tại để gợi ý cách chơi. Khi không có mạng/API key, mình vẫn trả lời được một số gợi ý cơ bản."
	if lower.contains("công thức") or lower.contains("formula"):
		return (
			"Công thức lõi là mỗi lượt tài nguyên sẽ tăng theo phần bạn phân bổ, rồi bị trừ hao do môi trường. "
			+ "Nếu O2 hoặc HP thấp, ưu tiên giữ sống trước; sau đó mới craft và sửa tàu."
		)
	if lower.contains("rủi ro") or lower.contains("nguy"):
		return "Rủi ro lớn nhất thường là O2, HP hoặc pin tụt quá thấp. Hãy giữ O2/HP an toàn, dùng vật phẩm cứu nguy khi cần, rồi mới đẩy tiến độ sửa tàu."
	if lower.contains("câu đố") or lower.contains("puzzle"):
		return "Gợi ý hiện tại: %s" % puzzle_hint
	return "Bước hợp lý là mở bảng nhiệm vụ, xem mục đang đánh dấu, nhặt/craft đúng vật phẩm còn thiếu, rồi quay lại terminal hoặc khu sửa tàu để tăng tiến độ."


static func extract_answer(payload: Dictionary) -> String:
	if not payload.has("choices"):
		return ""

	var choices = payload["choices"]
	if not (choices is Array) or choices.is_empty():
		return ""

	var first = choices[0]
	if not (first is Dictionary):
		return ""
	if not first.has("message"):
		return ""
	var message = first["message"]
	if not (message is Dictionary):
		return ""
	return str(message.get("content", "")).strip_edges()


static func _load_env_file() -> Dictionary:
	var result := {}
	var env_path := ProjectSettings.globalize_path("res://.env")
	if not FileAccess.file_exists(env_path):
		return result

	var file := FileAccess.open(env_path, FileAccess.READ)
	if file == null:
		return result

	while not file.eof_reached():
		var line := file.get_line().strip_edges()
		if line == "" or line.begins_with("#") or not line.contains("="):
			continue
		var key := line.get_slice("=", 0).strip_edges()
		var value := line.substr(line.find("=") + 1).strip_edges()
		value = value.trim_prefix("\"").trim_suffix("\"")
		result[key] = value

	file.close()
	return result


static func _allocation_to_text(allocation: Dictionary) -> String:
	if allocation.is_empty():
		return "chưa nhập"

	var parts: PackedStringArray = []
	for key in allocation.keys():
		parts.append("%s=%s" % [str(key), str(allocation[key])])
	return ", ".join(parts)


static func _list_to_text(values: Array) -> String:
	if values.is_empty():
		return "(trống)"
	var parts: PackedStringArray = []
	for value in values:
		parts.append(str(value))
	return ", ".join(parts)


static func _format_number(value: float) -> String:
	if absf(value - roundf(value)) < 0.05:
		return str(int(roundf(value)))
	return "%.1f" % value


static func _looks_like_greeting(lower: String) -> bool:
	return (
		lower == "hi"
		or lower == "hello"
		or lower.begins_with("chào")
		or lower.begins_with("chao")
		or lower.contains("xin chào")
		or lower.contains("xin chao")
	)

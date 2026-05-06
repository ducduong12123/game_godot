extends RefCounted

const DEFAULT_MODEL := "gemini-3.1-flash-lite-preview"
const TOPICS := ["formula", "risk", "allocation", "puzzle"]
const API_KEY_PATH := "user://gemini_api_key.txt"
const MODEL_PATH := "user://gemini_model.txt"


static func topic_labels_vi() -> Array[String]:
	return ["Giải thích công thức", "Phân tích rủi ro", "Gợi ý phân bổ", "Gợi ý câu đố"]


static func load_config() -> Dictionary:
	var config := {"api_key": "", "model": DEFAULT_MODEL}

	if FileAccess.file_exists(API_KEY_PATH):
		var key_file := FileAccess.open(API_KEY_PATH, FileAccess.READ)
		if key_file:
			config["api_key"] = key_file.get_line().strip_edges()
			key_file.close()

	if FileAccess.file_exists(MODEL_PATH):
		var model_file := FileAccess.open(MODEL_PATH, FileAccess.READ)
		if model_file:
			var model_name := model_file.get_line().strip_edges()
			model_file.close()
			if model_name != "":
				config["model"] = model_name

	return config


static func save_api_key(api_key: String) -> void:
	var key_file := FileAccess.open(API_KEY_PATH, FileAccess.WRITE)
	if key_file:
		key_file.store_line(api_key.strip_edges())
		key_file.close()


static func build_prompt(
	topic: String, state: Dictionary, allocation: Dictionary, inventory: Array[String], status_line: String, puzzle_hint: String
) -> String:
	var question := "Hãy giúp tôi sống sót hiệu quả."
	match topic:
		"formula":
			question = "Giải thích công thức sinh tồn từng bước cho học sinh lớp 8."
		"risk":
			question = "Phân tích rủi ro cao nhất ở trạng thái hiện tại và thứ tự ưu tiên xử lý."
		"allocation":
			question = "Gợi ý phân bổ pin cho lượt tiếp theo để tối đa khả năng sống sót."
		"puzzle":
			question = "Chỉ đưa gợi ý câu đố, không đưa đáp án đầy đủ. Gợi ý hiện có: %s" % puzzle_hint

	var inventory_text := "(trống)"
	if inventory.size() > 0:
		inventory_text = ", ".join(inventory)

	return (
		"%s\n\nTrạng thái JSON:\n%s\n\nPhân bổ JSON:\n%s\n\nTúi đồ:\n%s\n\nTrạng thái:\n%s"
		% [question, JSON.stringify(state), JSON.stringify(allocation), inventory_text, status_line]
	)


static func system_instruction() -> String:
	return (
		"Bạn là trợ giảng AI cho game sinh tồn STEM. "
		+ "Hãy trả lời ngắn gọn, thực tế, bằng tiếng Việt. "
		+ "Không đưa toàn bộ đáp án câu đố; chỉ đưa gợi ý và các bước suy luận."
	)


static func offline_answer(topic: String, puzzle_hint: String) -> String:
	match topic:
		"formula":
			return ("Công thức lõi: " +
				"O2' = O2 + 2*oxygen - 6, " +
				"Temp' = Temp + 1.6*heater - 0.1*(Temp-ambient), " +
				"Hydration' = Hydration + 2.2*water - 7, " +
				"Satiety' = Satiety + 1.8*food - 6.")
		"risk":
			return ("Ưu tiên rủi ro sống còn ngay: giữ O2 trên ngưỡng nguy hiểm, " +
				"rồi ổn định nhiệt độ, sau đó đến nước và độ no.")
		"allocation":
			return ("Gợi ý nền an toàn: oxy 4, máy sưởi 3, nước 3, thức ăn 2 " +
				"(điều chỉnh theo chỉ số hiện tại).")
		"puzzle":
			return "Gợi ý: %s" % puzzle_hint
		_:
			return "Hãy cân bằng oxy + nhiệt độ trước khi tối ưu tốc độ sửa tàu."


static func extract_answer(payload: Dictionary) -> String:
	if not payload.has("candidates"):
		return ""

	var candidates = payload["candidates"]
	if not (candidates is Array) or candidates.is_empty():
		return ""

	var result_lines := []
	for candidate in candidates:
		if not (candidate is Dictionary):
			continue
		if not candidate.has("content"):
			continue
		var content = candidate["content"]
		if not (content is Dictionary) or not content.has("parts"):
			continue
		var parts = content["parts"]
		if not (parts is Array):
			continue
		for part in parts:
			if part is Dictionary and part.has("text"):
				result_lines.append(str(part["text"]))

	return "\n".join(result_lines).strip_edges()

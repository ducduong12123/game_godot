extends RefCounted

const MAX_AI_LOG_LINES := 200
const MAX_CHAT_MEMORY_MESSAGES := 16
const MAX_MEMORY_TEXT_CHARS := 900
const AI_MAX_OUTPUT_TOKENS := 1000
const SCROLL_STEP_PX := 42.0

var game
var _ai_log_entries: Array[String] = []
var _chat_memory: Array[Dictionary] = []


func setup(game_ref) -> void:
	game = game_ref


func init_http() -> void:
	game.http = HTTPRequest.new()
	game.http.timeout = game.AI_TIMEOUT_SEC
	game.add_child(game.http)
	game.http.request_completed.connect(game._on_http_request_completed)


func load_ai_config() -> void:
	var config: Dictionary = game.AITutorService.load_config()
	game.ai_api_key = str(config.get("api_key", ""))
	game.ai_model = str(config.get("model", game.AITutorService.DEFAULT_MODEL))
	if game.ai_model.strip_edges() == "":
		game.ai_model = game.AITutorService.DEFAULT_MODEL


func on_save_key_pressed() -> void:
	pass


func on_ask_ai_pressed() -> void:
	var user_question := ""
	if game.ai_prompt_input != null:
		user_question = game.ai_prompt_input.text.strip_edges()
	if user_question == "":
		log_ai("Hệ thống", "Hãy nhập câu hỏi trước khi gửi.", "system")
		return
	ask_ai_question(user_question)


func ask_ai_topic(topic: String) -> void:
	var question := ""
	match topic:
		"formula":
			question = "Giải thích công thức sinh tồn hiện tại và việc cần ưu tiên."
		"risk":
			question = "Phân tích rủi ro cao nhất lúc này và tôi nên làm gì tiếp theo."
		"allocation":
			question = "Gợi ý cách phân bổ pin cho lượt tiếp theo."
		"puzzle":
			question = "Gợi ý cách giải câu đố hiện tại."
		_:
			question = "Tôi nên làm gì tiếp theo?"
	ask_ai_question(question)


func ask_ai_question(user_question: String) -> void:
	game.ai_last_topic = user_question
	game.ai_last_fallback = game.AITutorService.offline_answer(
		user_question, game.gameplay_controller.current_puzzle_hint()
	)

	if game.ai_pending:
		log_ai("Hệ thống", "AI đang xử lý yêu cầu trước đó.", "system")
		return

	log_ai("Bạn", user_question, "user")

	if game.ai_api_key.strip_edges() == "":
		var offline_answer: String = game.ai_last_fallback + "\n(ngoại tuyến - chưa có GROQ_API_KEY)"
		_remember_message("user", user_question)
		_remember_message("assistant", offline_answer)
		log_ai("AI", offline_answer, "offline")
		if game.ai_prompt_input != null:
			game.ai_prompt_input.text = ""
		return

	var messages: Array[Dictionary] = _build_request_messages(user_question)
	var payload := {
		"model": game.ai_model,
		"messages": messages,
		"temperature": 0.35,
		"max_tokens": AI_MAX_OUTPUT_TOKENS
	}

	var headers := PackedStringArray(
		[
			"Content-Type: application/json",
			"Authorization: Bearer %s" % game.ai_api_key
		]
	)
	var url: String = "%s/chat/completions" % game.AITutorService.API_BASE_URL
	var err: int = game.http.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(payload))
	if err != OK:
		log_ai("Hệ thống", "Không thể khởi tạo yêu cầu Groq (err=%d)." % err, "system")
		var init_fallback: String = game.ai_last_fallback + "\n(khởi tạo trực tuyến thất bại)"
		_remember_message("user", user_question)
		_remember_message("assistant", init_fallback)
		log_ai("AI", init_fallback, "offline")
		return

	_remember_message("user", user_question)
	game.ai_pending = true
	game.ui_controller.update_ui()
	log_ai("Hệ thống", "Đang gửi yêu cầu tới AI...", "system")
	if game.ai_prompt_input != null:
		game.ai_prompt_input.text = ""


func _build_ai_prompt(user_question: String) -> String:
	return game.AITutorService.build_prompt(
		user_question,
		_build_state_for_ai(),
		game.gameplay_controller.get_allocation_from_ui(),
		game.inventory,
		game.status_line,
		game.gameplay_controller.current_puzzle_hint()
	)


func _build_request_messages(user_question: String) -> Array[Dictionary]:
	var messages: Array[Dictionary] = [
		{"role": "system", "content": game.AITutorService.system_instruction()}
	]

	for memory_entry in _chat_memory:
		var role := str(memory_entry.get("role", "")).strip_edges()
		var content := str(memory_entry.get("content", "")).strip_edges()
		if content == "":
			continue
		if role != "user" and role != "assistant":
			continue
		messages.append({"role": role, "content": content})

	messages.append({"role": "user", "content": _build_ai_prompt(user_question)})
	return messages


func _build_state_for_ai() -> Dictionary:
	var terminal_missing: Array[String] = []
	if game.gameplay_controller != null:
		terminal_missing = game.gameplay_controller.missing_terminal_items()

	var mission_title := ""
	var mission_summary := ""
	var mission_detail := ""
	if game.mission_controller != null:
		mission_title = game.mission_controller.current_stage_title()
		mission_summary = game.mission_controller.current_stage_summary()
		mission_detail = game.mission_controller.detail_text()

	return {
		"mission_started": game.mission_started,
		"mission_title": mission_title,
		"mission_summary": mission_summary,
		"mission_detail": mission_detail,
		"turn": game.turn,
		"max_turns": game.max_turns,
		"room": game.world_controller.room_name_at_player(),
		"battery": game.battery,
		"temp": game.temp,
		"o2": game.o2,
		"hydration": game.hydration,
		"satiety": game.satiety,
		"hp": game.hp,
		"actions_left": game.actions_left,
		"repair_progress": game.repair_progress,
		"repair_stage_index": game.repair_stage_index,
		"last_event": game.last_event_title,
		"terminal_missing": terminal_missing,
		"puzzle_index": game.current_puzzle_index,
		"game_over": game.game_over
	}


func on_http_request_completed(
	result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray
) -> void:
	game.ai_pending = false
	game.ui_controller.update_ui()

	var parsed = JSON.parse_string(body.get_string_from_utf8())
	var answer := ""
	var err_text := ""

	if result == HTTPRequest.RESULT_SUCCESS and response_code < 400 and parsed is Dictionary:
		answer = game.AITutorService.extract_answer(parsed)
	elif result != HTTPRequest.RESULT_SUCCESS:
		err_text = "Yêu cầu HTTP thất bại (result=%d)." % result
	else:
		err_text = "HTTP %d" % response_code

	if answer != "":
		_remember_message("assistant", answer)
		log_ai("AI", answer, "online")
		return

	if err_text == "" and parsed is Dictionary and parsed.has("error"):
		var err_obj = parsed["error"]
		if err_obj is Dictionary:
			err_text = str(err_obj.get("message", "Lỗi AI không xác định."))
	if err_text == "":
		err_text = "Lỗi Groq không xác định."

	log_ai("Hệ thống", "Lỗi AI: %s" % err_text, "system")
	var error_fallback: String = game.ai_last_fallback + "\n(trực tuyến lỗi, đã dùng ngoại tuyến)"
	_remember_message("assistant", error_fallback)
	log_ai("AI", error_fallback, "offline")


func log_ai(speaker: String, text: String, source: String) -> void:
	if game.ai_log == null:
		return

	var safe_speaker := _escape_bbcode(speaker)
	var body_text := _format_chat_body(text)
	var speaker_color := _speaker_color_for_source(source)
	var body_color := _body_color_for_source(source)
	var entry := "[color=%s][b]%s[/b][/color]: [color=%s]%s[/color]\n\n" % [
		speaker_color,
		safe_speaker,
		body_color,
		body_text
	]

	_ai_log_entries.append(entry)
	_render_ai_log()
	_trim_ai_log_to_limit()
	_scroll_ai_log_to_bottom()


func on_ai_log_gui_input(event: InputEvent) -> void:
	if game.ai_log == null:
		return
	if event is not InputEventMouseButton:
		return

	var mouse_event := event as InputEventMouseButton
	if not mouse_event.pressed:
		return

	var delta := 0.0
	if mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
		delta = -SCROLL_STEP_PX
	elif mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		delta = SCROLL_STEP_PX
	else:
		return

	var scrollbar: VScrollBar = game.ai_log.get_v_scroll_bar()
	if scrollbar == null:
		return

	game.ai_log.scroll_following = false
	scrollbar.value = clampf(scrollbar.value + delta, scrollbar.min_value, scrollbar.max_value)
	game.ai_log.accept_event()


func _trim_ai_log_to_limit() -> void:
	while game.ai_log.get_line_count() > MAX_AI_LOG_LINES and _ai_log_entries.size() > 0:
		_ai_log_entries.remove_at(0)
		_render_ai_log()


func _scroll_ai_log_to_bottom() -> void:
	game.ai_log.scroll_following = true
	game.ai_log.call_deferred("scroll_to_line", maxi(0, game.ai_log.get_line_count() - 1))


func _render_ai_log() -> void:
	game.ai_log.clear()
	game.ai_log.append_text(_merged_log_text())


func _merged_log_text() -> String:
	var merged := ""
	for entry in _ai_log_entries:
		merged += entry
	return merged


func _remember_message(role: String, content: String) -> void:
	var clean_content := _compact_memory_text(content.strip_edges())
	if clean_content == "":
		return

	_chat_memory.append({"role": role, "content": clean_content})
	while _chat_memory.size() > MAX_CHAT_MEMORY_MESSAGES:
		_chat_memory.remove_at(0)


func _compact_memory_text(content: String) -> String:
	var clean := content.replace("\r", " ").replace("\n", " ")
	while clean.contains("  "):
		clean = clean.replace("  ", " ")
	if clean.length() <= MAX_MEMORY_TEXT_CHARS:
		return clean
	return clean.substr(0, MAX_MEMORY_TEXT_CHARS) + "..."


func _format_chat_body(text: String) -> String:
	var safe := _escape_bbcode(text)
	return _markdown_to_bbcode(safe)


func _markdown_to_bbcode(text: String) -> String:
	var normalized := text.replace("\r\n", "\n").replace("\r", "\n")
	normalized = _format_markdown_lines(normalized)
	normalized = _replace_paired_marker(normalized, "```", "[code]", "[/code]")
	normalized = _replace_paired_marker(normalized, "**", "[b]", "[/b]")
	normalized = _replace_paired_marker(normalized, "__", "[b]", "[/b]")
	normalized = _replace_paired_marker(normalized, "`", "[color=#F5D38A]", "[/color]")
	normalized = _replace_paired_marker(normalized, "*", "[i]", "[/i]")
	return normalized


func _format_markdown_lines(text: String) -> String:
	var output: PackedStringArray = []
	for raw_line in text.split("\n", false):
		var line := String(raw_line)
		var stripped := line.strip_edges()
		if stripped.begins_with("### "):
			output.append("[b]%s[/b]" % stripped.substr(4))
		elif stripped.begins_with("## "):
			output.append("[b]%s[/b]" % stripped.substr(3))
		elif stripped.begins_with("# "):
			output.append("[b]%s[/b]" % stripped.substr(2))
		elif stripped.begins_with("- "):
			output.append("• %s" % stripped.substr(2))
		else:
			output.append(line)
	return "\n".join(output)


func _replace_paired_marker(text: String, marker: String, open_tag: String, close_tag: String) -> String:
	var count := 0
	var scan_from := 0
	while true:
		var found := text.find(marker, scan_from)
		if found == -1:
			break
		count += 1
		scan_from = found + marker.length()

	if count < 2 or count % 2 != 0:
		return text

	var result := ""
	var open := false
	var cursor := 0
	while true:
		var marker_index := text.find(marker, cursor)
		if marker_index == -1:
			result += text.substr(cursor)
			break
		result += text.substr(cursor, marker_index - cursor)
		result += close_tag if open else open_tag
		open = not open
		cursor = marker_index + marker.length()
	return result


func _speaker_color_for_source(source: String) -> String:
	match source:
		"system":
			return "#8DB8FF"
		"offline":
			return "#F2AE76"
		"online":
			return "#8EDB8A"
		"user":
			return "#EAEAEA"
		_:
			return "#D0D8E8"


func _body_color_for_source(source: String) -> String:
	match source:
		"system":
			return "#C9DCFF"
		"offline":
			return "#F6D1B4"
		"online":
			return "#B9F3B6"
		"user":
			return "#F0F0F0"
		_:
			return "#E4E4E4"


func _escape_bbcode(value: String) -> String:
	return value.replace("[", "[lb]").replace("]", "[rb]")

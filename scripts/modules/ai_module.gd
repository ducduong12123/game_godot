extends RefCounted

const MAX_AI_LOG_LINES := 200
const SCROLL_STEP_PX := 42.0

var game
var _ai_log_entries: Array[String] = []


func setup(game_ref) -> void:
	game = game_ref


func init_http() -> void:
	game.http = HTTPRequest.new()
	game.http.timeout = game.AI_TIMEOUT_SEC
	game.add_child(game.http)
	game.http.request_completed.connect(game._on_http_request_completed)


func load_ai_config() -> void:
	var config = game.AITutorService.load_config()
	game.ai_api_key = str(config.get("api_key", ""))
	game.ai_model = str(config.get("model", game.AITutorService.DEFAULT_MODEL))
	if game.ai_model.strip_edges() == "":
		game.ai_model = game.AITutorService.DEFAULT_MODEL
	game.ai_key_input.text = game.ai_api_key


func on_save_key_pressed() -> void:
	game.ai_api_key = game.ai_key_input.text.strip_edges()
	game.AITutorService.save_api_key(game.ai_api_key)
	log_ai("Hệ thống", "Đã lưu API key vào user://gemini_api_key.txt", "system")
	game.ui_controller.update_ui()


func on_ask_ai_pressed() -> void:
	var idx = clampi(game.ai_topic_option.selected, 0, game.ai_topics.size() - 1)
	ask_ai_topic(game.ai_topics[idx])


func ask_ai_topic(topic: String) -> void:
	if not game.gameplay_controller.ensure_mission_started():
		return

	game.ai_last_topic = topic
	game.ai_last_fallback = game.AITutorService.offline_answer(
		topic, game.gameplay_controller.current_puzzle_hint()
	)

	if game.ai_pending:
		log_ai("Hệ thống", "Gemini đang xử lý yêu cầu trước đó.", "system")
		return

	if game.ai_api_key.strip_edges() == "":
		log_ai("AI", game.ai_last_fallback + "\n(ngoại tuyến - chưa có Gemini key)", "offline")
		return

	var payload = {
		"systemInstruction": {"parts": [{"text": game.AITutorService.system_instruction()}]},
		"contents": [{"role": "user", "parts": [{"text": _build_ai_prompt(topic)}]}],
		"generationConfig": {"temperature": 0.35, "topP": 0.9, "maxOutputTokens": 320}
	}

	var headers = PackedStringArray(["Content-Type: application/json"])
	var url = "https://generativelanguage.googleapis.com/v1beta/models/" + "%s:generateContent?key=%s" % [
		game.ai_model,
		game.ai_api_key
	]
	var err = game.http.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(payload))
	if err != OK:
		log_ai("Hệ thống", "Không thể khởi tạo yêu cầu Gemini (err=%d)." % err, "system")
		var fallback_msg: String = (
			game.ai_last_fallback
			+ "\n(khởi tạo trực tuyến thất bại, đã dùng ngoại tuyến)"
		)
		log_ai("AI", fallback_msg, "offline")
		return

	game.ai_pending = true
	game.ui_controller.update_ui()
	log_ai("Hệ thống", "Đang gửi yêu cầu Gemini...", "system")


func _build_ai_prompt(topic: String) -> String:
	return game.AITutorService.build_prompt(
		topic,
		_build_state_for_ai(),
		game.gameplay_controller.get_allocation_from_ui(),
		game.inventory,
		game.status_line,
		game.gameplay_controller.current_puzzle_hint()
	)


func _build_state_for_ai() -> Dictionary:
	return {
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
		"puzzle_index": game.current_puzzle_index,
		"game_over": game.game_over
	}


func on_http_request_completed(
	result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray
) -> void:
	game.ai_pending = false
	game.ui_controller.update_ui()

	var parsed = JSON.parse_string(body.get_string_from_utf8())
	var answer = ""
	var err_text = ""

	if result == HTTPRequest.RESULT_SUCCESS and response_code < 400 and parsed is Dictionary:
		answer = game.AITutorService.extract_answer(parsed)
		if answer == "" and parsed.has("error"):
			var err_obj = parsed["error"]
			if err_obj is Dictionary and err_obj.has("message"):
				err_text = str(err_obj["message"])
			else:
				err_text = "Gemini trả về câu trả lời rỗng."
	elif result != HTTPRequest.RESULT_SUCCESS:
		err_text = "Yêu cầu HTTP thất bại (result=%d)." % result
	else:
		err_text = "HTTP %d" % response_code

	if answer != "":
		log_ai("AI", answer, "online")
		return

	if err_text == "":
		err_text = "Lỗi Gemini không xác định."
	log_ai("Hệ thống", "Lỗi Gemini: %s" % err_text, "system")
	log_ai("AI", game.ai_last_fallback + "\n(trực tuyến lỗi, đã dùng ngoại tuyến)", "offline")


func log_ai(speaker: String, text: String, source: String) -> void:
	if game.ai_log == null:
		return

	var safe_speaker := _escape_bbcode(speaker)
	var safe_text := _escape_bbcode(text)
	var speaker_color := _speaker_color_for_source(source)
	var body_color := _body_color_for_source(source)
	var entry := "[color=%s][b]%s[/b][/color]: [color=%s]%s[/color]\n\n" % [
		speaker_color,
		safe_speaker,
		body_color,
		safe_text
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


func _speaker_color_for_source(source: String) -> String:
	match source:
		"system":
			return "#8DB8FF"
		"offline":
			return "#F2AE76"
		"online":
			return "#8EDB8A"
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
		_:
			return "#E4E4E4"


func _escape_bbcode(value: String) -> String:
	return value.replace("[", "[lb]").replace("]", "[rb]")

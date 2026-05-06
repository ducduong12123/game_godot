extends RefCounted

var game


func setup(game_ref) -> void:
	game = game_ref


func init_http() -> void:
	# Stub: no HTTP.
	pass


func load_ai_config() -> void:
	# Stub: keep UI consistent.
	game.ai_api_key = ""
	game.ai_model = game.AITutorService.DEFAULT_MODEL
	if game.ai_key_input != null:
		game.ai_key_input.text = ""


func on_save_key_pressed() -> void:
	log_ai(
		"Hệ thống",
		"AI stub đang bật (không hỗ trợ Gemini).",
		"system"
	)


func on_ask_ai_pressed() -> void:
	ask_ai_topic("formula")


func ask_ai_topic(topic: String) -> void:
	if game == null or game.ai_log == null:
		return
	var hint := ""
	if game.gameplay_controller != null:
		hint = game.gameplay_controller.current_puzzle_hint()
	var fallback: String = game.AITutorService.offline_answer(topic, hint)
	log_ai("AI", fallback + "\n(ngoại tuyến - AI stub)", "offline")


func on_http_request_completed(
	_result: int,
	_response_code: int,
	_headers: PackedStringArray,
	_body: PackedByteArray
) -> void:
	pass


func log_ai(speaker: String, text: String, _source: String) -> void:
	if game == null or game.ai_log == null:
		return
	game.ai_log.append_text("%s: %s\n\n" % [speaker, text])
	game.ai_log.scroll_to_line(maxi(0, game.ai_log.get_line_count() - 1))


func on_ai_log_gui_input(_event: InputEvent) -> void:
	pass

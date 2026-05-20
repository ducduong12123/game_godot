extends RefCounted

var game


func setup(game_ref) -> void:
	game = game_ref


func init_http() -> void:
	pass


func load_ai_config() -> void:
	game.ai_api_key = ""
	game.ai_model = game.AITutorService.DEFAULT_MODEL


func on_save_key_pressed() -> void:
	pass


func on_ask_ai_pressed() -> void:
	var user_question := ""
	if game.ai_prompt_input != null:
		user_question = game.ai_prompt_input.text.strip_edges()
	if user_question == "":
		user_question = "Tôi nên làm gì tiếp theo?"
	ask_ai_question(user_question)


func ask_ai_topic(topic: String) -> void:
	var question := "Tôi nên làm gì tiếp theo?"
	match topic:
		"formula":
			question = "Giải thích công thức sinh tồn hiện tại."
		"risk":
			question = "Phân tích rủi ro cao nhất lúc này."
		"allocation":
			question = "Gợi ý cách phân bổ pin."
		"puzzle":
			question = "Gợi ý câu đố hiện tại."
	ask_ai_question(question)


func ask_ai_question(user_question: String) -> void:
	if game == null or game.ai_log == null:
		return
	var hint := ""
	if game.gameplay_controller != null:
		hint = game.gameplay_controller.current_puzzle_hint()
	var fallback: String = game.AITutorService.offline_answer(user_question, hint)
	log_ai("Bạn", user_question, "user")
	log_ai("AI", fallback + "\n(ngoại tuyến - AI stub)", "offline")
	if game.ai_prompt_input != null:
		game.ai_prompt_input.text = ""


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

extends RefCounted

const WAITING_STATUS := "Hãy đọc luật chơi và bấm 'Bắt đầu nhiệm vụ'."
const ACTIVE_STATUS := "Nhiệm vụ bắt đầu. Hãy khám phá bản đồ, nhặt vật phẩm và cân bằng tài nguyên."


static func intro_text() -> String:
	return (
		"Năm 2148, tàu khảo sát ORION-17 bị mất ổn định sau bão bức xạ.\n"
		+ "Bạn là kỹ thuật viên sống sót cuối cùng trên khoang điều khiển.\n\n"
		+ "Để sống sót, bạn phải phân bổ pin cho 4 hệ: sưởi, oxy, nước, thức ăn.\n"
		+ "Mỗi lượt, bạn có thể khám phá để nhặt linh kiện và giải câu đố STEM để tăng tiến độ sửa tàu.\n"
		+ "Nếu cân bằng sai tài nguyên, bạn sẽ cạn sinh lực trước khi sửa xong."
	)


static func objective_text() -> String:
	return (
		"Mục tiêu: mở khóa các khoang, thu thập linh kiện, vượt sự cố theo lượt "
		+ "và đạt 100% sửa tàu trước lượt 18."
	)


static func rules_text() -> String:
	return """LUẬT CHƠI CƠ BẢN
1) Mỗi lượt, bạn phân bổ tối đa 12 pin (mỗi hệ tối đa 6).
2) WASD để di chuyển, E để tương tác/nhặt vật phẩm/mở khóa cửa.
3) Một số cửa bị khóa và cần vật phẩm chìa (thẻ kỹ thuật, cầu chì áp suất).
4) Trả lời đúng câu đố sẽ tăng tiến độ sửa tàu; trả lời sai sẽ mất HP.
5) Mỗi lượt có thể xuất hiện sự cố ngẫu nhiên làm giảm tài nguyên.
6) Oxy về 0, HP về 0 hoặc pin cạn trước khi sửa xong => thua.
7) Sửa tàu đạt 100% trước hoặc đúng lượt 18 => thắng.

NỘI DUNG GIÁO DỤC
- Học cách đọc và áp dụng công thức tuyến tính.
- Rèn tư duy ưu tiên rủi ro trong hệ thống giới hạn tài nguyên.
- Luyện chiến lược tối ưu từng lượt dưới áp lực thời gian."""


static func ai_system_instruction() -> String:
	return (
		"Bạn là trợ giảng AI cho game sinh tồn STEM. "
		+ "Hãy trả lời ngắn gọn, thực tế, bằng tiếng Việt. "
		+ "Không đưa toàn bộ đáp án câu đố; chỉ đưa gợi ý và các bước suy luận."
	)


static func repair_stages() -> Array:
	return [
		{"name": "Khởi động chẩn đoán lỗi", "threshold": 20.0},
		{"name": "Ổn định hệ hỗ trợ sống", "threshold": 45.0},
		{"name": "Hiệu chỉnh động cơ đẩy", "threshold": 75.0},
		{"name": "Kích hoạt nhảy không gian", "threshold": 100.0}
	]


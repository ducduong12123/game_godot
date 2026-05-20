extends RefCounted

const WAITING_STATUS := "Hãy đọc luật chơi và bấm 'Bắt đầu nhiệm vụ'."
const ACTIVE_STATUS := "Nhiệm vụ bắt đầu. Hãy khám phá map, nhặt vật phẩm và sửa tàu theo từng stage."


static func intro_text() -> String:
	return (
		"Nam 2148, tau ORION-17 bi vo he thong sau mot bao buc xa ngoai khong gian.\n"
		+ "Bạn là kỹ thuật viên sống sót cuối cùng và phải đưa con tàu trở lại hoạt động.\n\n"
		+ "Trong mỗi lượt, bạn phân bổ pin cho 4 hệ: sưởi, oxy, nước, thức ăn.\n"
		+ "Khám phá map để nhặt vật phẩm, mở cửa khóa, chế tạo linh kiện và giải puzzle STEM.\n"
		+ "Mục tiêu cuối cùng là hoàn thành 5 stage sửa tàu và kích hoạt escape trước lượt 18."
	)


static func objective_text() -> String:
	return (
		"Mục tiêu: mở khóa các khoang, thu thập linh kiện, hoàn thành 5 stage sửa tàu và đạt 100% trước lượt 18."
	)


static func rules_text() -> String:
	return """LUẬT CHƠI CƠ BẢN
1) Mỗi lượt, bạn phân bổ tối đa 12 pin, mỗi hệ tối đa 6.
2) WASD để di chuyển, E để tương tác, nhặt đồ, mở cửa và dùng terminal.
3) Cửa khóa cần key item để mở. Terminal cần đúng repair item theo từng stage.
4) Giải đúng puzzle sẽ tăng repair progress. Giải sai sẽ mất HP.
5) Cuối mỗi lượt có thể có sự cố ngẫu nhiên làm giảm tài nguyên.
6) O2 = 0, HP = 0 hoặc hết pin trước khi sửa xong => thua.
7) Đạt 100% repair progress trước hoặc đúng lượt 18 => thắng.

NỘI DUNG STEM
- Đọc và áp dụng công thức tuyến tính.
- Chọn ưu tiên khi tài nguyên giới hạn.
- Lập kế hoạch từng lượt dưới áp lực."""


static func ai_system_instruction() -> String:
	return (
		"Bạn là trợ giảng AI cho game sinh tồn STEM. "
		+ "Hãy trả lời ngắn gọn, thực tế, bằng tiếng Việt. "
		+ "Không đưa toàn bộ đáp án câu đố; chỉ đưa gợi ý và các bước suy luận."
	)


static func repair_stages() -> Array:
	return [
		{"name": "Bật lại ánh sáng và chẩn đoán", "threshold": 10.0},
		{"name": "Ổn định hệ hỗ trợ sống", "threshold": 30.0},
		{"name": "Khôi phục điện và nhiệt", "threshold": 50.0},
		{"name": "Ổn định reactor", "threshold": 75.0},
		{"name": "Chuẩn bị escape", "threshold": 100.0}
	]

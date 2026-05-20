
# Chuỗi nhiệm vụ sửa tàu (CONTENT_REPAIR_FLOW)

## STAGE 1: KHỞI ĐỘNG CƠ BẢN VÀ SINH TỒN
Tên stage: Ổn định hệ hỗ trợ sống
Mục tiêu: Khôi phục oxy và nguồn điện cơ bản để người chơi không bị chết ngạt ở ngay đầu game.
Điều kiện mở: Ngay khi bắt đầu game, người chơi tiếp cận Terminal đầu tiên.
Vật phẩm bắt buộc: 1x Cụm lọc không khí (Air Filter Module), 1x Pin dự phòng (Backup Battery).
Có puzzle không: Có (Puzzle: Cân bằng Oxy lượt đầu).
Phần thưởng: +25% Repair progress.
Mở khóa tiếp theo: Mở khóa quyền truy cập vào khu vực Hành lang chính và Phòng Y tế.
Text hoàn thành: "Hệ hỗ trợ sống đã ổn định. Mức Oxy đang tăng dần. Các khoang chính có thể duy trì thêm vài giờ. Cảnh báo: Hệ thống định vị vẫn đang sập."
Vai trò trong tiến trình game: Mốc chuyển từ trạng thái hoảng loạn lúc đâm tàu sang việc bắt đầu sửa chữa có kế hoạch. Dạy người chơi cơ chế sinh tồn cốt lõi.
Ghi chú implementation: Cần map tiến trình này vào `repair_progress`. Khi hoàn thành stage này thì tắt trừ máu do thiếu Oxy ở khoang chính.

---

## STAGE 2: LẬP BẢN ĐỒ VÀ MỞ ĐƯỜNG
Tên stage: Khôi phục hệ thống định vị
Mục tiêu: Sửa chữa đài chỉ huy để biết tàu đang trôi dạt về đâu và mở khóa các khu vực sâu hơn (Zero-G).
Điều kiện mở: Hoàn thành Stage 1 và tìm được Sổ tay Kỹ sư trưởng.
Vật phẩm bắt buộc: 1x Bảng mạch điều hướng (Navigation Board) - Yêu cầu phải chế tạo.
Có puzzle không: Có (Puzzle: Logic dây dẫn điện - để mở cửa khu vực lấy linh kiện).
Phần thưởng: +35% Repair progress (Tổng đạt 60%).
Mở khóa tiếp theo: Bản đồ toàn cảnh của tàu (Minimap) và quyền truy cập vào Buồng Năng lượng.
Text hoàn thành: "Bảng mạch định hướng đã trực tuyến. Radar quét thấy một trạm vũ trụ bỏ hoang gần đây. Chúng ta cần năng lượng để khởi động động cơ đẩy!"
Vai trò trong tiến trình game: Giai đoạn giữa game (mid-game). Tạo áp lực buộc người chơi phải đi farm nguyên liệu và chế tạo công thức phức tạp.
Ghi chú implementation: Kích hoạt UI Minimap sau khi người chơi lắp thành công Bảng mạch vào Terminal ở Đài chỉ huy.

---

## STAGE 3: CHỐT CHẶN CUỐI CÙNG
Tên stage: Vượt qua vùng Không trọng lực (Zero-G)
Mục tiêu: Sửa chữa đường truyền tải điện nối từ Đài chỉ huy xuống Buồng Năng lượng.
Điều kiện mở: Hoàn thành Stage 2.
Vật phẩm bắt buộc: Giày từ tính (Magnetic Boots), Đèn tia cực tím (UV Flashlight).
Có puzzle không: Có (Puzzle: Sự kết hợp Module).
Phần thưởng: +10% Repair progress (Tổng đạt 70%).
Mở khóa tiếp theo: Mở hệ thống cửa an ninh lớp cuối cùng tiến vào Lò phản ứng.
Text hoàn thành: "Đường truyền điện đã thông suốt. Nhưng Lõi năng lượng chính đang nguội lạnh. Hãy chuẩn bị tinh thần cho việc tái khởi động thủ công."
Vai trò trong tiến trình game: Thử thách người chơi về cách quản lý nhiều Module hỗ trợ cùng lúc và làm quen với môi trường vật lý mới.
Ghi chú implementation: Thay đổi trọng lực (gravity) của player ở khu vực này, bắt buộc check điều kiện phải mang Giày từ tính mới đi lại bình thường được.

---

## STAGE 4: NHIỆM VỤ TỐI THƯỢNG
Tên stage: Khởi động lại Lõi năng lượng
Mục tiêu: Chế tạo thành công Lõi lò phản ứng mới và cắm các thanh siêu dẫn để đạt mức nhiệt độ an toàn.
Điều kiện mở: Hoàn thành Stage 3 và bước vào Buồng Năng lượng.
Vật phẩm bắt buộc: 1x Lõi lò phản ứng (Reactor Core) - Chế tạo từ cực nhiều tài nguyên.
Có puzzle không: Có (Puzzle: Khởi động Lò phản ứng - Bài toán tính số lượng thanh siêu dẫn).
Phần thưởng: +30% Repair progress (Tổng đạt 100%).
Mở khóa tiếp theo: Màn hình Chiến thắng (Victory Screen).
Text hoàn thành: "Lõi lò phản ứng đã đạt 1050 độ C. Động cơ đẩy hoạt động 100%. Quỹ đạo đã được thiết lập lại. Chúc mừng phi hành gia, bạn đã cứu sống con tàu!"
Vai trò trong tiến trình game: Đỉnh điểm (Climax) của game. Bắt người chơi dốc toàn bộ tài nguyên và giải quyết câu đố toán học khó nhất để chiến thắng.
Ghi chú implementation: Khi kích hoạt thành công, chạy hiệu ứng rung màn hình, đổi ánh sáng toàn map sang màu xanh lam và gọi scene Ending.


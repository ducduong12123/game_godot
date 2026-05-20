# Danh sách công thức chế tạo (CONTENT_RECIPES)

## NHÓM 1: CÔNG THỨC SINH TỒN CƠ BẢN (Đầu game)

Tên recipe: Chế tạo Pin dự phòng
ID: make_battery
Mở khóa khi nào: Từ đầu game.
Nguyên liệu: 1x Mảnh hợp kim (Alloy Plate), 1x Dung dịch điện giải (Electrolyte Pack).
Chi phí pin: 0
Chi phí hành động: 1
Đầu ra: 1x Pin dự phòng (Backup Battery).
Loại đầu ra: Vật phẩm tiêu hao.
Hiệu ứng: Tạo ra item giúp hồi 25% Năng lượng.
Đánh đổi: Tốn mất dung dịch điện giải - thứ có thể dùng để chế đồ cứu thương sau này.
Vai trò trong flow game: Cứu nguy khi người chơi cạn kiệt năng lượng ở các màn đầu.
Ghi chú thêm: Đây là công thức cơ bản nhất để dạy người chơi cơ chế Crafting.

---
Tên recipe: Tổng hợp Keo sinh học
ID: make_biogel
Mở khóa khi nào: Sau khi mở khóa Phòng Y tế (Medbay).
Nguyên liệu: 2x Dung dịch điện giải (Electrolyte Pack).
Chi phí pin: 5
Chi phí hành động: 2
Đầu ra: 1x Keo sinh học (Bio-Gel).
Loại đầu ra: Vật phẩm tiêu hao.
Hiệu ứng: Tạo ra item hồi 50 HP.
Đánh đổi: Tốn rất nhiều Năng lượng (pin) để máy móc tổng hợp, khiến người chơi dễ rơi vào trạng thái thiếu điện.
Vai trò trong flow game: Cho người chơi lựa chọn đánh đổi Điện lấy Máu.
Ghi chú thêm: Âm thanh chế tạo nên giống tiếng đun sôi hóa chất.

---
Tên recipe: Tái chế Băng dính cách điện
ID: recycle_tape
Mở khóa khi nào: Từ đầu game.
Nguyên liệu: 1x Keo sinh học (Bio-Gel), 1x Mảnh hợp kim (Alloy Plate).
Chi phí pin: 2
Chi phí hành động: 1
Đầu ra: 1x Băng dính cách điện (Insulating Tape).
Loại đầu ra: Vật phẩm tiêu hao.
Hiệu ứng: Tạo ra item giúp vượt qua các nẹp cửa hỏng mà không tốn chìa khóa.
Đánh đổi: Phải hy sinh vật phẩm hồi máu (Keo sinh học).
Vai trò trong flow game: Cung cấp lối đi tắt cho người chơi lười giải đố nhưng giàu tài nguyên.
Ghi chú thêm: [Không có]


## NHÓM 2: CÔNG THỨC MODULE & CÔNG CỤ (Giữa game)

Tên recipe: Ráp Đèn tia cực tím
ID: uv_light_recipe
Mở khóa khi nào: Sau khi nhặt được bản thiết kế ở Phòng Kỹ thuật.
Nguyên liệu: 2x Mảnh hợp kim (Alloy Plate), 1x Pin dự phòng (Backup Battery).
Chi phí pin: 10
Chi phí hành động: 3
Đầu ra: 1x Đèn tia cực tím (UV Flashlight).
Loại đầu ra: Module hỗ trợ.
Hiệu ứng: Cho phép nhìn thấy hint ẩn trên tường/phím bấm.
Đánh đổi: Mất đi lượng pin dự phòng lớn và tốn điểm hành động.
Vai trò trong flow game: Bắt buộc phải chế để qua được các câu đố tìm mật khẩu ở giữa game.
Ghi chú thêm: Cần hiện thông báo "Đã gắn vào bộ đồ bảo hộ" khi chế xong.

---
Tên recipe: Sửa chữa Vi mạch hỏng
ID: fix_chip
Mở khóa khi nào: Khi tìm thấy Vi mạch hỏng đầu tiên.
Nguyên liệu: 1x Vi mạch hỏng (Damaged Microchip), 1x Băng dính cách điện (Insulating Tape).
Chi phí pin: 15
Chi phí hành động: 2
Đầu ra: 1x Vi mạch điều khiển (Control Chip).
Loại đầu ra: Nguyên liệu cấp 2.
Hiệu ứng: Dùng để làm nguyên liệu cho các thiết bị cao cấp.
Đánh đổi: Tốn nhiều năng lượng để hàn mạch.
Vai trò trong flow game: Dạy người chơi khái niệm "chế tạo nhiều bước" (chế A để làm nguyên liệu ghép thành B).
Ghi chú thêm: Thêm một câu đố nối dây điện mini khi bấm chế tạo công thức này sẽ rất hay.

---
Tên recipe: Nâng cấp Giày từ tính
ID: boots_upgrade
Mở khóa khi nào: Khi bước vào khu vực Zero-G.
Nguyên liệu: 1x Giày từ tính (Magnetic Boots), 2x Dây dẫn siêu dẫn (Superconductor Wire).
Chi phí pin: 20
Chi phí hành động: 4
Đầu ra: Giày từ tính cường hóa (Upgraded Mag Boots).
Loại đầu ra: Module hỗ trợ.
Hiệu ứng: Không bị giảm tốc độ di chuyển trong khu vực mất trọng lực và miễn nhiễm sát thương điện trên sàn.
Đánh đổi: Tốn vật liệu cực hiếm (Dây dẫn siêu dẫn).
Vai trò trong flow game: Tối ưu hóa trải nghiệm đi lại ở late-game.
Ghi chú thêm: Nâng cấp trực tiếp vào item cũ.


## NHÓM 3: CÔNG THỨC NHIỆM VỤ BẮT BUỘC (Cuối game)

Tên recipe: Hàn Bảng mạch điều hướng
ID: nav_board_recipe
Mở khóa khi nào: Khi nhận nhiệm vụ "Khôi phục hệ thống định vị".
Nguyên liệu: 2x Vi mạch điều khiển (Control Chip), 2x Dây dẫn siêu dẫn (Superconductor Wire), 3x Mảnh hợp kim (Alloy Plate).
Chi phí pin: 30
Chi phí hành động: 5
Đầu ra: 1x Bảng mạch điều hướng (Navigation Board).
Loại đầu ra: Vật phẩm sửa tàu bắt buộc.
Hiệu ứng: Hoàn thành stage 3 của quá trình sửa tàu.
Đánh đổi: Yêu cầu người chơi phải dốc gần như toàn bộ tài nguyên tích trữ được.
Vai trò trong flow game: Checkpoint chặn người chơi, ép họ phải đi farm đủ đồ mới được qua màn.
Ghi chú thêm: Đặt máy chế tạo chuyên dụng ở đài chỉ huy cho công thức này.

---
Tên recipe: Khởi động Lõi lò phản ứng
ID: reactor_crafting
Mở khóa khi nào: Khi vào được Buồng năng lượng (Nhiệm vụ cuối).
Nguyên liệu: 4x Dây dẫn siêu dẫn (Superconductor Wire), 3x Dung dịch điện giải (Electrolyte Pack), 5x Mảnh hợp kim (Alloy Plate).
Chi phí pin: 50
Chi phí hành động: 10
Đầu ra: 1x Lõi lò phản ứng (Reactor Core).
Loại đầu ra: Vật phẩm sửa tàu bắt buộc.
Hiệu ứng: Chế tạo thành công trái tim của con tàu, chuẩn bị cho điều kiện Thắng.
Đánh đổi: Cạn kiệt mọi nguồn lực. Nếu chế xong mà gặp quái/rủi ro thì gần như không còn đồ bơm máu/pin.
Vai trò trong flow game: Thử thách tối thượng về quản lý tài nguyên.
Ghi chú thêm: Khi nhấn nút chế tạo, toàn bộ tàu sẽ nháy đèn đỏ báo động.


## NHÓM 4: CÔNG THỨC ĐÁNH ĐỔI & PHÂN RÃ (Trade-off)

Tên recipe: Rã Pin lấy dung dịch
ID: dismantle_battery
Mở khóa khi nào: Sau khi gặp Terminal đầu tiên.
Nguyên liệu: 1x Pin dự phòng (Backup Battery).
Chi phí pin: 0
Chi phí hành động: 1
Đầu ra: 1x Dung dịch điện giải (Electrolyte Pack).
Loại đầu ra: Nguyên liệu chế tạo.
Hiệu ứng: Chuyển hóa Pin thành nguyên liệu lỏng.
Đánh đổi: Mất đi công cụ hồi năng lượng.
Vai trò trong flow game: Giúp người chơi gỡ bí khi đang quá thừa Pin nhưng lại thiếu Dung dịch để chế đồ cứu thương.
Ghi chú thêm: Quá trình rã sẽ làm mất luôn lớp vỏ hợp kim, không thu hồi được.

---
Tên recipe: Ép xung Lõi lọc khí
ID: overclock_air_filter
Mở khóa khi nào: Khi thanh Oxy của tàu tụt xuống dưới 20%.
Nguyên liệu: 1x Dây dẫn siêu dẫn (Superconductor Wire).
Chi phí pin: Toàn bộ pin hiện có.
Chi phí hành động: 0 (Hành động tức thì)
Đầu ra: Phục hồi 50% Oxy cho toàn bộ map.
Loại đầu ra: Hiệu ứng hệ thống (Không ra vật phẩm).
Hiệu ứng: Cứu tàu khỏi cảnh Game Over do hết Oxy.
Đánh đổi: Mất trắng toàn bộ Năng lượng hiện tại và 1 Dây dẫn quý hiếm. Nhân vật sẽ rơi vào trạng thái nguy hiểm (bò lết).
Vai trò trong flow game: Cơ chế "Nút bấm hoảng loạn" (Panic button) ở những giây phút sinh tử.
Ghi chú thêm: Chỉ hiển thị công thức này ở Terminal chính của phòng điều khiển khi Oxy xuống thấp.




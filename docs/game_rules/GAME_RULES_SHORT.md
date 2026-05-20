# Game Rules Short

Mục đích của file này là tóm tắt phần game rules đủ ngắn để đọc nhanh và đủ rõ để chốt hướng implementation.

## 1. Core loop

Mỗi lượt chơi đi theo nhịp:

1. Kiểm tra trạng thái sinh tồn và module đang bật.
2. Người chơi phân bổ pin và dùng số action còn lại.
3. Di chuyển, khám phá, nhặt đồ, giải puzzle, chế tạo, sửa tàu.
4. Kết thúc lượt: trừ tài nguyên, áp dụng event, cập nhật repair progress.
5. Kiểm tra thắng hoặc thua.

## 2. Tài nguyên cốt lõi

### O2
- Giảm theo lượt.
- Là áp lực sinh tồn sớm nhất.
- Về 0 thì bắt đầu mất HP.

### Battery
- Tài nguyên chiến lược quan trọng nhất từ giữa game trở đi.
- Dùng cho craft, module, sửa hệ thống, mở tiến trình.
- Hết pin thì module tắt và nhiều hệ thống không vận hành được.

### HP
- Điều kiện thua trực tiếp.
- Mất do thiếu O2, nhiệt độ nguy hiểm, bức xạ, event, đói hoặc khát kéo dài.

### Temp
- Kiểm soát độ nguy hiểm môi trường.
- Vượt ngưỡng thì gây mất HP hoặc tăng áp lực pin.

### Hydration / Satiety
- Áp lực sinh tồn trung hạn và dài hạn.
- Không giết người chơi ngay, nhưng kéo game vào trạng thái thua nếu bỏ mặc.

### Repair Progress
- Thanh tiến trình chính của game.
- Tăng khi hoàn thành stage sửa tàu, dùng repair item, vượt puzzle liên quan.

### Actions Left
- Giới hạn số việc làm mỗi lượt.
- Tạo tradeoff giữa survival, repair và exploration.

## 3. Trục áp lực của game

### Early game
- Áp lực chính: O2, ánh sáng, cửa khóa, thiếu vật liệu cơ bản.
- Mục tiêu: sống sót, mở khu đầu, hiểu loop nhặt đồ -> craft -> sửa.

### Mid game
- Áp lực chính: pin, module, thứ tự sửa hệ thống.
- Mục tiêu: ổn định O2, điện, nhiệt và mở các khu có tài nguyên quan trọng.

### Late game
- Áp lực chính: reactor, radiation, thiếu tài nguyên hiếm, timer thoát hiểm.
- Mục tiêu: hoàn thành chuỗi sửa tàu cuối và escape.

## 4. Vòng lặp tiến trình đúng

Loop đúng của game là:

1. Khám phá khu đang mở.
2. Nhặt nguyên liệu và key item.
3. Chế tạo item hoặc module cần thiết.
4. Sửa một hệ thống quan trọng.
5. Mở khu hoặc stage tiếp theo.
6. Lặp lại với áp lực cao hơn.

Nếu người chơi chỉ khám phá mà không craft hoặc không sửa hệ thống quan trọng thì sẽ soft-lock hoặc chết dần.

## 5. 5 stage sửa tàu cần nhớ

### Stage 1 - Ổn định khu khởi đầu
- Bật lại ánh sáng.
- Mở cửa cơ bản.
- Vá thông gió hoặc hệ hỗ trợ sống mức đầu.

### Stage 2 - Ổn định hệ hỗ trợ sống
- Khôi phục O2 hoặc cụm lọc khí.
- Giảm áp lực thiếu oxy toàn map.
- Mở thêm khu khám phá an toàn hơn.

### Stage 3 - Khôi phục điện và nhiệt
- Sửa lưới điện trung tâm.
- Ổn định nhiệt độ hoặc hệ thống liên quan.
- Mở recipe và hệ thống mạnh hơn.

### Stage 4 - Reactor crisis
- Xử lý lò phản ứng.
- Radiation và event tăng mạnh.
- Đây là đỉnh áp lực của giữa game.

### Stage 5 - Escape
- Khôi phục điều hướng, động cơ, launch control.
- Hoàn thành puzzle cuối.
- Kích hoạt thoát hiểm.

## 6. Hệ item theo vai trò

### Material
- Dùng để craft.
- Ví dụ: alloy plate, electrolyte pack, super wire, broken chip.

### Consumable
- Dùng một lần để cứu nguy hoặc hồi tài nguyên.
- Ví dụ: backup battery, portable oxygen, bio gel.

### Key item
- Mở khu, mở terminal, mở stage.
- Ví dụ: access card, engineer log.

### Repair item
- Dùng trực tiếp trong nhiệm vụ sửa tàu.
- Ví dụ: reactor core, navigation board, air filter module.

### Module
- Hiệu ứng nhiều lượt, thường đổi lấy battery drain.
- Ví dụ: UV flashlight, magnetic boots, oxygen recycler, radiation shield.

## 7. Những rule implementation cần chốt thêm

Đây là các chỗ hiện chưa đủ sạch để code thẳng:

- O2 giảm bao nhiêu mỗi lượt.
- Battery giảm bao nhiêu khi bật từng module.
- Temp ở ngưỡng nào thì bắt đầu gây damage.
- Item hồi chính xác bao nhiêu.
- Module kéo dài bao nhiêu lượt.
- Event có xác suất bao nhiêu.
- Item nào chỉ là data, item nào kéo theo tính năng mới.

## 8. Tính năng có thể làm sau

Các ý này hợp thiết kế nhưng không nên ép implement ngay nếu muốn ra bản chơi được sớm:

- Zero-G làm trượt người chơi.
- UV flashlight hiện hint ẩn trên map.
- Vật nặng làm chậm tốc độ.
- Reactor core gây mất máu khi mang.
- Minimap unlock hoặc clue rendering riêng.

## 9. Điều kiện thắng và thua

### Thắng
- Hoàn thành các stage sửa tàu chính.
- Kích hoạt escape thành công.
- Người chơi còn sống.

### Thua
- HP về 0.
- O2 sụp hoàn toàn và không cứu kịp.
- Reactor meltdown.
- Hết tài nguyên đến mức không thể tiếp tục progression.
- Fail nhiệm vụ cuối.

## 10. Thứ cần đọc sau file này

Sau khi đọc xong file ngắn này, chỉ cần đọc tiếp:

1. `docs/game_content/GAME_CONTENT_SHORT.md`
2. `docs/game_rules/IMPLEMENTATION_MAPPING.md`

Không cần quay lại file dài trừ khi cần tra cứu chi tiết.

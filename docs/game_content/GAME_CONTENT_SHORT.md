# Game Content Short

Mục đích của file này là gom phần content thành bản ngắn đủ để chốt scope triển khai.

## 1. Bộ content hiện tại đang xoay quanh gì

Game đang có 4 nhóm content chính:

1. Item
2. Recipe
3. Puzzle STEM
4. Repair flow

Mục tiêu của content là phục vụ loop:

khám phá -> nhặt nguyên liệu -> craft -> sửa tàu -> mở khu mới -> thoát hiểm

## 2. Nhóm item chính cần giữ

### A. Nguyên liệu chế tạo

Các item đáng giữ cho bản triển khai đầu:

- `alloy_plate`
- `electrolyte_pack`
- `super_wire`
- `broken_chip`

Vai trò:
- nguyên liệu nền cho craft
- chia độ hiếm theo khu vực
- tạo gating giữa early và mid game

### B. Vật phẩm sửa tàu bắt buộc

Các item cốt lõi:

- `reactor_core`
- `nav_board`
- `air_filter_module`

Vai trò:
- khóa progression chính
- gắn trực tiếp với stage sửa tàu

### C. Consumable

Các item đáng giữ:

- `backup_battery`
- `port_oxygen`
- `duct_tape`
- `bio_gel`

Vai trò:
- cứu nguy
- giảm độ gắt của survival loop
- cho người chơi hồi phục hoặc bypass tình huống xấu

### D. Key item

Các item đáng giữ:

- `keycard_lvl1`
- `engineer_log`

Vai trò:
- mở khu
- mở clue
- mở progression

### E. Module hỗ trợ

Các item hiện có:

- `uv_light`
- `mag_boots`

Nhận xét:
- ý tưởng tốt
- nhưng cả 2 đều đòi hỏi code mới
- không nên coi là bắt buộc cho vertical slice đầu

## 3. Recipe nên giữ cho bản đầu

Không nên làm hết nếu muốn ra bản chơi được sớm. Chỉ cần 6-8 recipe cốt lõi:

- Recipe hồi pin
- Recipe hồi O2
- Recipe hồi máu
- Recipe repair patch
- Recipe navigation board
- Recipe reactor core
- Recipe module ổn định O2 hoặc battery

Tiêu chí giữ recipe:

- phục vụ sống sót
- phục vụ sửa tàu
- có tradeoff rõ giữa nguyên liệu, pin, action

Recipe nên để sau:

- recipe chỉ thêm flavor
- recipe đòi hỏi cơ chế mới ngoài code hiện tại

## 4. Puzzle nên giữ cho bản đầu

Puzzle nên chia 3 lớp:

### Early
- puzzle đọc công thức đơn giản
- puzzle tính tài nguyên cơ bản
- puzzle mở terminal đầu tiên

### Mid
- puzzle điện, logic mạch
- puzzle chọn thứ tự sửa hệ thống
- puzzle đổi reward lấy risk

### Late
- puzzle reactor
- puzzle điều hướng
- puzzle launch/escape cuối

Tiêu chí giữ:
- phải mở progression, reward hoặc hệ thống
- không chỉ là câu hỏi cho có

## 5. Repair flow nên giữ cho bản đầu

Giữ progression ngắn và rõ:

1. Bật lại ánh sáng / khu đầu
2. Ổn định O2
3. Khôi phục điện hoặc nhiệt
4. Ổn định reactor
5. Chuẩn bị escape

Nếu làm nhiều stage nhỏ hơn ngay từ đầu, coder rất dễ sa vào viết flow mà chưa có game loop ổn.

## 6. Content nào dùng được ngay

Các phần có thể đưa vào game dưới dạng data khá nhanh:

- tên item
- ID item
- mô tả ngắn
- recipe ingredients
- recipe output
- puzzle question / answers / hint / reward
- tên stage sửa tàu
- item required cho từng stage

## 7. Content nào đòi hỏi code mới

Đây là phần cần đánh dấu riêng cho implementer:

- `mag_boots` với cơ chế trượt ở Zero-G
- `uv_light` với hint ẩn trên map
- item nặng làm chậm tốc độ
- reactor core gây damage khi mang
- đọc log để mở clue hoặc UI đọc tài liệu
- minimap unlock hoặc layer map mới

Nếu không cắt scope, những ý này sẽ làm chậm implementation rất mạnh.

## 8. Bộ content tối thiểu khuyên dùng cho vertical slice

### Materials
- `alloy_plate`
- `electrolyte_pack`
- `super_wire`

### Consumables
- `backup_battery`
- `port_oxygen`
- `bio_gel`

### Key items
- `keycard_lvl1`
- `engineer_log`

### Repair items
- `air_filter_module`
- `nav_board`
- `reactor_core`

### Optional module
- 1 module O2 hoặc battery trước

Không nên ôm quá nhiều module đặc biệt ở bản đầu.

## 9. Bộ content cần chốt lại trước khi coder làm

Trước khi implement, phải chốt 4 thứ:

1. Item nào là bắt buộc cho progression.
2. Recipe nào xuất hiện từ đầu, recipe nào mở sau.
3. Puzzle nào là gate thật sự.
4. Repair flow cuối cùng có bao nhiêu stage.

## 10. Kết luận ngắn

Content hiện tại đủ tốt để làm spec v1, nhưng chưa nên đổ hết vào game.

Nên dùng theo cách:

- giữ item và recipe cốt lõi
- giữ puzzle mở progression
- giữ repair flow ngắn
- tạm hoãn các cơ chế đẹp nhưng tốn code mới

## 11. Thứ cần đọc sau file này

Sau file này, chỉ cần đọc tiếp:

1. `docs/game_rules/IMPLEMENTATION_MAPPING.md`
2. nếu cần chi tiết mới quay lại:
   - `Content_Items.md`
   - `Content_Recipe.md`
   - `Content_Puzzles.md`
   - `Content_Repair_Flow.md`

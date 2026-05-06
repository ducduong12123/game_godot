# Art / Sprite - Tài liệu giao việc

Mục đích của tài liệu này là giao việc rõ ràng cho người phụ trách `Art / Sprite` trong project `SpaceStemGodot`.

Vai trò này không phụ trách thiết kế luật chơi lõi hay lập trình chính. Nhiệm vụ là tạo bộ hình ảnh và quy chuẩn hình ảnh đủ rõ để người implementation có thể đưa vào game đúng chỗ, đúng vai trò, đúng mức ưu tiên.

## 1. Vai trò này phụ trách gì

Người làm `Art / Sprite` chịu trách nhiệm cho:
- sprite nhân vật
- sprite vật phẩm
- sprite cửa, terminal, module, điểm tương tác
- icon tài nguyên UI
- hình minh họa hoặc biểu tượng cho puzzle, repair stage nếu cần
- thống nhất phong cách hình ảnh ingame

Vai trò này không phụ trách chính cho:
- viết rules game
- viết content item hoặc recipe
- lập trình Godot
- cân bằng gameplay
- sửa logic tài nguyên

## 2. Mục tiêu của vai trò

Cần tạo ra bộ asset giúp game dễ đọc hơn, rõ thông tin hơn và có cảm giác đồng nhất hơn.

Kết quả mong muốn:
- người chơi nhìn vào là phân biệt được vật phẩm theo nhóm
- cửa khóa, cửa mở, terminal và điểm tương tác đều dễ nhận biết
- UI tài nguyên có icon rõ ràng
- asset đủ nhất quán để không bị cảm giác “mỗi thứ một kiểu”

## 3. Bối cảnh hiện tại của project

Game hiện tại đang dùng nhiều hình khối vẽ trực tiếp trong code:
- `scripts/modules/world_module.gd`: vẽ phòng, cửa, item, người chơi bằng shape
- `scripts/modules/ui_module.gd`: dựng UI bằng code

Điều này có nghĩa là phần art hiện tại có thể đi theo 2 mức:
- mức 1: làm sprite và icon để thay thế dần hình khối hiện có
- mức 2: làm thêm visual feedback cho các trạng thái quan trọng

Người làm art không cần tự sửa code, nhưng phải bàn giao asset theo cách mà coder dễ gắn vào:
- tên file rõ
- nhóm asset rõ
- vai trò asset rõ
- kích thước hoặc tỷ lệ dự kiến rõ

## 4. Phạm vi công việc cụ thể

### 4.1. Sprite nhân vật

Cần thiết kế:
- sprite người chơi hoặc phi hành gia
- trạng thái cơ bản: đứng, di chuyển nếu đủ thời gian
- silhouette dễ đọc trên nền tối hoặc nền màu lạnh

Yêu cầu:
- nhìn ra ngay đây là nhân vật chính
- không quá nhỏ chi tiết
- phù hợp góc nhìn top-down hoặc giả top-down

### 4.2. Sprite vật phẩm

Cần thiết kế theo nhóm để người chơi nhìn là hiểu vai trò:
- vật phẩm chìa khóa
- vật phẩm sửa tàu bắt buộc
- nguyên liệu chế tạo
- vật phẩm tiêu hao
- module hỗ trợ

Mục tiêu là phân loại bằng hình:
- màu
- hình khối
- biểu tượng phụ

Ví dụ:
- item liên quan pin: thiên về vàng hoặc xanh điện
- item liên quan oxy: thiên về xanh lam hoặc trắng
- item liên quan nhiệt: thiên về cam, đỏ hoặc lõi phát sáng
- item kỹ thuật: thiên về xám, xanh thép

### 4.3. Sprite tương tác môi trường

Cần làm:
- terminal chính
- cửa mở
- cửa khóa
- cửa cần key item
- điểm repair hoặc panel điều khiển nếu có

Mục tiêu:
- người chơi nhìn map biết đâu là chỗ tương tác
- tránh nhầm vật phẩm nhặt được với vật thể môi trường

### 4.4. Icon tài nguyên cho UI

Cần chuẩn bị icon cho:
- pin
- nhiệt độ
- oxy
- nước
- độ no
- HP
- tiến độ sửa tàu
- hành động còn lại

Yêu cầu:
- đơn giản
- đọc tốt ở cỡ nhỏ
- cùng phong cách
- không quá nhiều chi tiết thừa

### 4.5. Visual feedback ưu tiên

Nếu còn thời gian, có thể chuẩn bị thêm asset cho:
- nhặt vật phẩm
- cảnh báo nguy hiểm
- tiến độ sửa tàu đạt mốc
- event ngẫu nhiên như rò oxy, chập mạch, lạnh sâu

Phần này là ưu tiên sau, không bắt buộc nếu nhân lực ít.

## 5. Deliverables bắt buộc

Người phụ trách `Art / Sprite` phải nộp 4 đầu ra chính.

### Deliverable A - Danh sách asset cần làm

Tên gợi ý:
- `docs/design/ART_ASSET_LIST.md`

Nội dung cần có:
- tên asset
- nhóm asset
- vai trò trong game
- mức ưu tiên

### Deliverable B - Quy chuẩn phong cách hình ảnh

Tên gợi ý:
- `docs/design/ART_STYLE_GUIDE.md`

Nội dung cần có:
- hướng phong cách
- bảng màu chính
- độ chi tiết mong muốn
- quy tắc ánh sáng, viền, độ tương phản

### Deliverable C - Bộ sprite/icon bàn giao

Tên gợi ý thư mục:
- `assets/sprites/`
- `assets/ui/icons/`

Nội dung cần có:
- file sprite thực tế
- icon UI thực tế
- tên file chuẩn hóa

### Deliverable D - Bảng mapping asset

Tên gợi ý:
- `docs/design/ART_IMPLEMENTATION_MAPPING.md`

Nội dung cần có:
- asset nào dùng cho object nào
- kích thước gợi ý
- anchor hoặc hướng đặt nếu cần
- ghi chú đặc biệt cho coder

## 6. Template bắt buộc cho từng asset

```text
Tên asset:
ID:
Nhóm:
Dùng cho:
Mô tả hình ảnh:
Màu chủ đạo:
Kích thước đề xuất:
Mức ưu tiên:
Trạng thái liên quan:
Ghi chú implementation:
```

Ví dụ:

```text
Tên asset: Cửa A1 khóa
ID: door_a1_locked
Nhóm: môi trường tương tác
Dùng cho: cửa khóa cần thẻ kỹ thuật
Mô tả hình ảnh: cửa trượt kim loại với đèn đỏ và biểu tượng khóa
Màu chủ đạo: xám thép, đỏ cảnh báo
Kích thước đề xuất: 32x64
Mức ưu tiên: cao
Trạng thái liên quan: locked
Ghi chú implementation: cần một biến thể mở và một biến thể đóng để coder đổi theo trạng thái
```

## 7. Template bắt buộc cho icon UI

```text
Tên icon:
Dùng cho chỉ số:
Ý nghĩa cần truyền tải:
Phong cách:
Màu chủ đạo:
Kích thước đề xuất:
Độ ưu tiên:
Ghi chú thêm:
```

Ví dụ:

```text
Tên icon: Pin năng lượng
Dùng cho chỉ số: battery
Ý nghĩa cần truyền tải: năng lượng còn lại của tàu và tài nguyên phân bổ
Phong cách: tối giản, sci-fi, dễ đọc ở cỡ nhỏ
Màu chủ đạo: vàng điện, xanh cyan nhạt
Kích thước đề xuất: 24x24
Độ ưu tiên: cao
Ghi chú thêm: cần rõ hình kể cả khi hiển thị trên nền tối
```

## 8. Checklist tự rà trước khi nộp

Người làm art phải tự kiểm tra:
- người chơi có phân biệt được nhóm vật phẩm bằng hình không
- asset có đồng nhất phong cách không
- icon UI có đọc tốt ở kích thước nhỏ không
- asset quan trọng có đủ tương phản với nền game không
- cửa, terminal và item có bị giống nhau quá không
- coder có đủ thông tin để gắn asset vào game không
- art team có đang làm dư asset chưa cần tới không

## 9. Cách bàn giao cho người implementation

Khi bàn giao asset, cần kèm:
- tên file chính xác
- asset dùng cho object nào
- trạng thái nào dùng sprite nào
- kích thước gợi ý
- nếu có animation thì ghi rõ frame nào, thứ tự nào

Ví dụ cách bàn giao:
- `player_idle.png`: nhân vật đứng
- `player_walk_strip.png`: nhân vật đi
- `door_locked_red.png`: dùng cho cửa khóa
- `door_open_green.png`: dùng cho cửa đã mở
- `icon_battery.png`: dùng cho UI pin

Người implementation sẽ cần biết:
- asset nào dùng thay item hình tròn hiện tại
- asset nào dùng thay cửa đang vẽ bằng hình chữ nhật
- asset nào chỉ dùng cho UI

## 10. Definition of done

Vai trò `Art / Sprite` được xem là hoàn thành khi:
- đã có danh sách asset rõ ràng
- đã có phong cách hình ảnh thống nhất
- đã có đủ sprite ưu tiên cao cho người chơi, item, cửa, terminal, icon UI
- coder nhận asset là biết gắn vào đâu
- phần art hỗ trợ gameplay đọc tốt hơn, không chỉ để trang trí

## 11. Cách phối hợp với các vai trò khác

Phối hợp với `Content design`:
- lấy danh sách vật phẩm, module, stage để biết cần vẽ gì
- xác nhận item nào là bắt buộc, item nào là tùy chọn

Phối hợp với `Game rules / systems design`:
- hiểu nhóm tài nguyên và vai trò gameplay để thể hiện đúng bằng hình

Phối hợp với `Gameplay implementer`:
- thống nhất tên file
- thống nhất cách tách trạng thái mở/đóng/khóa
- thống nhất asset nào cần trước để tích hợp sớm

## 12. Thứ tự làm việc đề xuất

1. Chốt style guide ngắn.
2. Liệt kê toàn bộ asset cần làm.
3. Làm nhóm asset ưu tiên cao:
   - player
   - item chính
   - cửa
   - terminal
   - icon UI
4. Làm nhóm asset ưu tiên trung bình:
   - module
   - item phụ
   - marker event hoặc repair
5. Bàn giao mapping asset cho coder.

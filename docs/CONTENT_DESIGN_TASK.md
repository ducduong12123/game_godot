# Content Design - Tài liệu giao việc

Mục đích của tài liệu này là giao việc rõ ràng cho người phụ trách `Content design` trong project `SpaceStemGodot`.

Vai trò này không phụ trách code chính. Nhiệm vụ là thiết kế nội dung cụ thể để người implementation có thể đưa vào game mà không phải tự suy đoán thêm.

## 1. Vai trò này phụ trách gì

Người làm `Content design` chịu trách nhiệm cho phần nội dung cụ thể của game, bao gồm:
- danh sách vật phẩm
- công thức lắp ráp
- câu đố STEM
- nhiệm vụ sửa tàu
- mô tả ingame
- nhịp tiến triển nội dung giữa đầu game, giữa game và cuối game

Vai trò này không phụ trách chính cho:
- công thức hệ thống lõi
- cân bằng code mức thấp
- lập trình Godot
- sprite hoàn thiện
- UI và hiệu ứng

## 2. Mục tiêu của vai trò

Cần tạo ra một bộ nội dung đủ chi tiết để:
- người làm `Game rules / systems design` kiểm tra được tính hợp lý
- người implement biết phải thêm gì vào data
- người làm art biết cần vẽ asset nào
- người test biết cần test những flow nào

Kết quả mong muốn là nội dung của game có cảm giác nhất quán:
- vật phẩm có vai trò rõ
- câu đố gắn với gameplay
- nhiệm vụ sửa tàu có tiến triển
- phần text ingame không bị chung chung

## 3. Phần content trong project hiện tại đang nằm ở đâu

Các file liên quan trực tiếp:
- `scripts/content/game_data.gd`: item, puzzle, recipe, terminal requirements
- `scripts/content/story_rules.gd`: intro, objective, rules text, repair stages

Người làm content không cần sửa trực tiếp các file này, nhưng phải viết tài liệu theo cách mà coder có thể map ngược vào đây.

## 4. Phạm vi công việc cụ thể

### 4.1. Thiết kế vật phẩm

Cần xây bộ vật phẩm theo nhóm rõ ràng:
- `Vật phẩm chìa khóa`
- `Vật phẩm sửa tàu bắt buộc`
- `Nguyên liệu chế tạo`
- `Vật phẩm tiêu hao`
- `Module hỗ trợ nhiều lượt`
- `Vật phẩm thưởng hoặc hỗ trợ tùy chọn`

Mỗi vật phẩm phải trả lời được:
- nó xuất hiện ở đâu
- người chơi lấy nó bằng cách nào
- nó dùng để làm gì
- nó có hỗ trợ sinh tồn, sửa tàu hay mở khóa không
- nó có liên quan đến vật phẩm hoặc nhiệm vụ nào khác không

### 4.2. Thiết kế công thức chế tạo

Cần xác định:
- công thức nào có từ đầu game
- công thức nào mở khóa sau một mốc sửa tàu hoặc sau khi vào khu mới
- công thức nào để cứu nguy
- công thức nào để tối ưu hóa đường chơi

Mỗi recipe cần có:
- nguyên liệu đầu vào
- chi phí pin
- chi phí hành động
- vật phẩm đầu ra
- tác dụng
- đánh đổi

### 4.3. Thiết kế câu đố STEM

Mục tiêu của puzzle không phải chỉ để “cho có”, mà phải phục vụ:
- tăng tiến độ sửa tàu
- dạy hoặc nhắc lại tư duy tài nguyên
- tạo áp lực ra quyết định

Mỗi puzzle cần có:
- câu hỏi
- 4 đáp án
- đáp án đúng
- gợi ý
- phần thưởng
- lý do tồn tại trong flow game

Cần chia puzzle theo mức:
- đầu game: đọc công thức trực tiếp, tính đơn giản
- giữa game: ưu tiên tài nguyên, chọn phương án an toàn
- cuối game: tối ưu nhiều ràng buộc cùng lúc

### 4.4. Thiết kế nhiệm vụ sửa tàu

Không nên chỉ có một thanh `repair_progress` trừu tượng. Cần biến nó thành chuỗi stage có ý nghĩa.

Mỗi stage sửa tàu cần có:
- tên stage
- mục tiêu
- vật phẩm cần có
- có yêu cầu puzzle hay không
- mở khóa nội dung gì tiếp theo
- câu text mô tả ngắn khi hoàn thành

### 4.5. Thiết kế nội dung text ingame

Cần chuẩn bị text cho:
- mô tả vật phẩm
- mô tả recipe
- text nhiệm vụ
- text mục tiêu stage
- câu gợi ý ngắn cho puzzle
- câu phản hồi khi hoàn thành một mốc sửa tàu

Yêu cầu:
- ngắn
- rõ
- đúng giọng điệu sci-fi sinh tồn
- không quá văn vẻ
- không mâu thuẫn với gameplay

## 5. Deliverables bắt buộc

Người phụ trách `Content design` phải nộp 4 đầu ra chính.

### Deliverable A - Danh sách vật phẩm

Tên gợi ý:
- `docs/design/CONTENT_ITEMS.md`

Nội dung cần có:
- toàn bộ item trong game
- phân nhóm item
- công dụng
- liên hệ với repair stage hoặc recipe

### Deliverable B - Danh sách recipe

Tên gợi ý:
- `docs/design/CONTENT_RECIPES.md`

Nội dung cần có:
- toàn bộ công thức chế tạo
- điều kiện mở
- hiệu ứng
- đánh đổi

### Deliverable C - Danh sách puzzle

Tên gợi ý:
- `docs/design/CONTENT_PUZZLES.md`

Nội dung cần có:
- danh sách câu đố
- câu trả lời đúng
- gợi ý
- phần thưởng
- mức độ khó

### Deliverable D - Chuỗi nhiệm vụ sửa tàu

Tên gợi ý:
- `docs/design/CONTENT_REPAIR_FLOW.md`

Nội dung cần có:
- stage đầu đến cuối
- mục tiêu từng stage
- item và puzzle liên quan
- text hoàn thành từng stage

## 6. Template bắt buộc cho vật phẩm

```text
Tên vật phẩm:
ID:
Nhóm:
Xuất hiện ở đâu:
Cách nhận:
Mô tả ngắn:
Công dụng chính:
Ảnh hưởng gameplay:
Liên quan đến recipe nào:
Liên quan đến nhiệm vụ nào:
Yêu cầu sprite:
Ghi chú thêm:
```

Ví dụ:

```text
Tên vật phẩm: Bộ lọc nước
ID: water_filter
Nhóm: vật phẩm sửa tàu bắt buộc
Xuất hiện ở đâu: Khoang thủy canh
Cách nhận: nhặt trực tiếp sau khi mở được khu dưới
Mô tả ngắn: Bộ lọc khẩn cấp dùng để ổn định nguồn nước sinh tồn.
Công dụng chính: dùng để hoàn thành một stage sửa tàu
Ảnh hưởng gameplay: mở tiến trình sửa tàu, không phải vật phẩm tiêu hao thông thường
Liên quan đến recipe nào: không
Liên quan đến nhiệm vụ nào: Ổn định hệ hỗ trợ sống
Yêu cầu sprite: khối lọc màu xanh xám, dạng hộp kỹ thuật
Ghi chú thêm: nên được đặt ở vị trí buộc người chơi phải khám phá
```

## 7. Template bắt buộc cho recipe

```text
Tên recipe:
ID:
Mở khóa khi nào:
Nguyên liệu:
Chi phí pin:
Chi phí hành động:
Đầu ra:
Loại đầu ra:
Hiệu ứng:
Đánh đổi:
Vai trò trong flow game:
Ghi chú thêm:
```

Ví dụ:

```text
Tên recipe: Bộ tăng pin
ID: battery_boost
Mở khóa khi nào: từ đầu game
Nguyên liệu: Alloy Plate, Electrolyte Pack
Chi phí pin: 0
Chi phí hành động: 1
Đầu ra: Bộ tăng pin
Loại đầu ra: vật phẩm tiêu hao
Hiệu ứng: +8 pin ngay lập tức
Đánh đổi: tốn 1 hành động, không hỗ trợ O2 hay nước
Vai trò trong flow game: cứu nguy khi người chơi thiếu pin ở đầu hoặc giữa game
Ghi chú thêm: không nên cho quá nhiều nguyên liệu miễn phí để spam
```

## 8. Template bắt buộc cho puzzle

```text
Tên puzzle:
Mức độ:
Ngữ cảnh:
Câu hỏi:
4 đáp án:
Đáp án đúng:
Gợi ý:
Phần thưởng:
Lý do đặt ở đây:
Ghi chú thêm:
```

Ví dụ:

```text
Tên puzzle: Cân bằng oxy lượt đầu
Mức độ: dễ
Ngữ cảnh: người chơi vừa tiếp cận terminal lần đầu
Câu hỏi: Nếu O2 hiện tại là 30 và oxygen = 3 thì O2 lượt sau là bao nhiêu?
4 đáp án: 24, 30, 36, 42
Đáp án đúng: 30
Gợi ý: lấy O2 hiện tại cộng phần tăng rồi trừ phần hao hụt cố định
Phần thưởng: +22% repair progress
Lý do đặt ở đây: dạy người chơi hiểu công thức trước khi gặp bài khó hơn
Ghi chú thêm: wording phải đủ rõ để học sinh lớp 8 đọc được
```

## 9. Template bắt buộc cho stage sửa tàu

```text
Tên stage:
Mục tiêu:
Điều kiện mở:
Vật phẩm bắt buộc:
Có puzzle không:
Phần thưởng:
Mở khóa tiếp theo:
Text hoàn thành:
Vai trò trong tiến trình game:
Ghi chú implementation:
```

Ví dụ:

```text
Tên stage: Ổn định hệ hỗ trợ sống
Mục tiêu: khôi phục oxy và lọc nước để tàu không sụp trước khi sửa sâu hơn
Điều kiện mở: đã chạm terminal lần đầu
Vật phẩm bắt buộc: Bình oxy, Bộ lọc nước
Có puzzle không: có
Phần thưởng: +25% repair progress
Mở khóa tiếp theo: công thức sustain trung cấp
Text hoàn thành: Hệ hỗ trợ sống đã ổn định trở lại. Các khoang chính có thể duy trì thêm vài giờ.
Vai trò trong tiến trình game: mốc chuyển từ sống sót cơ bản sang sửa tàu có kế hoạch
Ghi chú implementation: cần map vào repair stage và check item trong gameplay flow
```

## 10. Checklist tự rà trước khi nộp

Người làm content phải tự kiểm tra:
- mỗi vật phẩm có mục đích riêng chưa
- có item nào chỉ đổi tên nhưng chức năng trùng không
- recipe có tạo ra quyết định thú vị không
- puzzle có phục vụ học và gameplay không
- stage sửa tàu có cảm giác tiến triển không
- text ingame có ngắn và dễ hiểu không
- phần nội dung có map được sang data hiện tại không
- art team có đủ thông tin để vẽ sprite chưa

## 11. Cách bàn giao cho người implementation

Khi bàn giao, cần tách rõ:
- phần nào là dữ liệu item
- phần nào là dữ liệu recipe
- phần nào là dữ liệu puzzle
- phần nào là stage sửa tàu
- phần nào chỉ là text mô tả

Mapping mặc định:
- item, recipe, puzzle -> `scripts/content/game_data.gd`
- objective, rules text, repair stages -> `scripts/content/story_rules.gd`

Nếu có nội dung nào yêu cầu logic mới, cần ghi chú rõ:
- logic mới là gì
- trigger xảy ra khi nào
- tác động đến resource nào
- có cần coder sửa system hay gameplay flow không

## 12. Definition of done

Vai trò `Content design` được xem là hoàn thành khi:
- đã có bộ item, recipe, puzzle, repair stage rõ ràng
- tất cả nội dung có thể bàn giao cho coder mà không phải giải thích miệng quá nhiều
- text ingame đã đủ để dùng hoặc chỉnh nhẹ là đưa vào game được
- art team biết cần vẽ gì từ danh sách content

## 13. Cách phối hợp với các vai trò khác

Phối hợp với `Game rules / systems design`:
- xác nhận vật phẩm và puzzle có đúng logic balance không
- không tự thêm content phá vỡ core rules đã chốt

Phối hợp với `Gameplay implementer`:
- bàn giao content theo template
- đánh dấu nội dung nào là bắt buộc, nội dung nào là tùy chọn

Phối hợp với `Sprite/Art`:
- ghi rõ nhóm vật phẩm
- mô tả ngoại hình ngắn gọn
- ưu tiên asset nào cần trước

## 14. Thứ tự làm việc đề xuất

1. Chốt danh sách nhóm vật phẩm.
2. Viết danh sách vật phẩm cụ thể.
3. Viết recipe và điều kiện mở khóa.
4. Viết chuỗi puzzle từ dễ đến khó.
5. Viết flow sửa tàu theo stage.
6. Viết text ingame đi kèm.
7. Bàn giao cho người làm rules hoặc implementation để rà lần cuối.

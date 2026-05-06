Game Rules / Systems Design Task Doc

Mục đích của tài liệu này là giao việc rõ ràng cho người phụ trách Game rules /
systems design trong project SpaceStemGodot.

Tài liệu này không yêu cầu người phụ trách phải code toàn bộ tính năng. Nhiệm vụ
chính là viết rules tay rõ ràng và bàn giao lại cho người implementation.

1. Vai trò này phụ trách gì

Người làm Game rules / systems design chịu trách nhiệm cho:

  - Core gameplay loop theo turn
  - Logic tài nguyên
  - Item economy
  - Crafting và module effect
  - Event ngẫu nhiên
  - Puzzle reward/risk
  - Repair mission flow
  - Balance mức độ khó cơ bản

Người này không phụ trách chính cho:

  - Vẽ sprite chính thức
  - Polish UI
  - Animation/VFX
  - Refactor code không liên quan

2. Mục tiêu của vai trò

Cần tạo ra một bộ rule đủ rõ để bất kỳ ai implementation nào cũng có thể dựa vào
và code được mà không phải đoán ý đồ game design.

Kết quả mong muốn:

  - Người implementation biết chỉnh file nào
  - Người vẽ sprite biết cần vẽ asset nào
  - Người test biết cần test flow nào
  - Rules mới vẫn hợp với kiến trúc hiện tại của project

3. Kiến trúc hiện tại cần nhớ

Project đang tách như sau:

  - scripts/content/game_data.gd: item, puzzle, recipe, terminal requirements
  - scripts/content/story_rules.gd: objective, intro, rules text, repair stages
  - scripts/systems/survival_system.gd: công thức pin, oxy, nhiệt, nước, độ nổ,
    HP
  - scripts/systems/event_system.gd: biến cố ngẫu nhiên
  - scripts/modules/gameplay_module.gd: craft, dùng item, turn progression,
    repair flow

Quy tắc quan trọng:

  - Dữ liệu tĩnh thì đặt trong content/*
  - Công thức và state transition đặt trong systems/*
  - Orchestration đặt trong modules/*

4. Scope công việc cụ thể

Người phụ trách cần thiết kế đầy đủ 6 cụm sau.

4.1. Resource rules

Cần chốt:

  - Các tài nguyên tồn tại trong game
  - Tài nguyên nào giảm theo turn
  - Tài nguyên nào mất ngay lập tức gây thua
  - Ngưỡng nguy hiểm của từng tài nguyên
  - Tradeoff giữa survival và repair

Hiện tại game đang có:

  - battery
  - temp
  - o2
  - hydration
  - satiety
  - hp
  - repair_progress
  - actions_left

Cần trả lời rõ:

  - Battery dùng để phân bổ và craft như thế nào
  - Temp quan trọng ở mức nào
  - O2/xúc nước/độ nổ gây mất HP ra sao
  - HP giảm do đâu, hồi phục bởi cái gì

4.2. Item taxonomy

Cần thiết kế các nhóm vật phẩm rõ ràng:

  - key item: mở cửa, mở khu
  - repair core item: cần để sửa tàu
  - material: dùng craft
  - consumable: dùng 1 lần
  - module: buff nhiều turn
  - optional reward item: giúp an toàn hơn, không bắt buộc để phá đảo

Mỗi item cần có:

  - Tên
  - Loại
  - Cách nhận
  - Công dụng
  - Ảnh hưởng tới resource nào
  - Có bị tiêu hao hay không
  - Liên quan đến mission nào

4.3. Crafting rules

Cần chốt:

  - Recipe nào có sẵn từ đầu
  - Recipe nào chỉ mở sau khi đạt stage
  - Mỗi recipe tốn:
      - Ingredient nào
      - Bao nhiêu battery
      - Bao nhiêu action
  - Kết quả recipe là:
      - Consumable
      - Module
      - Repair component
      - Utility item

Cần tránh:

  - Recipe quá rẻ làm game vỡ balance
  - Recipe không có tradeoff
  - Item mới trùng công dụng item cũ

4.4. Module effect design

Module là vật phẩm có hiệu ứng kéo dài nhiều turn. Cần quy định:

  - Module tồn tại bao nhiêu turn
  - Stack được hay không
  - Ưu tiên resolve effect trước hay sau random event
  - Có module nào xung đột nhau không

Cần có bảng effect rõ:

  - Module ID
  - Tên hiển thị
  - Duration
  - Effect mỗi turn
  - Note balance

4.5. Repair mission design

Cần thiết kế một chuỗi nhiệm vụ sửa tàu thay vì chỉ có thanh repair_progress.

Mỗi stage sửa tàu cần có:

  - Tên stage
  - Mục tiêu
  - Điều kiện mở
  - Item bắt buộc
  - Có cần puzzle không
  - Reward khi xong
  - Tác động lên map/gameplay

Mục tiêu là để gameplay có nhịp:

  - Khám phá
  - Nhặt đồ
  - Craft
  - Vượt puzzle
  - Mở khóa khu
  - Sửa tàu từng phần

4.6. Balance assumptions

Cần viết rõ:

  - Đầu game người chơi dễ chết vì cái gì nhiều nhất
  - Mid game người chơi cần ưu tiên gì
  - Late game áp lực chính là gì
  - 1-2 chiến thuật hợp lệ
  - 1-2 chiến thuật sai sẽ dẫn tới thua

Không cần cân bằng tuyệt đối ngay, nhưng phải có giả thuyết balance rõ ràng.

5. Deliverables bắt buộc

Người phụ trách vai trò này phải nộp 5 output.

Deliverable A - Rules overview

1 file markdown tóm tắt:

  - Game loop
  - Các resource
  - Win/lose conditions
  - Progression tổng quát

Tên đề xuất:

  - docs/design/GAME_RULES_OVERVIEW.md

Deliverable B - Item and crafting sheet

1 file markdown hoặc bảng:

  - Danh sách item
  - Danh sách recipe
  - Effect và cost của từng cái

Tên đề xuất:

  - docs/design/ITEMS_AND_CRAFTING.md

Deliverable C - Repair mission sheet

1 file markdown:

  - Toàn bộ stage sửa tàu
  - Điều kiện mở
  - Item cần có
  - Reward

Tên đề xuất:

  - docs/design/REPAIR_MISSIONS.md

Deliverable D - Balance sheet

1 file markdown ngắn:

  - Giả thuyết balance
  - Case fail phổ biến
  - Mục tiêu tuning

Tên đề xuất:

  - docs/design/BALANCE_NOTES.md

Deliverable E - Implementation mapping

1 file markdown để bàn giao cho coder:

  - Rule nào vào game_data.gd
  - Rule nào vào story_rules.gd
  - Rule nào vào survival_system.gd
  - Rule nào vào event_system.gd
  - Rule nào vào gameplay_module.gd

Tên đề xuất:

  - docs/design/IMPLEMENTATION_MAPPING.md

6. Format phải dùng khi thiết kế item

Dùng template này cho từng item mới:

Tên:
ID:
Loại:
Nguồn:
Mô tả ngắn:
Dùng để:
Effect ngay:
Effect theo turn:
Chi phí sử dụng:
Bị tiêu hao không:
Liên quan đến stage nào:
Sprite cần có:
Ghi chú balance:

7. Format phải dùng khi thiết kế recipe

Tên recipe:
ID:
Ingredients:
Battery cost:
Action cost:
Output:
Loại output:
Effect:
Tradeoff:
Mở khóa khi nào:

8. Format phải dùng khi thiết kế repair mission

Tên stage:
Mục tiêu:
Điều kiện mở:
Vật phẩm bắt buộc:
Cần puzzle:
Kết quả khi thành công:
Tác động lên game:
Failure risk:
Ghi chú implementation:

9. Checklist quyết định trước khi nộp

Người làm rules phải tự kiểm tra:

  - Mỗi item có vai trò riêng chưa
  - Có item nào bị thừa không
  - Mỗi recipe có tradeoff chưa
  - Có chiến lược nào vỡ game quá dễ không
  - Game có ép người chơi đi khám phá map không
  - Sửa tàu có cảm giác tiến triển từng mốc không
  - Random event có làm khó chịu oan ức không
  - Puzzle reward có đáng để đánh đổi action không
  - Phần rules có map được vào code hiện tại không

10. Cách bàn giao cho người implementation

Khi nộp tài liệu, người phụ trách rules phải bàn giao đủ theo logic sau:

  - Cái gì là dữ liệu tĩnh
  - Cái gì là công thức
  - Cái gì là flow gameplay
  - Cái gì chỉ là text mô tả

Mặc định mapping:

  - Item, recipe, puzzle data -> scripts/content/game_data.gd
  - Objective, stage, rules text -> scripts/content/story_rules.gd
  - Công thức giảm/tăng resource -> scripts/systems/survival_system.gd
  - Event ngẫu nhiên -> scripts/systems/event_system.gd
  - Craft/use item/repair progression -> scripts/modules/gameplay_module.gd

Nếu có quy tắc nào đặc biệt, cần viết thêm:

  - Expected behavior
  - Trigger condition
  - Fail case
  - Ví dụ 1 turn mẫu nếu cần

11. Mẫu gói tài liệu cần nộp

Người phụ trách rules nên nộp theo bộ này:

01_GAME_RULES_OVERVIEW.md
02_ITEMS_AND_CRAFTING.md
03_REPAIR_MISSIONS.md
04_BALANCE_NOTES.md
05_IMPLEMENTATION_MAPPING.md

Nếu chưa kịp viết đầy đủ, ưu tiên nộp theo thứ tự:

1.  GAME_RULES_OVERVIEW
2.  ITEMS_AND_CRAFTING
3.  REPAIR_MISSIONS
4.  IMPLEMENTATION_MAPPING
5.  BALANCE_NOTES

12. Definition of done

Vai trò Game rules / systems design được xem là xong khi:

  - Đã có bộ rules đọc được bởi người khác
  - Item/recipe/mission được mô tả đầy đủ
  - Mỗi quy tắc chính đều có tradeoff và lý do tồn tại
  - Implementation mapping rõ ràng
  - Người tiếp theo có thể implement mà không phải hỏi lại ý đồ cơ bản

13. Đề xuất cách phối hợp với các vai trò khác

Làm việc với Sprite/Art:

  - Bàn giao danh sách item/door/module cần hình
  - Mỗi item cần mô tả visual ngắn

Làm việc với Gameplay implementer:

  - Bàn giao implementation mapping
  - Nếu có rule đặc biệt, viết ví dụ expected behavior

Làm việc với Balance tester:

  - Đưa 2-3 kịch bản chơi mẫu:
      - Chơi an toàn
      - Chơi tham repair sớm
      - Chơi craft nhiều module

14. Hướng đi đề xuất cho project này

Nếu chưa biết bắt đầu từ đâu, làm theo thứ tự sau:

1.  Chốt taxonomy item.
2.  Chốt 8-12 recipe cốt lõi.
3.  Chốt 4-5 stage sửa tàu.
4.  Chốt random event bucket.
5.  Viết implementation mapping.
6.  Mới chuyển sang AI coding hoặc implementation.

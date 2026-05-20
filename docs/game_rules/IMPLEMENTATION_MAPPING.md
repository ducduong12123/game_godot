1. game_data.gd

1.1. Item

1.1.1. Key Item (Vật phẩm khóa)

Tên: Thẻ truy cập kỹ thuật
ID: key_engineering_access_card
Loại: Key Item
Nguồn: Khu kỹ thuật bị khóa / phòng điều khiển phụ / loot early game
Mô tả ngắn: Thẻ dùng để mở các khu vực kỹ thuật cơ bản trong tàu
Dùng để: Mở cửa khu kỹ thuật và hệ thống phụ trợ
Effect ngay: Mở khóa khu vực mới trên map
Effect theo turn: Không có
Chi phí sử dụng: 0
Bị tiêu hao không: Không
Liên quan đến stage nào: Early game – Exploration & Basic Repair
Sprite cần có: Thẻ ID màu xanh / chip truy cập kỹ thuật
Ghi chú balance: Gate mở đầu game, kiểm soát nhịp khám phá map

Tên: Chìa khóa ghi đè lò phản ứng
ID: key_reactor_override_key
Loại: Key Item
Nguồn: Mid game mission / sau khi sửa hệ thống điện trung tâm
Mô tả ngắn: Thiết bị cho phép can thiệp và mở khóa lò phản ứng
Dùng để: Mở chuỗi nhiệm vụ lò phản ứng
Effect ngay: Kích hoạt hệ thống mission lò phản ứng
Effect theo turn: Tăng áp lực hệ thống (gián tiếp do mở crisis mode)
Chi phí sử dụng: 0
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid game – Reactor System Crisis
Sprite cần có: Chìa khóa công nghiệp phát sáng đỏ / thiết bị override
Ghi chú balance: Gate mid game quan trọng, mở escalation phase

Tên: Chip điều hướng
ID: key_navigation_chip
Loại: Key Item
Nguồn: Phòng điều khiển navigation / reward từ puzzle mid game
Mô tả ngắn: Chip dữ liệu giúp mở hệ thống điều hướng của tàu
Dùng để: Mở bản đồ điều hướng và đường thoát
Effect ngay: Unlock navigation system / mở map nâng cao
Effect theo turn: Giảm thời gian di chuyển gián tiếp (ít backtracking)
Chi phí sử dụng: 0
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid–Late game – Exploration expansion
Sprite cần có: Chip dữ liệu xanh dương / module điều hướng
Ghi chú balance: Giảm độ khó exploration, tăng hiệu quả di chuyển

Tên: Thiết bị cấp quyền an ninh
ID: key_security_clearance_device
Loại: Key Item
Nguồn: Khu an ninh / kho vũ khí / phòng restricted loot
Mô tả ngắn: Thiết bị cho phép truy cập khu vực an ninh cao
Dùng để: Mở khu vực restricted loot / tài nguyên hiếm
Effect ngay: Unlock khu an ninh
Effect theo turn: Tăng chất lượng loot (gián tiếp)
Chi phí sử dụng: 0
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid game – Exploration high risk zones
Sprite cần có: thẻ an ninh / badge quân sự / thiết bị xác thực
Ghi chú balance: Tạo risk–reward loop trong exploration

Tên: Mã kích hoạt thoát hiểm
ID: key_escape_activation_code
Loại: Key Item (Endgame / Consumable progression trigger)
Nguồn: Chuỗi nhiệm vụ cuối game / hệ thống trung tâm tàu
Mô tả ngắn: Mã khởi động hệ thống thoát tàu và ending sequence
Dùng để: Kích hoạt chế độ thoát hiểm
Effect ngay: Trigger endgame sequence
Effect theo turn: Kích hoạt trạng thái khủng hoảng (tăng áp lực toàn hệ thống)
Chi phí sử dụng: 0
Bị tiêu hao không: Có (sử dụng một lần)
Liên quan đến stage nào: Late game – Final Escape Stage
Sprite cần có: mã điện tử / giao diện terminal phát sáng
Ghi chú balance: Khóa ending, không thể rollback sau khi kích hoạt

1.1.2. Material (Nguyên liệu)

Tên: Phế liệu kim loại
ID: mat_metal_scrap
Loại: Material
Nguồn: Khu vực tàu hỏng / phòng kỹ thuật / loot exploration
Mô tả ngắn: Kim loại thô dùng để chế tạo và sửa chữa
Dùng để: Chế tạo vật phẩm sửa chữa và module cơ bản
Effect ngay: Không có
Effect theo turn: Không có
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Early game – Exploration & Basic Crafting
Sprite cần có: Mảnh kim loại rỉ sét, vụn cơ khí
Ghi chú balance: Nguyên liệu nền, xuất hiện nhiều để dạy hệ thống craft

Tên: Linh kiện mạch điện
ID: mat_circuit_parts
Loại: Material
Nguồn: Phòng kỹ thuật / puzzle điện / loot khu restricted
Mô tả ngắn: Linh kiện điện tử dùng cho hệ thống công nghệ
Dùng để: Chế tạo module và sửa hệ thống quan trọng
Effect ngay: Không có
Effect theo turn: Ổn định gián tiếp hệ thống điện khi sử dụng trong craft module
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Early–Mid game
Sprite cần có: chip điện tử, bảng mạch xanh
Ghi chú balance: Nguyên liệu trung tâm của hệ thống module

Tên: Lưới sợi tổng hợp
ID: mat_fiber_mesh
Loại: Material
Nguồn: Kho vật liệu / khu công nghiệp / loot môi trường
Mô tả ngắn: Vật liệu nhẹ dùng để gia cố và chế tạo linh hoạt
Dùng để: Craft consumable và repair item
Effect ngay: Không có
Effect theo turn: Không có
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Early game
Sprite cần có: lưới sợi, vật liệu tổng hợp dạng cuộn
Ghi chú balance: Nguyên liệu hỗ trợ survival và repair cơ bản

Tên: Gel nhiệt
ID: mat_thermal_gel
Loại: Material
Nguồn: Khu vực nhiệt độ cao / kho lạnh kỹ thuật / loot hazard zone
Mô tả ngắn: Chất ổn định nhiệt độ dùng trong môi trường khắc nghiệt
Dùng để: Chế tạo túi giữ nhiệt và module ổn định môi trường
Effect ngay: Không có
Effect theo turn: Giảm ảnh hưởng môi trường nhiệt (khi dùng trong item)
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid game – Hazard zones
Sprite cần có: gel phát sáng, chất lỏng năng lượng
Ghi chú balance: Gating vật phẩm chống môi trường

Tên: Pin năng lượng
ID: mat_energy_cell
Loại: Material
Nguồn: Phòng năng lượng / reactor / loot high-risk zone
Mô tả ngắn: Nguồn năng lượng dùng cho module và hệ thống quan trọng
Dùng để: Chế tạo module và repair item nâng cao
Effect ngay: Không có
Effect theo turn: Tăng khả năng vận hành module (gián tiếp)
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid–Late game
Sprite cần có: pin phát sáng xanh / lõi năng lượng
Ghi chú balance: Tài nguyên hiếm, kiểm soát power system

Tên: Tấm gia cố chịu lực
ID: mat_reinforced_plate
Loại: Material
Nguồn: Kho công nghiệp / khu vỡ tàu / loot cơ khí nặng
Mô tả ngắn: Vật liệu siêu bền dùng để gia cố cấu trúc tàu
Dùng để: Chế tạo module phòng thủ và repair hệ thống lớn
Effect ngay: Không có
Effect theo turn: Giảm rủi ro hỏng hệ thống (khi dùng trong module)
Chi phí sử dụng: 1 nguyên liệu khi craft
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid–Late game
Sprite cần có: tấm kim loại dày, khung thép công nghiệp
Ghi chú balance: Nguyên liệu cho endgame module và repair hệ thống lớn

1.1.3. Consumable (Vật phẩm tiêu hao)

Tên: Bộ cứu thương
ID: con_medkit
Loại: Consumable
Nguồn: Kho y tế / loot exploration / craft từ vật liệu cơ bản
Mô tả ngắn: Hồi phục sức khỏe cho người chơi
Dùng để: Hồi HP khi bị thương
Effect ngay: +HP ngay lập tức
Effect theo turn: Không
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: All stages
Sprite cần có: hộp y tế đỏ / túi sơ cứu
Ghi chú balance: Item hồi máu cơ bản, chống chết sớm

Tên: Túi nước
ID: con_water_pack
Loại: Consumable
Nguồn: Kho sinh tồn / khu lưu trữ / loot môi trường
Mô tả ngắn: Cung cấp nước để duy trì sinh tồn
Dùng để: Giảm mất hydration
Effect ngay: +hydration
Effect theo turn: Không
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: Early–Mid game
Sprite cần có: túi nước, bình nước sinh tồn
Ghi chú balance: Ngăn chết do thiếu nước trong survival loop

Tên: Khẩu phần lương thực
ID: con_food_ration
Loại: Consumable
Nguồn: Kho thực phẩm / loot sinh tồn / craft
Mô tả ngắn: Thực phẩm khẩn cấp duy trì năng lượng
Dùng để: Giảm đói và duy trì sinh tồn
Effect ngay: +satiety
Effect theo turn: Không
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: All stages
Sprite cần có: hộp thực phẩm quân dụng
Ghi chú balance: Resource giữ nhịp survival dài hạn

Tên: Bình oxy
ID: con_oxygen_canister
Loại: Consumable
Nguồn: Hệ thống oxy / loot khu kỹ thuật / craft
Mô tả ngắn: Cung cấp oxy khẩn cấp
Dùng để: Chống chết do thiếu oxy
Effect ngay: +O2 ngay lập tức
Effect theo turn: Không
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: Survival system toàn game
Sprite cần có: bình khí xanh / tank oxy mini
Ghi chú balance: Item cứu nguy chính trong môi trường độc hại

Tên: Túi giữ nhiệt
ID: con_thermal_pack
Loại: Consumable
Nguồn: Khu nhiệt độ thấp / craft từ gel nhiệt
Mô tả ngắn: Ổn định nhiệt độ cơ thể
Dùng để: Giảm ảnh hưởng môi trường lạnh/nóng
Effect ngay: ổn định temp
Effect theo turn: giảm damage từ môi trường (gián tiếp)
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid game – hazard zones
Sprite cần có: túi cách nhiệt / gói phát nhiệt
Ghi chú balance: chống môi trường, không phải item combat

Tên: Thuốc kích thích khẩn cấp
ID: con_emergency_stim
Loại: Consumable
Nguồn: Kho y tế đặc biệt / loot high-risk zone
Mô tả ngắn: Tăng khả năng sinh tồn tạm thời
Dùng để: cứu tình huống nguy hiểm
Effect ngay: +HP hoặc tăng hiệu suất sinh tồn tạm thời
Effect theo turn: giảm HP nhẹ sau hiệu ứng (side effect)
Chi phí sử dụng: 1 vật phẩm
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid–Late game
Sprite cần có: ống tiêm / thuốc năng lượng đỏ
Ghi chú balance: item “clutch save” nhưng có rủi ro

1.1.4. Module System (Hệ thống mô-đun hỗ trợ)

Tên: Bộ tái tạo oxy
ID: mod_oxygen_recycler
Loại: Module
Nguồn: Mid game craft / oxygen system repair reward
Mô tả ngắn: Tự động tạo oxy mỗi lượt
Dùng để: Duy trì O2 trong môi trường nguy hiểm
Effect ngay: Kích hoạt module
Effect theo turn: +O2 mỗi turn, -battery mỗi turn
Chi phí sử dụng: Tiêu hao pin liên tục
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid game – Survival system unlock
Sprite cần có: máy lọc khí / thiết bị tái tạo oxy
Ghi chú balance: Core sustain module, nhưng tạo áp lực battery dài hạn

Tên: Ổn định năng lượng
ID: mod_energy_stabilizer
Loại: Module
Nguồn: Mid game craft / reactor system
Mô tả ngắn: Giảm tiêu hao pin toàn hệ thống
Dùng để: tối ưu hóa battery economy
Effect ngay: Giảm battery drain
Effect theo turn: -10% đến -30% battery consumption
Chi phí sử dụng: Pin duy trì thấp
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid–Late game
Sprite cần có: lõi năng lượng xanh / ổn áp công nghiệp
Ghi chú balance: Module chống “soft-lock do thiếu pin”

Tên: Khiên chống bức xạ
ID: mod_radiation_shield
Loại: Module
Nguồn: Late game craft / hazard zone reward
Mô tả ngắn: Giảm sát thương môi trường bức xạ
Dùng để: survival trong khu vực độc hại
Effect ngay: Kích hoạt giảm damage
Effect theo turn: Giảm HP loss từ radiation event
Chi phí sử dụng: Battery trung bình
Bị tiêu hao không: Không
Liên quan đến stage nào: Late game – Radiation zones
Sprite cần có: lá chắn năng lượng / giáp điện từ
Ghi chú balance: Gate survival cho late game area

Tên: Hệ thống tự sửa chữa
ID: mod_auto_repair_assistant
Loại: Module
Nguồn: Mid–late game craft / engineering lab
Mô tả ngắn: Tự động tăng repair progress
Dùng để: hỗ trợ repair mission
Effect ngay: tăng repair efficiency
Effect theo turn: +repair_progress mỗi turn
Chi phí sử dụng: Battery cao
Bị tiêu hao không: Không
Liên quan đến stage nào: Repair-heavy missions
Sprite cần có: robot sửa chữa mini / drone kỹ thuật
Ghi chú balance: giảm độ khó repair nhưng tăng drain tài nguyên

Tên: Tái tạo nước
ID: mod_water_recovery
Loại: Module
Nguồn: Mid game craft / hydro system
Mô tả ngắn: Tự phục hồi nước theo thời gian
Dùng để: duy trì hydration
Effect ngay: kích hoạt hệ thống
Effect theo turn: +hydration mỗi turn
Chi phí sử dụng: Battery thấp–trung bình
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid game survival
Sprite cần có: máy lọc nước / bình tái chế
Ghi chú balance: giảm phụ thuộc consumable nước

Tên: Bộ ổn định nhiệt
ID: mod_thermal_regulator
Loại: Module
Nguồn: Hazard zone / thermal system craft
Mô tả ngắn: Ổn định nhiệt độ môi trường
Dùng để: chống extreme temperature
Effect ngay: giảm ảnh hưởng nhiệt độ
Effect theo turn: giảm temp damage / stabilize environment
Chi phí sử dụng: Battery trung bình
Bị tiêu hao không: Không
Liên quan đến stage nào: Mid–Late game
Sprite cần có: bộ điều hòa công nghiệp
Ghi chú balance: bắt buộc để sống trong biome nguy hiểm

1.1.5. Repair Item System (Hệ thống vật phẩm sửa chữa)

Tên: Miếng vá sửa chữa
ID: rep_repair_patch
Loại: Repair Item
Nguồn: Craft từ phế liệu kim loại + lưới sợi tổng hợp / loot early game
Mô tả ngắn: Vật liệu sửa chữa cơ bản dùng cho hư hỏng nhỏ
Dùng để: Sửa cửa, hệ thống phụ, lỗi nhẹ của tàu
Effect ngay: +repair_progress nhỏ
Effect theo turn: Không
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có
Liên quan đến stage nào: Early game – Basic repair missions
Sprite cần có: miếng vá cơ khí / patch kim loại
Ghi chú balance: Item tutorial cho hệ thống repair, xuất hiện nhiều

Tên: Lõi lò phản ứng
ID: rep_reactor_coil
Loại: Repair Item
Nguồn: Mid game craft / reactor system exploration reward
Mô tả ngắn: Thành phần sửa chữa lõi năng lượng chính của tàu
Dùng để: Sửa hệ thống lò phản ứng
Effect ngay: kích hoạt tiến trình repair reactor
Effect theo turn: tăng stability hệ thống năng lượng (gián tiếp)
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid game – Reactor crisis missions
Sprite cần có: lõi năng lượng phát sáng / coil công nghiệp
Ghi chú balance: Gate quan trọng mở mid-game crisis phase

Tên: Van làm mát
ID: rep_cooling_valve
Loại: Repair Item
Nguồn: Khu kỹ thuật nhiệt / hazard zone / craft mid game
Mô tả ngắn: Thiết bị điều chỉnh nhiệt độ hệ thống tàu
Dùng để: Sửa hệ thống nhiệt và giảm quá tải
Effect ngay: giảm nhiệt độ nguy hiểm
Effect theo turn: ổn định temp system
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid game – thermal system repair
Sprite cần có: van công nghiệp / bộ điều áp nhiệt
Ghi chú balance: chống chết do môi trường, tạo pressure survival

Tên: Lõi điều hướng
ID: rep_navigation_core
Loại: Repair Item
Nguồn: Puzzle navigation / loot khu điều khiển / mid–late game craft
Mô tả ngắn: Hệ thống điều hướng trung tâm của tàu
Dùng để: Sửa hệ thống bản đồ và đường thoát
Effect ngay: mở navigation system
Effect theo turn: giảm thời gian di chuyển gián tiếp (tối ưu exploration)
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có
Liên quan đến stage nào: Mid–Late game – exploration expansion
Sprite cần có: lõi dữ liệu / chip điều hướng lớn
Ghi chú balance: giảm độ khó khám phá cuối game

Tên: Ổn định động cơ
ID: rep_engine_stabilizer
Loại: Repair Item
Nguồn: Mid–late game craft / engine system mission reward
Mô tả ngắn: Thiết bị sửa hệ thống động cơ chính của tàu
Dùng để: Khôi phục khả năng vận hành tàu
Effect ngay: mở engine recovery phase
Effect theo turn: giảm nguy cơ system failure
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có
Liên quan đến stage nào: Late game – escape preparation
Sprite cần có: bộ ổn định cơ khí / module động cơ
Ghi chú balance: điều kiện bắt buộc trước khi thoát hiểm

Tên: Bộ điều khiển thoát hiểm
ID: rep_escape_controller
Loại: Repair Item
Nguồn: Final mission craft / endgame puzzle reward
Mô tả ngắn: Hệ thống kích hoạt thoát tàu
Dùng để: Kích hoạt escape sequence
Effect ngay: trigger ending cutscene / final mission
Effect theo turn: chuyển game sang trạng thái đếm ngược thoát hiểm
Chi phí sử dụng: 1 item
Bị tiêu hao không: Có (one-time use)
Liên quan đến stage nào: Final stage – escape system
Sprite cần có: bảng điều khiển trung tâm / interface phát sáng
Ghi chú balance: hard lock cho ending, không thể rollback

1.2. Recipe

Tên recipe: Miếng vá sửa chữa
ID: rec_repair_patch
Ingredients: Phế liệu kim loại + Lưới sợi tổng hợp
Battery cost: 5
Action cost: 1
Output: Miếng vá sửa chữa
Loại output: Repair Item
Effect: Tạo vật phẩm sửa chữa cơ bản dùng cho hệ thống hư hỏng nhẹ
Tradeoff: Tiêu hao nguyên liệu sinh tồn (material dễ kiếm nhưng cần farming liên tục)
Mở khóa khi nào: Early game – sau tutorial repair system

Tên recipe: Bình oxy dự phòng
ID: rec_oxygen_canister
Ingredients: Linh kiện mạch điện + Phế liệu kim loại
Battery cost: 8
Action cost: 1
Output: Bình oxy
Loại output: Consumable
Effect: Tạo vật phẩm hồi O2 khẩn cấp
Tradeoff: Dùng linh kiện điện → giảm khả năng craft module sớm
Mở khóa khi nào: Early game – sau khi mở khu kỹ thuật

Tên recipe: Túi giữ nhiệt
ID: rec_thermal_pack
Ingredients: Gel nhiệt + Lưới sợi tổng hợp
Battery cost: 6
Action cost: 1
Output: Túi giữ nhiệt
Loại output: Consumable
Effect: Giảm ảnh hưởng môi trường nhiệt độ (nóng/lạnh)
Tradeoff: Tốn material chuyên dụng → hạn chế craft spam
Mở khóa khi nào: Mid game – hazard zone unlock

Tên recipe: Bộ tái tạo oxy
ID: rec_oxygen_recycler
Ingredients: Linh kiện mạch điện + Pin năng lượng
Battery cost: 15
Action cost: 2
Output: Bộ tái tạo oxy
Loại output: Module
Effect: Tự động tăng O2 mỗi turn
Tradeoff: Tiêu hao pin liên tục → tăng áp lực battery system
Mở khóa khi nào: Mid game – Oxygen system repair

Tên recipe: Ổn định năng lượng
ID: rec_energy_stabilizer
Ingredients: Linh kiện mạch điện + Pin năng lượng
Battery cost: 12
Action cost: 2
Output: Ổn định năng lượng
Loại output: Module
Effect: Giảm tiêu hao battery toàn hệ thống
Tradeoff: Không tạo tài nguyên mới → chỉ tối ưu hóa
Mở khóa khi nào: Mid game – reactor system unlock

Tên recipe: Khiên chống bức xạ
ID: rec_radiation_shield
Ingredients: Tấm gia cố chịu lực + Linh kiện mạch điện
Battery cost: 18
Action cost: 2
Output: Khiên chống bức xạ
Loại output: Module
Effect: Giảm damage từ môi trường bức xạ
Tradeoff: Tốn vật liệu nặng → giảm khả năng craft động cơ sớm
Mở khóa khi nào: Mid–late game – hazard zone

Tên recipe: Lõi lò phản ứng
ID: rec_reactor_coil
Ingredients: Linh kiện mạch điện + Tấm gia cố chịu lực + Pin năng lượng
Battery cost: 25
Action cost: 3
Output: Lõi lò phản ứng
Loại output: Repair Item
Effect: Khôi phục hệ thống reactor / mở crisis mission
Tradeoff: Tốn tài nguyên cao → khóa progression nếu thiếu pin
Mở khóa khi nào: Mid game – reactor failure event

Tên recipe: Lõi điều hướng
ID: rec_navigation_core
Ingredients: Linh kiện mạch điện + Phế liệu kim loại
Battery cost: 10
Action cost: 2
Output: Lõi điều hướng
Loại output: Repair Item
Effect: Mở navigation system / bản đồ mở rộng
Tradeoff: Không ảnh hưởng survival trực tiếp → dễ bị bỏ qua nếu người chơi greedy
Mở khóa khi nào: Mid game – exploration unlock

Tên recipe: Ổn định động cơ
ID: rec_engine_stabilizer
Ingredients: Tấm gia cố chịu lực + Pin năng lượng
Battery cost: 20
Action cost: 3
Output: Ổn định động cơ
Loại output: Repair Item
Effect: Khôi phục engine system / mở escape preparation
Tradeoff: Đốt tài nguyên late game → tạo áp lực survival cực cao
Mở khóa khi nào: Late game – engine failure stage

Tên recipe: Bộ tăng cường tín hiệu
ID: rec_signal_booster
Ingredients: Linh kiện mạch điện + Phế liệu kim loại
Battery cost: 9
Action cost: 1
Output: Bộ tăng cường tín hiệu
Loại output: Utility Item / Module phụ trợ
Effect: Tăng khả năng tìm loot / giảm thời gian khám phá
Tradeoff: Không trực tiếp giúp survival → dễ bị bỏ qua
Mở khóa khi nào: Early–mid game exploration upgrade

1.3. Puzzle

Câu đố cửa an ninh
- Yêu cầu vật phẩm: Thẻ truy cập kỹ thuật
- Mục đích:
  + Mở khóa khu kỹ thuật
  + Cho phép người chơi tiếp cận tài nguyên và hệ thống cơ bản
- Vai trò gameplay:
  + Gate đầu game
  + Kiểm soát hướng khám phá ban đầu
- Tác động:
  + Mở thêm map mới
  + Cho phép bắt đầu chuỗi craft và repair
- Ghi chú balance:
  + Bắt buộc phải có, không thể bypass
  + Dễ đạt được để tránh soft-lock đầu game

Câu đố hệ thống điện 
- Yêu cầu vật phẩm: Linh kiện mạch điện, Pin năng lượng
- Mục đích: Khôi phục hệ thống điện trung tâm của tàu
- Vai trò gameplay:
  + Mid game progression gate
  + Mở module system và khu vực nâng cao
- Tác động:
  + Tăng khả năng sử dụng module
  + Mở hệ thống crafting nâng cao
- Ghi chú balance:
  + Ép người chơi phải farm material
  + Tạo áp lực battery economy

Câu đố hệ thống oxy 
- Yêu cầu vật phẩm: Module oxy hoặc vật phẩm sửa chữa oxy
- Mục đích: Khôi phục hệ thống sinh tồn (oxy toàn tàu)
- Vai trò gameplay:
  + Survival core system unlock
  + Giảm nguy cơ chết do thiếu O2
- Tác động:
  + Ổn định hệ sinh tồn theo turn
  + Giảm độ khó môi trường
- Ghi chú balance:
  + Không có oxy system → game cực khó
  + Đây là “soft survival relief gate”

Câu đố lò phản ứng 
- Yêu cầu vật phẩm: Chìa khóa ghi đè lò phản ứng, Lõi lò phản ứng
- Mục đích:
  + Mở hệ thống lò phản ứng trung tâm
  + Kích hoạt crisis / mid-late game escalation
- Vai trò gameplay:
  + Mid–late game critical gate
  + Bắt đầu chuỗi nhiệm vụ sửa reactor
- Tác động:
  + Tăng áp lực tài nguyên (battery drain)
  + Mở hệ thống repair nâng cao
- Ghi chú balance: Đây là bước chuyển từ “survival” → “crisis survival”

Câu đố điều hướng 
- Yêu cầu vật phẩm: Chip điều hướng hoặc Lõi điều hướng
- Mục đích: Khôi phục hệ thống điều hướng tàu
- Vai trò gameplay:
  + Mở exploration mở rộng
  + Cho phép xác định đường thoát
- Tác động:
  + Mở map lớn hơn
  + Giảm phụ thuộc vào khám phá ngẫu nhiên
- Ghi chú balance:
  + Giảm khó khăn exploration
  + Tạo cảm giác tiến trình rõ ràng

Câu đố thoát hiểm 
- Yêu cầu vật phẩm: Mã kích hoạt thoát hiểm, Ổn định động cơ
- Mục đích: Kích hoạt hệ thống thoát tàu, Trigger ending game
- Vai trò gameplay:
  + Final stage mission
  + Kết thúc toàn bộ progression loop
- Tác động:
  + Chuyển sang trạng thái endgame countdown
  + Không thể quay lại hệ thống cũ
- Ghi chú balance:
  + Hard lock ending
  + Nếu thiếu 1 item → không thể hoàn thành game
 
2. story_rules.gd

2.1. Objective

- Sửa chữa lò phản ứng
- Phân tích:
  + Mục tiêu mid–late game quan trọng nhất
  + Khôi phục nguồn năng lượng chính của tàu
  + Mở ra chuỗi “crisis system” (áp lực tài nguyên tăng mạnh)
- Vai trò gameplay:
  + Gate chuyển từ sinh tồn → khủng hoảng
  + Tăng mức độ tiêu hao battery và event nguy hiểm
- Ý nghĩa balance: Là mốc bắt buộc để game không bị “kẹt sinh tồn mãi”

- Khôi phục hệ thống oxy
- Phân tích:
  + Hệ thống sinh tồn cốt lõi của game
  + Giảm áp lực chết sớm do thiếu O2
  + Cho phép người chơi tập trung vào exploration và craft
- Vai trò gameplay: Soft survival gate (giảm độ khó sinh tồn)
- Ý nghĩa balance: Nếu không có → game quá khó và dễ chết liên tục

- Sửa hệ thống điện trung tâm
- Phân tích:
  + Mở lại toàn bộ hệ thống năng lượng tàu
  + Cho phép module hoạt động ổn định
  + Unlock crafting và hệ thống nâng cao
- Vai trò gameplay: Mid game progression gate
- Ý nghĩa balance: Tạo áp lực quản lý battery và tài nguyên

- Ổn định toàn bộ hệ thống tàu
- Phân tích:
  + Tổng hợp nhiều hệ thống: oxy + điện + nhiệt
  + Giảm tỷ lệ sự cố random event
  + Tạo trạng thái “ổn định tạm thời” trước late game
- Vai trò gameplay: Transition stage giữa mid và late game
- Ý nghĩa balance: Chuẩn bị cho khủng hoảng lớn (reactor / engine)

- Mở hệ thống điều hướng
- Phân tích:
  + Cho phép xác định đường đi và khu vực mới
  + Mở rộng exploration map
  + Giảm yếu tố RNG trong khám phá
- Vai trò gameplay: Exploration expansion gate
- Ý nghĩa balance: Giúp người chơi chủ động hơn thay vì mò mẫm

- Chuẩn bị chuỗi thoát hiểm
- Phân tích:
  + Chuẩn bị các hệ thống cuối: động cơ + điều hướng + năng lượng
  + Yêu cầu repair item cấp cao
  + Tăng áp lực tài nguyên mạnh
- Vai trò gameplay: Late game preparation phase
- Ý nghĩa balance: Ép người chơi hoàn thiện build trước khi kết thúc

- Kích hoạt phóng thoát tàu
- Phân tích:
  + Trigger ending game
  + Không thể quay lại hệ thống cũ
  + Kích hoạt countdown thoát hiểm
- Vai trò gameplay: Final mission / win condition
- Ý nghĩa balance: Hard lock kết thúc game

- Sống sót trong khủng hoảng môi trường
- Phân tích:
  + Trạng thái cuối khi hệ thống tàu sụp đổ
  + Tăng cực mạnh O2 / temp / battery pressure
  + Tạo áp lực sinh tồn cực cao
- Vai trò gameplay: Emergency survival state
- Ý nghĩa balance: Tạo cảm giác “đua với thời gian” trước ending

2.2. Stage

- Stage 1 – Early Survival
- Điều kiện mở: bắt đầu game
- Nội dung chính:
  + Tutorial survival (giới thiệu O2, HP, battery, turn system)
  + Repair Patch dùng cho sửa chữa cơ bản
  + Exploration khu vực hạn chế (map nhỏ, an toàn)
- Gameplay trọng tâm:
  + Học cơ chế sinh tồn
  + Làm quen vòng lặp: loot → craft → survive
- Áp lực chính:
  + O2 giảm theo turn
  + Thiếu tài nguyên cơ bản
- Mở stage tiếp theo khi: mở khu kỹ thuật (security door puzzle)
- Ghi chú balance: không được để người chơi chết quá sớm, loot phải đủ để craft repair patch

- Stage 2 – System Recovery
- Điều kiện mở: mở cửa an ninh
- Nội dung chính:
  + power system puzzle (khôi phục điện trung tâm)
  + craft consumable cơ bản (oxy, nước, thức ăn)
  + bắt đầu module cơ bản (battery + survival synergy)
- Gameplay trọng tâm:
  + quản lý tài nguyên + battery economy
  + bắt đầu xuất hiện tradeoff craft
- Áp lực chính:
  + thiếu battery để vận hành module
  + thiếu nguyên liệu để craft ổn định
- Mở stage tiếp theo khi: khôi phục điện trung tâm
- Ghi chú balance: tạo cảm giác “ổn định giả” trước khi game khó hơn

- Stage 3 – Ship Stabilization
- Điều kiện mở: power restored
- Nội dung chính:
  + oxygen system (ổn định O2 toàn tàu)
  + thermal hazards (nhiệt độ môi trường)
  + module usage bắt đầu quan trọng
- Gameplay trọng tâm: survival đa hệ thống (O2 + temp + battery), bắt đầu cần module để sống sót
- Áp lực chính:
  + môi trường nguy hiểm hơn (temp + O2 pressure)
  + module tiêu hao battery liên tục
- Mở stage tiếp theo khi: reactor access unlocked
- Ghi chú balance: đây là giai đoạn “stress survival chính”

- Stage 4 – Reactor Crisis
- Điều kiện mở: reactor puzzle completed
- Nội dung chính:
  + high danger zones (khu vực nguy hiểm)
  + repair reactor systems (repair item quan trọng)
  + resource pressure tăng mạnh
- Gameplay trọng tâm: ưu tiên repair thay vì survival, quản lý tài nguyên cực kỳ căng
- Áp lực chính: battery thiếu nghiêm trọng, event nguy hiểm liên tục
- Mở stage tiếp theo khi: reactor stabilized
- Ghi chú balance: đây là “peak difficulty mid game

- Stage 5 – Escape Preparation
- Điều kiện mở: reactor stabilized
- Nội dung chính:
  + navigation system mở
  + engine repair (repair item cấp cao)
  + final crafting (module + repair items)
- Gameplay trọng tâm: chuẩn bị build cuối game, tối ưu tài nguyên còn lại
- Áp lực chính: thiếu tài nguyên hiếm, sai craft có thể dẫn tới không đủ điều kiện escape
- Mở stage tiếp theo khi: escape system ready
- Ghi chú balance: đây là “checklist stage” (không còn thử nghiệm)

- Stage 6 – Final Escape
- Điều kiện mở: escape items completed
- Nội dung chính:
  + countdown escape system
  + final decision (thoát / thất bại / hy sinh)
- Gameplay trọng tâm: chạy đua thời gian, không còn exploration dài
- Áp lực chính: thời gian + tài nguyên cuối cùng, mọi sai lầm đều không sửa được
- Kết thúc game: escape thành công → win, thiếu điều kiện → fail ending
- Ghi chú balance: đảm bảo ending rõ ràng, không loop lại stage trước

2.3. Rules Text

- Luật hệ thống sinh tồn 
O2 giảm theo mỗi turn → hết O2 sẽ mất HP liên tục
HP giảm khi thiếu tài nguyên hoặc gặp môi trường nguy hiểm
Nhiệt độ vượt ngưỡng gây damage theo thời gian
Nước giảm theo hoạt động và exploration
Đói giảm dần theo thời gian → ảnh hưởng khả năng sống sót

- Luật hệ thống pin năng lượng 
Battery giảm theo turn và khi dùng module
Module hoạt động càng lâu → tiêu hao pin càng nhiều
Battery là tài nguyên giới hạn quan trọng nhất game
Hết battery → module và một số hệ thống bị vô hiệu hóa

- Luật hệ thống sửa chữa 
Mỗi repair mission cần item sửa chữa riêng
Không thể bỏ qua nhiệm vụ repair chính
Repair progress hoàn thành theo từng bước
Một số khu vực/map bị khóa nếu chưa sửa hệ thống

- Luật túi đồ 
Item có giới hạn stack để tránh tích trữ quá nhiều
Consumable dùng xong sẽ biến mất
Module có hiệu ứng kéo dài nhiều turn
Repair Item chỉ dùng cho repair mission

- Luật hệ thống turn 
Mỗi turn: giảm resource, kích hoạt effect module,trigger random event
Người chơi bị giới hạn action mỗi turn
Luôn phải lựa chọn giữa survival và repair progression

- Luật hệ thống sự kiện 
Event xuất hiện ngẫu nhiên theo khu vực
Event có thể: làm mất tài nguyên, gây damage HP,khóa khu vực tạm thời
Một số event có thể counter bằng item hoặc module phù hợp

- Luật tiến trình game 
Không thể bỏ qua stage chính
Puzzle là gate bắt buộc để mở progression
Repair mission quyết định mở stage tiếp theo
Item và resource quyết định tốc độ tiến game

3. survival_system.gd

- O2 (Oxy)
- Vai trò: Resource sinh tồn quan trọng nhất đầu game, Đại diện khả năng hô hấp của người chơi
- Cơ chế: Giảm mỗi turn, Giảm nhanh hơn ở hazard zone
- Có thể hồi bằng: Bình oxy, Oxygen Recycler Module
- Điều kiện nguy hiểm
O2 thấp → cảnh báo
O2 = 0 → mất HP mỗi turn
- Gameplay impact
Ép người chơi:
tìm oxy
repair oxygen system
ưu tiên survival trước exploration

- HP (Máu)
- Vai trò
- Resource sinh tồn cuối cùng
HP = 0 → game over
- HP giảm do
Thiếu O2
Nhiệt độ nguy hiểm
Radiation
Event damage
Đói / khát kéo dài
- HP hồi bằng
Medkit
Một số module late game
- Gameplay impact
Trừng phạt quản lý tài nguyên kém
Tạo áp lực lâu dài

- Temp (Nhiệt độ)
- Vai trò
Kiểm soát độ nguy hiểm môi trường
- Cơ chế
Temp thay đổi theo khu vực
Hazard zone: quá nóng, quá lạnh
- Điều kiện nguy hiểm: Temp vượt ngưỡng: giảm HP theo turn, tăng battery drain
- Counterplay
Thermal Pack
Thermal Regulator Module
- Gameplay impact
Ép dùng module survival
Làm exploration khó hơn

- Hydration (Nước)
- Vai trò: Resource sinh tồn trung hạn
- Cơ chế: Giảm theo turn, di chuyển, repair action
- Điều kiện nguy hiểm: Hydration thấp: giảm hiệu suất survival, tăng nguy cơ mất HP
- Hồi phục bằng
Water Pack
Water Recovery Module
- Gameplay impact
Ép exploration liên tục
Không cho player camp quá lâu

- Satiety (Đói)
- Vai trò: Resource sinh tồn dài hạn
- Cơ chế
Giảm chậm theo thời gian
Repair mission tiêu hao nhiều hơn
- Điều kiện nguy hiểm
Satiety thấp: giảm HP từ từ, tăng stress survival
- Hồi phục bằng: Food Ration
- Gameplay impact
Tạo áp lực survival dài hạn
Ngăn người chơi kéo game vô hạn

- Battery (Pin năng lượng)
- Vai trò: Resource chiến lược quan trọng nhất mid–late game
- Cơ chế
Giảm mỗi turn
Module tiêu hao liên tục
Crafting tiêu hao battery
- Hết battery sẽ:
Tắt module
Giảm khả năng survival
Một số hệ thống ngừng hoạt động
- Gameplay impact
Resource economy chính của game
Ép tradeoff:
survival
crafting
repair

- Repair Progress
- Vai trò: Theo dõi tiến trình sửa tàu
- Cơ chế
Tăng khi: dùng Repair Item, hoàn thành mission, solve puzzle
- Không đủ repair progress:
Không mở stage mới
Không mở ending
- Gameplay impact: Backbone progression system

- Actions Left
- Vai trò: Giới hạn số hành động mỗi turn
- Dùng cho
Exploration
Crafting
Repair
Use item
- Gameplay impact
Ép player tối ưu decision
Tạo turn pressure

4. event_system.gd

4.1. Các loại event chính trong game 

4.1.1. Event môi trường
- Vai trò
Tạo nguy hiểm theo khu vực
Ép người chơi chuẩn bị module phù hợp
- Ví dụ event
Rò rỉ oxy
Bão nhiệt
Rò rỉ phóng xạ
Mất áp suất phòng
Cháy hệ thống điện
- Tác động gameplay
Giảm O2
Tăng temp
Gây damage HP
Tăng battery drain
- Counterplay
Thermal Module
Radiation Shield
Oxygen Recycler

4.1.2. Event hệ thống tàu
- Vai trò
Tạo áp lực repair mission
Ép người chơi ưu tiên sửa hệ thống
- Ví dụ event
Reactor instability
Power fluctuation
Oxygen pipe failure
Engine malfunction
- Tác động gameplay
Khóa hệ thống
Tăng resource consumption
Mở crisis state
- Counterplay
Repair Item
Repair mission
Battery allocation

4.1.3. Event tài nguyên
- Vai trò: Tạo biến động resource economy
- Ví dụ event
Cargo cache
Broken supply crate
Lost battery pack
Water contamination
- Tác động gameplay
Nhận resource hiếm
Hoặc mất tài nguyên quan trọng
- Counterplay
Inventory management
Exploration planning

4.1.4. Event nguy hiểm
- Vai trò
Tạo áp lực combat-survival nhẹ
- Ví dụ event
Drone malfunction
Security turret activation
Electrical shock zone
- Tác động gameplay
Mất HP
Mất action
Tăng stress survival
- Counterplay
Security Access Device
Shield module
Repair system

4.1.5. Evant puzzle
- Vai trò
Mở progression gate
Tạo exploration reward
- Ví dụ event
Security terminal locked
Reactor access console
Navigation system puzzle
- Tác động gameplay
Mở stage mới
Unlock map
Unlock mission
- Counterplay
Key item
Puzzle solve
Correct item usage

4.2. Các event

4.2.1. Event: Rò rỉ oxy
Event ID: event_oxygen_leak
Tên event: Rò rỉ oxy
Loại event: Environmental Event
Stage xuất hiện: Stage 1, Stage 2, Stage 3
Điều kiện trigger: Đi vào khu vực hệ thống oxy, O2 system chưa ổn định
Resource bị ảnh hưởng: O2 giảm mạnh theo turn
Damage gây ra: HP giảm nếu O2 = 0
Item counter: Bình oxy, Bộ tái tạo oxy
Reward/risk: Risk: thiếu oxy, mất HP,Reward: mở khu vực chứa vật phẩm sinh tồn
Tỷ lệ xuất hiện: Trung bình

4.2.2. Event: Bão nhiệt
Event ID: event_heat_surge
Tên event: Bão nhiệt
Loại event: Environmental Event
Stage xuất hiện: Stage 3, Stage 4
Điều kiện trigger: Đi vào thermal zone, Reactor chưa ổn định
Resource bị ảnh hưởng: Temp tăng mạnh, Battery tiêu hao nhanh hơn
Damage gây ra: HP giảm theo turn nếu temp vượt ngưỡng
Item counter: Túi giữ nhiệt, Bộ điều chỉnh nhiệt
Reward/risk: Risk: damage môi trường liên tục, Reward: khu vực chứa material hiếm
Tỷ lệ xuất hiện: Cao

4.2.3. Event: Rò rỉ phóng xạ
Event ID: event_radiation_leak
Tên event: Rò rỉ phóng xạ
Loại event: Hazard Event
Stage xuất hiện: Stage 4, Stage 5
Điều kiện trigger: Reactor damage cao, Đi vào reactor zone
Resource bị ảnh hưởng: HP, Battery
Damage gây ra: Radiation damage mỗi turn
Item counter: Khiên chống bức xạ
Reward/risk: Risk: mất HP nhanh, Reward: loot repair item cấp cao
Tỷ lệ xuất hiện: Trung bình

4.2.4. Event: Dao động điện năng
Event ID: event_power_fluctuation
Tên event: Dao động điện năng
Loại event: System Failure Event
Stage xuất hiện: Stage 2, Stage 3, Stage 4
Điều kiện trigger: Power system chưa sửa hoàn chỉnh
Resource bị ảnh hưởng: Battery
Damage gây ra: Tắt module tạm thời
Item counter: Ổn định năng lượng, Pin năng lượng
Reward/risk: Risk: mất ổn định survival system, Reward: mở access tới power room
Tỷ lệ xuất hiện: Cao

4.2.5. Event: Hỏng đường ống oxy
Event ID: event_oxygen_pipe_failure
Tên event: Hỏng đường ống oxy
Loại event: System Failure Event
Stage xuất hiện: Stage 3
Điều kiện trigger: Oxygen system repair chưa hoàn tất
Resource bị ảnh hưởng: O2
Damage gây ra: O2 giảm nhanh theo turn
Item counter: Miếng vá sửa chữa, Bộ tái tạo oxy
Reward/risk: Risk: mất oxy toàn khu vực, Reward: giảm độ khó khi sửa thành công
Tỷ lệ xuất hiện: Trung bình

4.2.6. Event: Khóa cửa an ninh
Event ID: event_security_lockdown
Tên event: Khóa cửa an ninh
Loại event: Puzzle Event
Stage xuất hiện: Stage 1, Stage 2
Điều kiện trigger: Tiến vào security zone
Resource bị ảnh hưởng: Action
Damage gây ra: Không có damage trực tiếp
Item counter: Thẻ truy cập kỹ thuật, Thiết bị cấp quyền an ninh
Reward/risk: Risk: mất thời gian exploration, Reward: mở khu vực mới
Tỷ lệ xuất hiện: Thấp

4.2.7. Event: Lỗi điều hướng
Event ID: event_navigation_failure
Tên event: Lỗi điều hướng
Loại event: Puzzle/System Event
Stage xuất hiện: Stage 5
Điều kiện trigger: Navigation system chưa sửa 
Resource bị ảnh hưởng: Battery, Action
Damage gây ra: Giảm hiệu quả exploration
Item counter: Chip điều hướng, Lõi điều hướng
Reward/risk: Risk: delay escape progression, Reward: mở đường thoát hiểm
Tỷ lệ xuất hiện: Trung bình

4.2.8. Event: Mất ổn định lò phản ứng
Event ID: event_reactor_instability
Tên event: Mất ổn định lò phản ứng
Loại event: Critical System Event
Stage xuất hiện: Stage 4, Stage 5
Điều kiện trigger: Reactor chưa repair hoàn chỉnh
Resource bị ảnh hưởng: Battery, Temp, HP
Damage gây ra: Radiation damage + heat damage
Item counter: Lõi lò phản ứng,Khiên chống bức xạ
Reward/risk: Risk: crisis survival cực cao, Reward: mở final progression
Tỷ lệ xuất hiện: Cao

4.2.9. Event: Báo động thoát hiểm
Event ID: event_escape_countdown
Tên event: Báo động thoát hiểm
Loại event: Final Event
Stage xuất hiện: Stage 6
Điều kiện trigger: Escape system activated
Resource bị ảnh hưởng: O2, Battery, Action
Damage gây ra: Resource drain tăng mạnh
Item counter: Ổn định động cơ, Mã kích hoạt thoát hiểm
Reward/risk: Risk: thất bại cuối game, Reward: trigger ending
Tỷ lệ xuất hiện: Bắt buộc trigger (100%)

5. gameplay_module.gd

5.1. Các hành động chính mỗi turn

- Di chuyển / khám phá (Exploration): Di chuyển sang khu vực mới
- Mở map
- Tìm: material, consumable, repair item, key item
- Có thể trigger random event hoặc puzzle

- Loot tài nguyên
- Nhặt: phế liệu kim loại, pin năng lượng, linh kiện mạch điện,vật phẩm sinh tồn
- Giúp craft item và repair system

- Craft item / module
- Dùng material để chế tạo: consumable, module, repair item
- Tốn: battery, action
- Tạo tradeoff giữa survival và progression

- Dùng item
- Dùng consumable: hồi HP, hồi O2, giảm nhiệt
- Kích hoạt module: chống radiation, ổn định oxy, giảm battery drain

- Repair hệ thống
- Dùng repair item để sửa: oxygen system, power system, reactor, engine
- Tăng repair_progress
- Unlock stage hoặc khu vực mới

- Giải puzzle
- Dùng key item để: mở cửa an ninh, mở reactor access, mở navigation system
- Puzzle là progression gate bắt buộc

5.2. Item được dùng như thế nào

- Consumable Item (Vật phẩm tiêu hao)
Người chơi dùng trực tiếp từ inventory
Effect xảy ra ngay lập tức
Item biến mất sau khi sử dụng

- Module Item
Người chơi kích hoạt module
Module hoạt động nhiều turn liên tục
Mỗi turn sẽ tiêu hao battery

- Repair Item
Chỉ dùng tại repair mission cụ thể
Dùng để sửa hệ thống tàu
Tăng repair_progress

- Key Item
Không dùng để hồi resource
Dùng để: mở cửa, unlock puzzle, mở stage mới

5.3. Flow sửa tàu trong gameplay

Bước 1 – Khám phá khu vực
Người chơi phải exploration để tìm:
material
repair item
key item
module hỗ trợ survival

Bước 2 – Craft vật phẩm sửa chữa
Người chơi dùng material để craft:
Miếng vá sửa chữa
Lõi lò phản ứng
Ổn định động cơ
Craft sẽ: tốn battery, tốn action, tiêu hao nguyên liệu

Bước 3 – Mở khu repair
Một số hệ thống bị khóa bởi: security puzzle, reactor puzzle, navigation puzzle
Người chơi cần: key item, puzzle solve, repair requirement để tiếp cận khu sửa chữa.

Bước 4 – Thực hiện repair
Khi tới đúng khu vực: dùng repair item tương ứng, hoàn thành từng bước repair

Bước 5 – Tăng repair progress
Sau khi repair: repair_progress tăng, system hoạt động trở lại, giảm độ khó survival

Bước 6 – Unlock progression mới
Repair thành công sẽ:
mở stage tiếp theo
mở map mới
unlock mission mới
mở ending sequence

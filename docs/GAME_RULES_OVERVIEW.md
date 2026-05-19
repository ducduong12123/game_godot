1. Game Overview (Tổng quan trò chơi)
   Space STEM Survival là game sinh tồn chiến thuật theo lượt (Turn-based Survival Strategy Game) lấy bối cảnh trên tàu vũ trụ ORION-17 sau một sự cố bức xạ ngoài không gian.

   Người chơi vào vai kỹ thuật viên cuối cùng còn sống sót trên tàu và phải:
   - Quản lý tài nguyên sinh tồn
   - Khám phá các khoang tàu
   - Thu thập linh kiện
   - Giải các câu đố STEM
   - Chế tạo thiết bị
   - Sửa chữa tàu trước khi hết lượt

   Gameplay tập trung vào:
   - Resource Management (Quản lý tài nguyên)
   - Strategic Decision Making (Ra quyết định chiến thuật)
   - Survival Pressure (Áp lực sinh tồn)
   - STEM Puzzle Solving (Giải câu đố STEM)
   - Repair Progression (Tiến trình sửa tàu)

2. Core Gameplay Loop (Vòng lặp gameplay cốt lõi)
   2.1. Gameplay Flow
Start Turn
↓
Allocate Battery
↓
Explore Rooms
↓
Collect Resources
↓
Solve STEM Puzzle
↓
Craft Items / Modules
↓
Repair Ship Systems
↓
Random Event Trigger
↓
Resource Consumption
↓
Next Turn

   2.2. Giải thích Gameplay loop
   2.2.1. Start Turn (Bắt đầu lượt chơi mới)
   Khi bắt đầu turn mới, hệ thống sẽ tự động cập nhật toàn bộ trạng thái sinh tồn và chuẩn bị cho người chơi thực hiện hành động tiếp theo.

   Trong giai đoạn này, game sẽ:
   - Reset số lượng action của người chơi
   - Kiểm tra trạng thái các resource
   - Cập nhật hiệu ứng của module đang hoạt động
   - Kiểm tra điều kiện thắng/thua
   - Hiển thị warning nếu resource ở mức nguy hiểm
   - Cập nhật các effect còn duration theo turn

   Các hệ thống được xử lý trong Start Turn gồm:
   - Survival System: Cập nhật O2, nhiệt, nước
   - Module System: Kích hoạt effect theo turn
   - Event System: Kiểm tra event đang tồn tại
   - Repair System: Cập nhật repair status

   2.2.2. Allocate Battery (Phân bổ năng lượng pin)
   Đây là giai đoạn người chơi quyết định cách sử dụng nguồn điện hiện có trên tàu trong mỗi turn. Battery (Pin năng lượng) là tài nguyên quan trọng nhất trong game vì gần như mọi hệ thống sinh tồn và sửa chữa đều phụ thuộc vào điện năng.

   Người chơi phải phân bổ battery hợp lý cho các hệ thống khác nhau như:
   - Oxygen System: Duy trì oxy
   - Heating System: Giữ nhiệt độ ổn định
   - Water System: Duy trì nước sinh hoạt
   - Crafting Station: Chế tạo vật phẩm
   - Repair System: Sửa chữa tàu
   - Defense Modules: Giảm tác động sự kiện

   Mỗi hệ thống sẽ tiêu tốn lượng battery khác nhau tùy theo:
   - Độ hư hỏng của tàu
   - Repair stage hiện tại
   - Module đang hoạt động
   - Random event đang xảy ra

   Người chơi phải liên tục đưa ra tradeoff (đánh đổi chiến thuật) giữa:
   - Survival (Sinh tồn)
   - Repair Progression (Tiến trình sửa tàu)
   - Exploration (Khám phá)
   - Crafting (Chế tạo)

   Nếu battery xuống quá thấp:
   - Một số module sẽ shutdown
   - Resource decay tăng mạnh
   - Một số action bị khóa
   - Random event nguy hiểm hơn

   2.2.3. Explore Rooms (Khám phá khoang)
   Đây là giai đoạn người chơi di chuyển qua các khu vực khác nhau trên tàu để tìm kiếm tài nguyên, mở khóa tiến trình sửa chữa và khám phá các hệ thống còn hoạt động.

   Khám phá là hoạt động chính giúp người chơi:
   - Thu thập vật phẩm cần thiết
   - Tìm repair components
   - Mở khóa khu vực mới
   - Kích hoạt puzzle STEM
   - Tìm battery và vật tư sinh tồn
   - Tiếp cận repair stage tiếp theo

   Mỗi khu vực trên tàu sẽ có:
   - Mức độ nguy hiểm khác nhau
   - Resource khác nhau
   - Puzzle khác nhau
   - Event khác nhau
   - Điều kiện mở khóa khác nhau

   Trong quá trình khám phá, người chơi có thể:
   - Tìm thấy hidden item
   - Kích hoạt random event
   - Phát hiện room bị hỏng
   - Gặp environmental hazard
   - Mở shortcut giữa các khu vực

   2.2.4. Collect Resources (Thu thập tài nguyên)
   Đây là giai đoạn người chơi tìm kiếm và thu thập các resource cần thiết để duy trì sự sống và sửa chữa tàu. Thu thập tài nguyên là hoạt động quan trọng vì gần như toàn bộ gameplay đều phụ thuộc vào tài nguyên thu được trong quá trình khám phá.

   Người chơi có thể thu thập:
   - Battery cells
   - Oxygen canisters
   - Water packs
   - Food supplies
   - Crafting materials
   - Repair components
   - Key items
   - Module parts

   Tài nguyên xuất hiện ở:
   - Storage room
   - Engineering zone
   - Damaged compartments
   - Emergency containers
   - Hidden supply lockers
   - Puzzle reward rooms

   Một số resource:
   - Xuất hiện ngẫu nhiên
   - Có số lượng giới hạn
   - Chỉ xuất hiện sau repair stage nhất định
   - Yêu cầu giải puzzle để nhận

   Người chơi phải cân nhắc:
   - Có nên mạo hiểm đi xa để lấy resource hiếm
   - Có nên tiêu hao action để loot thêm
   - Có nên dùng battery để mở khóa container

   Nếu quản lý resource kém:
   - Người chơi sẽ thiếu vật liệu repair
   - Không đủ consumable để sinh tồn
   - Không thể craft module cần thiết

   2.2.5. Solve STEM Puzzle (Giải câu đố STEM)
   Đây là giai đoạn người chơi phải giải các puzzle liên quan đến kiến thức STEM để mở khóa hệ thống, nhận reward hoặc tiếp tục repair progression.

   Người chơi có thể gặp các loại puzzle như:
   - Tính toán năng lượng
   - Cân bằng điện áp
   - Logic mạch điện
   - Điều hướng tín hiệu
   - Tính nhiệt độ và áp suất
   - Công thức vật lý cơ bản
   - Puzzle logic hệ thống tàu

   Puzzle thường xuất hiện tại:
   - Control terminal
   - Locked rooms
   - Engineering systems
   - Security checkpoints
   - Reactor controls

   Khi hoàn thành puzzle, người chơi có thể:
   - Mở khóa khu vực mới
   - Nhận repair component
   - Tăng repair progress
   - Nhận battery hoặc consumable
   - Kích hoạt lại hệ thống tàu

   Nếu thất bại, người chơi có thể:
   - Mất action
   - Kích hoạt random event
   - Gây mất battery
   - Làm hỏng temporary system
   - Gây damage cho nhân vật

   2.2.6. Craft Items / Modules (Chế tạo vật phẩm và module)
   Đây là giai đoạn người chơi sử dụng tài nguyên thu thập được để chế tạo các vật phẩm hỗ trợ sinh tồn, sửa chữa tàu và tăng khả năng thích nghi với môi trường nguy hiểm.

   Crafting là hệ thống quan trọng giúp chuyển đổi:
   - Materials (Nguyên liệu)
   - Battery (Pin năng lượng)
   - Actions (Lượt hành động)
   thành:
   - Consumables
   - Utility items
   - Repair components
   - Survival modules

   Người chơi có thể chế tạo:
   - Oxygen filters
   - Water purifier
   - Thermal packs
   - Repair patch
   - Energy stabilizer
   - Radiation shield
   - Emergency medkit

   Mỗi recipe sẽ yêu cầu:
   - Nguyên liệu khác nhau
   - Lượng battery khác nhau
   - Action cost khác nhau

   2.2.7. Repair Ship Systems (Sửa chữa hệ thống tàu)
   Đây là giai đoạn người chơi khôi phục các hệ thống quan trọng của tàu nhằm tiến gần hơn đến mục tiêu cuối cùng là thoát khỏi không gian và sống sót.

   Repair system là progression system (hệ thống tiến trình) chính của game, quyết định:
   - Mở khóa gameplay mới
   - Kích hoạt khu vực mới
   - Tăng khả năng sinh tồn
   - Tiến tới ending của game

   Người chơi phải sửa nhiều hệ thống khác nhau trên tàu như:
   - Life Support System
   - Reactor System
   - Navigation System
   - Communication System
   - Engine System
   - Launch System

   Một số hệ thống chỉ có thể repair khi:
   - Đã mở khóa khu vực liên quan
   - Đã tìm được key item
   - Hoàn thành stage trước đó
   - Có đủ power supply

   Người chơi phải cân nhắc:
   - Dùng resource để sinh tồn
   - Hay đầu tư vào repair progression

   Nếu repair quá chậm:
   - Resource ngày càng cạn
   - Event nguy hiểm hơn
   - Áp lực survival tăng mạnh

   Nếu repair quá sớm:
   - Người chơi có thể thiếu consumable
   - Không đủ module bảo vệ
   - Dễ chết do thiếu preparation

   2.2.8. Random Event Trigger (Kích hoạt biến cố ngẫu nhiên)
   Cuối mỗi turn, hệ thống sẽ kiểm tra khả năng xảy ra Random Event (Biến cố ngẫu nhiên).

   Random Event là các sự cố bất ngờ xảy ra trên tàu nhằm:
   - Tăng áp lực sinh tồn
   - Làm gameplay không bị lặp lại
   - Buộc người chơi thay đổi chiến thuật
   - Tạo cảm giác nguy hiểm trong môi trường không gian

   Các biến cố có thể xảy ra gồm:
   - Oxygen Leak (Rò rỉ oxy)
   - Electrical Fire (Cháy điện)
   - Radiation Storm (Bão bức xạ)
   - System Failure (Hỏng hệ thống)
   - Frozen Pipeline (Đóng băng đường ống)
   - Reactor Instability (Lò phản ứng mất ổn định)

   Các biến cố có thể gây ra:
   - Ảnh hưởng tới resource
   - Gây mất HP
   - Làm hỏng module
   - Tăng action cost
   - Khóa tạm thời một khu vực

   Một số biến cố có thể giảm tác động nếu:
   - Người chơi đã craft module phù hợp
   - Repair stage liên quan đã hoàn thành
   - Có đủ battery để duy trì hệ thống

   2.2.9. Resource Consumption (Tiêu hao tài nguyên)
   Đây là giai đoạn hệ thống tự động giảm các resource sinh tồn sau mỗi turn để duy trì áp lực gameplay và buộc người chơi phải quản lý tài nguyên hiệu quả.

   Mỗi lượt trôi qua, các resource sẽ bị tiêu hao dựa trên:
   - Trạng thái hiện tại của tàu
   - Module đang hoạt động
   - Repair stage
   - Random event đang diễn ra
   - Khu vực người chơi đang đứng

   Các resource bị giảm theo turn gồm:
   - O2 (Oxy)
   - Battery (Pin năng lượng)
   - Temperature (Nhiệt độ)
   - Hydration (Nước)
   - Satiety (Thức ăn)

   Người chơi có thể giảm mức tiêu hao bằng cách:
   - Repair hệ thống liên quan
   - Craft survival module
   - Dùng consumable hỗ trợ
   - Phân bổ battery hợp lý

   Nếu tài nguyên xuống dưới mức nguy hiểm:
   - HP bắt đầu giảm
   - Một số action bị hạn chế
   - Random event dễ xảy ra hơn
   - Hiệu quả repair giảm

3. Turn System (Hệ thống lượt)
   3.1. Turn Structure (Cấu trúc lượt chơi)
   Gameplay của Space STEM Survival được xây dựng theo cơ chế turn-based (theo lượt), trong đó mỗi turn đại diện cho một khoảng thời gian sinh tồn trên tàu vũ trụ.

   Trong mỗi turn, người chơi phải:
   - Quản lý tài nguyên
   - Thực hiện hành động
   - Đưa ra quyết định chiến thuật
   - Chuẩn bị cho các sự kiện tiếp theo

   Trong một turn, người chơi có số lượng action giới hạn để thực hiện các hoạt động như:
   - Di chuyển
   - Thu thập item
   - Giải puzzle
   - Crafting
   - Repair system
   - Tương tác terminal

   3.2. Actions (Hành động)
   Actions là đơn vị hành động cơ bản mà người chơi sử dụng trong mỗi turn để thực hiện các hoạt động trên tàu. Mỗi hành động sẽ tiêu tốn một lượng action point nhất định và người chơi chỉ có số action giới hạn trong mỗi lượt chơi.

   Hệ thống action được thiết kế nhằm:
   - Tạo giới hạn chiến thuật
   - Buộc người chơi ưu tiên hành động quan trọng
   - Tăng áp lực quản lý thời gian
   - Tạo tradeoff giữa survival và repair progression

   Người chơi có thể sử dụng action để:
   - Di chuyển giữa các room
   - Thu thập resource
   - Tương tác với terminal
   - Giải puzzle STEM
   - Craft item
   - Repair hệ thống tàu
   - Sử dụng consumable
   - Kích hoạt module

   Nếu người chơi dùng action không hiệu quả:
   - Resource sẽ cạn nhanh
   - Repair progress chậm
   - Event nguy hiểm dễ xảy ra hơn

   3.3. Action Cost (Chi phí hành động)
   Mỗi hành động trong game đều tiêu tốn một lượng action nhất định. Đây là cơ chế giới hạn số việc người chơi có thể thực hiện trong một turn. Action cost giúp gameplay có tính chiến thuật hơn vì người chơi không thể làm mọi thứ trong cùng một lượt.

   Các hoạt động đơn giản thường tốn ít action hơn:
   - Di chuyển giữa các phòng
   - Thu thập item
   - Tương tác vật thể cơ bản
   
   Các hoạt động quan trọng hoặc phức tạp sẽ tốn nhiều action hơn:
   - Repair hệ thống tàu
   - Giải puzzle khó
   - Craft module nâng cao
   - Khởi động reactor

   Nếu người chơi tiêu hao action không hợp lý:
   - Không đủ thời gian repair
   - Resource giảm nhanh
   - Event nguy hiểm xuất hiện nhiều hơn

   3.4. Turn Pressure (Áp lực theo lượt)
   Turn pressure là cơ chế tạo áp lực liên tục lên người chơi trong suốt quá trình gameplay. Khi mỗi turn trôi qua, tình trạng của tàu sẽ ngày càng xấu đi nếu người chơi không quản lý tài nguyên và repair hợp lý.

   Mỗi turn kết thúc sẽ làm:
   - O2 giảm
   - Battery tiêu hao
   - Nhiệt độ giảm
   - Nước và thức ăn cạn dần
   - Random event có khả năng xuất hiện
   
   Càng về late game:
   - Resource decay càng mạnh
   - Event càng nguy hiểm
   - Repair requirement càng cao
   - Survival pressure càng lớn
   
   Người chơi luôn phải lựa chọn giữa:
   - Sinh tồn ngắn hạn
   - Tiến trình sửa tàu dài hạn

   Nếu người chơi quá tập trung vào survival:
   - Repair progress sẽ quá chậm
   - Tàu tiếp tục xuống cấp
   - Event mạnh hơn xuất hiện
   
   Nếu người chơi quá tập trung repair:
   - Thiếu consumable
   - Thiếu battery
   - HP giảm nhanh
   - Dễ chết giữa game

   Người chơi có thể giảm áp lực bằng cách:
   - Repair hệ thống quan trọng
   - Craft survival modules
   - Quản lý battery hiệu quả
   - Khám phá để tìm resource hiếm

4. Resource System (Hệ thống tài nguyên)
   4.1. Battery (Pin năng lượng)
   Battery là nguồn năng lượng chính duy trì hoạt động của toàn bộ con tàu và cũng là tài nguyên quan trọng nhất trong gameplay. Hầu hết các hệ thống sinh tồn và sửa chữa đều cần battery để hoạt động, vì vậy người chơi phải liên tục quản lý và phân bổ năng lượng hợp lý trong mỗi turn.

   Battery được sử dụng cho:
   - Oxygen System
   - Heating System
   - Water Purifier
   - Crafting Station
   - Repair System
   - Security Door
   - Defense Module
   - Emergency Systems
   
   Người chơi có thể nhận battery bằng cách:
   - Khám phá map
   - Loot container
   - Hoàn thành puzzle
   - Repair reactor
   - Thu thập battery cell hiếm
   
   Battery sẽ bị tiêu hao liên tục theo:
   - Số lượng hệ thống đang hoạt động
   - Module đang bật
   - Repair task hiện tại
   - Random event đang diễn ra
   - Mức độ hư hỏng của tàu

   Nếu battery xuống thấp:
   - Một số hệ thống sẽ shutdown
   - O2 decay tăng
   - Temperature giảm nhanh
   - Crafting bị giới hạn
   - Một số room bị khóa
   - Random event nguy hiểm hơn
   
   Nếu battery cạn hoàn toàn:
   - Tàu rơi vào emergency state
   - Survival pressure tăng mạnh
   - HP bắt đầu giảm theo turn
   - Một số repair stage không thể tiếp tục

   4.2. O2 – Oxygen (Oxy)
   O2 là tài nguyên đại diện cho lượng oxy còn lại trên tàu và là yếu tố sinh tồn quan trọng đối với người chơi. Hệ thống oxy quyết định khả năng duy trì sự sống trong môi trường không gian. Nếu lượng O2 giảm quá thấp, nhân vật sẽ nhanh chóng mất HP và có nguy cơ game over.

   O2 được tiêu hao theo:
   - Mỗi turn gameplay
   - Tình trạng Life Support System
   - Random event liên quan đến rò rỉ oxy
   - Một số khu vực bị hỏng trên tàu
   - Số lượng hệ thống đang hoạt động
   
   Người chơi có thể duy trì hoặc hồi O2 bằng cách:
   - Repair Life Support System
   - Dùng Oxygen Canister
   - Craft Oxygen Filter
   - Kích hoạt Oxygen Recycler Module
   - Phân bổ đủ battery cho hệ thống oxy
   
   Một số sự kiện có thể làm O2 giảm nhanh hơn:
   - Oxygen Leak
   - Hull Breach
   - System Failure
   - Explosion event
   
   Nếu O2 xuống mức nguy hiểm:
   - Màn hình cảnh báo sẽ xuất hiện
   - Âm thanh báo động được kích hoạt
   - HP bắt đầu giảm theo turn
   - Action efficiency giảm
   
   Nếu O2 cạn hoàn toàn:
   - Nhân vật bị suffocation damage (sát thương ngạt thở)
   - HP giảm cực nhanh
   - Một số action bị khóa
   - Nguy cơ game over rất cao
   
   Một số khu vực trên tàu có:
   - O2 ổn định
   - O2 thấp
   - Hoặc hoàn toàn không có oxy
   
   Điều này buộc người chơi phải:
   - Chuẩn bị consumable phù hợp
   - Quản lý battery hợp lý
   - Repair hệ thống hỗ trợ sự sống sớm
   
   Người chơi có thể giảm áp lực O2 bằng:
   - Craft module hỗ trợ
   - Unlock room an toàn
   - Repair hệ thống tàu liên quan
   - Tối ưu exploration route

   4.3. Temperature (Nhiệt độ)
   Temperature là hệ thống quản lý nhiệt độ môi trường và thân nhiệt của nhân vật trong quá trình sinh tồn trên tàu vũ trụ. Do phần lớn hệ thống sưởi trên tàu đã bị hỏng sau sự cố, nhiều khu vực sẽ có nhiệt độ cực thấp, gây ảnh hưởng trực tiếp đến khả năng sống sót của người chơi.

   Nhiệt độ bị ảnh hưởng bởi:
   - Trạng thái Heating System
   - Battery allocation
   - Random event
   - Khu vực người chơi đang đứng
   - Mức độ hư hỏng của tàu

     Một số khu vực có nhiệt độ nguy hiểm như:
     - Frozen Storage
     - Outer Maintenance Tunnel
     - Damaged Airlock
     - Reactor Cooling Area
     
     Nếu nhiệt độ xuống thấp:
     - Nhân vật bị cold damage (sát thương do lạnh)
     - HP giảm theo turn
     - Action efficiency giảm
     - Một số hoạt động tốn nhiều action hơn
     - Module hoạt động kém hiệu quả
     
     Nếu nhiệt độ giảm xuống mức cực thấp:
     - Người chơi có nguy cơ bị hypothermia (hạ thân nhiệt)
     - Tốc độ resource decay tăng
     - Repair speed giảm
     - Một số action có thể bị khóa tạm thời
     
     Người chơi có thể duy trì nhiệt độ bằng cách:
     - Phân bổ battery cho Heating System
     - Repair hệ thống sưởi
     - Craft Thermal Pack
     - Sử dụng Thermal Regulator Module
     - Tránh ở quá lâu trong khu vực đóng băng

     4.4. Hydration (Lượng nước trong cơ thể)
     Hydration là hệ thống quản lý lượng nước cần thiết để duy trì sự sống của nhân vật trong môi trường không gian. Do hệ thống nước trên tàu bị hư hỏng sau sự cố, nguồn nước sạch trở thành tài nguyên giới hạn và người chơi phải quản lý cẩn thận để tránh mất sức hoặc tử vong.

     Hydration sẽ giảm dần theo:
     - Mỗi lượt chơi
     - Mức độ hoạt động của nhân vật
     - Nhiệt độ môi trường
     - Một số sự kiện ngẫu nhiên
     - Tình trạng hệ thống lọc nước
     
     Nếu lượng nước trong cơ thể giảm xuống thấp:
     - Nhân vật bị mất sức
     - Hiệu quả hành động giảm
     - Một số hành động tốn nhiều lượt hơn
     - Tốc độ hồi phục giảm
     
     Nếu Hydration xuống mức nguy hiểm:
     - Máu (HP) bắt đầu giảm theo lượt
     - Nhân vật dễ bị ảnh hưởng bởi nhiệt độ và bức xạ
     - Khả năng sinh tồn giảm mạnh
     
     Nếu cạn nước hoàn toàn:
     - Nhân vật bị mất nước nghiêm trọng
     - Máu giảm nhanh liên tục
     - Nguy cơ thua game rất cao
     
     Người chơi có thể hồi Hydration bằng cách:
     - Sử dụng Water Pack (Gói nước)
     - Repair Water System (Sửa hệ thống nước)
     - Craft Water Purifier (Máy lọc nước)
     - Kích hoạt Water Recycling Module (Module tái chế nước)
     
     Một số khu vực trên tàu có:
     - Nguồn nước dự phòng
     - Máy lọc bị hỏng
     - Đường ống nước đóng băng
     - Khu vực nhiễm bẩn không thể sử dụng nước trực tiếp
     
     Một số biến cố ngẫu nhiên có thể làm Hydration giảm nhanh hơn:
     - Water Leakage (Rò rỉ nước)
     - Filter Failure (Hỏng bộ lọc)
     - Frozen Pipeline (Đóng băng đường ống)
     - Heat Surge (Nhiệt độ tăng đột ngột)
     
     4.5. Satiety (Độ no)
     Satiety là hệ thống quản lý mức độ no và năng lượng cơ thể của nhân vật trong quá trình sinh tồn trên tàu vũ trụ. Do nguồn thực phẩm trên tàu có giới hạn, người chơi phải liên tục tìm kiếm và quản lý thức ăn để duy trì thể trạng ổn định cho nhân vật.

     Satiety sẽ giảm dần theo:
     - Mỗi lượt chơi
     - Mức độ hoạt động của nhân vật
     - Điều kiện môi trường khắc nghiệt
     - Một số biến cố ngẫu nhiên
     - Tình trạng sức khỏe hiện tại
   
   Nếu độ no giảm xuống thấp:
   - Nhân vật bị suy giảm thể lực
   - Hiệu quả hành động giảm
   - Tốc độ repair chậm hơn
   - Một số hành động tiêu tốn nhiều lượt hơn
   
   Nếu Satiety xuống mức nguy hiểm:
   - Máu (HP) bắt đầu giảm theo lượt
   - Khả năng hồi phục giảm mạnh
   - Nhân vật dễ bị ảnh hưởng bởi lạnh và bức xạ
   - Áp lực sinh tồn tăng cao
   
   Nếu cạn thức ăn hoàn toàn:
   - Nhân vật rơi vào trạng thái đói nghiêm trọng
   - Máu giảm liên tục
   - Một số hành động bị hạn chế
   - Nguy cơ thua game tăng nhanh
   
   Người chơi có thể hồi Satiety bằng cách:
   - Sử dụng Food Pack (Gói thực phẩm)
   - Thu thập thực phẩm từ Hydroponics Room (Khu trồng thực phẩm)
   - Craft Emergency Ration (Khẩu phần khẩn cấp)
   - Repair Food Production System (Sửa hệ thống sản xuất thực phẩm)
   
   Một số khu vực trên tàu có:
   - Kho thực phẩm dự phòng
   - Khu trồng cây bị hỏng
   - Thực phẩm bị nhiễm bẩn
   - Container chứa ration hiếm
   
   Một số biến cố ngẫu nhiên có thể làm Satiety giảm nhanh hơn:
   - Food Contamination (Nhiễm bẩn thực phẩm)
   - Storage Failure (Hỏng kho lưu trữ)
   - Hydroponics Damage (Hư hỏng khu trồng thực phẩm)
   - Supply Loss (Mất nguồn tiếp tế)
   
   4.6. HP – Health Points (Máu / Điểm sinh mạng)
   HP là chỉ số đại diện cho tình trạng sức khỏe và khả năng sống sót của nhân vật trong suốt quá trình gameplay. Đây là tài nguyên sinh tồn cuối cùng của người chơi. Khi HP giảm về 0, trò chơi sẽ kết thúc và người chơi thất bại.

   HP bị ảnh hưởng bởi hầu hết các hệ thống sinh tồn trong game như:
   - Oxy
   - Nhiệt độ
   - Nước
   - Thức ăn
   - Bức xạ
   - Random event
   - Environmental hazard
   
   Người chơi sẽ mất HP khi:
   - Thiếu oxy
   - Bị hạ thân nhiệt
   - Mất nước
   - Đói kéo dài
   - Tiếp xúc bức xạ
   - Thất bại puzzle
   - Gặp sự cố cháy nổ
   - Kích hoạt event nguy hiểm
   
   Một số khu vực trên tàu gây damage trực tiếp như:
   - Radiation Zone (Khu vực nhiễm bức xạ)
   - Reactor Core (Lõi lò phản ứng)
   - Damaged Airlock (Khoang khóa khí bị hỏng)
   - Burning Compartment (Khoang cháy)
   
   Nếu HP xuống thấp:
   - Màn hình cảnh báo xuất hiện
   - Một số hiệu ứng sinh tồn nặng hơn
   - Hiệu quả hành động giảm
   - Áp lực gameplay tăng mạnh
   
   Nếu HP bằng 0:
   - Người chơi game over
   - Turn kết thúc hoàn toàn
   - Repair progression thất bại
   
   Người chơi có thể hồi HP bằng cách:
   - Sử dụng Medkit (Bộ cứu thương)
   - Dùng Medical Supply (Vật tư y tế)
   - Nghỉ ngơi trong Safe Room (Phòng an toàn)
   - Kích hoạt Medical Module (Module y tế)
   - Duy trì resource ở trạng thái ổn định

5. Exploration System (Hệ thống khám phá)
   5.1. Room Structure (Cấu trúc các khu vực trên tàu)
   Con tàu trong Space STEM Survival được chia thành nhiều room (khu vực/phòng chức năng) khác nhau. Mỗi room có vai trò riêng trong gameplay và ảnh hưởng trực tiếp đến exploration, survival và repair progression.

   Mỗi room sẽ có:
   - Chức năng riêng
   - Mức độ nguy hiểm khác nhau
   - Resource khác nhau
   - Puzzle khác nhau
   - Event khác nhau
   - Điều kiện mở khóa khác nhau

   Các room chính trên tàu gồm:
   - Command Room (Phòng điều khiển): Trung tâm điều khiển chính của tàu chứa objective và navigation system, liên quan đến final repair stage
   - Engineering Room (Phòng kỹ thuật): Khu sửa chữa hệ thống tàu chứa repair component và crafting station, có nhiều electrical hazard
   - Life Support Room (Phòng hỗ trợ sự sống): Điều khiển oxy và nước, repair tại đây giúp giảm resource decay, quan trọng ở early game
   - Reactor Core (Lõi lò phản ứng): Nguồn battery chính của tàu khu vực nguy hiểm có radiation cao, unlock ở mid hoặc late game
   - Hydroponics Room (Khu trồng thực phẩm): Cung cấp food supply có thể repair để tạo resource ổn định, một số khu vực bị đóng băng
   - Medical Bay (Khu y tế): Chứa medkit và medical supply, có thể hồi HP, một số terminal chứa puzzle y khoa
   - Storage Room (Kho vật tư): Chứa material và consumable, có nhiều hidden container, một số loot xuất hiện ngẫu nhiên
   - Security Sector (Khu an ninh): Chứa access key và security terminal, có locked door và advanced puzzle, liên quan đến nhiều unlock progression
   - Escape Hangar (Khu phóng tàu thoát hiểm): Final area của game, chỉ mở khi repair progress đủ cao, liên quan đến win condition

     Người chơi phải:
     - Quản lý route exploration hợp lý
     - Chuẩn bị consumable trước khi vào khu nguy hiểm
     - Repair các room quan trọng để giảm áp lực sinh tồn

     5.2. Locked Doors (Hệ thống cửa khóa)
     Locked Doors là hệ thống các cánh cửa bị khóa nhằm kiểm soát tiến trình khám phá và tạo mục tiêu rõ ràng cho người chơi trong quá trình gameplay. Một số khu vực trên tàu sẽ không thể tiếp cận ngay từ đầu mà cần hoàn thành điều kiện nhất định để mở khóa.

     Các loại khóa trong game gồm:
     - Security Lock (Khóa an ninh): Cần access card hoặc security key, thường xuất hiện ở khu kỹ thuật hoặc khu an ninh
     - Power Lock (Khóa nguồn điện): Chỉ mở khi khu vực có đủ battery, liên quan đến repair reactor hoặc power system
     - Puzzle Lock (Khóa câu đố): Yêu cầu giải STEM puzzle để mở cửa, có thể liên quan đến toán học, logic hoặc kỹ thuật
     - Emergency Lockdown (Khóa khẩn cấp): Xuất hiện sau random event, chỉ mở khi repair hệ thống liên quan
     - Stage Lock (Khóa theo tiến trình): Chỉ mở khi hoàn thành repair stage trước đó

     Một số cửa khóa bảo vệ:
     - Resource hiếm
     - Repair component quan trọng
     - Module nâng cao
     - Shortcut giữa các khu vực
     - Final mission area
     
     Người chơi có thể mở khóa cửa bằng cách:
     - Tìm key item
     - Hoàn thành puzzle
     - Repair hệ thống điện
     - Kích hoạt terminal
     - Dùng battery để override hệ thống khóa
     
     Một số cửa có thể:
     - Bị hỏng
     - Mất điện
     - Có radiation phía sau
     - Kích hoạt event khi mở

     5.3. Exploration Reward (Phần thưởng khám phá)
     Exploration Reward là hệ thống phần thưởng mà người chơi nhận được khi khám phá các khu vực trên tàu. Đây là cơ chế khuyến khích người chơi di chuyển, tìm kiếm tài nguyên và chấp nhận rủi ro để đạt được lợi ích lớn hơn.

     Khi khám phá room mới, người chơi có thể nhận được:
     - Material (Nguyên liệu chế tạo)
     - Consumable (Vật phẩm tiêu hao)
     - Repair Component (Linh kiện sửa chữa)
     - Key Item (Vật phẩm mở khóa)
     - Battery Cell (Pin năng lượng)
     - Module Part (Bộ phận module)

     Một số phần thưởng chỉ xuất hiện:
     - Sau repair stage nhất định
     - Trong khu vực bí mật
     - Sau khi giải puzzle
     - Sau random event đặc biệt

6. Item System (Hệ thống vật phẩm)
   6.1. Key Item (Vật phẩm mở khóa)
   Key Item là nhóm vật phẩm đặc biệt dùng để mở khóa khu vực, kích hoạt hệ thống hoặc cho phép người chơi tiếp tục progression của game.

   Người chơi có thể tìm thấy Key Item bằng cách:
   - Khám phá room mới
   - Hoàn thành puzzle STEM
   - Repair hệ thống tàu
   - Mở hidden container
   - Hoàn thành mini mission

   Key Item được dùng để:
   - Mở locked door
   - Kích hoạt terminal
   - Unlock repair stage mới
   - Mở khu vực bí mật
   - Kích hoạt hệ thống quan trọng

   Một số Key Item:
   - Engineering Access Card (Thẻ truy cập phòng kỹ thuật)
   - Reactor Override Key (Khóa khởi động lò phản ứng)
   - Navigation Chip (Chip định vị)
   - Security Clearance Device (Thiết bị cấp quyền an ninh)
   - Escape Launch Code (Mã phóng tàu thoát hiểm)

   6.2. Material (Nguyên liệu chế tạo)
   Material là nhóm tài nguyên cơ bản dùng để crafting (chế tạo), repair (sửa chữa) và nâng cấp các hệ thống trên tàu. Đây là loại item được sử dụng thường xuyên nhất trong gameplay và đóng vai trò quan trọng trong việc duy trì khả năng sinh tồn của người chơi.

   Người chơi có thể thu thập material bằng cách:
   - Khám phá room
   - Loot container
   - Tháo dỡ hệ thống hỏng
   - Hoàn thành puzzle
   - Nhận reward từ event hoặc mission

   Material được dùng để:
   - Craft consumable
   - Chế tạo module
   - Repair hệ thống tàu
   - Mở khóa một số objective
   - Tạo repair component nâng cao

   Một số Material:
   - Metal Scrap (Mảnh kim loại)
   - Fiber Mesh (Lưới sợi tổng hợp)
   - Circuit Parts (Linh kiện mạch điện)
   - Energy Cell (Tế bào năng lượng)
   - Thermal Gel (Gel giữ nhiệt)
   - Reinforced Plate (Tấm kim loại gia cố)

   6.3. Consumable (Vật phẩm tiêu hao)
   Consumable là nhóm vật phẩm có thể sử dụng trực tiếp để hồi phục, hỗ trợ sinh tồn hoặc giảm áp lực trong gameplay. Sau khi sử dụng, vật phẩm sẽ bị tiêu hao và biến mất khỏi inventory. Đây là nhóm item giúp người chơi duy trì sự sống trong các tình huống nguy hiểm hoặc thiếu tài nguyên.

   Người chơi có thể nhận consumable bằng cách:
   - Loot container
   - Khám phá room
   - Reward từ puzzle
   - Hoàn thành mission
   - Nhặt trong emergency supply box

   Consumable thường được dùng để:
   - Hồi HP
   - Hồi oxy
   - Hồi nước
   - Hồi độ no
   - Giảm damage tạm thời
   - Hỗ trợ exploration
   - Tăng khả năng sống sót trong event nguy hiểm

   Một số consumable:
   - Medkit (Bộ cứu thương)
   - Water Pack (Gói nước)
   - Food Ration (Khẩu phần ăn)
   - Oxygen Canister (Bình oxy)
   - Thermal Pack (Túi giữ nhiệt)
   - Emergency Stim (Thuốc kích thích khẩn cấp)

   6.4. Module (Thiết bị hỗ trợ)
   Module là nhóm thiết bị đặc biệt có khả năng tạo hiệu ứng hỗ trợ kéo dài trong nhiều turn, giúp người chơi tăng khả năng sinh tồn và tối ưu hóa việc quản lý tài nguyên.

   Module được sử dụng để:
   - Giảm tiêu hao tài nguyên
   - Tăng hiệu quả repair
   - Tăng khả năng chống chịu
   - Hỗ trợ exploration
   - Giảm tác động từ random event
   - Tăng hiệu suất sinh tồn
   
   Người chơi có thể nhận module bằng cách:
   - Crafting
   - Hoàn thành puzzle STEM
   - Repair system quan trọng
   - Khám phá room hiếm
   - Nhận reward từ mission
   
   Một số module phổ biến gồm:
   - Oxygen Recycler (Thiết bị tái chế oxy)
   - Thermal Regulator (Bộ điều chỉnh nhiệt độ)
   - Energy Stabilizer (Bộ ổn định năng lượng)
   - Radiation Shield (Khiên chống bức xạ)
   - Auto Repair Assistant (Thiết bị hỗ trợ sửa chữa)
   - Water Recovery Unit (Thiết bị tái tạo nước)

   6.5. Repair Item (Vật phẩm sửa chữa)
   Repair Item là nhóm vật phẩm chuyên dùng để sửa chữa các hệ thống quan trọng trên tàu và tăng repair progression trong quá trình gameplay. Đây là nhóm item cốt lõi liên quan trực tiếp đến mục tiêu thắng của game, vì người chơi phải sử dụng repair item để khôi phục các hệ thống bị hỏng và hoàn thành quá trình sửa tàu.

   Repair Item được sử dụng để:
   - Repair reactor
   - Sửa hệ thống oxy
   - Khôi phục navigation system
   - Kích hoạt engine
   - Mở repair stage mới
   - Hoàn thành objective chính
   
   Người chơi có thể nhận repair item bằng cách:
   - Khám phá khu kỹ thuật
   - Hoàn thành puzzle STEM
   - Crafting
   - Reward từ mission
   - Loot trong khu vực nguy hiểm
   - Repair system nhỏ để mở supply cache
   
   Một số repair item phổ biến gồm:
   - Repair Patch (Miếng vá sửa chữa)
   - Reactor Coil (Cuộn lõi lò phản ứng)
   - Power Regulator (Bộ điều chỉnh điện năng)
   - Navigation Chip (Chip định vị)
   - Cooling Valve (Van làm mát)
   - Circuit Stabilizer (Bộ ổn định mạch điện)

7. Crafting System (Hệ thống chế tạo)
   7.1. Crafting Overview (Tổng quan hệ thống chế tạo)
   Crafting là hệ thống cho phép người chơi sử dụng nguyên liệu thu thập được để tạo ra vật phẩm hỗ trợ sinh tồn, module và repair item phục vụ cho quá trình sửa tàu.

   Đây là một trong những hệ thống gameplay quan trọng nhất vì nó kết nối trực tiếp:
   - Exploration (Khám phá)
   - Resource management (Quản lý tài nguyên)
   - Survival gameplay (Gameplay sinh tồn)
   - Repair progression (Tiến trình sửa tàu)
   
   Người chơi có thể craft:
   - Consumable (Vật phẩm tiêu hao)
   - Module hỗ trợ
   - Repair component (Linh kiện sửa chữa)
   - Utility item (Vật phẩm hỗ trợ đặc biệt)
   
   Để chế tạo item, người chơi cần:
   - Material phù hợp
   - Battery (Pin năng lượng)
   - Action point (Lượt hành động)
   - Một số trường hợp cần repair stage nhất định
   
   Crafting thường được thực hiện tại:
   - Engineering Station (Trạm kỹ thuật)
   - Portable Workbench (Bàn chế tạo di động)
   - Repair Terminal (Thiết bị sửa chữa)
   - Special Craft Room (Phòng chế tạo đặc biệt)

   7.2. Crafting Cost (Chi phí chế tạo)
   Mỗi lần crafting (chế tạo), người chơi phải tiêu tốn một lượng tài nguyên nhất định để tạo ra item mới. Đây là cơ chế giúp giữ cân bằng gameplay và tạo tradeoff trong quá trình sinh tồn.

   Crafting cost bao gồm:
   - Material (Nguyên liệu)
   - Battery (Pin năng lượng)
   - Action point (Lượt hành động)
   
   Chi phí crafting được thiết kế để:
   - Ngăn người chơi spam item quá dễ
   - Tạo áp lực quản lý resource
   - Buộc người chơi ưu tiên item quan trọng
   - Giữ progression cân bằng

   Các item đơn giản thường:
   - Tốn ít material
   - Tốn ít battery
   - Craft nhanh

   Các item mạnh hoặc nâng cao sẽ:
   - Tốn nhiều material hiếm
   - Tốn nhiều battery
   - Cần nhiều action hơn
   - Có điều kiện unlock

   7.3. Crafting Tradeoff (Đánh đổi trong chế tạo)
   Crafting Tradeoff là cơ chế buộc người chơi phải lựa chọn giữa nhiều nhu cầu khác nhau khi sử dụng tài nguyên để chế tạo vật phẩm.

   Do resource trong game có giới hạn, người chơi không thể craft mọi thứ mình muốn. Mỗi quyết định crafting đều sẽ ảnh hưởng trực tiếp đến:
   - Khả năng sinh tồn
   - Tốc độ repair progression
   - Khả năng exploration
   - Mức độ an toàn ở các turn sau

   Người chơi luôn phải tự đặt câu hỏi:
   - Craft ngay hay tiết kiệm?
   - Ưu tiên survival hay progression?
   - Có đủ battery để duy trì module không?
   - Có nên mạo hiểm exploration để tìm resource hiếm hơn không?

   Một số item được thiết kế cố ý để:
   - Mạnh nhưng đắt
   - Hiệu quả cao nhưng tiêu hao battery lớn
   - Giúp survival tốt nhưng làm chậm repair progression

   Một số chiến thuật hợp lệ:
   - Chơi an toàn: Craft nhiều consumable, Repair chậm nhưng ổn định
   - Chơi repair rush: Ưu tiên repair item, Ít consumable hơn, Risk cao nhưng kết thúc game nhanh hơn
   - Chơi module build: Đầu tư module mạnh, Resource đầu game khó khăn, Mid game ổn định hơn

8. Puzzle System (Hệ thống câu đố STEM)
   8.1. Vai trò của Puzzle System (Hệ thống câu đố STEM)
   Puzzle System là hệ thống câu đố giáo dục tích hợp trong gameplay nhằm tạo thử thách tư duy và hỗ trợ progression của người chơi trong quá trình sinh tồn trên tàu vũ trụ.

   Puzzle xuất hiện trong nhiều hoạt động khác nhau như:
   - Mở khóa hệ thống tàu
   - Repair machine
   - Kích hoạt reactor
   - Điều khiển nguồn điện
   - Giải mã terminal
   - Mở security door

   Puzzle có thể:
   - Có giới hạn lượt thử
   - Tiêu tốn action
   - Kích hoạt random event nếu thất bại
   - Mở reward đặc biệt nếu hoàn thành tốt
   
   8.2. Puzzle Types (Các loại câu đố STEM)
   Puzzle trong Space STEM Survival được chia thành nhiều loại khác nhau nhằm tạo sự đa dạng trong gameplay và giúp người chơi tiếp cận nhiều dạng tư duy STEM.

   Mỗi loại puzzle sẽ:
   - Có cơ chế riêng
   - Độ khó riêng
   - Reward khác nhau
   - Liên kết với các hệ thống gameplay khác nhau

   Các loại puzzle chính gồm:
   - Logic Circuit Puzzle (Câu đố mạch điện logic): Người chơi phải nối mạch hoặc kích hoạt đúng hệ thống điện, liên quan đến engineering gameplay, thường dùng để mở cửa hoặc repair machine
   - Energy Balancing Puzzle (Câu đố cân bằng năng lượng): Người chơi phân bổ nguồn điện hợp lý cho các hệ thống, liên quan đến battery management, có thể mở reactor hoặc life support
   - Signal Routing Puzzle (Câu đố điều hướng tín hiệu): Người chơi phải dẫn tín hiệu đến đúng vị trí, thường xuất hiện ở communication room hoặc security system, độ khó tăng dần theo stage
   - Temperature Control Puzzle (Câu đố điều chỉnh nhiệt độ): Điều chỉnh nhiệt độ hệ thống để tránh quá nóng hoặc đóng băng, liên quan đến heating system và cooling system
   - Math Calculation Puzzle (Câu đố tính toán): Người chơi giải bài toán STEM đơn giản, có thể liên quan đến công thức vật lý hoặc logic số học, dùng trong reactor hoặc navigation system
   - Reactor Stabilization Puzzle (Câu đố ổn định lò phản ứng): Puzzle độ khó cao ở mid hoặc late game, người chơi phải cân bằng nhiều hệ thống cùng lúc, failure risk lớn hơn các puzzle thông thường
   - Sequence Memory Puzzle (Câu đố ghi nhớ chuỗi): Ghi nhớ tín hiệu hoặc mã điều khiển, thường liên quan đến security terminal
   - Pressure Control Puzzle (Câu đố áp suất): Điều chỉnh áp suất để tránh system failure, có thể liên quan đến oxygen system hoặc reactor

     8.3. Puzzle Reward (Phần thưởng từ câu đố STEM)
     Puzzle Reward là hệ thống phần thưởng người chơi nhận được sau khi hoàn thành các câu đố STEM trong game.

     Mỗi puzzle sẽ có reward khác nhau tùy theo:
     - Độ khó
     - Khu vực xuất hiện
     - Repair stage hiện tại
     - Risk level của puzzle

     Người chơi có thể nhận được các reward như:
     - Battery (Pin năng lượng): Hồi năng lượng cho hệ thống tàu giúp giảm áp lực survival
     - Consumable (Vật phẩm tiêu hao): Water Pack, Food Ration, Oxygen Canister, Medkit
     - Material (Nguyên liệu chế tạo): Metal Scrap, Circuit Parts, Thermal Gel, Energy Cell
     - Repair Item (Vật phẩm sửa chữa): Repair Patch, Reactor Coil, Navigation Chip, Cooling Valve
     - Key Item (Vật phẩm mở khóa): Access Card, Security Key, Launch Code, Override Device
     - Module Reward (Phần thưởng module): Oxygen Recycler, Radiation Shield, Thermal Regulator, Energy Stabilizer

     8.4. Puzzle Failure (Thất bại khi giải câu đố)
     Puzzle Failure là hệ thống xử lý khi người chơi giải sai hoặc không hoàn thành puzzle STEM trong game.

     Khi thất bại puzzle, người chơi có thể bị:
     - Mất action
     - Mất battery
     - Giảm HP
     - Giảm resource
     - Kích hoạt random event
     - Khóa terminal tạm thời

     Mức độ penalty (hình phạt) phụ thuộc vào:
     - Loại puzzle
     - Độ khó puzzle
     - Khu vực hiện tại
     - Repair stage
     - Trạng thái hệ thống tàu

9. Random Event System (Hệ thống biến cố ngẫu nhiên)
    9.1. Mục đích của Random Event System (Hệ thống biến cố ngẫu nhiên)
   Random Event System là hệ thống tạo ra các sự kiện xảy ra ngẫu nhiên trong quá trình gameplay nhằm tăng áp lực sinh tồn, tạo sự bất ngờ và làm cho mỗi lần chơi trở nên khác nhau.

   Các random event có thể:
   - Gây bất lợi cho người chơi
   - Mang lại reward bất ngờ
   - Thay đổi trạng thái của tàu
   - Ảnh hưởng đến exploration và repair progression

   9.2. Event Examples (Ví dụ về các biến cố ngẫu nhiên)
   Trong quá trình gameplay, người chơi sẽ gặp nhiều random event khác nhau xảy ra trên tàu. Các event này giúp tạo áp lực sinh tồn, thay đổi tình huống gameplay và buộc người chơi phải thích nghi liên tục.

   Mỗi event sẽ có:
   - Trigger condition (Điều kiện kích hoạt)
   - Effect (Hiệu ứng)
   - Duration (Thời gian ảnh hưởng)
   - Risk level (Mức độ nguy hiểm)
   - Reward hoặc penalty riêng

   Một số random event tiêu biểu trong game:
   - Oxygen Leak (Rò rỉ oxy): O2 giảm nhanh hơn trong nhiều turn, Một số room bị thiếu oxy nghiêm trọng, Người chơi cần repair Life Support hoặc dùng Oxygen Canister
   - Power Failure (Mất điện hệ thống): Battery consumption tăng mạnh, Một số room bị khóa tạm thời, Crafting station ngừng hoạt động
   - Radiation Storm (Bão bức xạ): Radiation damage tăng ở nhiều khu vực, Exploration trở nên nguy hiểm hơn, Reactor area có reward lớn hơn trong thời gian event
   - Frozen Pipeline (Đóng băng đường ống): Hydration decay tăng, Water System hoạt động kém hiệu quả, Một số room bị giảm nhiệt độ mạnh
   - Heating Failure (Hỏng hệ thống sưởi): Temperature giảm nhanh theo turn, Cold damage tăng, Một số module chống lạnh hoạt động hiệu quả hơn
   - Reactor Instability (Lò phản ứng mất ổn định): Reactor Core trở nên nguy hiểm, Có nguy cơ explosion event, Battery reward tăng nếu repair thành công
   - Emergency Supply Drop (Nguồn tiếp tế khẩn cấp): Spawn thêm consumable và material, Reward exploration tăng tạm thời, Event hỗ trợ người chơi trong giai đoạn khó
   - Security Lockdown (Khóa an ninh khẩn cấp): Một số cửa bị khóa, Security puzzle xuất hiện, Exploration route bị thay đổi
   - System Fire (Cháy hệ thống): HP giảm nếu ở gần khu vực cháy, Room bị damage, Có thể phá hủy resource trong khu vực
   - Communication Signal Detected (Phát hiện tín hiệu liên lạc): Unlock side mission hoặc hidden room, Có thể dẫn đến reward lớn hoặc event nguy hiểm

     9.3. Event Balance (Cân bằng hệ thống biến cố ngẫu nhiên)
     Event Balance là hệ thống kiểm soát độ khó và tần suất xuất hiện của random event nhằm đảm bảo gameplay luôn có thử thách nhưng không gây cảm giác quá bất công hoặc khó chịu cho người chơi.

     Tần suất event sẽ thay đổi theo progression:
     - Early game: Event đơn giản hơn, Chủ yếu hướng dẫn survival gameplay, Penalty nhẹ
     - Mid game: Event bắt đầu kết hợp nhiều hệ thống, Resource pressure tăng, Exploration nguy hiểm hơn
     - Late game: Event phức tạp hơn, Có chain effect, Survival pressure rất cao
     
     Một số nguyên tắc balance quan trọng:
     - Không spawn quá nhiều event nguy hiểm cùng lúc, tránh gameplay quá áp lực
     - Không tạo event impossible state, người chơi luôn phải có ít nhất một hướng xử lý
     - Event phải phù hợp với trạng thái hiện tại của game, không spawn radiation storm quá sớm, không khóa toàn bộ map khi thiếu battery
     - Có xen kẽ event hỗ trợ, giúp giảm áp lực ở thời điểm khó

10. Repair Progression (Tiến trình sửa tàu)
    10.1. Repair Stages (Các giai đoạn sửa tàu)
    Repair Stages là hệ thống chia tiến trình sửa chữa con tàu thành nhiều giai đoạn khác nhau nhằm tạo progression rõ ràng trong gameplay. Người chơi sẽ phải sửa từng hệ thống quan trọng của tàu theo thứ tự hợp lý để dần khôi phục khả năng hoạt động của con tàu.

    Repair progression trong game gồm 5 stage chính:
    - Stage 1 — Restore Life Support (Khôi phục hệ thống hỗ trợ sự sống): Repair hệ thống oxy và nước cơ bản, Giảm O2 decay và Hydration decay, Giúp early game ổn định hơn, Unlock thêm safe room và crafting station cơ bản
    - Stage 2 — Restore Engineering Systems (Khôi phục hệ thống kỹ thuật): Repair hệ thống điện và crafting system, Unlock advanced crafting recipe, Giảm battery consumption, Mở Engineering Zone
    - Stage 3 — Stabilize Reactor Core (Ổn định lõi lò phản ứng): Repair reactor để tăng battery supply, Unlock high-power system, Giảm power failure event, Radiation risk tăng trong quá trình repair
    - Stage 4 — Restore Navigation System (Khôi phục hệ thống định vị): Kích hoạt navigation computer, Unlock new exploration area, Mở final mission path, Puzzle difficulty tăng mạnh
    - Stage 5 — Prepare Escape Launch (Chuẩn bị phóng tàu thoát hiểm): Repair engine và launch system, Thu thập final repair component, Hoàn thành final puzzle, Mở win condition của game

    Nếu repair quá chậm:
    - Resource cạn dần
    - Event ngày càng nguy hiểm
    - Survival pressure tăng mạnh
    
    Nếu repair quá sớm:
    - Thiếu consumable
    - Thiếu module hỗ trợ
    - Dễ thất bại ở khu vực nguy hiểm

    10.2. Progression Purpose (Mục đích của tiến trình sửa tàu)
    Repair Progression được xây dựng không chỉ để tạo mục tiêu hoàn thành game, mà còn để điều khiển nhịp gameplay và tạo cảm giác phát triển liên tục cho người chơi.

    Mục đích chính của progression gồm:
    - Tạo mục tiêu dài hạn cho người chơi: Người chơi luôn biết mình đang sửa hệ thống nào, Gameplay có direction rõ ràng, Tránh cảm giác “sống sót vô nghĩa”
    - Chia gameplay thành nhiều giai đoạn:
      Early game → tập trung survival
      Mid game → cân bằng survival và repair
      Late game → tập trung hoàn thành mission cuối
    - Tạo cảm giác con tàu đang được khôi phục thật sự: Sau mỗi stage, tàu hoạt động ổn định hơn, Một số room được mở khóa, Hệ thống mới bắt đầu hoạt động
    - Kiểm soát độ khó theo progression: Khu vực nguy hiểm chỉ mở sau, Puzzle khó tăng dần, Random event thay đổi theo stage
    - Tăng giá trị exploration: Người chơi cần khám phá để tìm repair item, Một số progression bị khóa bởi key item hoặc puzzle
    - Kết nối crafting với gameplay: Repair cần material và module, Người chơi phải lựa chọn giữa survival và progression

11. Difficulty Curve (Đường cong độ khó)
    Đường cong độ khó trong Space STEM Survival được thiết kế theo hướng: Early game dễ tiếp cận, Mid game tạo áp lực chiến thuật, Late game căng thẳng và nguy hiểm hơn

    Gameplay được chia thành 3 giai đoạn độ khó chính:
    - Early Game (Đầu game): Người chơi học cơ chế gameplay, Resource vẫn còn tương đối ổn định, Puzzle đơn giản, Event nhẹ và dễ xử lý, Exploration risk chưa quá cao
    - Mid Game (Giữa game): Resource bắt đầu thiếu hụt, Exploration nguy hiểm hơn, Event xuất hiện thường xuyên hơn, Puzzle có nhiều bước hơn, Người chơi phải bắt đầu tối ưu resource
    - Late Game (Cuối game): Survival pressure rất cao, Resource hiếm hơn, Event nguy hiểm hơn, Puzzle phức tạp hơn, Một số room cực kỳ nguy hiểm

    Độ khó tăng dần thông qua:
    - Resource decay tăng
    - Event pool nguy hiểm hơn
    - Puzzle complexity cao hơn
    - Repair cost lớn hơn
    - Exploration risk cao hơn

12. Win Condition (Điều kiện thắng)
    Mục tiêu cuối cùng của game không chỉ là sống sót, mà là:
    - Sửa chữa các hệ thống quan trọng của con tàu
    - Khôi phục khả năng hoạt động
    - Chuẩn bị tàu thoát hiểm
    - Rời khỏi khu vực nguy hiểm thành công

    Để chiến thắng, người chơi phải hoàn thành toàn bộ repair progression chính gồm:
    - Restore Life Support: Khôi phục hệ thống hỗ trợ sự sống, Ổn định oxy và nước
    - Restore Engineering Systems: Sửa hệ thống kỹ thuật và điện năng, Mở crafting nâng cao
    - Stabilize Reactor Core: Ổn định lò phản ứng, Khôi phục nguồn battery chính
    - Restore Navigation System: Kích hoạt hệ thống định vị, Xác định lộ trình thoát hiểm
    - Prepare Escape Launch: Repair engine và launch system, Chuẩn bị phóng tàu thoát hiểm

    Game kết thúc chiến thắng khi:
    - Escape ship launch thành công
    - Người chơi sống sót
    - Con tàu hoặc tàu thoát hiểm hoạt động ổn định

13. Lose Condition (Điều kiện thua)
    Người chơi không chỉ thua vì hết máu, mà còn có thể thất bại do:
    - Thiếu tài nguyên
    - Hệ thống tàu sụp đổ
    - Repair progression quá chậm
    - Random event nghiêm trọng

    Các điều kiện thua chính gồm:
    - HP về 0: Người chơi tử vong do thiếu oxy, đóng băng, radiation dâmge, explosion, system hazard
    - O2 cạn hoàn toàn: Người chơi không còn oxy để sinh tồn, HP sẽ giảm cực nhanh, Nếu không xử lý kịp sẽ dẫn tới game over
    - Temperature xuống mức nguy hiểm quá lâu: Người chơi bị đóng băng, Cold damage tăng liên tục, Survival system sụp đổ
    - Reactor Meltdown (Lò phản ứng phát nổ): Reactor instability vượt mức an toàn, Kích hoạt catastrophic failure, Game over ngay lập tức
    - Life Support Failure: Hệ thống hỗ trợ sự sống ngừng hoạt động hoàn toàn, O2 và hydration giảm cực mạnh, Không thể duy trì survival lâu dài
    - Battery cạn kiệt hoàn toàn: Một số hệ thống ngừng hoạt động, Crafting bị khóa, Room bị mất điện, Survival pressure tăng rất nhanh
    - Không đủ resource để tiếp tục progression: Thiếu repair item, Thiếu consumable, Không thể exploration an toàn, Gameplay rơi vào fail state
    - Final Mission Failure: Thất bại trong final launch sequence, Reactor overload khi phóng tàu, Không đủ battery cho launch system

    Một số sai lầm phổ biến dẫn tới thua:
    - Exploration quá tham
    - Craft quá nhiều item không cần thiết
    - Không repair hệ thống quan trọng
    - Dùng hết consumable quá sớm
    - Ignore random event quá lâu

14. Core Design Philosophy (Triết lý thiết kế gameplay)
    Triết lý thiết kế của game tập trung vào:
    - Sinh tồn trong môi trường không gian nguy hiểm
    - Học tập thông qua gameplay STEM
    - Quản lý tài nguyên chiến thuật
    - Khám phá và sửa chữa con tàu từng bước

    Core Design Philosophy được xây dựng nhằm:
    - Tạo gameplay có chiều sâu
    - Kết hợp giáo dục và sinh tồn tự nhiên
    - Tăng replayability (Khả năng chơi lại)
    - Giữ gameplay luôn căng thẳng nhưng thú vị
    - Tạo cảm giác khám phá và tiến bộ liên tục

15. Final Goal (Mục tiêu cuối cùng của game)
    Mục tiêu cuối cùng của người chơi là:
    - Sinh tồn đủ lâu trên con tàu bị hỏng
    - Khám phá các khu vực của tàu
    - Thu thập tài nguyên và repair component
    - Khôi phục các hệ thống quan trọng
    - Hoàn thành repair progression
    - Kích hoạt tàu thoát hiểm và rời khỏi khu vực nguy hiểm

    Final Goal cũng hướng tới:
    - Tăng replayability (Khả năng chơi lại)
    - Tạo cảm giác học thông qua gameplay
    - Giữ gameplay luôn có chiều sâu chiến thuật
    - Tạo cảm giác khám phá khoa học viễn tưởng
    
    Khi hoàn thành game, người chơi cần cảm thấy:
    - Mình đã thật sự sống sót qua khủng hoảng
    - Mọi hệ thống gameplay đều có ý nghĩa
    - Các quyết định trước đó ảnh hưởng đến kết quả cuối
    - Gameplay vừa mang tính giải trí vừa mang tính học tập
    

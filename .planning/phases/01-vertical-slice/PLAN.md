# /gsd-plan - Phase 01 Vertical Slice

Ngay lap: 2026-04-19
Project: Space STEM Survival (Godot)
Muc tieu phase: Co ban choi duoc tron vong (kham pha -> nhat do -> craft -> phan bo -> puzzle -> win/lose), san sang demo thi.

## 1) Scope bat buoc
1. Co man hinh bat dau va luat choi ro rang.
2. Core loop day du: kham pha, nhat vat pham, crafting, phan bo tai nguyen, puzzle STEM, feedback thang/thua.
3. AI tutor on dinh, co fallback offline.
4. Ban demo chay duoc o muc co ban.

## 2) Phan cong ro giua Assistant va AI kia
| Hang muc | Assistant (Codex + MCP) | AI kia (gdtoolkit) |
|---|---|---|
| Vai tro | Owner gameplay logic + runtime verify | Owner lint/format + refactor an toan |
| Duoc sua | `scripts/main.gd`, `scripts/modules/gameplay_module.gd`, `scripts/modules/world_module.gd`, `scripts/systems/survival_system.gd`, `scripts/content/game_data.gd` | Cac `.gd` vua doi de format/lint; script phu tro test balance |
| Khong duoc sua | Khong giao patch chi-style cho AI kia khi dang lam logic | Khong doi cong thuc gameplay, khong doi balance, khong doi game loop, khong sua `scenes/main.tscn` |
| Tool chinh | MCP: `validate_script`, `run_scene`, `is_playing`, `get_errors`, `stop_scene` | `gdformat`, `gdlint`, cleanup khong doi hanh vi |
| Dau ra bat buoc | Runtime report sau moi feature | Lint report + patch style/refactor |

## 3) Task cu the tung ben
### Assistant (Codex + MCP)
1. A1 - Implement Crafting System v1.
2. A2 - Noi crafting vao inventory, action cost, battery cost, effect theo luot.
3. A3 - Dong bo UI state voi logic gameplay.
4. A4 - Chay runtime gate bang MCP va chot ket qua.

### AI kia (gdtoolkit)
1. B1 - Chay `gdformat` tren file da thay doi.
2. B2 - Chay `gdlint`, fix warning an toan.
3. B3 - Refactor nhe (tach ham dai, dat ten ro nghia), khong doi hanh vi.
4. B4 - Tra lint summary de Assistant verify runtime lai.

### Ban (Product/Content)
1. C1 - Chot 12 cong thuc craft va 8-12 puzzle STEM.
2. C2 - Chot text tieng Viet cuoi cho UI/luat.
3. C3 - Asset toi thieu + playtest 3-5 nguoi.

## 4) Rule lam song song (bat buoc)
1. Mot file chi co 1 owner tai mot thoi diem.
2. Khong sua dong thoi 2 file nhay cam: `scripts/main.gd`, `scenes/main.tscn`.
3. Thu tu handoff co dinh:
1. Assistant code logic.
2. AI kia lint/format/refactor an toan.
3. Assistant chay runtime gate MCP.
4. Neu runtime fail, patch quay lai Assistant.
4. Khong merge patch khi chua co runtime report.

## 5) Sprint 4 ngay
### Day 1
1. Assistant: A1.
2. AI kia: B1, B2 baseline.
3. Ban: C1.

### Day 2
1. Assistant: A2.
2. AI kia: B3.
3. Ban: C2.

### Day 3
1. Assistant: A3, A4.
2. AI kia: B4.
3. Ban: C3 (playtest dot 1).

### Day 4
1. Chot bugfix cuoi.
2. Dong goi demo.
3. Chot bao cao va script demo 5 phut.

## 6) Definition of done
1. Co start screen, luat choi, tuong tac chinh.
2. Co feedback dung/sai va thang/thua.
3. Core loop choi duoc end-to-end.
4. Runtime gate pass: scene chay, khong blocker error.
5. Demo 5 phut on dinh.

## 7) Prompt handoff mau
### Cho AI kia
"Run gdformat + gdlint on changed .gd files in SpaceStemGodot. Do only safe style/refactor changes, no gameplay logic changes. Return patch + lint summary."

### Cho Assistant
"Implement [feature-name] in SpaceStemGodot with direct code edits, then run MCP verify loop: validate_script -> run_scene -> is_playing -> get_errors -> stop_scene. Return changed files and runtime result."

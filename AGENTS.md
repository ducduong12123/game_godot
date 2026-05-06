# AGENTS.md

Purpose: give AI coding agents enough project context to edit safely without breaking game flow.

## 1) Project Map

- Engine: Godot `4.6` (`project.godot`)
- Entry scene: `res://scenes/main.tscn`
- Entry script: `res://scripts/main.gd`
- Main architecture style: one orchestrator (`main.gd`) + feature modules in `scripts/modules` + pure data in `scripts/content` + pure simulation systems in `scripts/systems`.

Folders:
- `scenes/`: scene files (`main.tscn` currently).
- `scripts/main.gd`: runtime state and event routing hub.
- `scripts/modules/`: UI/world/gameplay/AI controllers (RefCounted objects).
- `scripts/content/`: static content factories and constants (items, map, puzzles, story text, recipes).
- `scripts/systems/`: deterministic turn simulation and random event logic; AI prompt/config helper.
- `assets/fonts/`: UI font resources loaded manually from bytes.

## 2) Runtime Ownership (What Lives Where)

`scripts/main.gd` owns:
- Global mutable game state: turn, stats, inventory, doors, puzzles, modules, AI flags.
- Godot lifecycle hooks: `_ready`, `_process`, `_draw`.
- Input action registration in `_ensure_input_actions`.
- Signal handlers that delegate into modules.

`scripts/modules/world_module.gd` owns:
- Movement collision against ship walls/door openings.
- Door open/locked checks.
- Nearest item/door detection.
- All map drawing (rooms, grid, walls, doors, items, player, labels).

`scripts/modules/gameplay_module.gd` owns:
- Mission start gate and turn progression.
- Interaction rules (`E` key logic): unlock door, pick item, open puzzle.
- Crafting pipeline and temporary module effects.
- Puzzle resolution and repair progress.
- Win/loss state transitions.
- Calls into `survival_system` and `event_system` each turn.

`scripts/modules/ui_module.gd` owns:
- Full runtime UI construction in code (CanvasLayer + Panels + Labels + Buttons).
- Start overlay, rules popup, puzzle panel.
- UI refresh text (`update_ui` and `update_prompt_label`).
- Theme/font application.

`scripts/modules/ai_module.gd` owns:
- HTTPRequest setup and Gemini API request cycle.
- Online/offline AI tutor behavior.
- AI chat log rendering and scroll behavior.
- Prompt construction using current state snapshot.

`scripts/modules/ai_module_stub.gd`:
- Fallback if `ai_module.gd` fails to load at runtime.

## 3) Data vs Logic Boundary

Content-only files (should stay declarative):
- `scripts/content/game_data.gd`: item list, puzzle list, craft recipes, required terminal items.
- `scripts/content/map_data.gd`: world rect, wall lines, room rectangles/colors, door definitions.
- `scripts/content/story_rules.gd`: intro/objective/rules text and repair stage milestones.

Logic/system files:
- `scripts/systems/survival_system.gd`: allocation validation, turn stat formulas, HP damage, action budget.
- `scripts/systems/event_system.gd`: random event roll and stat deltas.
- `scripts/systems/ai_tutor_service.gd`: prompt templates, offline answers, API key/model persistence, response extraction.

Rule: put new constants/content in `content/*`; put reusable formulas/state transitions in `systems/*`; keep orchestration in modules/main.

## 4) Core Game Loop (Mental Model)

1. `_ready` in `main.gd`:
   - randomize RNG
   - ensure input map actions
   - setup modules and build UI
   - setup AI controller (dynamic load + fallback)
   - show start overlay

2. `_process`:
   - before mission start: only accept start input and update prompt
   - after mission start: movement + interact + AI hotkeys
   - update nearby item prompt and redraw

3. Player applies a turn:
   - validate allocation
   - apply `SurvivalSystem.apply_turn`
   - apply random event (`EventSystem.roll_event`)
   - apply active crafted module effects
   - check fail/win/turn limit
   - increment turn and reset per-turn allocation/actions

## 5) Editing Rules For AI Agents

- Do not bypass module boundaries unless refactoring intentionally.
- Preserve Vietnamese gameplay/UI strings unless task asks for localization/text rewrite.
- Keep input action names stable (`move_left/right/up/down`, `interact`, `ai_formula/risk/alloc/puzzle`).
- Avoid hardcoding duplicate formulas in modules; use `survival_system.gd`.
- If changing puzzle/item/recipe IDs or names, update dependent checks:
  - door required items
  - terminal required items
  - module effect `match` keys
- Keep AI optional: game must still run with empty API key or failed AI module load.

## 6) High-Risk Touch Points

- `main.gd::_create_ai_controller`: dynamic script load fallback; easy to break startup if changed carelessly.
- `ui_module.gd::build_ui`: many signal bindings to `main.gd` handlers; broken names mean silent UI failures.
- `gameplay_module.gd::on_apply_turn_pressed`: central turn pipeline and game-over checks.
- `world_module.gd::_crosses_wall` + door geometry logic: impacts movement between rooms.

## 7) Fast Change Recipes

- Add new random event:
  - edit `scripts/systems/event_system.gd` events array.
- Add new craft module:
  - add recipe in `scripts/content/game_data.gd`
  - add effect handling in `gameplay_module.gd::_apply_active_modules`.
- Add new puzzle:
  - append puzzle dict in `scripts/content/game_data.gd`.
- Tune survival balance:
  - edit formulas/thresholds in `scripts/systems/survival_system.gd`.
- Adjust map layout/doors:
  - edit `scripts/content/map_data.gd` and verify door orientation/start/end.

## 8) Validation Checklist After Edits

- Project launches into `main.tscn` with start overlay visible.
- Movement works (WASD/arrows), interaction works (`E`).
- Turn apply updates stats and advances turn.
- Door lock/unlock flow still works with required items.
- Puzzle panel opens/closes and updates repair progress.
- AI panel works offline with no key, and does not block gameplay.

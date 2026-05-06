# Space STEM Survival (Godot)

Prototype game built for your concept:
- exploration map + pickup items
- survival resource allocation
- STEM puzzle terminal
- AI tutor with Gemini API (`gemini-3.1-flash-lite-preview`)

## Open and run

1. Open Godot 4.x.
2. Import project folder: `D:\GameMakerProject\SpaceStemGodot`.
3. Run main scene (`res://scenes/main.tscn`).

## Controls

- Move: `W A S D`
- Interact: `E`
- AI hotkeys:
  - `H`: formula explanation
  - `J`: risk analysis
  - `K`: allocation suggestion
  - `L`: puzzle hint

## Gemini key setup

Inside the game UI:
1. Paste API key into `Paste Gemini API key here...`
2. Click `Save Key`

The key is saved to `user://gemini_api_key.txt` by Godot runtime.

## Current scope

This is an MVP foundation for coding-first development in Godot:
- single scene architecture
- one map area
- inventory + terminal gate
- multi-question STEM puzzle chain
- online/offline tutor fallback

Next expansion can add:
- multiple rooms
- richer item crafting
- dynamic puzzle generation
- narrative mission structure


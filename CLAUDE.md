# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Advanced Grappling is an **Arma 3 game mod** (SQF scripting language) that adds throwable grappling hooks and 40mm launcher rounds that integrate with the Advanced Urban Rappelling (AUR) mod. Optional ACE3 compatibility is provided via a separate addon.

## Build Commands

Uses **HEMTT** (Heavy Enhanced Modding Tool for Arma 3):

```bash
hemtt build              # Development build → /.hemttout/
hemtt build --release    # Release build → /releases/
hemtt launch             # Build and launch Arma 3 (without ACE)
hemtt launch ace         # Build and launch with ACE3
```

The VS Code default task (`Ctrl+Shift+B`) runs `hemtt build`.

There is no automated test framework. Testing is done manually using the VR test mission (`.hemtt/missions/test.VR/`), launched with the HEMTT launch commands above. The default launch mission is `zeus_test_arena.Tanoa`.

## Architecture

### Addon Structure

Three addons in `addons/`:

- **`main/`** — Mod metadata, shared macros, versioning (`script_version.hpp` defines 0.1.0), debug utilities. No game logic.
- **`grappling/`** — All core grappling hook logic: weapon/ammo configs, and 11 SQF functions. This is where most changes happen.
- **`compat_ace/`** — Thin compatibility layer. Replaces vanilla `fnc_onBisFired` with ACE-specific event handlers (`fnc_onAceFired`, `fnc_onAceThrown`). Only loads when ACE3 is present.

### Key Functions (all in `addons/grappling/functions/`)

The main flow when a grappling hook is fired:

1. `fnc_onBisFired.sqf` (or ACE equivalent) — weapon fired event → calls `fnc_spawnRope`
2. `fnc_spawnRope.sqf` — creates a hidden UAV as rope anchor, creates rope entity, calls `fnc_findRappelPoint`
3. `fnc_findRappelPoint.sqf` — terrain/object intersection tests (up to 40 raycasts) to find a valid attachment point
4. `fnc_rappelAction.sqf` / `fnc_rappel.sqf` — player initiates rappelling from rope; overrides AUR's rappel to support mid-rope start positions
5. `fnc_removeNearbyRope.sqf` — rope pickup/retraction; despawns anchor UAV and rope entity

Supporting functions: `fnc_canRappel.sqf`, `fnc_getClosestRope.sqf`, `fnc_setRopeVisibility.sqf`

### Macro & Naming Conventions

The CBA macro system is used throughout. Key macros defined via the header chain:
`script_component.hpp` → `script_mod.hpp` → `script_macros.hpp` → CBA common macros

- Functions are named `ag_COMPONENT_fnc_FUNCTION` (e.g., `ag_grappling_fnc_spawnRope`)
- `FUNC(name)` — resolves to the full function name
- `QFUNC(name)` — quoted version (used in `addAction` conditions)
- `PREP(name)` — registers function for CBA compile caching
- `PATHTOF(file)` / `QPATHTOF(file)` — resolves path to addon file

### Configuration Classes

Defined in `addons/grappling/config.cpp`:
- **CfgAmmo**: `G_Grappling_Hook` (throwable, shotShell simulation) and `G_40mm_Grappling_Hook` (launcher round) — both zero damage, 10s TTL
- **CfgMagazines**: `Grenade_Grappling_Hook` and `1Rnd_Grappling_Hook_shell`
- **CfgWeapons**: Adds `Grenade_Grappel_Muzzle` to the standard Throw weapon

### Dependencies

- **CBA_A3** — macro/event system (required)
- **Advanced Urban Rappelling** — base rappelling mechanics (required)
- **ACE3** — optional; `compat_ace` addon handles the integration
- Arma 3 2.14+ required

Workshop IDs for required mods are in `.hemtt/project.toml` under `[hemtt.launch]`.

## Version

Defined in `addons/main/script_version.hpp` via `#define MAJOR/MINOR/PATCH`. Update here when bumping version.

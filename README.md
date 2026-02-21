# Advanced Grappling

**Advanced Grappling** is an Arma 3 mod that adds throwable grappling hooks and 40mm launcher rounds to deploy ropes at range. It extends [Advanced Urban Rappelling](https://steamcommunity.com/workshop/filedetails/?id=730310357) with the ability to attach ropes to surfaces from a distance, enabling rappelling off buildings, cliffs, and other structures.

**Version:** 0.1.0

---

## Features

- **Throwable grappling hook** — hold and throw like a grenade; hooks onto nearby surfaces and drops a rope
- **40mm launcher grappling hook** — fire from any compatible grenade launcher to deploy a rope at range
- **Automatic surface detection** — up to 40 raycasts locate a valid edge or surface to attach the rope to
- **Rope rappelling** — integrates with Advanced Urban Rappelling; climb the deployed rope from any point along it
- **Rope retrieval** — pick up and reclaim your grappling hook magazine when done
- **ACE3 compatibility** — full support for ACE throwing mechanics and ACE firedPlayer events (optional)

---

## Requirements

| Mod | Steam Workshop | Notes |
|-----|---------------|-------|
| [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997) | `450814997` | Required |
| [Advanced Urban Rappelling](https://steamcommunity.com/workshop/filedetails/?id=730310357) | `730310357` | Required |
| [ACE3](https://steamcommunity.com/workshop/filedetails/?id=463939057) | `463939057` | Optional |

**Minimum Arma 3 version:** 2.14

ACE3 is fully optional. The mod detects its presence automatically and activates the compatibility layer only when ACE is loaded (see [ACE3 Compatibility](#ace3-compatibility)).

---

## Installation

1. Subscribe to **CBA_A3** and **Advanced Urban Rappelling** on the Steam Workshop.
2. Subscribe to **Advanced Grappling** on the Steam Workshop.
3. Enable all three mods in the Arma 3 launcher and launch.

---

## Items

### Throwable Grappling Hook

| Property | Value |
|----------|-------|
| Magazine class | `Grenade_Grappling_Hook` |
| Display name | Throwable Grappling Hook |
| Short name | Grappling Hook |
| Description | Throwable grappling hook with 100m rope |
| Mass | 16 |
| Count | 1 |

Added to the standard **Throw** weapon as a new muzzle (`Grenade_Grappel_Muzzle`). Appears alongside grenades and smoke in the throw selection. Throw at a rooftop, ledge, or overhang to deploy a rope.

### 40mm Grappling Hook Round

| Property | Value |
|----------|-------|
| Magazine class | `1Rnd_Grappling_Hook_shell` |
| Display name | 40 mm Grappling Hook Round |
| Short name | Grappling Hook |
| Description | 40mm grenade launcher shell that launches a grappling hook |
| Mass | 14 |
| Initial speed | 45 m/s |
| Count | 1 |

Compatible with all **CBA_40mm_M203** and **UGL_40x36** magazine well weapons (M320, M203, EGLM, etc.). Fire at a surface to deploy a rope at range.

Both variants deal **zero damage** and have a **10-second time to live** in flight.

---

## How It Works

### Deploying a Rope

1. Throw or fire the grappling hook at a surface.
2. The projectile travels to the target.
3. On landing, the mod performs up to **40 raycasts** around the impact point to find a valid attachment edge (rooftop ledge, wall top, cliff edge, etc.) within 1.5 m.
4. If a surface is found, an invisible anchor is placed at the attachment point and a rope is created, hanging down to the player's position.
5. If no surface is found (e.g. thrown into open air), the rope falls to the ground at the projectile's landing position.

### Player Actions

Two scroll-wheel actions appear when near a deployed rope:

| Action | Condition | What it does |
|--------|-----------|--------------|
| **Climb rope** | Rope is attached to a surface, player not already rappelling | Initiates rappelling via Advanced Urban Rappelling |
| **Pick up rope** | Any rope is nearby, player not rappelling | Retracts the rope and returns the magazine to inventory |

"Climb rope" is only available for **attached** ropes (those that found a valid surface). Unattached ropes (fallen on the ground) can only be picked up.

### Rope Retrieval

Approaching a deployed rope and selecting **Pick up rope** (scroll wheel) destroys the rope and returns the grappling hook magazine to your inventory, so you can reuse it.

---

## ACE3 Compatibility

When ACE3 is loaded alongside this mod, the `compat_ace` PBO activates automatically. Without ACE3, this PBO is skipped entirely by the engine — no configuration is required.

### What changes with ACE3

| Behaviour | Without ACE3 | With ACE3 |
|-----------|-------------|-----------|
| Throw event | CBA `fired` BIS player event | `ace_throwableThrown` event |
| Launcher event | CBA `fired` BIS player event | `ace_firedPlayer` event |
| ACE advanced throwing | Not applicable | Supported — prime mode is detected and ignored correctly |

The ACE compat layer replaces the vanilla fired event handler with ACE's equivalent events, enabling correct interaction with ACE's advanced throwing system (hold to aim, pull pin, etc.).

### Technical detail

The `compat_ace` addon lists `ace_main` in `requiredAddons`. Arma 3's engine skips the entire PBO at startup if `ace_main` is absent, making the ACE integration truly optional with no runtime overhead.

---

## For Developers

### Build System

This project uses [HEMTT](https://github.com/BrettMayson/HEMTT):

```bash
hemtt build              # Development build → /.hemttout/
hemtt build --release    # Release build → /releases/
hemtt launch             # Build and launch Arma 3 (without ACE)
hemtt launch ace         # Build and launch with ACE3
```

The VS Code default task (`Ctrl+Shift+B`) runs `hemtt build`.

### Testing

There is no automated test framework. Testing is done manually using the VR test mission (`.hemtt/missions/test.VR/`), launched via the HEMTT launch commands above. The default mission is `zeus_test_arena.Tanoa`.

### Addon Structure

| Addon | Purpose |
|-------|---------|
| `main` | Mod metadata, shared macros, versioning |
| `grappling` | All core logic: configs, 11 SQF functions |
| `compat_ace` | ACE3 event handler replacement (only loads with ACE) |

### Key Functions (`addons/grappling/functions/`)

| Function | Description |
|----------|-------------|
| `fnc_onBisFired` | Vanilla fired event → calls `fnc_spawnRope` |
| `fnc_spawnRope` | Creates anchor UAV and rope entity, calls `fnc_findRappelPoint` |
| `fnc_findRappelPoint` | Up to 40 raycasts to locate a valid attachment edge |
| `fnc_rappelAction` | Entry point for "Climb rope" action |
| `fnc_rappel` | Overrides AUR rappel to support mid-rope start positions |
| `fnc_removeNearbyRope` | Rope pickup — despawns anchor and returns magazine |
| `fnc_canClimb` | Condition: rope nearby + anchor attached to surface |
| `fnc_canPickup` | Condition: rope nearby |
| `fnc_getClosestRope` | Finds nearest rope segment within 2 m |
| `fnc_setRopeVisibility` | Shows/hides rope segments (used during rappelling) |

### Recommended VS Code Extensions

- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [SQFLint](https://marketplace.visualstudio.com/items?itemName=skacekachna.sqflint)
- [SQF Language](https://marketplace.visualstudio.com/items?itemName=Armitxes.sqf)
- [psioniq File Header](https://marketplace.visualstudio.com/items?itemName=psioniq.psi-header)

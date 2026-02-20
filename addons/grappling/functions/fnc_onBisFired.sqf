#include "..\script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

// only handle events for ammo fired from this package
if (_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {};

// track the projectile updates on a separate thread
[_unit, _projectile, _magazine] spawn FUNC(spawnRope);

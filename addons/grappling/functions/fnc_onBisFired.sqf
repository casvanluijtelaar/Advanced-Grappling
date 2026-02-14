#include "..\script_component.hpp"
/*
 * fn_addEventHandlers.sqf
 *
 * Adds grappling event handlers to a unit.
 * Called by postInit for the initial player and by the "Respawn" EH for new player objects.
 */

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

// only handle events for ammo fired from this package
if (_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {};

// ignore when not fired on foot
if (vehicle _unit != _unit) exitWith {};

// track the projectile updates on a separate thread
[_unit, _projectile] spawn FUNC(spawnRope);

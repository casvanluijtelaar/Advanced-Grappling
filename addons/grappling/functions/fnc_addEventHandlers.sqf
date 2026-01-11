#include "..\script_component.hpp"
/*
 * fn_addEventHandlers.sqf
 *
 * Adds grappling event handlers to a unit.
 * Called by postInit for the initial player and by the "Respawn" EH for new player objects.
 */

params ["_unit"];

_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    // only handle events for ammo fired from this package
    if (_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {};

    // ignore when not fired on foot
    if (vehicle _unit != _unit) exitWith {};

    // track the projectile updates on a separate thread
    [_unit, _projectile] spawn FUNC(spawnRope);
}];

_unit addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];
    [_unit] call FUNC(addEventHandlers);
}];

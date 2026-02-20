#include "script_component.hpp"
/*
 * fnc_onAceThrown.sqf
 *
 * Handles the ace_throwableThrown event for grappling hooks.
 */
params ["_unit", "_activeThrowable"];

private _magazine = typeOf _activeThrowable;

// only handle events for ammo fired from this package
if (_magazine != "G_40mm_Grappling_Hook" && _magazine != "G_Grappling_Hook" && _magazine != "Grenade_Grappling_Hook") exitWith {};

// track the projectile updates on a separate thread
[_unit, _activeThrowable, _magazine] spawn EFUNC(grappling,spawnRope);

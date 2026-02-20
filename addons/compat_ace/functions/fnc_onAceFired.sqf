#include "script_component.hpp"

/*
 * fnc_onAceFired.sqf
 *
 * Handles the ace_firedPlayer event for grappling hooks.
 */
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

// if the fired event triggered on an ace grenade prime, ignore it
if(_unit getVariable ["ace_advanced_throwing_primed", false]) exitWith {};

// only handle events for ammo fired from this package
if (_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {};

// track the projectile updates on a separate thread
[_unit, _projectile, _magazine] spawn EFUNC(grappling,spawnRope);

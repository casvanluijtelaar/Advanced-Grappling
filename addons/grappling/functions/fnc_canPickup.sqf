#include "script_component.hpp"

/*
 * fnc_canPickup.sqf
 *
 * Condition check for the "Pick up rope" action.
 * True whenever a rope is nearby and the unit is not rappelling.
 */

params ["_unit"];

if (_unit getVariable ["AUR_Is_Rappelling", false]) exitWith { false };

private _ropeData = [_unit] call FUNC(getClosestRope);

count _ropeData > 0

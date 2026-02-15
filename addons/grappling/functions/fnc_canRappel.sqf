#include "script_component.hpp"

/*
 * fnc_canRappel.sqf
 *
 * Condition check for grappling actions (Remove/Rappel).
 * Checks if the unit is not already rappelling and if there's a rope nearby.
 */

params ["_unit"];

if (_unit getVariable ["AUR_Is_Rappelling", false]) exitWith { false };

private _ropeData = [_unit] call FUNC(getClosestRope);

count _ropeData > 0

#include "script_component.hpp"

/*
 * fnc_canClimb.sqf
 *
 * Condition check for the "Climb rope" action.
 * Requires a nearby rope whose anchor is attached to a surface.
 */

params ["_unit"];

if (_unit getVariable ["AUR_Is_Rappelling", false]) exitWith { false };

private _ropeData = [_unit] call FUNC(getClosestRope);
if (count _ropeData == 0) exitWith { false };

(_ropeData select 0) getVariable ["AG_is_Attached", false]

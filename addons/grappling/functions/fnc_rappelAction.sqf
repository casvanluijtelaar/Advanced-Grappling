#include "script_component.hpp"

/*
 * fnc_rappelAction.sqf
 *
 * Finds the closest rope segment and prints its location.
 */

params ["_player"];

private _ropeData = [_player] call FUNC(getClosestRope);

if (count _ropeData > 0) then {
    _ropeData params ["_anchor", "_closestPos"];
    systemChat format ["Closest rope segment at: %1", _closestPos];
} else {
    systemChat "No rope nearby to rappel.";
};

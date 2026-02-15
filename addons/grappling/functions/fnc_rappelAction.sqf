#include "script_component.hpp"

/*
 * fnc_rappelAction.sqf
 *
 * Finds the closest rope segment and starts the rappel process.
 */

params ["_player"];

private _ropeData = [_player] call FUNC(getClosestRope);

if (count _ropeData > 0) then {
    _ropeData params ["_anchor", "_closestPos"];
    
    private _rappelPoint = getPosASL _anchor;
    private _rappelDirection = _anchor getVariable ["AG_Grapple_Direction", [0,1,0]];
    private _ropeLength = _anchor getVariable ["AG_Grapple_Length", 100];
    
    [_player, _rappelPoint, _rappelDirection, _ropeLength, _closestPos] call FUNC(rappel);
} else {
    systemChat "No rope nearby to rappel.";
};

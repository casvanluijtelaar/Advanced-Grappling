#include "script_component.hpp"

/*
 * fnc_setRopeVisibility.sqf
 *
 * Sets the visibility of all ropes attached to an anchor globally.
 */

params ["_anchor", "_visible"];

if (isNull _anchor) exitWith {};

{
    private _rope = _x;
    if (!isNull _rope) then {
        {
            if (!isNull _x) then {
                [_x, !_visible] remoteExec ["hideObjectGlobal", 0];
            };
        } forEach ropeSegments _rope;
    };
} forEach ropes _anchor;

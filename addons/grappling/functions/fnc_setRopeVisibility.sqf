#include "script_component.hpp"

/*
 * fnc_setRopeVisibility.sqf
 *
 * Sets the visibility of all ropes attached to an anchor globally.
 */

params ["_anchor", "_visible"];

if (isNull _anchor) exitWith {};

// Ropes and their segments are often only accessible on the machine that owns the anchor.
if (!local _anchor) exitWith {
    _this remoteExec [QFUNC(setRopeVisibility), _anchor];
};

{
    private _rope = _x;
    if (!isNull _rope) then {
        {
            // Execute hideObjectGlobal from the server so it propagates reliably to all clients.
            if (!isNull _x) then {
                [_x, !_visible] remoteExec ["hideObjectGlobal", 2];
            };
        } forEach ropeSegments _rope;
    };
} forEach ropes _anchor;

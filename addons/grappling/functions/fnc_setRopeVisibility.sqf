#include "script_component.hpp"

/*
 * fnc_setRopeVisibility.sqf
 *
 * Sets the visibility of all ropes attached to an anchor globally.
 */

params ["_anchor", "_visible"];

{
    private _rope = _x;
    {
        [_x, !_visible] remoteExec ["hideObjectGlobal", 2];
    } forEach ropeSegments _rope;
} forEach ropes _anchor;

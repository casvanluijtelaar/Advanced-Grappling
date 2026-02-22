#include "script_component.hpp"

/*
 * fnc_setRopeVisibility.sqf
 *
 * Sets the visibility of all ropes attached to an anchor globally.
 */

params ["_anchor", "_visible"];

if (isNull _anchor) exitWith {};

// Ropes created with ropeCreate are local to the machine that created them.
// Run on the anchor owner so that hideObject applies to their local rope instances.
if (!local _anchor) exitWith {
    _this remoteExec [QFUNC(setRopeVisibility), _anchor];
};

{
 [_x, !_visible] remoteExec ["hideObjectGlobal", 0];
} forEach ropes _anchor;

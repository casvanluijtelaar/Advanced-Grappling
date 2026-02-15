#include "script_component.hpp"

/*
 * fnc_getFacingRope.sqf
 *
 * Returns the nearest grappling anchor where at least one rope segment is within 2m of the unit.
 * Scans all anchors within 20m (2D) to find the actual closest one.
 * Returns objNull if no such rope exists.
 */

params ["_unit"];

private _unitPos = getPosASL _unit;
private _nearbyAnchors = nearestObjects [_unit, ["B_static_AA_F"], 20, true] select { _x getVariable ["AG_is_Grappling_Anchor", false] };
if (count _nearbyAnchors == 0) exitWith { objNull };

private _closestAnchor = objNull;
private _minDistance = 2; // Maximum distance to consider

{
    private _anchor = _x;
    {
        private _rope = _x;
        {
            private _dist = (getPosASL _x) distance _unitPos;
            if (_dist < _minDistance) then {
                _minDistance = _dist;
                _closestAnchor = _anchor;
            };
        } forEach (ropeSegments _rope);
    } forEach (ropes _anchor);
} forEach _nearbyAnchors;

_closestAnchor

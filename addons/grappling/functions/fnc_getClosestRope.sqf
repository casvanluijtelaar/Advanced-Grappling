#include "script_component.hpp"

/*
 * fnc_getClosestRope.sqf
 *
 * Returns the nearest grappling anchor and the position of the closest segment.
 * Scans all anchors within 20m (2D) to find the actual closest one within 2m.
 * Returns [] if no such rope exists.
 */

params ["_unit"];

private _unitPos = getPosASL _unit;
private _nearbyAnchors = nearestObjects [_unit, ["B_UAV_01_F"], 20, true] select {
    (_x getVariable ["AG_is_Grappling_Anchor", false]) &&
    !(_x getVariable ["AG_is_Being_Used", false])
};
if (_nearbyAnchors isEqualTo []) exitWith { [] };

private _closestAnchor = objNull;
private _closestPos = [0,0,0];
private _minDistance = 2; // Maximum distance to consider

{
    private _anchor = _x;
    {
        private _rope = _x;
        {
            private _segmentPos = getPosASL _x;
            private _dist = _segmentPos distance _unitPos;
            if (_dist < _minDistance) then {
                _minDistance = _dist;
                _closestAnchor = _anchor;
                _closestPos = _segmentPos;
            };
        } forEach (ropeSegments _rope);
    } forEach (ropes _anchor);
} forEach _nearbyAnchors;

if (isNull _closestAnchor) exitWith { [] };

[_closestAnchor, _closestPos]

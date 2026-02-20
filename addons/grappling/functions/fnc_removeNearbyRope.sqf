#include "script_component.hpp"

/*
 * fnc_removeNearbyRope.sqf
 *
 * Finds the nearest grappling anchor the player is facing and removes it.
 */

params ["_player"];

private _ropeData = [_player] call FUNC(getClosestRope);

if (count _ropeData > 0) then {
    _ropeData params ["_anchor", "_closestPos"];

    // Return magazine to player
    private _magazine = _anchor getVariable ["AG_Grapple_Magazine", ""];
    if (_magazine != "") then {
        systemChat format ["returning magazine %1", _magazine];
        _player addMagazine _magazine;
    };

    // Destroy ropes attached to this anchor
    private _ropes = ropes _anchor;
    {
        ropeDestroy _x;
    } forEach _ropes;

    // Delete the anchor object
    deleteVehicle _anchor;
};

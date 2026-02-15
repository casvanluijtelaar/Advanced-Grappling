#include "script_component.hpp"

/*
 * fnc_removeNearbyRope.sqf
 *
 * Finds the nearest grappling anchor the player is facing and removes it.
 */

params ["_player"];

private _anchor = [_player] call FUNC(getFacingRope);

if (!isNull _anchor) then {
    // Destroy ropes attached to this anchor
    private _ropes = ropes _anchor;
    {
        ropeDestroy _x;
    } forEach _ropes;
    
    // Delete the anchor object
    deleteVehicle _anchor;
} else {
    // Fallback just in case, though the action condition should prevent this
    // systemChat "No grappling rope in front of you.";
};

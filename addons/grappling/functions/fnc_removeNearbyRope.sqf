#include "script_component.hpp"

/*
 * fnc_removeNearbyRope.sqf
 *
 * Finds the nearest grappling anchor and removes it along with any attached ropes.
 */

params ["_player"];

// Find nearby anchors within 5 meters
private _nearbyAnchors = nearestObjects [_player, ["B_static_AA_F"], 5] select { _x getVariable ["AG_is_Grappling_Anchor", false] };

if (count _nearbyAnchors > 0) then {
    private _nearestAnchor = _nearbyAnchors select 0;
    
    // Destroy ropes attached to this anchor
    private _ropes = ropes _nearestAnchor;
    {
        ropeDestroy _x;
    } forEach _ropes;
    
    // Delete the anchor object
    deleteVehicle _nearestAnchor;
    
    // Optional: Feedback
    // systemChat "Grappling rope removed.";
} else {
    // systemChat "No grappling rope nearby to remove.";
};

#include "script_component.hpp"

/*
 * Tracks a grappling hook projectile in flight, then creates a permanent rope
 * anchored to the nearest valid surface at the landing position.
 * If no surface is found, the rope falls freely from the landing point.
 */

params ["_player","_projectile", "_magazine"];

// Create a temporary hidden UAV to follow the projectile and carry a visual rope during flight.
_hook = createVehicle ["B_UAV_01_F", _player, [], 0, "CAN_COLLIDE"];
hideObject _hook;
[_hook] remoteExec ["hideObjectGlobal", 2];
_hook allowDamage false;
[[_hook],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// Attach a visual rope to the tracking hook so the rope appears to trail during flight.
_rope = ropeCreate [_hook, [0,0,0], 100];
_rope allowDamage false;

// Each frame, move the tracking hook to the projectile position until it disappears (lands/expires).
_finalProjectilePos = getPosASL _player;

waitUntil {
	if (isNull _projectile) exitWith {true};
	_finalProjectilePos = getPosASL _projectile;
    _hook setPosWorld _finalProjectilePos;
	false;
};

// Projectile has landed — destroy the temporary visual rope and tracking hook.
ropeDestroy _rope;
deleteVehicle _hook;

// Search for a valid surface attachment point near the landing position.
_grappelData = [_finalProjectilePos, "POSITION"] call FUNC(findRappelPoint);

private _isAttached = true;
private _grappelPoint = [0,0,0];
private _grappelDirection = [0,0,0];

if (count _grappelData == 0) then {
    _isAttached = false;
    _grappelPoint = _finalProjectilePos;
} else {
    _grappelPoint = _grappelData select 0;
    _grappelDirection = _grappelData select 1;
};

// Rope length is just shortest path between _grappelPoint and player, with some extra buffer
_ropeLength = (_grappelPoint distance getPosASL _player) + 5;

// Create the permanent anchor. Starts at the player position so the rope
// can be created stretched downward, then moved to the grapple point.
_anchor = createVehicle ["B_UAV_01_F", _player, [], 0, "CAN_COLLIDE"];
_anchor allowDamage false;
hideObject _anchor;
[_anchor] remoteExec ["hideObjectGlobal", 2];
[[_anchor],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// Create a temporary object at the player so ropeCreate stretches the rope downward.
// Without this, the rope would collapse at the anchor position before being moved.
_tempTarget = createVehicle ["Land_Can_V2_F", _player, [], 0, "CAN_COLLIDE"];
_tempTarget allowDamage false;
hideObject _tempTarget;
[_tempTarget] remoteExec ["hideObjectGlobal", 2];
[[_tempTarget],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// Create the permanent rope while the anchor is still at the player position.
// Simulation must be enabled at this point for rope segments to render correctly.
_permRope = ropeCreate [_anchor, [0, 0, 0], _tempTarget, [0, 0, 0], _ropeLength];
_permRope allowDamage false;

// Move the anchor to the grapple point now that the rope segments are initialized.
_anchor setPosWorld _grappelPoint;

// Attached: anchor stays in place with simulation enabled (segments already rendered).
// Unattached: disable engine sound and let the anchor fall to the ground.
if (!_isAttached) then {
    hintSilent "Hook did not attach properly";
    _anchor engineOn false;
    _anchor setDamage 0.95;
    _anchor setFuel 0;
};

// Store metadata on the anchor for use by rappel and pickup functions.
_anchor setVariable ["AG_is_Grappling_Anchor", true, true];
_anchor setVariable ["AG_is_Attached", _isAttached, true];
_anchor setVariable ["AG_Grapple_Direction", _grappelDirection, true];
_anchor setVariable ["AG_Grapple_Length", _ropeLength, true];
_anchor setVariable ["AG_Grapple_Magazine", _magazine, true];

// Remove the temp target — rope end is now free-hanging at the player's position.
deleteVehicle _tempTarget;

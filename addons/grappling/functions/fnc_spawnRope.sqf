#include "script_component.hpp"

/*
 * place a rope from the player position to the provided _projectile
 */

params ["_player","_projectile", "_magazine"];

// create hidden vehicle that we can attach a rope to.
_hook = createVehicle ["B_UAV_01_F", _player, [], 0, "CAN_COLLIDE"];
hideObject _hook;
hideObjectGlobal _hook;
_hook allowDamage false;
[[_hook],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// attach a rope to the hook
_rope = ropeCreate [_hook, [0,0,0], 100];
_rope allowDamage false;

// update the hook position to match the projectile position
_finalProjectilePos = getPosASL _player;

waitUntil {
	if (isNull _projectile) exitWith {true};
	_finalProjectilePos = getPosASL _projectile;
    _hook setPosWorld _finalProjectilePos;
	false;
};

// initial rope was only for visuals, we need to destroy it when replaced
// with the advanced_urban_rappelling rope
ropeDestroy _rope;
deleteVehicle _hook;

// find a rappelpoint near heighest point of the rope
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

// create a new anchor at the player.
_anchor = createVehicle ["B_UAV_01_F", _player, [], 0, "CAN_COLLIDE"];
_anchor allowDamage false;
hideObject _anchor;
hideObjectGlobal _anchor;
[[_anchor],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// Create a temporary target at the player to pull the rope to them
_tempTarget = createVehicle ["Land_Can_V2_F", _player, [], 0, "CAN_COLLIDE"];
_tempTarget allowDamage false;
hideObject _tempTarget;
hideObjectGlobal _tempTarget;
[[_tempTarget],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// Create the rope between anchor and temp target
// This ensures the rope is "stretched" to the player at creation
_permRope = ropeCreate [_anchor, [0, 0, 0], _tempTarget, [0, 0, 0], _ropeLength];
_permRope allowDamage false;

// Now move the anchor to the grapple point
_anchor setPosWorld _grappelPoint;

// If attached: freeze anchor in place (simulation must be enabled during ropeCreate for segments to render)
// If not attached: let anchor fall with physics
if (!_isAttached) then {
    hint "Hook did not attach properly";
    _anchor setFuel 0;
    _anchor setDamage 0.95;
};

// store information in the anchor so we can reuse it later
_anchor setVariable ["AG_is_Grappling_Anchor", true, true];
_anchor setVariable ["AG_is_Attached", _isAttached, true];
_anchor setVariable ["AG_Grapple_Direction", _grappelDirection, true];
_anchor setVariable ["AG_Grapple_Length", _ropeLength, true];
_anchor setVariable ["AG_Grapple_Magazine", _magazine, true];

// Delete the temp target to leave the rope free-ended at the player's position
deleteVehicle _tempTarget;

#include "script_component.hpp"

/*
 * place a rope from the player position to the provided _projectile
 */

params ["_player","_projectile"];

// create hidden vehicle that we can attach a rope to.
_hook = createVehicle ["B_static_AA_F", _player, [], 0, "CAN_COLLIDE"];
hideObject _hook;
hideObjectGlobal _hook;
_hook allowDamage false;
[[_hook],"AUR_Hide_Object_Global"] call AUR_RemoteExecServer;

// attach a rope to the hook
_rope = ropeCreate [_hook, [0,0,0], 100];
_rope allowDamage false;

// update the hook position to match the projectile position
waitUntil {
	if (isNull _projectile) exitWith {true};
	_hook setPosWorld getPosASL _projectile;
	false;
};

// find the highest rope segment position
_highestSegmentPos = [0, 0, 0];
{
	_segmentPos = getPosASL _x;
	if ((_segmentPos select 2) > (_highestSegmentPos select 2)) then {
		_highestSegmentPos = _segmentPos;
	};

} forEach ropeSegments _rope;

// initial rope was only for visuals, we need to destroy it when replaced
// with the advanced_urban_rappelling rope
ropeDestroy _rope;
deleteVehicle _hook;

// find a rappelpoint near heighest point of the rope
_grappelData = [_highestSegmentPos, "POSITION"] call FUNC(findRappelPoint);
if(count _grappelData == 0) exitWith {false;};
_grappelPoint = _grappelData select 0;
_grappelDirection = _grappelData select 1;

// Calculate distance and positions
_playerPos = getPosASL _player;
_ropeLength = _grappelPoint distance _playerPos;

// Create anchor at player (matching existing patterns)
_anchor = createVehicle ["B_static_AA_F", _player, [], 0, "CAN_COLLIDE"];
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

// Delete the temp target to leave the rope free-ended at the player's position
deleteVehicle _tempTarget;

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

// if player is already rappelling they should not be able to start another one
if(_player getVariable ["AUR_Is_Rappelling",false])  exitWith {false};

// find a rappelpoint near heighest point of the rope
_grappelData = [_highestSegmentPos, "POSITION"] call FUNC(findRappelPoint);
if(count _grappelData == 0) exitWith {false;};
_grappelPoint = _grappelData select 0;
_grappelDirection = _grappelData select 1;

// if the grappel point is more than 20 meters away in the horizontal direction
// cancel the grappeling
if((_player distance2D _grappelPoint) > 20) exitWith {false;};


// start the advanced urbanced urban rappelling
_ropeLength = (getPosASL _player) distance _grappelPoint;
[_player, _grappelPoint, _grappelDirection, _ropeLength] call FUNC(rappel);

nil

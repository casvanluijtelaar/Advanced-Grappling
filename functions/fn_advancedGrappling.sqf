
// place a rope from the _player position to the projectile
AOW_Spawn_Rope = {
	params ["_projectile"];

	// create hidden vegicle that we can attach a rope to.
	_hook = createVehicle ["B_static_AA_F", player, [], 0, "CAN_COLLIDE"];
	hideObject _hook;
	hideObjectGlobal _hook;
	_hook allowDamage false;

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
	if(player getVariable ["AUR_Is_Rappelling",false])  exitWith {false};

	// find a rappelpoint near heighest point of the rope
	_grappelData = [_highestSegmentPos, "POSITION"] call AOW_Find_Rappel_Point;
	if(count _grappelData == 0) exitWith {false;};
	_grappelPoint = _grappelData select 0;
	_grappelDirection = _grappelData select 1;

    // if the grappel point is more than 20 meters away in the horizontal direction
	// cancel the grappeling
	if((player distance2D _grappelPoint) > 20) exitWith {false;};


	// start the advanced urbanced urban rappelling
	_ropeLength = (getPosASL player) distance _grappelPoint;
	[player, _grappelPoint, _grappelDirection, _ropeLength] call AOW_Rappel;
};

// register event handlers for [player]
AOW_Add_Player_Event_Handlers = {
	params ["_player"];

	_player addEventHandler ["Fired", {
		private _ammo = _this select 4;
		private _projectile = _this select 6;

		// only handle events for ammo fired from this package
		if(_ammo != "G_40mm_GRAPPEL" && _ammo != "G_GRAPPEL") exitWith {false;};

		// ignore when not fired on foot
		if(vehicle _player != _player) exitWith {false;};

		// track the projectile updates on a separate thread
		[_projectile] spawn AOW_Spawn_Rope;
	}];
};


// initialize event handlers for all real players
if(!isDedicated) then {
	if(!isNull player && isPlayer player) then {
		[player] call AOW_Add_Player_Event_Handlers;
	};
};
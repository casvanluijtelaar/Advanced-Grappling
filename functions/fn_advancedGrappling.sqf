
// place a rope from the _player position to the projectile
AOW_Spawn_Rope = {
	params ["_projectile"];

	// update projectile position until it despawns
	_projectTilePos = getPosASL _projectile;

	// create hidden vegicle that we can attach a rope to.
	_hook = createVehicle ["B_static_AA_F", player, [], 0, "CAN_COLLIDE"];
	hideObject _hook;
	hideObjectGlobal _hook;
	_hook allowDamage false;

	// attach a rope to the hook
	_rope = ropeCreate [_hook, [0,0,0], 5];
	_rope allowDamage false;


	waitUntil {
		// update projectile position until it despawns
		if (isNull _projectile) exitWith {true};
		_projectTilePos = getPosASL _projectile;
		_hook setPosWorld _projectTilePos;


		// set the ropelength as the distance between the player and the 
		// projectile with 10 meters slack.
		_distanceBetweenPlayerAndProjectile = player distance _projectTilePos;
		ropeUnwind [_rope, 20, _distanceBetweenPlayerAndProjectile, false];

		false;
	};

	// initial rope was only for visuals, we need to destroy it when replaced 
	// with the advanced_urban_rappelling rope
	ropeDestroy _rope;

	// if player is already rappelling they should not be able to start another one
	if(player getVariable ["AUR_Is_Rappelling",false])  exitWith {false};

	// find a rappelpoint near the impact location of the grappling hook 
	_grappelData = [_projectTilePos, "POSITION"] call AOW_Find_Rappel_Point;
	if(count _grappelData == 0) exitWith {false;};
	_grappelPoint = _grappelData select 0;
	_grappelDirection = _grappelData select 1;

    // if the grappel point is more than 20 meters away in the horizontal direction
	// cancel the grappeling
	if((player distance2D _grappelPoint) > 20) exitWith {false;};
	
	// start the advanced urbanced urban rappelling with a ropelength that is
	// slightly longer than the vertical height
	_ropeLength = (_grappelPoint select 2) * 1.3;
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
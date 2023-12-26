
// Exit on Headless
if (!hasInterface) exitWith {};

[] spawn {
	while {true} do {

		
		if(!isNull player && isPlayer player) then {
			if!(player getVariable ["AOW_EventHandlers_Loaded",false] ) then {

				// reset grappling on respawn
				player addEventHandler ["Respawn", {
					player setVariable ["AOW_EventHandlers_Loaded",false];
				}];

				// register fired event handler to detect grappling launch
				player addEventHandler ["Fired", {
					private _ammo = _this select 4;
					private _projectile = _this select 6;

					// only handle events for ammo fired from this package
					if(_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {false;};

					// ignore when not fired on foot
					if(vehicle player != player) exitWith {false;};

					// track the projectile updates on a separate thread
					[_projectile] spawn AOW_fnc_spawnRope;
				}];

				player setVariable ["AOW_EventHandlers_Loaded",true];
			};
		};
		sleep 5;
	};
};

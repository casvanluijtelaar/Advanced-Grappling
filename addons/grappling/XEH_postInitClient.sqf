#include "script_component.hpp"

["ace_firedPlayer", {
    systemChat "fired triggered";

    // only handle events for ammo fired from this package
    if (_ammo != "G_40mm_Grappling_Hook" && _ammo != "G_Grappling_Hook") exitWith {false;};

    systemChat "ammo triggered";

    // track the projectile updates on a separate thread
    [_unit, _projectile] spawn FUNC(spawnRope);
}] call CBA_fnc_addEventHandler;

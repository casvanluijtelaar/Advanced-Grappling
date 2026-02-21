#include "script_component.hpp"

["AG_FiredEvent", "fired", FUNC(onBisFired)] call CBA_fnc_addBISPlayerEventHandler;


player addAction [
    "Climb rope",
    {
        [player] call FUNC(rappelAction);
    },
    nil,
    1.5,
    false,
    true,
    "",
    format ["[_this] call %1", QFUNC(canClimb)]
];


player addAction [
    "Pick up rope",
    {
        [player] call FUNC(removeNearbyRope);
    },
    nil,
    1.5,
    false,
    true,
    "",
    format ["[_this] call %1", QFUNC(canPickup)]
];

#include "script_component.hpp"

["TAG_AgFiredEvent", "fired", FUNC(onBisFired)] call CBA_fnc_addBISPlayerEventHandler;


player addAction [
    "Climb Rope",
    {
        [player] call FUNC(rappelAction);
    },
    nil,
    1.5,
    false,
    true,
    "",
    format ["[_this] call %1", QFUNC(canRappel)]
];


player addAction [
    "Remove Rope",
    {
        [player] call FUNC(removeNearbyRope);
    },
    nil,
    1.5,
    false,
    true,
    "",
    format ["[_this] call %1", QFUNC(canRappel)]
];

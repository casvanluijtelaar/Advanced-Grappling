#include "script_component.hpp"

["TAG_AgFiredEvent", "fired", FUNC(onBisFired)] call CBA_fnc_addBISPlayerEventHandler;

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
    format ["count ([_this] call %1) > 0", QFUNC(getClosestRope)]
];

player addAction [
    "Rappel",
    {
        [player] call FUNC(rappelAction);
    },
    nil,
    1.5,
    false,
    true,
    "",
    format ["count ([_this] call %1) > 0", QFUNC(getClosestRope)]
];

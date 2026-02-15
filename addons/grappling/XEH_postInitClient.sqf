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
    "(nearestObjects [player, ['B_static_AA_F'], 5] findIf { _x getVariable ['AG_is_Grappling_Anchor', false] }) != -1"
];

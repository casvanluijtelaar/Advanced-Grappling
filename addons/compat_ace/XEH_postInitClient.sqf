#include "script_component.hpp"


hasACE = (!isNil "ace_common_fnc_isModLoaded");

if (hasACE) then {
    ["ace_firedPlayer", FUNC(onAceFired)] call CBA_fnc_addEventHandler;
    ["TAG_AgFiredEvent"] call CBA_fnc_removeBISPlayerEventHandler;
};

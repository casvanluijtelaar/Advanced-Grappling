#include "script_component.hpp"


hasACE = (!isNil "ace_common_fnc_isModLoaded");

if (hasACE) then {
    ["ace_throwableThrown", FUNC(onAceThrown)] call CBA_fnc_addEventHandler;
    ["ace_firedPlayer", FUNC(onAceFired)] call CBA_fnc_addEventHandler;
    ["AG_FiredEvent"] call CBA_fnc_removeBISPlayerEventHandler;
};

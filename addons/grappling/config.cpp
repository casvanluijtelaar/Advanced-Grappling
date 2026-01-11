#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
		weapons[] = { "Throw" };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ag_main",
            "AUR_AdvancedUrbanRappelling",
            "A3_weapons_F"
        };
        author = "supercas240";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"

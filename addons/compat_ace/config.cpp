#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ag_grappling",
            "ace_main"
        };
        author = "supercas240";
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"

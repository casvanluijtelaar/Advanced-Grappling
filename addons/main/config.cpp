class CfgPatches
{
	class ADDON 
	{
		author = "supercas240";
		name = "ADDON";
		units[] = {"AOW_AdvancedGrappling"};
		requiredVersion = 1.0;
		requiredAddons[] = {"AUR_AdvancedUrbanRappelling", "A3_weapons_F"};
		weapons[] = {"Grenade_Grappel_Throw"};
	};
};

class CfgFunctions
{
	class advanced_grappling
	{
		class advancedGrappling
		{
			preStart = 1;
		};

        class advancedUrbanRappellingOverrides;
	};
};

#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"
class CfgPatches
{
	class AOW_AdvancedGrappling
	{
		author = "supercas240";
		name = "Advanced Grappling";
		url = "https://github.com/casvanluijtelaar";
		units[] = {"AOW_AdvancedGrappling"};
		requiredVersion = 1.0;
		requiredAddons[] = {"AUR_AdvancedUrbanRappelling", "A3_weapons_F"};
		weapons[] = {"Grenade_Grappel_Throw"};
	};
};

class CfgFunctions
{
	class SA
	{
		class AdvancedGrappling
		{
			file = "\AOW_AdvancedGrappling\functions";
			class advancedGrappling
			{
				postInit = 1;
			};
			class advancedUrbanRappellingOverrides
			{
				postInit = 1;
			};
		};
	};
};

#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"
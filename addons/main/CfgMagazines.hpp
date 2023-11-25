class CfgMagazines
{
	class 1Rnd_HE_Grenade_shell;
	class 1Rnd_Grappling_Hook_shell : 1Rnd_HE_Grenade_shell
	{
		author = "supercas240";
		scope = 2;
		type = 16;
		displayName = "40mm Grappling Hook Round";
		displayNameShort = "Grappling Hook";
		ammo = "G_40mm_Grappling_Hook";
		picture = "x\advanced_grappling\addons\main\data\grappling_hook_slug_ca.paa";
		modelSpecial = "\a3\Weapons_F\MagazineProxies\mag_40x36_HE_1rnd.p3d";
		initSpeed = 80;
		count = 1;
		nameSound = "";
		descriptionShort = "40mm grenade launcher shell that launches a grappling hook";
		mass = 4;
		modelSpecialIsProxy = 1;
		deleteIfEmpty = 0;
	};

	class HandGrenade;
	class Grenade_Grappling_Hook : HandGrenade
	{
		author = "supercas240";
		scope = 2;
		displayName = "Throwable Grappling Hook";
		displayNameShort = "Grappling Hook";
		ammo = "G_Grappling_Hook";
		picture = "x\advanced_grappling\addons\main\data\grappling_hook_ca.paa";
		model = "\A3\weapons_f\ammo\flare_white";
		descriptionShort = "Throwable grappling hook with 100m rope";
		mass = 8;
		deleteIfEmpty = 0;
	};
};
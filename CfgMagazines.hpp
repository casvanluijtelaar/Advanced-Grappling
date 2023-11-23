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
		picture = "\A3\Weapons_f\Data\ui\gear_UGL_slug_CA.paa";
		ammo = "G_40mm_Grappling_Hook";
		initSpeed = 80;
		count = 1;
		nameSound = "";
		descriptionShort = "40mm grenade launcher shell that launches a grappling hook";
		mass = 4;
		modelSpecial = "\a3\Weapons_F\MagazineProxies\mag_40x36_HE_1rnd.p3d";
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
		model = "\A3\weapons_f\ammo\flare_white";
		picture = "\A3\Weapons_F\Data\UI\gear_flare_white_ca.paa";
		ammo = "G_Grappling_Hook";
	};
};
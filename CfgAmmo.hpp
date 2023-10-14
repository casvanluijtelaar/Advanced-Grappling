class CfgAmmo {

	class GrenadeBase;
	class Default;	// External class reference
	class Grenade : Default {};
	class GrenadeHand : Grenade {};

	// throwable grappling hook
	class G_GRAPPEL  : GrenadeHand  {
		brightness = 0;
		explosionSoundEffect = "";
		simulation = "shotShell";
		model = "\A3\weapons_f\ammo\flare_white";
		hit = 0;
		indirectHit = 0;
		indirectHitRange = 0;
		warheadName = "GRAPPEL";
		visibleFire = 0;
		audibleFire = 0;
		visibleFireTime = 0;
		dangerRadiusHit = -1;
		deflectionSlowDown = 0;
		suppressionRadiusHit = 0;
		explosive = 0;
		explosionTime = 0;
		cost = 10;
		deflecting = 0;
		airFriction = -0.001;
		fuseDistance = 1;
		whistleDist = 0;    // no BIS explosion effects
        whistleOnFire = 0;  // no BIS firing effects
		typicalSpeed = 180;
		caliber = 2;
		soundHit1[] = {};
		soundHit2[] = {};
		soundHit3[] = {};
		soundHit4[] = {};
		multiSoundHit[] = {"soundHit1",0.25,"soundHit2",0.25,"soundHit3",0.25,"soundHit4",0.25};
	};

	// grenade launcher grappling hook
	class G_40mm_GRAPPEL : GrenadeBase {
		brightness = 0;
		explosionSoundEffect = "";
		simulation = "shotShell";
		model = "\A3\weapons_f\ammo\UGL_slug";
		hit = 0;
		indirectHit = 0;
		indirectHitRange = 0;
		warheadName = "GRAPPEL";
		visibleFire = 0;
		audibleFire = 0;
		visibleFireTime = 0;
		dangerRadiusHit = -1;
		deflectionSlowDown = 0;
		suppressionRadiusHit = 0;
		explosive = 0;
		explosionTime = 0;
		cost = 10;
		deflecting = 0;
		airFriction = -0.01;
		fuseDistance = 1;
		whistleDist = 0;  
        whistleOnFire = 0;
		typicalSpeed = 180;
		caliber = 2;
		soundHit1[] = {};
		soundHit2[] = {};
		soundHit3[] = {};
		soundHit4[] = {};
		multiSoundHit[] = {"soundHit1",0.25,"soundHit2",0.25,"soundHit3",0.25,"soundHit4",0.25};
	};
};

class CfgAmmo
{

    class GrenadeBase;

    // throwable grappling hook
    class G_Grappling_Hook : GrenadeBase
    {
        aiAmmoUsageFlags = "0"; // no AI usage
        cost = 40;
        dangerRadiusHit = 0;
        deflecting = 0;
        explosionTime = -1;
        explosive = 0;
        grenadeBurningSound[] = {};
        grenadeFireSound[] = {};
        hit = 0;
        indirectHit = 0;
        model = "\A3\weapons_f\ammo\flare_white";
        simulation = "shotShell";
        soundHit[] = {"", 0, 0};
        soundFly[] = {"", 0, 0};
        soundEngine[] = {"", 0, 0};
        suppressionRadiusHit = 0;
        timeToLive = 10;
        typicalSpeed = 22;
        warheadName = "GRAPPLING HOOK";
        whistleDist = 0;

        class CamShakeFire
        {
            power = 0;
            duration = 0;
            frequency = 0;
            distance = 0;
        };
        class CamShakePlayerFire
        {
            power = 0;
            duration = 0;
            frequency = 0;
        };
        class CamShakeHit
        {
            power = 0;
            duration = 0;
            frequency = 0;
        };
    };

    // grenade launcher grappling hook
    class G_40mm_Grappling_Hook : GrenadeBase
    {
        aiAmmoUsageFlags = "0"; // no AI usage
        cost = 40;
        dangerRadiusHit = 0;
        deflecting = 0;
        explosionTime = -1;
        explosive = 0;
        grenadeBurningSound[] = {};
        grenadeFireSound[] = {};
        hit = 0;
        indirectHit = 0;
        maxSpeed = 100;
        model = "\A3\weapons_f\ammo\UGL_slug";
        simulation = "shotShell";
        soundHit[] = {"", 0, 0};
        soundFly[] = {"", 0, 0};
        soundEngine[] = {"", 0, 0};
        suppressionRadiusHit = 0;
        timeToLive = 10;
        typicalSpeed = 22;
        warheadName = "GRAPPLING HOOK";
        whistleDist = 0;
        soundHit1[] = {};
        soundHit2[] = {};
        soundHit3[] = {};
        soundHit4[] = {};
        multiSoundHit[] = {"soundHit1", 0.25, "soundHit2", 0.25, "soundHit3", 0.25, "soundHit4", 0.25};

        class CamShakeFire
        {
            power = 0;
            duration = 0;
            frequency = 0;
            distance = 0;
        };
        class CamShakePlayerFire
        {
            power = 0;
            duration = 0;
            frequency = 0;
        };
        class CamShakeHit
        {
            power = 0;
            duration = 0;
            frequency = 0;
        };
    };
};

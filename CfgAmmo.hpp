class CfgAmmo
{

    class GrenadeCore;

    // throwable grappling hook
    class G_Grappling_Hook : GrenadeCore
    {
        aiAmmoUsageFlags = "0"; // no AI usage
        cost = 40;
        dangerRadiusHit = 0;
        deflecting = 0;
        explosionTime = -1;
        explosive = 0;
        hit = 0;
        indirectHit = 0;
        model = "\A3\weapons_f\ammo\flare_white";
        simulation = "shotShell";
        suppressionRadiusHit = 0;
        timeToLive = 10;
        typicalSpeed = 22;
        warheadName = "GRAPPLING HOOK";
        whistleDist = 0;

        soundFly[] = {"AOW_AdvancedGrappling\sounds\launch.ogg", 1, 1};
        soundHit1[] = {"AOW_AdvancedGrappling\sounds\impact.ogg", 3.16228, 1, 1400};
        multiSoundHit[] = {"soundHit1", 1};
        muzzleEffect = "";

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
    class G_40mm_Grappling_Hook : GrenadeCore
    {
        aiAmmoUsageFlags = "0"; // no AI usage
        cost = 40;
        dangerRadiusHit = 0;
        deflecting = 0;
        explosionTime = -1;
        explosive = 0;
        hit = 0;
        indirectHit = 0;
        maxSpeed = 100;
        model = "\A3\weapons_f\ammo\UGL_slug";
        simulation = "shotShell";
        suppressionRadiusHit = 0;
        timeToLive = 10;
        typicalSpeed = 22;
        warheadName = "GRAPPLING HOOK";
        whistleDist = 0;

        soundFly[] = {"AOW_AdvancedGrappling\sounds\launch.ogg", 1, 1};
        soundHit1[] = {"AOW_AdvancedGrappling\sounds\impact.ogg", 3.16228, 1, 1400};
        multiSoundHit[] = {"soundHit1", 1};
        muzzleEffect = "";
       
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

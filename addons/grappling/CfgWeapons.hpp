class CfgWeapons
{
    class GrenadeLauncher;
    class Throw : GrenadeLauncher
    {
        muzzles[] += {"Grenade_Grappel_Muzzle"};

        class ThrowMuzzle;
        class Grenade_Grappel_Muzzle : ThrowMuzzle
        {
            magazines[] = {"Grenade_Grappling_Hook"};
        };
    };
};
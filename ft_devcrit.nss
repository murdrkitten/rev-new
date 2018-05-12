#include "nwnx_weapon"
#include "inc_effects"

//const int FEAT_DEVCRIT_BASE_DC = 20;

void main()
{
/*
    // Force bypass the default Dev Crit effect.
    NWNX_Weapon_BypassDevastatingCritical();

    // JIC. - murdrkitten
    // object oAttacker = GetItemPossessor(oWeapon);
    object oAttacker = OBJECT_SELF;

    // This seems to be spelled wrong. Be wary for later updates. -murdrkitten
    struct NWNX_Weapon_DevastatingCriticalEvent_Data criticalData = NWNX_Weapon_GetDevastatingCriticalEventData();
    object oCritTarget = criticalData.oTarget;
    object oCritWeapon = criticalData.oWeapon;
    int nCritDamage = criticalData.nDamage;
    int nDC = FEAT_DEVCRIT_BASE_DC + GetAbilityModifier(ABILITY_STRENGTH, oAttacker);

    // Begin result checks.
    switch( EFFECTS_DoFortitudeSave(oCritTarget, nDC, SAVING_THROW_TYPE_DEATH, oAttacker) )
    {
    // Failed save.
    case(0):
        EFFECTS_ApplyTaggedEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE, TRUE), "EFFECT_DEVCRIT_DEATH", oCritTarget);
        break;
    // Succeeded save.
    case(1):
        break;
    // Immune.
    case(2):
        break;
     }
     */
}


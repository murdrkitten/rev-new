//::///////////////////////////////////////////////
//:: [Name]: inc_listener.nss
//:: [Authors]: murdrkitten
//:: [Functionality]:
/*
    Include functions for working with listeners.
*/
//::///////////////////////////////////////////////

const string LISTENER_TEMPLATE = "c_listener01";

//create listener for oPC
void LISTENER_Create(object oPC);

//internally used
void _LISTENER_ActionFollow(object oTarget);

//return target of oListener
object LISTENER_GetTarget(object oListener = OBJECT_SELF);

//set last sMessage of oPC
void LISTENER_SetLastMessage(string sMessage, object oPC = OBJECT_SELF);

//return last message of oPC
string LISTENER_GetLastMessage(object oPC = OBJECT_SELF);

//clear last message of oPC
void LISTENER_ClearLastMessage(object oPC = OBJECT_SELF);

//destroy listener of oPC
void LISTENER_DestroyListener(object oPC);

void LISTENER_CreateListener(object oPC)
{
    object oListener = GetLocalObject(oPC, "LISTENER_OBJECT");
    if (GetIsObjectValid(oListener)) return;

    oListener        = CreateObject(OBJECT_TYPE_CREATURE,
                                    LISTENER_TEMPLATE,
                                    GetLocation(oPC));

    if (GetIsObjectValid(oListener))
    {
        SetLocalObject(oListener, "LISTENER_TARGET", oPC);
        SetLocalObject(oPC, "LISTENER_OBJECT", oListener);

        SetListenPattern(oListener, "**");
        SetListening(oListener, TRUE);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                            ExtraordinaryEffect(EffectCutsceneParalyze()),
                            oListener);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                            ExtraordinaryEffect(EffectCutsceneGhost()),
                            oListener);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                            ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY)),
                            oListener);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                            ExtraordinaryEffect(EffectTrueSeeing()),
                            oListener);

        SetAILevel(oListener, AI_LEVEL_LOW);

        AssignCommand(oListener, _LISTENER_ActionFollow(oPC));
    }
}
//----------------------------------------------------------------
void _LISTENER_ActionFollow(object oTarget)
{
    object oTarget  = LISTENER_GetTarget();

    if (! GetIsObjectValid(oTarget))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    float fDistance = GetDistanceToObject(oTarget);

    SetCommandable(TRUE);
    if (fDistance >= 5.0 || fDistance == -1.0) ActionJumpToObject(oTarget);
    ActionWait(5.0);
    ActionDoCommand(_LISTENER_ActionFollow(oTarget));
    SetCommandable(FALSE);
}
//----------------------------------------------------------------
object LISTENER_GetTarget(object oListener = OBJECT_SELF)
{
    return GetLocalObject(oListener, "LISTENER_TARGET");
}
//----------------------------------------------------------------
void LISTENER_SetLastMessage(string sMessage, object oPC = OBJECT_SELF)
{
    SetLocalString(oPC, "LISTENER_MESSAGE", sMessage);
}
//----------------------------------------------------------------
string LISTENER_GetLastMessage(object oPC = OBJECT_SELF)
{
    return GetLocalString(oPC, "LISTENER_MESSAGE");
}
//----------------------------------------------------------------
void LISTENER_ClearLastMessage(object oPC = OBJECT_SELF)
{
    DeleteLocalString(oPC, "LISTENER_MESSAGE");
}
//----------------------------------------------------------------
void LISTENER_DestroyListener(object oPC)
{
    object oListener = GetLocalObject(oPC, "LISTENER_OBJECT");
    if (GetIsObjectValid(oListener)) return;

    DestroyObject(oListener);
    LISTENER_ClearLastMessage(oPC);
}

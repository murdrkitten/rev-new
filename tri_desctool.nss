//::///////////////////////////////////////////////
//:: [Name]: tri_desctool.nss
//:: [Authors]: murdrkitten
//:: [Functionality]:
/*
    Fires upon using the Description Tool
*/
//::///////////////////////////////////////////////

#include "inc_conv"

void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();

    SetLocalObject(oActivator, "ITEM_ACTIVATED", oItem);

    SetLocalObject(oItem, "ITEM_ACTIVATOR", oActivator);
    SetLocalObject(oItem, "ITEM_TARGET", oTarget);
    SetLocalLocation(oItem, "ITEM_TARGETLOC", lTarget);

    CONV_StartConv(oActivator, "tri_desctool", oActivator, TRUE);

}


#include "nwnx_player"

void main()
{
    object oSpeaker = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    //NWNX_Player_ForcePlaceableExamineWindow(oPC, oPC);

    AssignCommand(oPC, ActionExamine(oPC) );

}

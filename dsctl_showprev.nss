// Goes on StartingConditional

#include "inc_description"

int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sString = DESC_GetDescription(oSpeaker);

    SetCustomToken(9955, sString);

   // return FALSE;
   return TRUE;
}

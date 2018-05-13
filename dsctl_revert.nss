#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();


    DESC_SetDescription( oSpeaker, GetLocalString(oSpeaker, "DESCRIPTION_ORIGINAL") );

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Reverted description to original.");
}

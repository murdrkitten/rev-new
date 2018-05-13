#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    DESC_SetDescription(oSpeaker, " ");

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Erased description.");
}

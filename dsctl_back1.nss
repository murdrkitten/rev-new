#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sMessage = DESC_GetDescription();
    sMessage        = GetStringLeft(sMessage, GetStringLength(sMessage) - 1);

    DESC_SetDescription(oSpeaker, sMessage);

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Backspaced by 1.");
}

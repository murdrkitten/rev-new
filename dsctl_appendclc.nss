#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sMessage = "</c>";

    DESC_AppendDescription(sMessage, oSpeaker);

    DeleteLocalInt(oSpeaker, "COLOR_OPEN");

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Color tag closed.");
}

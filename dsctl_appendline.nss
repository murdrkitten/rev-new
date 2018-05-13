#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sMessage = "\n";

    DESC_AppendDescription(sMessage, oSpeaker);

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Added new carriage line to description.");
}

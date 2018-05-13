#include "inc_string"
#include "inc_listener"
#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sMessage = LISTENER_GetLastMessage(oSpeaker);
    sMessage = GetStringLeft(sMessage, 3);

    if( StringToInt(sMessage) < 000 || StringToInt(sMessage) > 777 )
    {
        if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Not a valid color.");
        return;
    }

    sMessage = STRING_GenerateColorTag(sMessage);

    DESC_AppendDescription(sMessage, oSpeaker);

    SetLocalInt(oSpeaker, "COLOR_OPEN", TRUE);

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Added " + sMessage + "your specified color" + "</c> to description. Don't forget to close the color tag when you're done.");
}

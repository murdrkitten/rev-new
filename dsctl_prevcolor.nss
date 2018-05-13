// Goes on StartingConditional

#include "inc_string"
#include "inc_listener"

int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    string sString = LISTENER_GetLastMessage(oSpeaker);
    sString = GetStringLeft(sString, 3);

    if( StringToInt(sString) < 000 || StringToInt(sString) > 777 )
    {
        if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "Not a valid color.");
    }
    else
    {
        SetCustomToken(9956, STRING_StringToRGBString("Lorem Ipsum", sString) );
    }

   // return FALSE;
   return TRUE;
}

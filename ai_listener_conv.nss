#include "inc_listener"

//----------------------------------------------------------------
void main()
{
    if (GetListenPatternNumber())              return;

    //filter speaker
    object oSpeaker      = GetLastSpeaker();
    if (oSpeaker != LISTENER_GetTarget())           return;

    //filter ai command
    string sString       = GetMatchedSubstring(0);

    //filter feedback
    string sOutput       = GetLocalString(OBJECT_SELF, "LISTENER_OUTPUT");
    DeleteLocalString(OBJECT_SELF, "LISTENER_OUTPUT");
    if (sString == sOutput)                    return;


    //store message
    LISTENER_SetLastMessage(sString, oSpeaker);
}

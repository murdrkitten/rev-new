// Goes on StartingConditional.

#include "inc_listener"

int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;
    
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker == GetPCSpeaker();
    
    LISTENER_ClearLastMessage(oSpeaker);

    return TRUE;
}
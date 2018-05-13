#include "inc_listener"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    LISTENER_DestroyListener(oSpeaker);

}

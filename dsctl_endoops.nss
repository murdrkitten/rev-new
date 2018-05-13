#include "inc_listener"
#include "inc_description"

void main()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    LISTENER_DestroyListener(oSpeaker);

    // Ensure the color tag closes.
    DESC_AppendDescription("</c>", oSpeaker);
    DeleteLocalInt(oSpeaker, "COLOR_OPEN");

    if( GetIsPC(oSpeaker) ) SendMessageToPC(oSpeaker, "We detected your description tool closed unexpectantly! Your backup is still safe. Just use the tool again.");

}

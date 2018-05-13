int StartingConditional()
{
    object oSpeaker = OBJECT_SELF;
    if( GetPCSpeaker() != OBJECT_INVALID ) oSpeaker = GetPCSpeaker();

    if(GetLocalInt(oSpeaker, "COLOR_OPEN") == TRUE) return TRUE;

    return FALSE;
}

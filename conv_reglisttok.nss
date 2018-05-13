// Goes on StartingConditional

int StartingConditional()
{
    string sString = GetLocalString(OBJECT_SELF, "PLAYER_SAID");

    //DeleteLocalString(OBJECT_SELF, "PLAYER_SAID");

    if (sString != "")
    {
        SetCustomToken(100, sString);
        return TRUE;
    }

    return FALSE;
}

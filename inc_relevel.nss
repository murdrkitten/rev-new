//Return amount of XP needed to reach nLevel
int XPForLevel(int nLevel)
{
    return (nLevel * (nLevel - 1)) * 500;
}

//Return level with specifiec xp
int LevelForXP(int nXP)
{
    int nLevel = FloatToInt(0.5f * (1 + sqrt(4.0f * (nXP/500.0f) + 1)));
    if(nLevel > 40)
    {
        nLevel = 40;
    }
    else if(nLevel < 1)
    {
        nLevel = 1;
    }
    return nLevel;
}

int LevelByClassSum(object oCreature)
{
    return GetLevelByPosition(1, oCreature) + GetLevelByPosition(2, oCreature) + GetLevelByPosition(3, oCreature);
}

//Sets creature to nLevel(Removing xp if creature had more)
void SetLevel(object oCreature, int nLevel)
{
    SetXP(oCreature, XPForLevel(nLevel));
}

//Decreases creature level by nLevelDecrease, without losing xp
void DecreaseLevelBy(object oCreature, int nLevelDecrease)
{
    int iRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oCreature);
    if(iRDD)
    {
        SpeakString("Red Dragon Disciples can not currently re-level due to bugs in the game. Please see a DM.");
        return;
    }
    int nCurrentXP = GetXP(oCreature);
    int nCurrentLevel = LevelByClassSum(oCreature);
    if(nCurrentLevel <= nLevelDecrease)
    {
        nLevelDecrease = nCurrentLevel - 1;
    }
    SetLevel(oCreature, nCurrentLevel - nLevelDecrease);
    DelayCommand(0.5f, SetXP(oCreature, nCurrentXP));
}

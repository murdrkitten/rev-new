string DESC_GetDescription(object oObject = OBJECT_SELF, int nOriginal = FALSE, int nIdentified = TRUE);

string DESC_SetDescription(object oObject = OBJECT_SELF, string sText = "", int nIdentified = TRUE);

string DESC_AppendDescription(string sText, object oObject = OBJECT_SELF, int nIdentified = TRUE);


string DESC_GetDescription(object oObject = OBJECT_SELF, int nOriginal = FALSE, int nIdentified = TRUE)
{
    return GetDescription(oObject, nOriginal, nIdentified);
}

string DESC_SetDescription(object oObject = OBJECT_SELF, string sText = "", int nIdentified = TRUE)
{
    SetDescription(oObject, sText, nIdentified);

    return sText;
}

string DESC_AppendDescription(string sText, object oObject = OBJECT_SELF, int nIdentified = TRUE)
{

    DESC_SetDescription(oObject, DESC_GetDescription(oObject) + sText, nIdentified);

    return sText;
}

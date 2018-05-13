//::///////////////////////////////////////////////
//:: [Name]: inc_string.nss
//:: [Authors]:
//:: Created By: Deva B. Winblood
//:: Created On: Feb 3rd, 2008
//:: Modified by: The Krit
//:: Modified on: Apr 15, 2008
//:: Reimplimented for Last Light on 5/6/2018 by murdrkitten
//:: [Functionality]:
/*
    This is a collection of string functions useful
    for coloring text, parsing text, etc.
    Very useful for the new OnPlayerChat event.
*/
//::///////////////////////////////////////////////


//////////////////////////////////////
// CONSTANTS
//////////////////////////////////////

const string STRING_COLOR_BLACK = "000";
const string STRING_COLOR_BLUE  = "007";
const string STRING_COLOR_GREEN = "070";
const string STRING_COLOR_PINK  = "755";
const string STRING_COLOR_RED   = "700";
const string STRING_COLOR_ROSE  = "744";
const string STRING_COLOR_WHITE = "777";

struct sStringTokenizer {
    int nRemainingLen;
    string sOrig;
    string sRemaining;
    string sDelim;
    string sLastTok;
};

int DELIM_NOT_FOUND = -1;

//////////////////////////////////////
// PROTOTYPES
//////////////////////////////////////


// FILE: x3_inc_string      FUNCTION: StringToRGBString()
//
// This function will make sString be the specified color
// as specified in sRGB.  RGB is the Red, Green, and Blue
// components of the color.  Each color can have a value from
// 0 to 7.
// Ex: red   == "700"
//     green == "070"
//     blue  == "007"
//     white == "777"
//     black == "000"
// The STRING_COLOR_* constants may be used for sRGB.
string STRING_StringToRGBString(string sString, string sRGB);

// FILE: x3_inc_string      FUNCTION: StringToRGBString()
//
// This function will create the specified color tag
// as specified in sRGB.  RGB is the Red, Green, and Blue
// components of the color.  Each color can have a value from
// 0 to 7.
// Ex: red   == "700"
//     green == "070"
//     blue  == "007"
//     white == "777"
//     black == "000"
// The STRING_COLOR_* constants may be used for sRGB.
string STRING_GenerateColorTag(string sRGB);


// FILE: x3_inc_string       FUNCTION: StringParse()
//
// This function will parse sSource from left to right until it encounters
// sDelimiter and will return all the characters it encountered before
// the delimiter occurred.
// If bRightToLeft is set to TRUE then it will parse from right to left instead.
string STRING_StringParse(string sSource, string sDelimiter = " ", int bRightToLeft = FALSE);


// FILE: x3_inc_string        FUNCTION: StringRemoveParsed()
//
// This function will take sParsed and remove it from the left side of sSource.
// It will also remove any excess sDelimiter occurrences after sParsed.
// If bRightToLeft is set to TRUE then it will perform this from the right side
// rather than the left.
//
// No check is made that sParsed actually matches sSource; all that matters
// about sParsed is its length.
string STRING_StringRemoveParsed(string sSource, string sParsed, string sDelimiter = " ", int bRightToLeft = FALSE);


// FILE: x3_inc_string         FUNCTION: StringReplace()
//
// This function will replace any occurrence of sFind in sSource with sReplace.
string STRING_StringReplace(string sSource, string sFind, string sReplace);

// Get a string tokenizer for sString. sDelim may be multiple
// characters in length.
struct sStringTokenizer STRING_GetStringTokenizer(string sString, string sDelim);

// Check to see if any more tokens remain. Returns 0 if not, 1 if so.
int STRING_HasMoreTokens(struct sStringTokenizer stTok);

// Get next token
struct sStringTokenizer STRING_AdvanceToNextToken(struct sStringTokenizer stTok);

// Get the last token retrieved
string STRING_GetNextToken(struct sStringTokenizer stTok);

// Get the number of tokens in the string, by delimeter.
int STRING_GetNumberTokens(string sString, string sDelim);

// Get the specified token in the string, by delimiter.
// The first string is position 0, the second is position 1, etc.
string STRING_GetTokenByPosition(string sString, string sDelim, int nPos);


///////////////////////////////////////
// FUNCTIONS
///////////////////////////////////////


//------------------------------------------------------------------------------
// This function will make sString be the specified color
// as specified in sRGB.  RGB is the Red, Green, and Blue
// components of the color.  Each color can have a value from
// 0 to 7.
//
string STRING_StringToRGBString(string sString, string sRGB)
{
    // The magic characters (padded -- the last three characters are the same).
    string sColorCodes = " fw®°Ìþþþ";
    // For the older version going 0 to 6, use:
    //string sColorCodes = " fw®°Ìþþþþ";

    return "<c" +   // Begin the color token.
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 0, 1)), 1) + // red
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 1, 1)), 1) + // green
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 2, 1)), 1) + // blue
            ">" +   // End the color token
            sString + "</c>";
}//StringToRGBString()

string STRING_GenerateColorTag(string sRGB)
{
    // The magic characters (padded -- the last three characters are the same).
    string sColorCodes = " fw®°Ìþþþ";
    // For the older version going 0 to 6, use:
    //string sColorCodes = " fw®°Ìþþþþ";

    return "<c" +   // Begin the color token.
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 0, 1)), 1) + // red
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 1, 1)), 1) + // green
            GetSubString(sColorCodes, StringToInt(GetSubString(sRGB, 2, 1)), 1) + // blue
            ">";   // End the color token
}


//------------------------------------------------------------------------------
// This function will parse sSource from left to right until it encounters
// sDelimiter and will return all the characters it encountered before
// the delimiter occurred.
// If bRightToLeft is set to TRUE then it will parse from right to left instead.
//
string STRING_StringParse(string sSource, string sDelimiter = " ", int bRightToLeft = FALSE)
{
    // Find the first delimiter.
    int nDelimIndex = FindSubString(sSource, sDelimiter);
    if ( nDelimIndex < 0 )
        // Delimiter not found; return the whole source string.
        return sSource;

    // For left-to-right, we're basically done.
    if ( !bRightToLeft )
        return GetStringLeft(sSource, nDelimIndex);

    // For right-to-left, we need to find the last delimiter.
    int nLastDelim = 0;
    while ( nDelimIndex >= 0 )
    {
        nLastDelim = nDelimIndex;
        nDelimIndex = FindSubString(sSource, sDelimiter, nLastDelim+1);
    }
    // Return everything after the last delimiter.
    int nRetLength = GetStringLength(sSource) - nLastDelim - GetStringLength(sDelimiter);
    return GetStringRight(sSource, nRetLength);
}//StringParse()


//------------------------------------------------------------------------------
// This function will take sParsed and remove it from the left side of sSource.
// It will also remove any excess sDelimiter occurrences after sParsed.
// If bRightToLeft is set to TRUE then it will perform this from the right side
// rather than the left.
//
// No check is made that sParsed actually matches sSource; all that matters
// about sParsed is its length.
//
string STRING_StringRemoveParsed(string sSource, string sParsed, string sDelimiter = " ", int bRightToLeft = FALSE)
{
    int nDelimLength = GetStringLength(sDelimiter);

    if ( !bRightToLeft )
    {
        // Start after a string the length of sParsed.
        int nStart = GetStringLength(sParsed);
        if ( nDelimLength > 0 )
            // Locate excess delimiters.
            while ( GetSubString(sSource, nStart, nDelimLength) == sDelimiter )
                nStart += nDelimLength;
        // Remove the delimiters and the string the length of sParsed.
        return GetStringRight(sSource, GetStringLength(sSource) - nStart);
    }
    else
    {
        // Stop before a string the length of sParsed.
        int nEnd = GetStringLength(sSource) - GetStringLength(sParsed);
        if ( nDelimLength > 0 )
            // Locate excess delimiters.
            while ( GetSubString(sSource, nEnd - nDelimLength, nDelimLength) == sDelimiter )
                nEnd -= nDelimLength;
        // Remove the delimiters and the string the length of sParsed.
        return GetStringLeft(sSource, nEnd);
    }
}//StringRemoveParsed()


//------------------------------------------------------------------------------
// This function will replace any occurrence of sFind in sSource with sReplace.
//
string STRING_StringReplace(string sSource, string sFind, string sReplace)
{
    int nFindLength = GetStringLength(sFind);
    int nPosition = 0;
    string sRetVal = "";

    // Locate all occurences of sFind.
    int nFound = FindSubString(sSource, sFind);
    while ( nFound >= 0 )
    {
        // Build the return string, replacing this occurence of sFind with sReplace.
        sRetVal += GetSubString(sSource, nPosition, nFound - nPosition) + sReplace;
        nPosition = nFound + nFindLength;
        nFound = FindSubString(sSource, sFind, nPosition);
    }
    // Tack on the end of sSource and return.
    return sRetVal + GetStringRight(sSource, GetStringLength(sSource) - nPosition);
}//StringReplace()



// Get a string tokenizer for sString. sDelim may be multiple
// characters in length.
struct sStringTokenizer STRING_GetStringTokenizer(string sString, string sDelim)
{
    struct sStringTokenizer sNew;

    sNew.sOrig = sString;
    sNew.sRemaining = sString;
    sNew.sDelim = sDelim;
    sNew.sLastTok = "";
    sNew.nRemainingLen = GetStringLength(sString);

    return sNew;
}

// Check to see if any more tokens remain. Returns 0 if not, 1 if so.
int STRING_HasMoreTokens(struct sStringTokenizer stTok)
{
    if (stTok.nRemainingLen > 0) {
        return TRUE;
    }
    return FALSE;
}

// Move tokenizer to next token
struct sStringTokenizer STRING_AdvanceToNextToken(struct sStringTokenizer stTok)
{
    int nDelimPos = FindSubString(stTok.sRemaining, stTok.sDelim);
    if (nDelimPos == DELIM_NOT_FOUND) {
        // no delimiters in the string
        stTok.sLastTok = stTok.sRemaining;
        stTok.sRemaining = "";
        stTok.nRemainingLen = 0;
    } else {
        stTok.sLastTok = GetSubString(stTok.sRemaining, 0, nDelimPos);
        stTok.sRemaining = GetSubString(stTok.sRemaining,
                                        nDelimPos+1,
                                        stTok.nRemainingLen - (nDelimPos+1));
        stTok.nRemainingLen = GetStringLength(stTok.sRemaining);
    }

    return stTok;
}

// Get the next token
string STRING_GetNextToken(struct sStringTokenizer stTok)
{
    return stTok.sLastTok;
}

// Get the number of tokens in the string, by delimeter.
int STRING_GetNumberTokens(string sString, string sDelim)
{
    struct sStringTokenizer stTok = STRING_GetStringTokenizer(sString, sDelim);
    int nElements = 0;
    while (STRING_HasMoreTokens(stTok)) {
        stTok = STRING_AdvanceToNextToken(stTok);
        nElements++;
    }
    return nElements;
}

// Get the specified token in the string, by delimiter.
// The first string is position 0, the second is position 1, etc.
string STRING_GetTokenByPosition(string sString, string sDelim, int nPos)
{
    struct sStringTokenizer stTok = STRING_GetStringTokenizer(sString, sDelim);
    int i=0;
    while (STRING_HasMoreTokens(stTok) && i <= nPos) {
        stTok = STRING_AdvanceToNextToken(stTok);
        i++;
    }
    if (i != nPos + 1)
        return "";

    return STRING_GetNextToken(stTok);
}


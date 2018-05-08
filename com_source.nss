
///////////////////////////////////////////////////////////////////////////////
/////////////////////Mad Rabbit's Player Chat Commands/////////////////////////
////////////////////////////////Version 1.01///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
/*
////////////////////////////////////////////////////////////////////////////////
//Created By : MadRabbit                                                      //
//Email : mad_rabbit_land@hotmail.com                                         //
//Created On : March 2009                                                     //
//Updated On : March 2009                                                     //
//NOTE : Do not email me with requests. Only bug reports and suggestions for  //
//improvement of the entire program for the vault. I do not do special        //
//versions for individual worlds.                                             //
//CREDIT : Ravish for Ravish's Intimate Emotes                                //
////////////////////////////////////////////////////////////////////////////////

*/
///////////////////////////////////////////////////////////////////////////////
///DO NOT CHANGE ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING///
///////////////////////////////Constants///////////////////////////////////////

//Duration of the looping emotes
//Default = 7200.0 //2 hours
const float PC_COMMAND_LOOP_DUR = 7200.0;

//How long a player must wait before using another player voice command
//Set to 0.0 to allow players to use commands with no delay.
//Default = 6.0 //6 seconds or 1 round
const float PC_COMMAND_SPAM_DELAY = 6.0;

//This is the maximum length of a secondary command. Exception is /desc add and
//any other commands that require text input from player
const int PC_COMMAND_MAX_COMMAND_LENGTH = 32;

//This is the prefix of primary command scripts
const string PC_COMMAND_PRIMARY_SCRIPTS = "com_s_";

//////////////////////////////Declarations//////////////////////////////////////

//Master function for Player Chat Command program. For On Player Chat event
void MRPlayerChat();

//Master function for On Activate Item event
void MROnActivateItem();

///////////////////////////////Definition//////////////////////////////////////

//Add new script prefixs here so they can be registered as valid
int CheckForScripts(string sPrimaryCommand)
{
    int nBool = FALSE;

    if (sPrimaryCommand == "crl")
        nBool = TRUE;
    else if (sPrimaryCommand == "dsc")
        nBool = TRUE;
    else if (sPrimaryCommand == "emo")
        nBool = TRUE;
    else if (sPrimaryCommand == "eye")
        nBool = TRUE;
    else if (sPrimaryCommand == "hug")
        nBool = TRUE;
    else if (sPrimaryCommand == "ios")
        nBool = TRUE;
    else if (sPrimaryCommand == "itm")
        nBool = TRUE;
    else if (sPrimaryCommand == "jrl")
        nBool = TRUE;
    else if (sPrimaryCommand == "lap")
        nBool = TRUE;
    else if (sPrimaryCommand == "rll")
        nBool = TRUE;
    else if (sPrimaryCommand == "mad")
        nBool = TRUE;
    else if (sPrimaryCommand == "pet")
        nBool = TRUE;
    else if (sPrimaryCommand == "sex")
        nBool = TRUE;
    else if (sPrimaryCommand == "spk")
        nBool = TRUE;
    else if (sPrimaryCommand == "stp")
        nBool = TRUE;
    else if (sPrimaryCommand == "sve")
        nBool = TRUE;
    else if (sPrimaryCommand == "tch")
        nBool = TRUE;
    else if (sPrimaryCommand == "vis")
        nBool = TRUE;
    else if (sPrimaryCommand == "wlk")
        nBool = TRUE;
    else if (sPrimaryCommand == "ani")
        nBool = TRUE;

    return nBool;
}

void MRPlayerChat()
{
    object oPC = GetPCChatSpeaker();
    string sMessage = GetPCChatMessage();

    //Determine if its one of my commands
    string sSlash = GetSubString(sMessage, 0, 1);

    //Dont fire the code if its not one of my commands.
    if (sSlash != "/") return;

    //Set talk volume
    SetPCChatVolume(TALKVOLUME_SILENT_TALK);

    //Get the primary command
    string sPrimaryCommand = GetSubString(sMessage, 1, 3);
    //Combine it with the script prefix to create a script name.
    string sScript = PC_COMMAND_PRIMARY_SCRIPTS + sPrimaryCommand;

    if (!CheckForScripts(sPrimaryCommand))
    {
        SendMessageToPC(oPC, "Invalid Command");
        return;
    }

    //Fire the code
    ExecuteScript(sScript, oPC);
}

void MROnActivateItem()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oItem);

    //If its not the Item Selector, abort
    if (sTag != "pc_comm_itm_svr") return;

    //If oTarget is not a valid item, abort
    if (!GetIsObjectValid(oTarget) || GetObjectType(oTarget) != OBJECT_TYPE_ITEM) {
        SendMessageToPC(oPC, "You must target an item with the Player Command Item Selector!");
        return; }

    SetLocalObject(oPC, "PC_COMM_SVD_ITEM", oTarget);
    SendMessageToPC(oPC, "The item " + GetName(oTarget) + " has been selected");
}



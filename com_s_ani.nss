#include "com_source"

void main()
{
    string sMessage = GetPCChatMessage();
    string sSecondaryCommand = GetSubString(sMessage, 5, PC_COMMAND_MAX_COMMAND_LENGTH);

    if (sSecondaryCommand == "normal")
        SetPhenoType(1);
    else if (sSecondaryCommand == "kensai")
        SetPhenoType(15);
    else if (sSecondaryCommand == "assassin")
        SetPhenoType(16);
    else if (sSecondaryCommand == "heavy")
        SetPhenoType(17);
    else if (sSecondaryCommand == "fencing")
        SetPhenoType(18);
    else if (sSecondaryCommand == "arcane")
        SetPhenoType(19);
    else if (sSecondaryCommand == "demonblade")
        SetPhenoType(20);
    else if (sSecondaryCommand == "warrior")
        SetPhenoType(21);
    else if (sSecondaryCommand == "tiger")
        SetPhenoType(30);
    else if (sSecondaryCommand == "sun")
        SetPhenoType(31);
    else if (sSecondaryCommand == "dragon")
        SetPhenoType(32);
    else if (sSecondaryCommand == "bear")
        SetPhenoType(33);
    else
        SendMessageToPC(OBJECT_SELF, "Invalid Command");
}

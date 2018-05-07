#include "inc_relevel"

void main()
{
    object oPC = GetPCSpeaker();
    DecreaseLevelBy(oPC, 1);
}

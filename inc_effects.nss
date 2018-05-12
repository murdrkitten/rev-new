//::///////////////////////////////////////////////
//:: [Name]: inc_effects.nss
//:: [Authors]: murdrkitten
//:: [Functionality]: Include functions for effects,
//:: such as those which would be applied by feats or spells.
//::///////////////////////////////////////////////

// Applies an effect and gives it a tag specified by "sTag". Effects without a tag specified will be given an "EFFECT_UNTAGGED" tag.
void EFFECTS_ApplyTaggedEffectToObject(int nDurationType, effect eEffect, string sTag = "", object oCreature = OBJECT_SELF, float fDuration = 0.0f);

// Removes all effects by tag sTag on oCreature.
void EFFECTS_RemoveAllEffectsByTag(string sTag, object oCreature = OBJECT_SELF);

// Returns whether the target has an effect by the tag "sTag" or not.
int EFFECTS_GetTargetHasEffect(string sTag, object oCreature = OBJECT_SELF);

// Modify an effect
void EFFECTS_ModifyEffect(effect eNewEffect, int nNewDurationType = DURATION_TYPE_INSTANT, string sOldTag = "", string sNewTag = "", object oCreature = OBJECT_SELF, float fNewDuration = 0.0f);

// Replacement to FortitudeSave for more controllable methods.
int EFFECTS_DoFortitudeSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

// Replacement to ReflexSave for more controllable methods.
int EFFECTS_DoReflexSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

// Replacement to WillSave for more controllable methods.
int EFFECTS_DoWillSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

//::///////////////////////////////////////////////
//:: Main Body
//::///////////////////////////////////////////////

void EFFECTS_ApplyTaggedEffectToObject(int nDurationType, effect eEffect, string sTag = "", object oCreature = OBJECT_SELF, float fDuration = 0.0f)
{
    if ( sTag == "" ) sTag = "EFFECT_UNTAGGED";
    effect eTaggedEffect = TagEffect(eEffect, sTag);
    ApplyEffectToObject(nDurationType, eTaggedEffect, oCreature, fDuration);
}

void EFFECTS_RemoveAllEffectsByTag(string sTag, object oCreature = OBJECT_SELF)
{
    effect eEffect = GetFirstEffect(oCreature);
    while ( GetIsEffectValid(eEffect) )
    {
        if ( GetEffectTag(eEffect) == sTag ) RemoveEffect(oCreature, eEffect);
        eEffect = GetNextEffect(oCreature);
    }
}

int EFFECTS_GetTargetHasEffect(string sTag, object oCreature = OBJECT_SELF)
{
    effect eEffect = GetFirstEffect(oCreature);
    while ( GetIsEffectValid(eEffect) )
    {
        if ( GetEffectTag(eEffect) == sTag ) return 1;
        eEffect = GetNextEffect(oCreature);
    }
    return 0;
}

void EFFECTS_ModifyEffect(effect eNewEffect, int nNewDurationType = DURATION_TYPE_INSTANT, string sOldTag = "", string sNewTag = "", object oCreature = OBJECT_SELF, float fNewDuration = 0.0f)
{
    // the fok r u tryin'a do????
    if ( oCreature == OBJECT_INVALID || sOldTag == "" )
    {
        return;
    }

    // We prevented some stupid shit from happening,
    // so with that aside... This is a pretty big while loop.
    // Might be a better way to do it but it should do the trick for now.

    // The old effect.
    effect eOldEffect = GetFirstEffect(oCreature);
    while ( GetIsEffectValid(eOldEffect) )
    {
        // We found what we were looking for...
        // What that means is we found a valid effect
        // with a tag matching "sOldTag".
        if ( GetEffectTag(eOldEffect) == sOldTag )
        {
            // No specification of a new tag... tag stays the same.
            if( sNewTag == "" ) sNewTag = sOldTag;

            // No specification of a new duration type... duration type stays the same.
            if( nNewDurationType == DURATION_TYPE_INSTANT ) nNewDurationType == GetEffectDurationType(eOldEffect);

            // And now we know a little more about what kind of effect we're working with.

            // -- Okay, so we're a temporary effect...
            if( nNewDurationType == DURATION_TYPE_TEMPORARY )
            {
                // We did not specify a new duration, so seamlessly tack on the old remaining duration;
                // ba-da-bing, ba-da-boom.
                if( fNewDuration == 0.0f ) fNewDuration = IntToFloat( GetEffectDurationRemaining(eOldEffect) );
            }
            // -- We're a permanent effect.
            else if ( nNewDurationType == DURATION_TYPE_PERMANENT )
            {
                // Better safe than sorry.
                fNewDuration == 0.0f;
            }

            // -- phew. Finally, apply it.
            EFFECTS_ApplyTaggedEffectToObject(nNewDurationType, eNewEffect, sNewTag, oCreature, fNewDuration);
        }
        // Now move on to the next effect.
        eOldEffect = GetNextEffect(oCreature);
    }
}

int EFFECTS_DoFortitudeSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF)
{
    // As per usual command, 0 if failed, 1 if succeeded, 2 if immune.
    int nResult = FortitudeSave(oCreature, nDC, nSaveType, oSaveVersus);
    return nResult;
}

int EFFECTS_DoReflexSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF)
{
    // As per usual command, 0 if failed, 1 if succeeded, 2 if immune.
    int nResult = ReflexSave(oCreature, nDC, nSaveType, oSaveVersus);
    return nResult;
}

int EFFECTS_DoWillSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF)
{
    // As per usual command, 0 if failed, 1 if succeeded, 2 if immune.
    int nResult = WillSave(oCreature, nDC, nSaveType, oSaveVersus);
    return nResult;
}




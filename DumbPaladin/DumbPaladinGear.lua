local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

function DumbPaladin:PerformGearChecksOnUnit(unit)
    DumbPaladin:PerformTabardCheckOnUnit(unit)
    DumbPaladin:PerformItemRackSetCheck()
    DumbPaladin:PerformTalentSpecCheck()
end

function DumbPaladin:IsSupportedInstance(instanceId)
    for _, instanceProperties in pairs(DumbPaladin.SupportedInstances) do
        if instanceProperties.id == instanceId then
            return true
        end
    end

    return false
end

function DumbPaladin:PerformTabardCheckOnUnit(unit)
    if not DumbPaladin.db.profile.settings.gear.tabards.checkTabards then
        DumbPaladin:PrintDebugMessageToChatWindow("Tabard checks disabled. Skipping.")
        return
    end

    DumbPaladin:PrintDebugMessageToChatWindow("Checking tabards.")

    local desiredTabard = DumbPaladin.db.profile.settings.gear.tabards.selectedTabard

    if not desiredTabard then
        DumbPaladin:PrintDebugMessageToChatWindow("No desired tabard selected. Skipping tabard check.")
    end

    local tabardSlotId = 19
    local currentlyEquippedTabard = GetInventoryItemID(unit, tabardSlotId)
    local desiredTabardId = DumbPaladin.Tabards[desiredTabard].id

    if currentlyEquippedTabard ~= desiredTabardId then
        local desiredTabardName = DumbPaladin.Tabards[desiredTabard].name
        DumbPaladin:IssueMissingTabardWarnings(desiredTabardName)
    end
end

function DumbPaladin:IssueMissingTabardWarnings(desiredTabardName)
    if DumbPaladin.db.profile.settings.gear.warnings.raidWarning then
        DumbPaladin:IssueRaidWarning(L["You have the wrong tabard equipped!"])
        DumbPaladin:IssueRaidWarning(L["You should be wearing your "] .. desiredTabardName)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.chat then
        DumbPaladin:IssueChatWarning(L["You have the wrong tabard equipped!"])
        DumbPaladin:IssueChatWarning(L["You should be wearing your "] .. desiredTabardName)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.flashScreen then
        DumbPaladin:IssueScreenFlashWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.soundWarning then
        DumbPaladin:IssueSoundWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.textToSpeech then
        DumbPaladin:IssueTextToSpeechWarning(L["You have the wrong tabard equipped!"])
        DumbPaladin:IssueTextToSpeechWarning(L["You should be wearing your "] .. desiredTabardName)
    end
end

function DumbPaladin:PerformItemRackSetCheck()
    if not DumbPaladin.db.profile.settings.gear.itemRack.checkItemRackSet then
        DumbPaladin:PrintDebugMessageToChatWindow("Item rack set checks disabled. Skipping.")
        return
    end

    DumbPaladin:PrintDebugMessageToChatWindow("Checking item rack sets.")

    local desiredItemRackSet = DumbPaladin.db.profile.settings.gear.itemRack.selectedItemRackSet

    if not desiredItemRackSet then
        DumbPaladin:PrintDebugMessageToChatWindow("No desired item rack set selected. Skipping check.")
    end

    local currentlyActiveItemRackSet = ItemRackUser.CurrentSet or ""

    if currentlyActiveItemRackSet ~= desiredItemRackSet then
        DumbPaladin:IssueWrongItemRackSetWarnings(desiredItemRackSet)
    end
end

function DumbPaladin:IssueWrongItemRackSetWarnings(desiredItemRackSet)
    if DumbPaladin.db.profile.settings.gear.warnings.raidWarning then
        DumbPaladin:IssueRaidWarning(L["You have the wrong item rack set equipped!"])
        DumbPaladin:IssueRaidWarning(L["You should be wearing "] .. desiredItemRackSet)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.chat then
        DumbPaladin:IssueChatWarning(L["You have the wrong item rack set equipped!"])
        DumbPaladin:IssueChatWarning(L["You should be wearing "] .. desiredItemRackSet)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.flashScreen then
        DumbPaladin:IssueScreenFlashWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.soundWarning then
        DumbPaladin:IssueSoundWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.textToSpeech then
        DumbPaladin:IssueTextToSpeechWarning(L["You have the wrong item rack set equipped!"])
        DumbPaladin:IssueTextToSpeechWarning(L["You should be wearing "] .. desiredItemRackSet)
    end
end

function DumbPaladin:PerformTalentSpecCheck()
    if not DumbPaladin.db.profile.settings.gear.talentSpec.checkTalentSpec then
        DumbPaladin:PrintDebugMessageToChatWindow("Spec checks disabled. Skipping.")
        return
    end

    DumbPaladin:PrintDebugMessageToChatWindow("Checking spec.")

    local desiredTalentSpecId = DumbPaladin.db.profile.settings.gear.talentSpec.selectedTalentSpec

    if not desiredTalentSpecId then
        DumbPaladin:PrintDebugMessageToChatWindow("No desired spec selected. Skipping spec check.")
    end

    local desiredTalentSpecName = desiredTalentSpecId and GetTalentTabInfo(desiredTalentSpecId) or "No desired"

    local currentTalentSpecId = GetActiveTalentGroup()
    local currentTalentSpecName = GetTalentTabInfo(currentTalentSpecId)

    DumbPaladin:PrintDebugMessageToChatWindow("Desired spec id " .. desiredTalentSpecId .. " and name " .. desiredTalentSpecName)
    DumbPaladin:PrintDebugMessageToChatWindow("Active spec id " .. currentTalentSpecId .. " and name " .. currentTalentSpecName)

    if currentTalentSpecName ~= desiredTalentSpecName then
        DumbPaladin:IssueWrongTalentSpecWarnings(desiredTalentSpecName)
    end
end

function DumbPaladin:IssueWrongTalentSpecWarnings(desiredTalentSpec)
    if DumbPaladin.db.profile.settings.gear.warnings.raidWarning then
        DumbPaladin:IssueRaidWarning(L["You have the wrong spec active!"])
        DumbPaladin:IssueRaidWarning(L["You should activate "] .. desiredTalentSpec)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.chat then
        DumbPaladin:IssueChatWarning(L["You have the wrong spec active!"])
        DumbPaladin:IssueChatWarning(L["You should activate "] .. desiredTalentSpec)
    end

    if DumbPaladin.db.profile.settings.gear.warnings.flashScreen then
        DumbPaladin:IssueScreenFlashWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.soundWarning then
        DumbPaladin:IssueSoundWarning()
    end

    if DumbPaladin.db.profile.settings.gear.warnings.textToSpeech then
        DumbPaladin:IssueTextToSpeechWarning(L["You have the wrong spec active!"])
        DumbPaladin:IssueTextToSpeechWarning(L["You should activate "] .. desiredTalentSpec)
    end
end

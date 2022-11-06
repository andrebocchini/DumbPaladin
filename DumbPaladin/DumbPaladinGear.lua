local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

function DumbPaladin:PerformGearChecksOnUnit(unit)
    DumbPaladin:PerformTabardCheckOnUnit(unit)
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
        DumbPaladin:PrintMessageToChatWindow(L["You have the wrong tabard equipped!"])
        DumbPaladin:PrintMessageToChatWindow(L["You should be wearing your "] .. desiredTabardName)
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


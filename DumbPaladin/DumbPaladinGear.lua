local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

function DumbPaladin:IsSupportedInstance(instanceId)
    for _, instanceProperties in pairs(DumbPaladin.SupportedInstances) do
        if instanceProperties.id == instanceId then
            return true
        end
    end

    return false
end

function DumbPaladin:PerformGearChecksOnUnit(unit)
    DumbPaladin:PerformTabardCheckOnUnit(unit)
end

function DumbPaladin:PerformTabardCheckOnUnit(unit)
    if not DumbPaladin.db.profile.tabards.checkTabards then
        DumbPaladin:PrintDebugMessageToChatWindow("Tabard checks disabled. Skipping.")
        return
    end

    DumbPaladin:PrintDebugMessageToChatWindow("Checking tabards.")

    local desiredTabard = DumbPaladin.db.profile.tabards.selectedTabard

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
    DumbPaladin:PrintMessageToChatWindow(L["You have the wrong tabard equipped!"])
    DumbPaladin:PrintMessageToChatWindow(L["You should be wearing your "] .. desiredTabardName)

    DumbPaladin:IssueRaidWarning(L["You have the wrong tabard equipped!"])
    DumbPaladin:IssueRaidWarning(L["You should be wearing your "] .. desiredTabardName)
end


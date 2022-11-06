local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

function DumbPaladin:PerformBuffChecksOnUnit(unit)
    DumbPaladin:CheckForMissingRequiredBuffsFromUnit(unit)
end

function DumbPaladin:GetSpellName(spellId)
    if not spellId then
        return "(nil)"
    end

    return select(1, GetSpellInfo(spellId))
end

-- Goes through the user's settings and returns a list of all buffs that the player marked as required
function DumbPaladin:GetBuffsUserSelectedAsRequired()
    local requiredBuffs = {}

    for class, classProperties in pairs(DumbPaladin.Buffs) do
        DumbPaladin:PrintDebugMessageToChatWindow("Checking buffs for class " .. class)

        for buff, buffProperties in pairs(classProperties.buffs) do
            local name = DumbPaladin:GetSpellName(buffProperties.spellIds[1])

            DumbPaladin:PrintDebugMessageToChatWindow("Checking if " .. name .. " is required")
            if DumbPaladin.db.profile.classes[class].buffs[buff].required then
                DumbPaladin:PrintDebugMessageToChatWindow(name .. " is required")
                requiredBuffs[name] = buffProperties.spellIds
            else
                DumbPaladin:PrintDebugMessageToChatWindow(name .. " is not required")
            end
        end
    end

    return requiredBuffs
end

-- Checks if a spell id belongs to a table of spell ids indexed by integers
function DumbPaladin:DoesBuffBelongsToFamilyOfBuffs(buffSpellId, buffFamilySpellIds)
    if not buffSpellId then
        return false
    end

    if not buffFamilySpellIds then
        return false
    end

    local buffSpellName = DumbPaladin:GetSpellName(buffSpellId)

    if not buffSpellName then
        return false
    end

    for _, buffFamilySpellId in pairs(buffFamilySpellIds) do
        local buffFamilySpellName = DumbPaladin:GetSpellName(buffFamilySpellId)

        if buffSpellName == buffFamilySpellName then
            return true
        end
    end

    return false
end

-- Compares the player's current buffs against a list of required buffs and returns a
-- list of all required buffs missing from the player
function DumbPaladin:GetMissingRequiredBuffsFromUnit(unit, requiredBuffs)
    if not unit then
        unit = "(nil)"
    end

    if not requiredBuffs then
        requiredBuffs = {}
    end

    local missingRequiredBuffs = {}

    for requiredBuffName, requiredBuffSpellIds in pairs(requiredBuffs) do
        local missingRequiredBuff = true

        for activeBuffIndex = 1, 32 do
            local activeBuffName, _, _, _, _, _, _, _, _, activeBuffSpellId, _  = UnitBuff(unit, activeBuffIndex)

            if not activeBuffName then
                break
            end

            local buffBelongsToFamily = DumbPaladin:DoesBuffBelongsToFamilyOfBuffs(activeBuffSpellId, requiredBuffSpellIds)

            if buffBelongsToFamily == true then
                DumbPaladin:PrintDebugMessageToChatWindow(requiredBuffName .. " is not missing")
                missingRequiredBuff = false
                break
            end
        end

        if missingRequiredBuff then
            DumbPaladin:PrintDebugMessageToChatWindow(requiredBuffName .. " is missing")
            missingRequiredBuffs[requiredBuffName] = true
        end
    end

    return missingRequiredBuffs
end

-- Checks the player's current buffs against the required buffs, and displays messages
-- letting the player know which buffs he's missing
function DumbPaladin:CheckForMissingRequiredBuffsFromUnit(unit)
    if not unit then
        unit = "(nil)"
    end

    if not DumbPaladin:IsAtLeastOneMissingBuffWarningTypeEnabled() then
        DumbPaladin:PrintDebugMessageToChatWindow("Warnings disabled. Skipping buff check.")
        return
    end

    DumbPaladin:PrintDebugMessageToChatWindow("Performing buff checks.")

    local requiredBuffs = DumbPaladin:GetBuffsUserSelectedAsRequired()
    local missingRequiredBuffs = DumbPaladin:GetMissingRequiredBuffsFromUnit(unit, requiredBuffs)
    local missingBuffCount = 0

    for _ in pairs(missingRequiredBuffs) do
        missingBuffCount = missingBuffCount + 1
    end

    if missingBuffCount > 0 then
        DumbPaladin:IssueMissingBuffWarnings(missingRequiredBuffs)
    end
end

function DumbPaladin:IssueMissingBuffWarnings(missingRequiredBuffs)
    if not missingRequiredBuffs then
        missingRequiredBuffs = {}
    end

    local indexedTable = {}
    local index = 1
    for buffName in pairs(missingRequiredBuffs) do
        indexedTable[index] = buffName
        index = index + 1
    end

    local accumulatedBuffs = ""
    for i, value in ipairs(indexedTable) do
        if i == 1 then
            accumulatedBuffs = value
        else
            accumulatedBuffs = accumulatedBuffs .. ", " .. value
        end
    end

    if DumbPaladin.db.profile.settings.warnings.raidWarning then
        DumbPaladin:IssueRaidWarning(L["MissingBuffsWarning"])
        DumbPaladin:IssueRaidWarning(accumulatedBuffs)
    end

    if DumbPaladin.db.profile.settings.warnings.chat then
        DumbPaladin:PrintMessageToChatWindow(L["MissingBuffsWarning"])
        DumbPaladin:PrintMessageToChatWindow(accumulatedBuffs)
    end

    if DumbPaladin.db.profile.settings.warnings.flashScreen then
        DumbPaladin:IssueScreenFlashWarning()
    end

    if DumbPaladin.db.profile.settings.warnings.soundWarning then
        DumbPaladin:IssueSoundWarning()
    end

    if DumbPaladin.db.profile.settings.warnings.textToSpeech then
        DumbPaladin:IssueTextToSpeechWarning(accumulatedBuffs)
    end
end

function DumbPaladin:IsAtLeastOneMissingBuffWarningTypeEnabled()
    return DumbPaladin.db.profile.settings.warnings.chat or
            DumbPaladin.db.profile.settings.warnings.raidWarning or
            DumbPaladin.db.profile.settings.warnings.flashScreen or
            DumbPaladin.db.profile.settings.warnings.soundWarning or
            DumbPaladin.db.profile.settings.warnings.textToSpeech
end

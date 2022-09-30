local addonName = ...

DumbPaladin = LibStub("AceAddon-3.0"):NewAddon(addonName)
DumbPaladin.NAME = addonName

local AceGUI = LibStub("AceGUI-3.0")
local AceDB = LibStub("AceDB-3.0")
local AceConfigCmd = LibStub("AceConfigCmd-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConsole = LibStub("AceConsole-3.0")
local Icon = LibStub("LibDBIcon-1.0")

local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

local version = GetAddOnMetadata(DumbPaladin.NAME, "version")

local DumbPaladinLDB = LibStub("LibDataBroker-1.1"):NewDataObject("DumbPaladinMiniMapIcon", {
    type = "launcher",
    text = DumbPaladin.NAME,
    icon = "Interface\\Icons\\Spell_Holy_RighteousnessAura",
    OnTooltipShow = function(tooltip)
        tooltip:SetText(DumbPaladin.NAME)
        tooltip:Show()
   end,
    OnClick = function()
        DumbPaladin:ShowOptions()
    end,
})

-- Enables/disables printing of debug messages
local DumbPaladin_DebugEnabled = false


-- Prints additional debug messages to the default chat window
function DumbPaladin:Debug(string)
    if not string then
        string = "(nil)"
    end

    if DumbPaladin_DebugEnabled then
        AceConsole:Print("[" .. DumbPaladin.NAME .. " - " .. L["DEBUG"] .. "] " .. string)
    end
end


-- Prints a message to the default chat window
function DumbPaladin:Print(string)
    AceConsole:Print("[" .. DumbPaladin.NAME .. "] " .. string)
end


-- Goes through the user's settings and returns a list of all buffs that the player marked as required
function DumbPaladin:RequiredBuffs()
    local requiredBuffs = {}

    for class, classProperties in pairs(self.db.profile.classes) do
        DumbPaladin:Debug("Checking buffs for class " .. class)

        for _, classBuffProperties in pairs(classProperties.buffs) do
            local name, _, _, _, _, _, _ = GetSpellInfo(classBuffProperties.spellIds[0])

            DumbPaladin:Debug("Checking if " .. name .. " is required")
            if classBuffProperties.required then
                DumbPaladin:Debug(name .. " is required")
                requiredBuffs[name] = classBuffProperties.spellIds
            else
                DumbPaladin:Debug(name .. " is not required")
            end
        end
    end

    return requiredBuffs
end


-- Checks if a spell id belongs to a table of spell ids indexed by integers
function DumbPaladin:BuffBelongsToFamilyOfBuffs(buffSpellId, buffFamilySpellIds)
    for _, buffFamilySpellId in pairs(buffFamilySpellIds) do
        if buffSpellId == buffFamilySpellId then
            return true
        end
    end

    return false
end


-- Compares the player's current buffs against a list of required buffs and returns a
-- list of all required buffs missing from the player
function DumbPaladin:MissingRequiredBuffs(requiredBuffs)
    local missingRequiredBuffs = {}

    for requiredBuffName, requiredBuffSpellIds in pairs(requiredBuffs) do
        local missingRequiredBuff = true

        for activeBuffIndex = 1, 32 do
            local activeBuffName, _, _, _, _, _, _, _, _, activeBuffSpellId, _  = UnitBuff("player", activeBuffIndex)

            if not activeBuffName then
                break
            end

            local buffBelongsToFamily = DumbPaladin:BuffBelongsToFamilyOfBuffs(activeBuffSpellId, requiredBuffSpellIds)

            if buffBelongsToFamily == true then
                DumbPaladin:Debug(requiredBuffName .. " is not missing")
                missingRequiredBuff = false
                break
            end
        end

        if missingRequiredBuff then
            DumbPaladin:Debug(requiredBuffName .. " is missing")
            missingRequiredBuffs[requiredBuffName] = true
        end
    end

    return missingRequiredBuffs
end


function DumbPaladin:IsWarningEnabled()
    return self.db.profile.settings.warnings.chat == true or
            self.db.profile.settings.warnings.raidWarning == true or
            self.db.profile.settings.warnings.flashScreen == true or
            self.db.profile.settings.warnings.soundWarning == true
end


-- Checks the player's current buffs against the required buffs, and displays messages
-- letting the player know which buffs he's missing
function DumbPaladin:CheckBuffs()
    if not DumbPaladin:IsWarningEnabled() then
        DumbPaladin:Debug("Warnings disabled. Skipping buff check.")
        return
    end

    DumbPaladin:Debug("Performing buff checks.")

    local requiredBuffs = DumbPaladin:RequiredBuffs()
    local missingRequiredBuffs = DumbPaladin:MissingRequiredBuffs(requiredBuffs)
    local missingBuffCount = 0

    for _ in pairs(missingRequiredBuffs) do
        missingBuffCount = missingBuffCount + 1
    end

    if missingBuffCount > 0 then
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

        if self.db.profile.settings.warnings.raidWarning == true then
            DumbPaladin:RaidWarning(L["MissingBuffsWarning"])
            DumbPaladin:RaidWarning(accumulatedBuffs)
        end

        if self.db.profile.settings.warnings.chat == true then
            DumbPaladin:Print(L["MissingBuffsWarning"])
            DumbPaladin:Print(accumulatedBuffs)
        end

        if self.db.profile.settings.warnings.flashScreen == true then
            DumbPaladin:FlashScreen()
        end

        if self.db.profile.settings.warnings.soundWarning == true then
            DumbPaladin:PlayWarningSound()
        end
    end
end


function DumbPaladin:RaidWarning(message)
    RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
end


-- Flashes red around the edges of the screen for a few seconds
function DumbPaladin:FlashScreen()
    if not self.FlashFrame then
        local flasher = CreateFrame("Frame", "Tc2FlashFrame")
        flasher:SetToplevel(true)
        flasher:SetFrameStrata("FULLSCREEN_DIALOG")
        flasher:SetAllPoints(UIParent)
        flasher:EnableMouse(false)
        flasher:Hide()
        flasher.texture = flasher:CreateTexture(nil, "BACKGROUND")
        flasher.texture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
        flasher.texture:SetAllPoints(UIParent)
        flasher.texture:SetBlendMode("ADD")
        flasher:SetScript("OnShow", function(self)
            self.elapsed = 0
            self:SetAlpha(0)
        end)
        flasher:SetScript("OnUpdate", function(self, elapsed)
            elapsed = self.elapsed + elapsed
            if elapsed < 2.6 then
                local alpha = elapsed % 1.3
                if alpha < 0.15 then
                    self:SetAlpha(alpha / 0.15)
                elseif alpha < 0.9 then
                    self:SetAlpha(1 - (alpha - 0.15) / 0.6)
                else
                    self:SetAlpha(0)
                end
            else
                self:Hide()
            end
            self.elapsed = elapsed
        end)
        self.FlashFrame = flasher
    end

    self.FlashFrame:Show()
end


function DumbPaladin:PlayWarningSound()
    PlaySound(6594)
end


function DumbPaladin:EnteredCombat()
    if self.db.profile.settings.checks.whenEnteringCombat == false then
        return
    end

    DumbPaladin:CheckBuffs()
end


function DumbPaladin:BuffChanged(unitId)
    if self.db.profile.settings.checks.whenInCombat == false then
        return
    end

    if unitId == "player" and UnitAffectingCombat(unitId) then
        DumbPaladin:CheckBuffs()
    end
end


-- Shows the options window if the player is not in combat
function DumbPaladin:ShowOptions()
    if UnitAffectingCombat("player") then
        DumbPaladin:Debug("Can't show options while in combat")
        return
    end

    DumbPaladin_ConfigFrame:Show()
end


function DumbPaladin:OnSettingToggled(info, input)
    DumbPaladin:Debug(tostring(info["option"].name) .. " set to: " .. tostring(input))

    if self.db.profile.minimap.hide == true then
        Icon:Hide("DumbPaladinMiniMapIcon")
    else
        Icon:Show("DumbPaladinMiniMapIcon")
    end
end


function DumbPaladin:OnBuffToggled(info, input)
    DumbPaladin:Debug(tostring(info["option"].name) .. " was set to: " .. tostring(input))
end


function DumbPaladin:InitializeDatabase()
    self.db = AceDB:New("DumbPaladinDB", DumbPaladin_DefaultDatabase)
end


-- Creates and registers the options window
function DumbPaladin:RegisterOptions()
    AceConfigRegistry:RegisterOptionsTable(DumbPaladin.NAME, DumbPaladin_Options, false)
    AceConfigCmd:CreateChatCommand("dp", DumbPaladin.NAME)
    AceConfigCmd:CreateChatCommand(DumbPaladin.NAME, DumbPaladin.NAME)
end


function DumbPaladin:CreateConfigFrame()
    if not DumbPaladin_ConfigFrame then
		local ConfigFrame = AceGUI:Create("Frame")

        AceConfigDialog:SetDefaultSize(DumbPaladin.NAME, 600, 500)
		AceConfigDialog:Open(DumbPaladin.NAME, ConfigFrame)

        ConfigFrame:SetStatusText(DumbPaladin.NAME .. " v" .. version)
		ConfigFrame:EnableResize(false)
		ConfigFrame:Hide()
		_G["DumbPaladin_ConfigFrame"] = ConfigFrame.frame
		table.insert(UISpecialFrames, "DumbPaladin_ConfigFrame")
	end
end


function DumbPaladin:SetupMinimapIcon()
    Icon:Register("DumbPaladinMiniMapIcon", DumbPaladinLDB, self.db.profile.minimap)
end


-- Register for all the events this addon listens for
function DumbPaladin:RegisterEvents()
    local EventFrame = CreateFrame("Frame", "DumbPaladin_EventFrame")

    EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    EventFrame:RegisterEvent("UNIT_AURA")

    EventFrame:SetScript("OnEvent", function(self, event, ...)
        if event=="PLAYER_REGEN_DISABLED" then
            DumbPaladin:Debug("Entering combat")
            DumbPaladin:EnteredCombat()
        elseif event=="UNIT_AURA" then
            local unitId = ...
            if unitId == "player" then
                DumbPaladin:Debug("Buff gained/dropped")
                DumbPaladin:BuffChanged(unitId)
            end
        end
    end)
end


function DumbPaladin:OnInitialize()
    DumbPaladin:InitializeDatabase()
    DumbPaladin:RegisterOptions()
    DumbPaladin:CreateConfigFrame()
    DumbPaladin:SetupMinimapIcon()
end


function DumbPaladin:OnEnable()
    DumbPaladin:RegisterEvents()
end
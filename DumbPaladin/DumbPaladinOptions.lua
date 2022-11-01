local AceConfigCmd = LibStub("AceConfigCmd-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

local function buildTabardNames(tabards)
    if not tabards then
        tabards = {}
    end

    local tabardNames = {}

    for tabard, properties in pairs (tabards) do
        tabardNames[tabard] = properties.name
    end

    return tabardNames
end

local function buildClassBuffOptions(buffs)
    if not buffs then
        buffs = {}
    end

    local buffOptions = {}

    for buffId, buffDetails in pairs(buffs) do
        buffOptions[buffId] = {
            name = buffDetails.name,
            type = "toggle",
        }
    end

    return buffOptions
end

local function buildClassOption(classId, classDetails)
    if not classId then
        classId = "(nil)"
    end

    if not classDetails then
        classDetails = {}
    end

    local classOptions = {}

    classOptions["name"] = classDetails.name
    classOptions["type"] = "group"
    classOptions["childGroups"] = "tab"
    classOptions["set"] = function(info, input)
        DumbPaladin.db.profile.classes[classId].buffs[info[#info]].required = input
        DumbPaladin:OnSettingToggled(info, input)
    end
    classOptions["get"] = function(info)
        return DumbPaladin.db.profile.classes[classId].buffs[info[#info]].required
    end
    classOptions["args"] = buildClassBuffOptions(classDetails.buffs)

    return classOptions
end

local function buildClassOptions(classes)
    if not classes then
        classes = {}
    end

    local buffs = {}

    for classId, classDetails in pairs(classes) do
        buffs[classId] = buildClassOption(classId, classDetails)
    end

    return buffs
end

local DumbPaladin_Options = {
    name = DumbPaladin.NAME .. " v" .. DumbPaladin.VERSION,
    type = "group",
    childGroups = "tab",
    args = {
        options = {
            name = L["Options"],
            type = "execute",
            guiHidden = true,
            func = function()
                DumbPaladin:ShowOptions()
            end
        },
        check = {
            name = L["Checks for buffs"],
            type = "execute",
            guiHidden = true,
            func = function()
                DumbPaladin:CheckForMissingRequiredBuffsFromUnit()
            end
        },
        general = {
            order = 1,
            name = L["General"],
            type = "group",
            cmdHidden = true,
            args = {
                minimap = {
                    name = L["Minimap"],
                    type = "group",
                    inline = true,
                    cmdHidden = true,
                    args = {
                        hideMinimap = {
                            name = L["Hide Minimap"],
                            cmdHidden = true,
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.minimap.hide = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.minimap.hide
                            end
                        }
                    }
                }
            }
        },
        buffs = {
            order = 2,
            name = L["Buffs"],
            type = "group",
            cmdHidden = true,
            args = {
                warnings = {
                    name = L["WarningsSettings"],
                    type = "group",
                    inline = true,
                    args = {
                        chat = {
                            name = L["ChatWarning"],
                            desc = L["ChatWarningTooltip"],
                            cmdHidden = true,
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.warnings.chat = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.warnings.chat
                            end
                        },
                        raidWarning = {
                            name = L["RaidWarning"],
                            desc = L["RaidWarningTooltip"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.warnings.raidWarning = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.warnings.raidWarning
                            end
                        },
                        flashScreen = {
                            name = L["FlashScreen"],
                            desc = L["FlashScreenTooltip"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.warnings.flashScreen = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.warnings.flashScreen
                            end
                        },
                        soundWarning = {
                            name = L["SoundWarning"],
                            desc = L["SoundWarningTooltip"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.warnings.soundWarning = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.warnings.soundWarning
                            end
                        },
                        textToSpeech = {
                            name = L["TextToSpeech"],
                            desc = L["TextToSpeechTooltip"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.warnings.textToSpeech = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.warnings.textToSpeech
                            end
                        }
                    }
                },
                checks = {
                    name = L["BuffChecksSettings"],
                    type = "group",
                    inline = true,
                    args = {
                        whenEnteringCombat = {
                            name = L["CheckWhenEnteringCombat"],
                            desc = L["CheckWhenEnteringCombatDescription"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.buffChecks.whenEnteringCombat = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.buffChecks.whenEnteringCombat
                            end
                        },
                        whenInCombat = {
                            name = L["CheckInCombat"],
                            desc = L["CheckInCombatDescription"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.buffChecks.whenInCombat = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.buffChecks.whenInCombat
                            end
                        },
                    }
                },
                classBuffs = {
                    name = L["ClassBuffsSettings"],
                    type = "group",
                    args = buildClassOptions(DumbPaladin.Buffs)
                },
            }
        },
        gear = {
            order = 3,
            name = L["Gear"],
            type = "group",
            cmdHidden = true,
            args = {
                checks = {
                    order = 3,
                    name = L["GearChecksSettings"],
                    type = "group",
                    inline = true,
                    args = {
                        whenEnteringDungeons = {
                            name = L["CheckWhenEnteringDungeons"],
                            desc = L["CheckWhenEnteringDungeonsDescription"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.settings.gearChecks.whenEnteringDungeons = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.settings.gearChecks.whenEnteringDungeons
                            end
                        },
                    },
                },
                tabards = {
                    name = L["TabardsSettings"],
                    type = "group",
                    inline = true,
                    args = {
                        checkTabards = {
                            order = 1,
                            name = L["CheckTabards"],
                            type = "toggle",
                            set = function(info, input)
                                DumbPaladin.db.profile.tabards.checkTabards = input
                                DumbPaladin:OnSettingToggled(info, input)
                            end,
                            get = function()
                                return DumbPaladin.db.profile.tabards.checkTabards
                            end
                        },
                        availableTabards = {
                            order = 2,
                            name = "",
                            type = "select",
                            style = "dropdown",
                            values = buildTabardNames(DumbPaladin.Tabards),
                            disabled = function()
                                return not DumbPaladin.db.profile.tabards.checkTabards
                            end,
                            set = function(_, input)
                                DumbPaladin.db.profile.tabards.selectedTabard = input
                            end,
                            get = function()
                                local selectedTabard = DumbPaladin.db.profile.tabards.selectedTabard

                                if not selectedTabard then
                                    return ""
                                end

                                return DumbPaladin.db.profile.tabards.selectedTabard
                            end
                        }
                    }
                }
            }
        }
    }
}

-- Creates and registers the options window
function DumbPaladin:RegisterOptions()
    DumbPaladin_Options.args.profile = AceDBOptions:GetOptionsTable(DumbPaladin.db)
    DumbPaladin_Options.args.profile.order = 4
    DumbPaladin_Options.args.profile.cmdHidden = true

    AceConfigRegistry:RegisterOptionsTable(DumbPaladin.NAME, DumbPaladin_Options, false)
end

function DumbPaladin:CreateSlashCommands()
    AceConfigCmd:CreateChatCommand("dp", DumbPaladin.NAME)
    AceConfigCmd:CreateChatCommand(DumbPaladin.NAME, DumbPaladin.NAME)
end

-- Shows the options window if the player is not in combat
function DumbPaladin:ShowOptions()
    if UnitAffectingCombat("player") then
        DumbPaladin:PrintDebugMessageToChatWindow("Can't show options while in combat")
        return
    end

    AceConfigDialog:SetDefaultSize(DumbPaladin.NAME, 600, 700)
    AceConfigDialog:Open(DumbPaladin.NAME)
end

function DumbPaladin:OnSettingToggled(info, input)
    DumbPaladin:PrintDebugMessageToChatWindow(tostring(info["option"].name) .. " set to: " .. tostring(input))

    if DumbPaladin.db.profile.minimap.hide then
        Icon:Hide("DumbPaladinMiniMapIcon")
    else
        Icon:Show("DumbPaladinMiniMapIcon")
    end
end






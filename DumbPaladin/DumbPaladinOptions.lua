local addonName = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)


local function buildClassBuffOptions(buffs)
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
    local classOptions = {}
    
    classOptions["name"] = classDetails.name
    classOptions["type"] = "group"
    classOptions["inline"] = true
    classOptions["cmdHidden"] = true
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
    local buffs = {}

    for classId, classDetails in pairs(classes) do
        buffs[classId] = buildClassOption(classId, classDetails)
    end
    
    return buffs
end


DumbPaladin_Options = {
    name = DumbPaladin.NAME,
    type = "group",
    args = {
        general = {
            order = 1,
            name = L["GeneralSettings"],
            type = "group",
            inline = true,
            args = {
                minimap = {
                    name = L["HideMinimap"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.minimap.hide = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.minimap.hide
                    end
                },
                options = {
                    name = L["OptionsCommandDescription"],
                    type = "execute",
                    guiHidden = true,
                    func = function ()
                        DumbPaladin:ShowOptions()
                    end
                },
                check = {
                    name = L["CheckCommandDescription"],
                    type = "execute",
                    guiHidden = true,
                    func = function ()
                        DumbPaladin:CheckBuffs()
                    end
                }
            }
        },
        warnings = {
            order = 2,
            name = L["WarningsSettings"],
            type = "group",
            inline = true,
            cmdHidden = true,
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
                    get = function(info)
                        return DumbPaladin.db.profile.settings.warnings.chat
                    end
                },
                raidWarning = {
                    name = L["RaidWarning"],
                    desc = L["RaidWarningTooltip"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.warnings.raidWarning = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.warnings.raidWarning
                    end
                },
                flashScreen = {
                    name = L["FlashScreen"],
                    desc = L["FlashScreenTooltip"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.warnings.flashScreen = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.warnings.flashScreen
                    end
                },
                soundWarning = {
                    name = L["SoundWarning"],
                    desc = L["SoundWarningTooltip"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.warnings.soundWarning = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.warnings.soundWarning
                    end
                },
                textToSpeect = {
                    name = L["TextToSpeech"],
                    desc = L["TextToSpeechTooltip"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.warnings.textToSpeech = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.warnings.textToSpeech
                    end
                }
            }
        },
        checks = {
            order = 3,
            name = L["ChecksSettings"],
            type = "group",
            inline = true,
            cmdHidden = true,
            args = {
                whenEnteringCombat = {
                    name = L["CheckWhenEnteringCombat"],
                    desc = L["CheckWhenEnteringCombatDescription"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.checks.whenEnteringCombat = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.checks.whenEnteringCombat
                    end
                },
                whenInCombat = {
                    name = L["CheckInCombat"],
                    desc = L["CheckInCombatDescription"],
                    cmdHidden = true,
                    type = "toggle",
                    set = function(info, input)
                        DumbPaladin.db.profile.settings.checks.whenInCombat = input
                        DumbPaladin:OnSettingToggled(info, input)
                    end,
                    get = function(info)
                        return DumbPaladin.db.profile.settings.checks.whenInCombat
                    end
                },
            }
        },
        buffs = {
            order = 4,
            name = L["ClassBuffsSettings"],
            type = "group",
            inline = true,
            cmdHidden = true,
            args = buildClassOptions(DumbPaladin_DefaultDatabase.profile.classes)
        }
    }
}

local AceConfigCmd = LibStub("AceConfigCmd-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)
local LibDBIcon = LibStub("LibDBIcon-1.0")

local function BuildTalentSpecs()
    local availableSpecs = {}

    for index = 1, GetNumTalentTabs() do
        local name = GetTalentTabInfo(index)
        availableSpecs[index] = name

        DumbPaladin:PrintDebugMessageToChatWindow("Found spec with name " .. name .. " and index " .. index)
    end

    return availableSpecs
end

local function BuildTabardNames(tabards)
    if not tabards then
        tabards = {}
    end

    local tabardNames = {}

    for tabard, properties in pairs (tabards) do
        tabardNames[tabard] = properties.name
    end

    return tabardNames
end

local function BuildItemRackSets(itemRack)
    if not itemRack then
        return {}
    end

    if not itemRack.Sets then
        return {}
    end

    local itemRackSets = itemRack.Sets
    local itemRackSetNames = {}

    for name, _ in pairs(itemRackSets) do
        if name and name ~= "~Unequip" and name ~= "~CombatQueue" then
            itemRackSetNames[name] = name
        end
    end

    return itemRackSetNames
end

local function BuildClassBuffOptions(buffs)
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

local function BuildClassOption(classId, classDetails)
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
        DumbPaladin.db.profile.settings.buffs.classes[classId].buffs[info[#info]].required = input
        DumbPaladin:OnSettingToggled(info, input)
    end
    classOptions["get"] = function(info)
        return DumbPaladin.db.profile.settings.buffs.classes[classId].buffs[info[#info]].required
    end
    classOptions["args"] = BuildClassBuffOptions(classDetails.buffs)

    return classOptions
end

local function BuildClassOptions(classes)
    if not classes then
        classes = {}
    end

    local buffs = {}

    for classId, classDetails in pairs(classes) do
        buffs[classId] = BuildClassOption(classId, classDetails)
    end

    return buffs
end

local function BuildOptions()
    return {
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
                    DumbPaladin:PerformBuffChecksOnUnit("player")
                    DumbPaladin:PerformGearChecksOnUnit("player")
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
                                    DumbPaladin.db.profile.settings.buffs.warnings.chat = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.warnings.chat
                                end
                            },
                            raidWarning = {
                                name = L["RaidWarning"],
                                desc = L["RaidWarningTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.buffs.warnings.raidWarning = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.warnings.raidWarning
                                end
                            },
                            flashScreen = {
                                name = L["FlashScreen"],
                                desc = L["FlashScreenTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.buffs.warnings.flashScreen = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.warnings.flashScreen
                                end
                            },
                            soundWarning = {
                                name = L["SoundWarning"],
                                desc = L["SoundWarningTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.buffs.warnings.soundWarning = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.warnings.soundWarning
                                end
                            },
                            textToSpeech = {
                                name = L["TextToSpeech"],
                                desc = L["TextToSpeechTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.buffs.warnings.textToSpeech = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.warnings.textToSpeech
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
                                    DumbPaladin.db.profile.settings.buffs.checks.whenEnteringCombat = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.checks.whenEnteringCombat
                                end
                            },
                            whenInCombat = {
                                name = L["CheckInCombat"],
                                desc = L["CheckInCombatDescription"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.buffs.checks.whenInCombat = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.buffs.checks.whenInCombat
                                end
                            },
                        }
                    },
                    classBuffs = {
                        name = L["ClassBuffsSettings"],
                        type = "group",
                        args = BuildClassOptions(DumbPaladin.Buffs)
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
                        order = 1,
                        name = L["GearChecksSettings"],
                        type = "group",
                        inline = true,
                        args = {
                            whenEnteringDungeons = {
                                name = L["CheckWhenEnteringDungeons"],
                                desc = L["CheckWhenEnteringDungeonsDescription"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.checks.whenEnteringDungeons = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.checks.whenEnteringDungeons
                                end
                            },
                        },
                    },
                    warnings = {
                        name = L["WarningsSettings"],
                        order = 2,
                        type = "group",
                        inline = true,
                        args = {
                            chat = {
                                name = L["ChatWarning"],
                                desc = L["ChatWarningTooltip"],
                                cmdHidden = true,
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.warnings.chat = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.warnings.chat
                                end
                            },
                            raidWarning = {
                                name = L["RaidWarning"],
                                desc = L["RaidWarningTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.tabards.gear.raidWarning = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.warnings.raidWarning
                                end
                            },
                            flashScreen = {
                                name = L["FlashScreen"],
                                desc = L["FlashScreenTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.warnings.flashScreen = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.warnings.flashScreen
                                end
                            },
                            soundWarning = {
                                name = L["SoundWarning"],
                                desc = L["SoundWarningTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.warnings.soundWarning = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.warnings.soundWarning
                                end
                            },
                            textToSpeech = {
                                name = L["TextToSpeech"],
                                desc = L["TextToSpeechTooltip"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.warnings.textToSpeech = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.warnings.textToSpeech
                                end
                            }
                        }
                    },
                    tabards = {
                        name = L["TabardsSettings"],
                        order = 3,
                        type = "group",
                        inline = true,
                        args = {
                            checkTabards = {
                                order = 1,
                                name = L["CheckTabards"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.tabards.checkTabards = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.tabards.checkTabards
                                end
                            },
                            availableTabards = {
                                order = 2,
                                name = "",
                                type = "select",
                                style = "dropdown",
                                values = BuildTabardNames(DumbPaladin.Tabards),
                                disabled = function()
                                    return not DumbPaladin.db.profile.settings.gear.tabards.checkTabards
                                end,
                                set = function(_, input)
                                    DumbPaladin.db.profile.settings.gear.tabards.selectedTabard = input
                                end,
                                get = function()
                                    local selectedTabard = DumbPaladin.db.profile.settings.gear.tabards.selectedTabard

                                    if not selectedTabard then
                                        return ""
                                    end

                                    return DumbPaladin.db.profile.settings.gear.tabards.selectedTabard
                                end
                            }
                        }
                    },
                    itemRack = {
                        name = L["ItemRackSettings"],
                        order = 4,
                        type = "group",
                        inline = true,
                        args = {
                            checkItemRackSets = {
                                order = 1,
                                name = L["CheckItemRackSets"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.itemRack.checkItemRackSet = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.itemRack.checkItemRackSet
                                end
                            },
                            availableItemRackSets = {
                                order = 2,
                                name = "",
                                type = "select",
                                style = "dropdown",
                                values = BuildItemRackSets(ItemRackUser),
                                disabled = function()
                                    return not DumbPaladin.db.profile.settings.gear.itemRack.checkItemRackSet
                                end,
                                set = function(_, input)
                                    DumbPaladin.db.profile.settings.gear.itemRack.selectedItemRackSet = input
                                end,
                                get = function()
                                    local selectedItemRackSet = DumbPaladin.db.profile.settings.gear.itemRack.selectedItemRackSet

                                    if not selectedItemRackSet then
                                        return ""
                                    end

                                    return DumbPaladin.db.profile.settings.gear.itemRack.selectedItemRackSet
                                end
                            }
                        }
                    },
                    spec = {
                        name = L["SpecSettings"],
                        order = 5,
                        type = "group",
                        inline = true,
                        args = {
                            checkTalentSpec = {
                                order = 1,
                                name = L["CheckTalentSpec"],
                                type = "toggle",
                                set = function(info, input)
                                    DumbPaladin.db.profile.settings.gear.talentSpec.checkTalentSpec = input
                                    DumbPaladin:OnSettingToggled(info, input)
                                end,
                                get = function()
                                    return DumbPaladin.db.profile.settings.gear.talentSpec.checkTalentSpec
                                end
                            },
                            availableTalentSpecs = {
                                order = 2,
                                name = "",
                                type = "select",
                                style = "dropdown",
                                values = BuildTalentSpecs(),
                                disabled = function()
                                    return not DumbPaladin.db.profile.settings.gear.talentSpec.checkTalentSpec
                                end,
                                set = function(_, input)
                                    DumbPaladin.db.profile.settings.gear.talentSpec.selectedTalentSpec = input
                                end,
                                get = function()
                                    local selectedTalentSpec = DumbPaladin.db.profile.settings.gear.talentSpec.selectedTalentSpec

                                    if not selectedTalentSpec then
                                        return ""
                                    end

                                    return DumbPaladin.db.profile.settings.gear.talentSpec.selectedTalentSpec
                                end
                            }
                        }
                    }
                }
            }
        }
    }
end

-- Creates and registers the options window
function DumbPaladin:RegisterOptions()
    local options = BuildOptions()

    options.args.profile = AceDBOptions:GetOptionsTable(DumbPaladin.db)
    options.args.profile.order = 4
    options.args.profile.cmdHidden = true

    AceConfigRegistry:RegisterOptionsTable(DumbPaladin.NAME, options, false)
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
        LibDBIcon:Hide("DumbPaladinMiniMapIcon")
    else
        LibDBIcon:Show("DumbPaladinMiniMapIcon")
    end
end
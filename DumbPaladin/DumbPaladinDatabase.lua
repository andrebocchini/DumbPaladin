local AceDB = LibStub("AceDB-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

local DumbPaladin_DefaultDatabase = {
    profile = {
        minimap = {
            hide = false
        },
        settings = {
            buffs = {
                checks = {
                    whenEnteringCombat = true,
                    whenInCombat = false
                },
                warnings = {
                    chat = true,
                    raidWarning = true,
                    flashScreen = true,
                    soundWarning = true,
                    textToSpeech = true,
                },
                classes = {
                    druid = {
                        name = L["Druid"],
                        buffs = {
                            markOfTheWild = {
                                required = false
                            },
                            thorns = {
                                required = false
                            }
                        }
                    },
                    hunter = {
                        name = L["Hunter"],
                        buffs = {
                            aspectOfTheBeast = {
                                required = false
                            },
                            aspectOfTheCheetah = {
                                required = false
                            },
                            aspectOfTheDragonhawk = {
                                required = false
                            },
                            aspectOfTheHawk = {
                                required = false
                            },
                            aspectOfTheMonkey = {
                                required = false
                            },
                            aspectOfThePack = {
                                required = false
                            },
                            aspectOfTheViper = {
                                required = false
                            },
                            aspectOfTheWild = {
                                required = false
                            },
                        }
                    },
                    mage = {
                        name = L["Mage"],
                        buffs = {
                            amplifyMagic = {
                                required = false
                            },
                            arcaneIntellect = {
                                required = false
                            },
                            dampenMagic = {
                                required = false
                            },
                            frostArmor = {
                                required = false
                            },
                            iceArmor = {
                                required = false
                            },
                            mageArmor = {
                                required = false
                            },
                            moltenArmor = {
                                required = false
                            }
                        }
                    },
                    paladin = {
                        name = L["Paladin"],
                        buffs = {
                            blessingOfKings = {
                                required = false
                            },
                            blessingOfMight = {
                                required = false
                            },
                            blessingOfWisdom = {
                                required = false
                            },
                            blessingOfProtection = {
                                required = false
                            },
                            blessingOfSanctuary = {
                                required = false
                            },
                            concentrationAura = {
                                required = false
                            },
                            crusaderAura = {
                                required = false
                            },
                            devotionAura = {
                                required = false
                            },
                            fireResistanceAura = {
                                required = false
                            },
                            frostResistanceAura = {
                                required = false
                            },
                            retributionAura = {
                                required = false
                            },
                            righteousFury = {
                                required = false
                            },
                            sacredShield = {
                                required = false
                            },
                            sealOfCorruption = {
                                required = false
                            },
                            sealOfJustice = {
                                required = false
                            },
                            sealOfLight = {
                                required = false
                            },
                            sealOfRighteousness = {
                                required = false
                            },
                            sealOfVengeance = {
                                required = false
                            },
                            sealOfWisdom = {
                                required = false
                            },
                            shadowResistanceAura = {
                                required = false
                            }
                        }
                    },
                    priest = {
                        name = L["Priest"],
                        buffs = {
                            divineSpirit = {
                                required = false
                            },
                            fearWard = {
                                required = false
                            },
                            innerFire = {
                                required = false
                            },
                            powerWordFortitude = {
                                required = false
                            },
                            shadowProtection = {
                                required = false
                            },
                            vampiricEmbrace = {
                                required = false
                            },
                        }
                    },
                    warlock = {
                        name = L["Warlock"],
                        buffs = {
                            demonArmor = {
                                required = false
                            },
                            demonSkin = {
                                required = false
                            },
                            felArmor = {
                                required = false
                            },
                            unendingBreath = {
                                required = false
                            }
                        }
                    }
                }
            },
            gear = {
                checks = {
                    whenEnteringDungeons = true
                },
                warnings = {
                    chat = true,
                    raidWarning = true,
                    flashScreen = true,
                    soundWarning = true,
                    textToSpeech = true,
                },
                tabards = {
                    checkTabards = false,
                    selectedTabard = ""
                },
                itemRack = {
                    checkItemRackSet = false,
                    selectedItemRackSet = ""
                },
                talentSpec = {
                    checkTalentSpec = false,
                    selectedTalentSpec = ""
                }
            },
        },

    }
}

function DumbPaladin:InitializeDatabase()
    DumbPaladin.db = AceDB:New("DumbPaladinDB", DumbPaladin_DefaultDatabase, true)
end
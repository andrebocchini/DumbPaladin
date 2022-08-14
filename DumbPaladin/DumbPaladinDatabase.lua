local addonName = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

DumbPaladin_DefaultDatabase = {
    profile = {
        minimap = {
            hide = false
        },
        settings = {
            checks = {
                whenEnteringCombat = true,
                whenInCombat = false
            },
            warnings = {
                chat = true,
                raidWarning = true,
                flashScreen = true,
                soundWarning = true
            }
        },
        classes = {
            paladin = {
                name = L["Paladin"],
                buffs = {
                    blessingOfWisdom = {
                        name = select(1, GetSpellInfo(19742)),
                        required = false,
                        spellIds = {
                            [0] = 19742, -- Blessing of Wisdom
                            [1] = 19850,
                            [2] = 19852,
                            [3] = 19853,
                            [4] = 19854, 
                            [5] = 25290,
                            [6] = 27142,
                            [7] = 25894, -- Greater Blessing of Wisdom
                            [8] = 25918,
                            [9] = 27143
                        },
                    },
                    blessingOfLight = {
                        name = select(1, GetSpellInfo(19977)),
                        required = false,
                        spellIds = {
                            [0] = 19977, -- Blessing of Light
                            [1] = 19978,
                            [2] = 19979,
                            [3] = 27144,
                            [4] = 25890, -- Greater Blessing of Light
                            [5] = 27145
                        }
                    },
                    blessingOfMight = {
                        name = select(1, GetSpellInfo(19740)),
                        required = false,
                        spellIds = {
                            [0] = 19740, -- Blessing of Might
                            [1] = 19834,
                            [2] = 19835,
                            [3] = 19836,
                            [4] = 19837,
                            [5] = 19838,
                            [6] = 25291,
                            [7] = 27140,
                            [8] = 25782, -- Greater Blessing of Might
                            [9] = 25916,
                            [10] = 27141
                        }
                    },
                    blessingOfSalvation = {
                        name = select(1, GetSpellInfo(1038)),
                        required = false,
                        spellIds = {
                            [0] = 1038, -- Blessing of Salvation
                            [1] = 25895  -- Greater Blessing of Salvation
                        }
                    },
                    blessingOfKings = {
                        name = select(1, GetSpellInfo(20217)),
                        required = false,
                        spellIds = {
                            [0] = 20217, -- Blessing of Kings
                            [1] = 25898  -- Greater Blessing of Kings
                        }
                    },
                    blessingOfProtection = {
                        name = select(1, GetSpellInfo(1022)),
                        required = false,
                        spellIds = {
                            [0] = 1022, 
                            [1] = 5599,
                            [2] = 10278
                        }
                    },
                    blessingOfSanctuary = {
                        name = select(1, GetSpellInfo(20911)),
                        required = false,
                        spellIds = {
                            [0] = 20911, -- Blessing of Sanctuary 
                            [1] = 20912,
                            [2] = 20913,
                            [3] = 20914,
                            [4] = 27168,
                            [5] = 25899, -- Greater Blessing of Sanctuary
                            [6] = 27169
                        }
                    },
                    righteousFury = {
                        name = select(1, GetSpellInfo(25780)),
                        required = false,
                        spellIds = {
                            [0] = 25780
                        }
                    },
                    retributionAura = {
                        name = select(1, GetSpellInfo(7294)),
                        required = false,
                        spellIds = {
                            [0] = 7294,
                            [1] = 10298,
                            [2] = 10299,
                            [3] = 10300,
                            [4] = 10301,
                            [5] = 27150
                        }
                    },
                    devotionAura = {
                        name = select(1, GetSpellInfo(465)),
                        required = false,
                        spellIds = {
                            [0] = 465,
                            [1] = 10290,
                            [2] = 643,
                            [3] = 10291,
                            [4] = 1032,
                            [5] = 10292,
                            [6] = 10293,
                            [7] = 27149
                        }
                    },
                    concentrationAura = {
                        name = select(1, GetSpellInfo(19746)),
                        required = false,
                        spellIds = {
                            [0] = 19746
                        }
                    },
                    crusaderAura = {
                        name = select(1, GetSpellInfo(32223)),
                        required = false,
                        spellIds = {
                            [0] = 32223
                        }
                    },
                    fireResistanceAura = {
                        name = select(1, GetSpellInfo(19891)),
                        required = false,
                        spellIds = {
                            [0] = 19891,
                            [1] = 19899,
                            [2] = 19900,
                            [3] = 27153
                        }
                    },
                    frostResistanceAura = {
                        name = select(1, GetSpellInfo(19888)),
                        required = false,
                        spellIds = {
                            [0] = 19888,
                            [1] = 19897,
                            [2] = 19898,
                            [3] = 27152
                        }
                    },
                    shadowResistanceAura = {
                        name = select(1, GetSpellInfo(19876)),
                        required = false,
                        spellIds = {
                            [0] = 19876,
                            [1] = 19895,
                            [2] = 19896,
                            [3] = 27151
                        }
                    }
                }
            },
            mage = {
                name = L["Mage"],
                buffs = {
                    moltenArmor = {
                        name = select(1, GetSpellInfo(30482)),
                        required = false,
                        spellIds = {
                            [0] = 30482
                        }
                    },
                    arcaneIntellect = {
                        name = select(1, GetSpellInfo(1459)),
                        required = false,
                        spellIds = {
                            [0] = 1459, -- Arcane Intellect
                            [1] = 1460,
                            [2] = 1461,
                            [3] = 10156,
                            [4] = 10157,
                            [5] = 27126,
                            [6] = 23028, -- Arcane Brilliance
                            [7] = 27127,
                        }
                    },
                    iceBarrier = {
                        name = select(1, GetSpellInfo(11426)),
                        required = false,
                        spellIds = {
                            [0] = 11426,
                            [1] = 13031,
                            [2] = 13032,
                            [3] = 13033,
                            [4] = 27134,
                            [5] = 33405
                        }
                    },
                    mageArmor = {
                        name = select(1, GetSpellInfo(6117)),
                        required = false,
                        spellIds = {
                            [0] = 6117,
                            [1] = 22782,
                            [2] = 22783,
                            [3] = 27125
                        }
                    },
                    iceArmor = {
                        name = select(1, GetSpellInfo(7302)),
                        required = false,
                        spellIds = {
                            [0] = 7302,
                            [1] = 7320,
                            [2] = 10219,
                            [3] = 10220,
                            [4] = 27124
                        }
                    },
                    amplifyMagic = {
                        name = select(1, GetSpellInfo(1008)),
                        required = false,
                        spellIds = {
                            [0] = 1008,
                            [1] = 8455,
                            [2] = 10169,
                            [3] = 10170,
                            [4] = 27130,
                            [5] = 33946
                        }
                    },
                    dampenMagic = {
                        name = select(1, GetSpellInfo(604)),
                        required = false,
                        spellIds = {
                            [0] = 604,
                            [1] = 8450,
                            [2] = 8451,
                            [3] = 10173,
                            [4] = 10174,
                            [5] = 33944
                        }
                    }
                }
            },
            druid = {
                name = L["Druid"],
                buffs = {
                    markOfTheWild = {
                        name = select(1, GetSpellInfo(1126)),
                        required = false,
                        spellIds = {
                            [0] = 1126, -- Mark of The Wild
                            [1] = 5232,
                            [2] = 6756,
                            [3] = 5234,
                            [4] = 8907,
                            [5] = 9884,
                            [6] = 9885,
                            [7] = 26990,
                            [8] = 21849, -- Gift of The Wild
                            [9] = 21850,
                            [10] = 26991
                        }
                    },
                    thorns = {
                        name = select(1, GetSpellInfo(467)),
                        required = false,
                        spellIds = {
                            [0] = 467,
                            [1] = 782,
                            [2] = 1075,
                            [3] = 8914,
                            [4] = 9756,
                            [5] = 9910,
                            [6] = 26992
                        }
                    }
                }
            },
            warlock = {
                name = L["Warlock"],
                buffs = {
                    demonArmor = {
                        name = select(1, GetSpellInfo(11733)),
                        required = false,
                        spellIds = {
                            [0] = 687,
                            [1] = 696,
                            [2] = 11733,
                            [3] = 11734,
                            [4] = 11734,
                            [5] = 27260
                        }
                    },
                    felArmor = {
                        name = select(1, GetSpellInfo(28176)),
                        required = false,
                        spellIds = {
                            [0] = 28176,
                            [1] = 28189
                        }
                    },
                    unendingBreath = {
                        name = select(1, GetSpellInfo(5697)),
                        required = false,
                        spellIds = {
                            [0] = 5697
                        }
                    },
                    soulLink = {
                        name = select(1, GetSpellInfo(19028)),
                        required = false,
                        spellIds = {
                            [0] = 19028
                        }
                    }
                }
            },
            priest = {
                name = L["Priest"],
                buffs = {
                    innerFire = {
                        name = select(1, GetSpellInfo(588)),
                        required = false,
                        spellIds = {
                            [0] = 588,
                            [1] = 7128,
                            [2] = 602,
                            [3] = 1006,
                            [4] = 10951,
                            [5] = 10952,
                            [6] = 25431
                        }
                    },
                    powerWordFortitude = {
                        name = select(1, GetSpellInfo(1243)),
                        required = false,
                        spellIds = {
                            [0] = 1243,
                            [1] = 1244,
                            [2] = 1245,
                            [3] = 2791,
                            [4] = 10937,
                            [5] = 10938,
                            [6] = 25389,
                            [7] = 21562, -- Prayer of Fortitude
                            [8] = 21564,
                            [9] = 25392
                        }
                    }
                }
            },
            hunter = {
                name = L["Hunter"],
                buffs = {
                    aspectOfTheBeast = {
                        name = select(1, GetSpellInfo(13161)),
                        required = false,
                        spellIds = {
                            [0] = 13161
                        }
                    },
                    aspectOfTheCheetah = {
                        name = select(1, GetSpellInfo(5118)),
                        required = false,
                        spellIds = {
                            [0] = 5118
                        }
                    },
                    aspectOfTheHawk = {
                        name = select(1, GetSpellInfo(13165)),
                        required = false,
                        spellIds = {
                            [0] = 13165,
                            [1] = 14318,
                            [2] = 14319,
                            [3] = 14320,
                            [4] = 14321,
                            [5] = 14322,
                            [6] = 25296,
                            [7] = 27044,
                        }
                    },
                    aspectOfTheMonkey = {
                        name = select(1, GetSpellInfo(13163)),
                        required = false,
                        spellIds = {
                            [0] = 13163
                        }
                    },
                    aspectOfThePack = {
                        name = select(1, GetSpellInfo(13159)),
                        required = false,
                        spellIds = {
                            [0] = 13159
                        }
                    },
                    aspectOfTheViper = {
                        name = select(1, GetSpellInfo(34074)),
                        required = false,
                        spellIds = {
                            [0] = 34074
                        }
                    },
                    aspectOfTheWild = {
                        name = select(1, GetSpellInfo(20043)),
                        required = false,
                        spellIds = {
                            [0] = 20043,
                            [1] = 20190,
                            [2] = 27045,
                        }
                    },
                }
            }
        }
    }
}
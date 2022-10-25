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
                soundWarning = true,
                textToSpeech = true,
            }
        },
        classes = {
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
                            [8] = 48469,
                            [9] = 21849, -- Gift of The Wild
                            [10] = 21850,
                            [11] = 26991,
                            [12] = 48470
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
                            [6] = 26992,
                            [7] = 53307
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
                    aspectOfTheDragonhawk = {
                        name = select(1, GetSpellInfo(61846)),
                        required = false,
                        spellIds = {
                            [0] = 61846,
                            [1] = 61847
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
                            [3] = 49071,
                        }
                    },
                }
            },
            mage = {
                name = L["Mage"],
                buffs = {
                    amplifyMagic = {
                        name = select(1, GetSpellInfo(1008)),
                        required = false,
                        spellIds = {
                            [0] = 1008,
                            [1] = 8455,
                            [2] = 10169,
                            [3] = 10170,
                            [4] = 27130,
                            [5] = 33946,
                            [6] = 43017
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
                            [6] = 42995,
                            [7] = 23028, -- Arcane Brilliance
                            [8] = 27127,
                            [9] = 43002,
                            [10] = 61024, -- Dalaran Intellect
                            [11] = 61316 -- Dalaran Brilliance
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
                    },
                    frostArmor = {
                        name = select(1, GetSpellInfo(168)),
                        required = false,
                        spellIds = {
                            [0] = 168,
                            [1] = 7300,
                            [2] = 7301
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
                            [4] = 27124,
                            [5] = 43008
                        }
                    },
                    mageArmor = {
                        name = select(1, GetSpellInfo(6117)),
                        required = false,
                        spellIds = {
                            [0] = 6117,
                            [1] = 22782,
                            [2] = 22783,
                            [3] = 27125,
                            [4] = 43023,
                            [5] = 43024
                        }
                    },
                    moltenArmor = {
                        name = select(1, GetSpellInfo(30482)),
                        required = false,
                        spellIds = {
                            [0] = 30482,
                            [1] = 43045,
                            [2] = 43046
                        }
                    }
                }
            },
            paladin = {
                name = L["Paladin"],
                buffs = {
                    blessingOfKings = {
                        name = select(1, GetSpellInfo(20217)),
                        required = false,
                        spellIds = {
                            [0] = 20217, -- Blessing of Kings
                            [1] = 25898  -- Greater Blessing of Kings
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
                            [8] = 48931,
                            [9] = 48932,
                            [9] = 25782, -- Greater Blessing of Might
                            [10] = 25916,
                            [11] = 27141,
                            [12] = 48933,
                            [13] = 48934

                        }
                    },
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
                            [7] = 48935,
                            [8] = 48936,
                            [8] = 25894, -- Greater Blessing of Wisdom
                            [9] = 25918,
                            [10] = 27143,
                            [11] = 48937,
                            [12] = 48938
                        },
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
                            [7] = 27149,
                            [8] = 48941,
                            [9] = 48942
                        }
                    },
                    fireResistanceAura = {
                        name = select(1, GetSpellInfo(19891)),
                        required = false,
                        spellIds = {
                            [0] = 19891,
                            [1] = 19899,
                            [2] = 19900,
                            [3] = 27153,
                            [4] = 48947
                        }
                    },
                    frostResistanceAura = {
                        name = select(1, GetSpellInfo(19888)),
                        required = false,
                        spellIds = {
                            [0] = 19888,
                            [1] = 19897,
                            [2] = 19898,
                            [3] = 27152,
                            [4] = 48945
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
                            [5] = 27150,
                            [6] = 54043
                        }
                    },
                    righteousFury = {
                        name = select(1, GetSpellInfo(25780)),
                        required = false,
                        spellIds = {
                            [0] = 25780
                        }
                    },
                    sealOfCorruption = {
                        name = select(1, GetSpellInfo(348704)),
                        required = false,
                        spellIds = {
                            [0] = 348704,
                            [1] = 53736
                        }
                    },
                    sealOfJustice = {
                        name = select(1, GetSpellInfo(20164)),
                        required = false,
                        spellIds = {
                            [0] = 20164
                        }
                    },
                    sealOfLight = {
                        name = select(1, GetSpellInfo(20165)),
                        required = false,
                        spellIds = {
                            [0] = 20165
                        }
                    },
                    sealOfRighteousness = {
                        name = select(1, GetSpellInfo(21084)),
                        required = false,
                        spellIds = {
                            [0] = 21084,
                            [1] = 20154
                        }
                    },
                    sealOfVengeance = {
                        name = select(1, GetSpellInfo(31801)),
                        required = false,
                        spellIds = {
                            [0] = 31801
                        }
                    },
                    sealOfWisdom = {
                        name = select(1, GetSpellInfo(20166)),
                        required = false,
                        spellIds = {
                            [0] = 20166
                        }
                    },
                    shadowResistanceAura = {
                        name = select(1, GetSpellInfo(19876)),
                        required = false,
                        spellIds = {
                            [0] = 19876,
                            [1] = 19895,
                            [2] = 19896,
                            [3] = 27151,
                            [4] = 48943
                        }
                    }
                }
            },
            priest = {
                name = L["Priest"],
                buffs = {
                    divineSpirit = {
                        name = select(1, GetSpellInfo(14752)),
                        required = false,
                        spellIds = {
                            [0] = 14752,
                            [1] = 14818,
                            [2] = 14819,
                            [3] = 27841,
                            [4] = 25312,
                            [5] = 48073,
                            [7] = 27681, -- Prayer of Spirit
                            [8] = 32999,
                            [9] = 48074
                        }
                    },
                    fearWard = {
                        name = select(1, GetSpellInfo(6346)),
                        required = false,
                        spellIds = {
                            [0] = 6346
                        }
                    },
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
                            [6] = 25431,
                            [7] = 48040,
                            [8] = 48168
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
                            [7] = 48161,
                            [8] = 21562, -- Prayer of Fortitude
                            [9] = 21564,
                            [10] = 25392,
                            [11] = 48162
                        }
                    },
                    shadowProtection = {
                        name = select(1, GetSpellInfo(976)),
                        required = false,
                        spellIds = {
                            [0] = 976,
                            [1] = 10957,
                            [2] = 10958,
                            [3] = 25433,
                            [4] = 48169,
                            [5] = 27683, -- Prayer of Shadow Protection
                            [6] = 39374,
                            [7] = 48170
                        }
                    },
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
                            [5] = 27260,
                            [6] = 47793,
                            [5] = 47889
                        }
                    },
                    felArmor = {
                        name = select(1, GetSpellInfo(28176)),
                        required = false,
                        spellIds = {
                            [0] = 28176,
                            [1] = 28189,
                            [2] = 47982,
                            [3] = 47893
                        }
                    },
                    unendingBreath = {
                        name = select(1, GetSpellInfo(5697)),
                        required = false,
                        spellIds = {
                            [0] = 5697
                        }
                    }
                }
            }
        }
    }
}
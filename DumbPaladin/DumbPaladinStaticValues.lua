local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

DumbPaladin.SupportedInstances = {
    ahnkahetTheOldKingdom = {
        id = 619,
        name = "Ahn'kahet: The Old Kingdom"
    },
    azjolNerub = {
        id = 601,
        name = "Azjol-Nerub"
    },
    draktharonKeep = {
        id = 600,
        name = "Drak'Tharon Keep",
    },
    gundrak = {
        id = 604,
        name = "Gundrak"
    },
    hallsOfLightning = {
        id = 602,
        name = "Halls of Lightning"
    },
    hallsOfStone = {
        id = 599,
        name = "Halls of Stone"
    },
    theCullingOfStratholme = {
        id = 595,
        name = "The Culling of Stratholme"
    },
    theNexus = {
        id = 576,
        name = "The Nexus"
    },
    theOculus = {
        id = 578,
        name = "The Oculus"
    },
    theVioleHold = {
        id = 608,
        name = "The Violet Hold"
    },
    utgardeKeep = {
        id = 574,
        name = "Utgarde Keep"
    },
    utgardePinnacle = {
        id = 575,
        name = "Utgarde Pinnacle"
    }
}

DumbPaladin.Tabards = {
    tabardOfTheArgentCrusade = {
        id = 43154,
        name = "Tabard of the Argent Crusade"
    },
    tabardOfTheEbonBlade = {
        id = 43155,
        name = "Tabard of the Ebon Blade"
    },
    tabardOfTheKirinTor = {
        id = 43157,
        name = "Tabard of the Kirin Tor"
    },
    tabardOfTheWyrmrestAcord = {
        id = 43156,
        name = "Tabard of the Wyrmrest Acord"
    }
}

DumbPaladin.Buffs = {
    druid = {
        name = L["Druid"],
        buffs = {
            markOfTheWild = {
                name = select(1, GetSpellInfo(1126)),
                spellIds = {
                    [1] = 1126, -- Mark of The Wild
                    [2] = 21849, -- Gift of The Wild
                }
            },
            thorns = {
                name = select(1, GetSpellInfo(467)),
                spellIds = {
                    [1] = 467
                }
            }
        }
    },
    hunter = {
        name = L["Hunter"],
        buffs = {
            aspectOfTheBeast = {
                name = select(1, GetSpellInfo(13161)),
                spellIds = {
                    [1] = 13161
                }
            },
            aspectOfTheCheetah = {
                name = select(1, GetSpellInfo(5118)),
                spellIds = {
                    [1] = 5118
                }
            },
            aspectOfTheDragonhawk = {
                name = select(1, GetSpellInfo(61846)),
                spellIds = {
                    [1] = 61846
                }
            },
            aspectOfTheHawk = {
                name = select(1, GetSpellInfo(13165)),
                spellIds = {
                    [1] = 13165
                }
            },
            aspectOfTheMonkey = {
                name = select(1, GetSpellInfo(13163)),
                spellIds = {
                    [1] = 13163
                }
            },
            aspectOfThePack = {
                name = select(1, GetSpellInfo(13159)),
                spellIds = {
                    [1] = 13159
                }
            },
            aspectOfTheViper = {
                name = select(1, GetSpellInfo(34074)),
                spellIds = {
                    [1] = 34074
                }
            },
            aspectOfTheWild = {
                name = select(1, GetSpellInfo(20043)),
                spellIds = {
                    [1] = 20043
                }
            },
        }
    },
    mage = {
        name = L["Mage"],
        buffs = {
            amplifyMagic = {
                name = select(1, GetSpellInfo(1008)),
                spellIds = {
                    [1] = 1008
                }
            },
            arcaneIntellect = {
                name = select(1, GetSpellInfo(1459)),
                spellIds = {
                    [1] = 1459, -- Arcane Intellect
                    [2] = 23028, -- Arcane Brilliance
                    [3] = 61024, -- Dalaran Intellect
                    [4] = 61316 -- Dalaran Brilliance
                }
            },
            dampenMagic = {
                name = select(1, GetSpellInfo(604)),
                spellIds = {
                    [1] = 604
                }
            },
            frostArmor = {
                name = select(1, GetSpellInfo(168)),
                spellIds = {
                    [1] = 168
                }
            },
            iceArmor = {
                name = select(1, GetSpellInfo(7302)),
                spellIds = {
                    [1] = 7302
                }
            },
            mageArmor = {
                name = select(1, GetSpellInfo(6117)),
                spellIds = {
                    [1] = 6117
                }
            },
            moltenArmor = {
                name = select(1, GetSpellInfo(30482)),
                spellIds = {
                    [1] = 30482
                }
            }
        }
    },
    paladin = {
        name = L["Paladin"],
        buffs = {
            blessingOfKings = {
                name = select(1, GetSpellInfo(20217)),
                spellIds = {
                    [1] = 20217, -- Blessing of Kings
                    [2] = 25898  -- Greater Blessing of Kings
                }
            },
            blessingOfMight = {
                name = select(1, GetSpellInfo(19740)),
                spellIds = {
                    [1] = 19740, -- Blessing of Might
                    [2] = 25782 -- Greater Blessing of Might
                }
            },
            blessingOfWisdom = {
                name = select(1, GetSpellInfo(19742)),
                spellIds = {
                    [1] = 19742, -- Blessing of Wisdom
                    [2] = 25894 -- Greater Blessing of Wisdom
                },
            },
            blessingOfProtection = {
                name = select(1, GetSpellInfo(1022)),
                spellIds = {
                    [1] = 1022
                }
            },
            blessingOfSanctuary = {
                name = select(1, GetSpellInfo(20911)),
                spellIds = {
                    [1] = 20911, -- Blessing of Sanctuary
                    [2] = 25899 -- Greater Blessing of Sanctuary
                }
            },
            concentrationAura = {
                name = select(1, GetSpellInfo(19746)),
                spellIds = {
                    [1] = 19746
                }
            },
            crusaderAura = {
                name = select(1, GetSpellInfo(32223)),
                spellIds = {
                    [1] = 32223
                }
            },
            devotionAura = {
                name = select(1, GetSpellInfo(465)),
                spellIds = {
                    [1] = 465
                }
            },
            fireResistanceAura = {
                name = select(1, GetSpellInfo(19891)),
                spellIds = {
                    [1] = 19891
                }
            },
            frostResistanceAura = {
                name = select(1, GetSpellInfo(19888)),
                spellIds = {
                    [1] = 19888
                }
            },
            retributionAura = {
                name = select(1, GetSpellInfo(7294)),
                spellIds = {
                    [1] = 7294
                }
            },
            righteousFury = {
                name = select(1, GetSpellInfo(25780)),
                spellIds = {
                    [1] = 25780
                }
            },
            sacredShield = {
                name = select(1, GetSpellInfo(53601)),
                spellIds = {
                    [1] = 53601
                }
            },
            sealOfCorruption = {
                name = select(1, GetSpellInfo(348704)),
                spellIds = {
                    [1] = 348704
                }
            },
            sealOfJustice = {
                name = select(1, GetSpellInfo(20164)),
                spellIds = {
                    [1] = 20164
                }
            },
            sealOfLight = {
                name = select(1, GetSpellInfo(20165)),
                spellIds = {
                    [1] = 20165
                }
            },
            sealOfRighteousness = {
                name = select(1, GetSpellInfo(21084)),
                spellIds = {
                    [1] = 21084
                }
            },
            sealOfVengeance = {
                name = select(1, GetSpellInfo(31801)),
                spellIds = {
                    [1] = 31801
                }
            },
            sealOfWisdom = {
                name = select(1, GetSpellInfo(20166)),
                spellIds = {
                    [1] = 20166
                }
            },
            shadowResistanceAura = {
                name = select(1, GetSpellInfo(19876)),
                spellIds = {
                    [1] = 19876
                }
            }
        }
    },
    priest = {
        name = L["Priest"],
        buffs = {
            divineSpirit = {
                name = select(1, GetSpellInfo(14752)),
                spellIds = {
                    [1] = 14752, -- Divine Spirit
                    [2] = 27681 -- Prayer of Spirit
                }
            },
            fearWard = {
                name = select(1, GetSpellInfo(6346)),
                spellIds = {
                    [1] = 6346
                }
            },
            innerFire = {
                name = select(1, GetSpellInfo(588)),
                spellIds = {
                    [1] = 588
                }
            },
            powerWordFortitude = {
                name = select(1, GetSpellInfo(1243)),
                spellIds = {
                    [1] = 1243,
                    [2] = 21562 -- Prayer of Fortitude
                }
            },
            shadowProtection = {
                name = select(1, GetSpellInfo(976)),
                spellIds = {
                    [1] = 976, -- Shadow Protection
                    [2] = 27683 -- Prayer of Shadow Protection
                }
            },
            vampiricEmbrace = {
                name = select(1, GetSpellInfo(15286)),
                spellIds = {
                    [1] = 15286
                }
            },
        }
    },
    warlock = {
        name = L["Warlock"],
        buffs = {
            demonArmor = {
                name = select(1, GetSpellInfo(706)),
                spellIds = {
                    [1] = 706
                }
            },
            demonSkin = {
                name = select(1, GetSpellInfo(687)),
                spellIds = {
                    [1] = 687
                }
            },
            felArmor = {
                name = select(1, GetSpellInfo(28176)),
                spellIds = {
                    [1] = 28176
                }
            },
            unendingBreath = {
                name = select(1, GetSpellInfo(5697)),
                spellIds = {
                    [1] = 5697
                }
            }
        }
    }
}

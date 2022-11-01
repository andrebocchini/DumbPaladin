local LibDBIcon = LibStub("LibDBIcon-1.0")

-- Creates the minimap icon
local DumbPaladinMinimapIcon = LibStub("LibDataBroker-1.1"):NewDataObject("DumbPaladinMiniMapIcon", {
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

function DumbPaladin:SetupMinimapIcon()
    LibDBIcon:Register("DumbPaladinMiniMapIcon", DumbPaladinMinimapIcon, DumbPaladin.db.profile.minimap)
end
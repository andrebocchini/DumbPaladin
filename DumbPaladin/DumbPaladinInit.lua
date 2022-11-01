function DumbPaladin:OnInitialize()
    DumbPaladin:InitializeDatabase()
    DumbPaladin:RegisterOptions()
    DumbPaladin:CreateSlashCommands()
    DumbPaladin:SetupMinimapIcon()
end

function DumbPaladin:OnEnable()
    DumbPaladin:RegisterEvents()
end
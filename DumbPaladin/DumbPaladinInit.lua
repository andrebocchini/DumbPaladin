function DumbPaladin:OnInitialize()
    DumbPaladin:InitializeDatabase()
    DumbPaladin:ConfigureProfileOptions()
    DumbPaladin:RegisterOptions()
    DumbPaladin:CreateSlashCommands()
    DumbPaladin:SetupMinimapIcon()
end

function DumbPaladin:OnEnable()
    DumbPaladin:RegisterEvents()
end
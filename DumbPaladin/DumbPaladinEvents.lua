function DumbPaladin:PLAYER_REGEN_DISABLED()
    if not DumbPaladin.db.profile.settings.buffChecks.whenEnteringCombat then
        return
    end

    DumbPaladin:PerformBuffChecksOnUnit("player")
end

function DumbPaladin:UNIT_AURA(unit)
    if not unit then
        unit = "(nil)"
    end

    if not DumbPaladin.db.profile.settings.buffChecks.whenInCombat then
        return
    end

    if unit == "player" and UnitAffectingCombat(unit) then
        DumbPaladin:PerformBuffChecksOnUnit(unit)
    end
end

function DumbPaladin:ZONE_CHANGED_NEW_AREA()
    local instanceId = select(8, GetInstanceInfo())
    local isSupportedInstance = DumbPaladin:IsSupportedInstance(instanceId)

    if isSupportedInstance then
        DumbPaladin:PerformGearChecksOnUnit("player")
    end
end

-- Register for all the events this addon listens for
function DumbPaladin:RegisterEvents()
    local eventHandlers = {
        ["PLAYER_REGEN_DISABLED"] = function()
            DumbPaladin:PrintDebugMessageToChatWindow("Entering combat")
            DumbPaladin:PLAYER_REGEN_DISABLED()
        end,
        ["UNIT_AURA"] = function(...)
            local unit = ...
            if unit == "player" then
                DumbPaladin:PrintDebugMessageToChatWindow("Buff gained/dropped")
                DumbPaladin:UNIT_AURA(unit)
            end
        end,
        ["ZONE_CHANGED_NEW_AREA"] = function()
            DumbPaladin:PrintDebugMessageToChatWindow("Zone changed")
            DumbPaladin:ZONE_CHANGED_NEW_AREA()
        end
    }

    local EventFrame = CreateFrame("Frame", "DumbPaladin_EventFrame")

    -- Register events
    for event, _ in pairs(eventHandlers) do
        EventFrame:RegisterEvent(event)
    end

    -- Execute event handler
    EventFrame:SetScript("OnEvent", function(_, event, ...)
        local eventHandler = eventHandlers[event]

        if eventHandler then
            eventHandler(...)
        end
    end)
end

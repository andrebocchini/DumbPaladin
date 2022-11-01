local addonName = ...

DumbPaladin = LibStub("AceAddon-3.0"):NewAddon(addonName)
DumbPaladin.NAME = addonName
DumbPaladin.VERSION = GetAddOnMetadata(DumbPaladin.NAME, "version")
DumbPaladin.DEBUG = false

local AceConsole = LibStub("AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

-- Prints additional debug messages to the default chat window
function DumbPaladin:PrintDebugMessageToChatWindow(string)
    if not string then
        string = "(nil)"
    end

    if DumbPaladin.DEBUG then
        AceConsole:Print("[" .. DumbPaladin.NAME .. " - " .. L["DEBUG"] .. "] " .. string)
    end
end

-- Prints a message to the default chat window
function DumbPaladin:PrintMessageToChatWindow(string)
    if not string then
        string = "(nil)"
    end

    AceConsole:Print("[" .. DumbPaladin.NAME .. "] " .. string)
end



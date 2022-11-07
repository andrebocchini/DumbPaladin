local L = LibStub("AceLocale-3.0"):GetLocale(DumbPaladin.NAME)

function IssueChatWarning(message)
    if not message then
        message = "(nil)"
    end

    DumbPaladin:PrintMessageToChatWindow(message)
end

function DumbPaladin:IssueRaidWarning(message)
    if not message then
        message = "(nil)"
    end

    RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
end

-- Flashes red around the edges of the screen for a few seconds
function DumbPaladin:IssueScreenFlashWarning()
    if not self.FlashFrame then
        local f = CreateFrame("Frame", "DumbPaladinFlashingFrame")

        f:SetToplevel(true)
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetAllPoints(UIParent)
        f:EnableMouse(false)
        f:Hide()
        f.texture = f:CreateTexture(nil, "BACKGROUND")
        f.texture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
        f.texture:SetAllPoints(UIParent)
        f.texture:SetBlendMode("ADD")

        f:SetScript("OnShow", function(self)
            self.elapsed = 0
            self:SetAlpha(0)
        end)

        f:SetScript("OnUpdate", function(self, elapsed)
            elapsed = self.elapsed + elapsed
            if elapsed < 2.6 then
                local alpha = elapsed % 1.3
                if alpha < 0.15 then
                    self:SetAlpha(alpha / 0.15)
                elseif alpha < 0.9 then
                    self:SetAlpha(1 - (alpha - 0.15) / 0.6)
                else
                    self:SetAlpha(0)
                end
            else
                self:Hide()
            end
            self.elapsed = elapsed
        end)

        self.FlashFrame = f
    end

    self.FlashFrame:Show()
end

function DumbPaladin:IssueSoundWarning()
    PlaySound(6594)
end

function DumbPaladin:IssueTextToSpeechWarning(accumulatedBuffs)
    if not accumulatedBuffs then
        accumulatedBuffs = "(nil)"
    end

    local destination = Enum.VoiceTtsDestination.LocalPlayback
    local speed = -2
    local volume = GetCVar("Sound_MasterVolume") * 100

    C_VoiceChat.SpeakText(0, L["MissingBuffsWarning"], destination, speed, volume)
    C_VoiceChat.SpeakText(0, accumulatedBuffs, destination, speed, volume)
end

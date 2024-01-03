-- Author      : Heroes Place - 9
-- Create Date : 12/22/2023 12:29:27 PM

PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not';
function SlashCmdList.EVENT(msg, editBox)
    EventKeyFrame:Show()
end

function ValidateKeyButton_OnClick()
    print(InputKey:GetText())
    EventKeyFrame:Hide()
    ChoosePlayersFrame:Show()
end

-- Partie ChoosePlayersFrame

function ChoosePlayersFrame_OnLoad()
    -- Exemple OnLoad on fait quelque chose
end

function ValidateChoosePlayersButton_OnClick()
    -- ChoosePlayersFrame:Hide()
    send_invites(get_selection(), InputKey:GetText())
end

local targetFrame = CreateFrame("Frame")
targetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
targetFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_TARGET_CHANGED" then
        if UnitIsPlayer("target") then
            local targetName = UnitName("target")
            TargetFontString:SetText("Cible : " .. targetName)
        else
            TargetFontString:SetText("Cible")
        end
    end
end)

local function CheckButtonStatus(checkButton)
    if checkButton:GetChecked() then
        print(checkButton:GetName() .. " is enabled")
    else
        print(checkButton:GetName() .. " is disabled")
    end
end

function CB_GuildPlayers_OnClick(self)
    CheckButtonStatus(self)
end

function CB_RaidPlayers_OnClick(self)
    CheckButtonStatus(self)

    CB_PartyPlayers:SetChecked(true)

    if (self:GetChecked()) then
        CB_PartyPlayers:Disable()
    else
        CB_PartyPlayers:Enable()
    end
end

function CB_PartyPlayers_OnClick(self)
    CheckButtonStatus(self)
end

function BackChoosePlayersButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function PlayerToListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function TargetToListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end
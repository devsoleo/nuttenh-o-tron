-- Author      : Heroes Place - 9
-- Create Date : 12/22/2023 12:29:27 PM

function ValidateKeyButton_OnClick()
    -- print("The key is : ".. InputKey:GetText())
    
    EventKeyFrame:Hide()
    ChoosePlayersFrame:Show()
end

function ValidateChoosePlayersButton_OnClick()
    -- ChoosePlayersFrame:Hide()
    send_invites(get_selection(), InputKey:GetText())
end

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
    -- print("Button " .. self:GetName() .. " is pressed")

    ChoosePlayersFrame:Hide()
    EventKeyFrame:Show()
end

function PlayerToListButton_OnClick(self)
    if (add_player_to_selection(Input_Player:GetText())) then
        Input_Player:SetText("")
    end
end

function TargetToListButton_OnClick(self)
    if (UnitName("target") ~= nil) then
        add_player_to_selection(UnitName("target"))
    end
end

function ClearListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end
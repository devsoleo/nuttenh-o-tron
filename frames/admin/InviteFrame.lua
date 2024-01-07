function CB_RaidPlayers_OnClick(self)
    CB_PartyPlayers:SetChecked(true)

    if (self:GetChecked()) then
        CB_PartyPlayers:Disable()
    else
        CB_PartyPlayers:Enable()
    end
end

function B_PlayerNameToInviteList_OnClick(self)
    if (addPlayerToInviteList(EB_InvitedPlayerName:GetText())) then
        EB_InvitedPlayerName:SetText("")
        EB_InvitedPlayerName:ClearFocus()
    end
end

function B_TargetToInviteList_OnClick(self)
    if (UnitName("target") ~= nil and UnitIsPlayer("target") == 1) then
        addPlayerToInviteList(UnitName("target"))
    end
end

function B_BackToEventKeyFrame_OnClick(self)
    F_Invite:Hide()
    F_EventKey:Show()
end

function B_SubmitInvites_OnClick(self)
    sendInvites(getInviteList(), EB_InvitedPlayerName:GetText())
end
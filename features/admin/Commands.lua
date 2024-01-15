PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not';
function SlashCmdList.EVENT(msg, editBox)
    local key = msg:match("^(%S*)%s*(.-)$")
    
    if (key ~= nil and key ~= "") then
        F_EventKey:Hide()

        if (hasInviteToSend(getInviteList()) == false) then
            EB_EventKey:SetText(key)
            F_Invite:Show()
        else
            EB_EventKey:SetText(key)
            F_Invite:Hide()
            F_AdminPanel:Show()
        end
    else
        F_EventKey:Show()
        F_Invite:Hide()
    end
end
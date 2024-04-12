PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not'
function SlashCmdList.EVENT(msg, editBox)
    local key = msg:match("^(%S*)%s*(.-)$")
    
    if (key ~= nil and key ~= "") then
        if (hasInviteToSend() == false and get_storage("invites") == nil) then
            F_Invite:Show()
        else
            F_Invite:Hide()

            if (F_AdminPanel:IsVisible() == 1) then
                F_AdminPanel:Hide()
            else
                F_AdminPanel:Show()
            end
        end
    else
        F_AdminPanel:Show()
        F_Invite:Hide()
    end
end
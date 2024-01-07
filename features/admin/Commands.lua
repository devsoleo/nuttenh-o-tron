PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not';
function SlashCmdList.EVENT(msg, editBox)
    local key = msg:match("^(%S*)%s*(.-)$")
    
    if (key ~= nil and key ~= "") then
        EB_EventKey:SetText(key)
        F_EventKey:Hide()
        F_Invite:Show()
    else
        F_EventKey:Show()
        F_Invite:Hide()
    end
end
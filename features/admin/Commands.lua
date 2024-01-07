PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not';
function SlashCmdList.EVENT(msg, editBox)
    local key = msg:match("^(%S*)%s*(.-)$")
    
    if (key ~= nil and key ~= "") then
        InputKey:SetText(key)
        EventKeyFrame:Hide()
        ChoosePlayersFrame:Show()
    else
        EventKeyFrame:Show()
        ChoosePlayersFrame:Hide()
    end
end
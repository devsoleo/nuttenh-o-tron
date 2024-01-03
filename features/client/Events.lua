local onAddonMessage = CreateFrame("Frame")
onAddonMessage:RegisterEvent("CHAT_MSG_ADDON")
onAddonMessage:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    -- On vérifie si le message est adressé à notre addon
    if (prefix ~= PREFIX) then
        return
    end

    print("Message reçu : " .. event .. " " .. prefix .. " " .. message .. " " .. channel .. " " .. sender)
end)
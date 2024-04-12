local onGuildUpdate = CreateFrame("Frame")
onGuildUpdate:RegisterEvent("PLAYER_GUILD_UPDATE")
onGuildUpdate:SetScript("OnEvent", function(self, ...)
    if (isInGuild("PLAYER") == false) then
        CB_GuildPlayers:SetChecked(false)
        CB_GuildPlayers:Disable()
        FS_Guild:SetAlpha(0.5)
        CB_GuildPlayers:SetAlpha(0.5)
    else
        CB_GuildPlayers:Enable()
        FS_Guild:SetAlpha(1)
        CB_GuildPlayers:SetAlpha(1)
    end
end)

local onRaidUpdate = CreateFrame("Frame")
onRaidUpdate:RegisterEvent("RAID_ROSTER_UPDATE")
onRaidUpdate:SetScript("OnEvent", function(self, ...)
    if (UnitInRaid("PLAYER") ~= 1) then
        CB_RaidPlayers:SetChecked(false)
        CB_RaidPlayers:Disable()
        FS_Raid:SetAlpha(0.5)
        CB_RaidPlayers:SetAlpha(0.5)
    else
        CB_RaidPlayers:Enable()
        FS_Raid:SetAlpha(1)
        CB_RaidPlayers:SetAlpha(1)
    end
end)

local onPartyUpdate = CreateFrame("Frame")
onPartyUpdate:RegisterEvent("PARTY_MEMBERS_CHANGED")
onPartyUpdate:SetScript("OnEvent", function(self, ...)
    if (GetNumPartyMembers() == 0) then
        CB_PartyPlayers:SetChecked(false)
        CB_PartyPlayers:Disable()
        CB_PartyPlayers:SetAlpha(0.5)
        FS_Party:SetAlpha(0.5)
    else
        CB_PartyPlayers:Enable()
        FS_Party:SetAlpha(1)
        CB_PartyPlayers:SetAlpha(1)
    end
end)

local onAddonMessage = CreateFrame("Frame")
onAddonMessage:RegisterEvent("CHAT_MSG_ADDON")
onAddonMessage:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    if (prefix ~= PREFIX or sender == UnitName("PLAYER")) then
        return
    end

    if (message == "accept_invite") then
        print("[ADMIN] " .. sender .. " a accepté votre invitation !")

        -- Add player to the event player list
        local players = get_storage("players")

        if (players == nil) then
            players = {}
        end

        table.insert(players, sender)
        set_storage("players", players)

        -- Add FontString to the event panel
        local FS_Player = F_AdminPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        FS_Player:SetText(sender)
        FS_Player:SetPoint("TOPLEFT", 10, -10)
        FS_Player:SetJustifyH("LEFT")
        FS_Player:SetWidth(200)
        FS_Player:SetHeight(20)
        
    end
end)
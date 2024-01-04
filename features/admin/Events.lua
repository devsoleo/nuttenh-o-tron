local onGuildUpdate = CreateFrame("Frame")
onGuildUpdate:RegisterEvent("PLAYER_GUILD_UPDATE")
onGuildUpdate:SetScript("OnEvent", function(self, ...)
    if (isInGuild("PLAYER") == false) then
        CB_GuildPlayers:SetChecked(false)
        CB_GuildPlayers:Disable()
        GuildFontString:SetAlpha(0.5)
        CB_GuildPlayers:SetAlpha(0.5)
    else
        CB_GuildPlayers:Enable()
        GuildFontString:SetAlpha(1)
        CB_GuildPlayers:SetAlpha(1)
    end
end)

local onRaidUpdate = CreateFrame("Frame")
onRaidUpdate:RegisterEvent("RAID_ROSTER_UPDATE")
onRaidUpdate:SetScript("OnEvent", function(self, ...)
    if (UnitInRaid("PLAYER") ~= 1) then
        CB_RaidPlayers:SetChecked(false)
        CB_RaidPlayers:Disable()
        RaidFontString:SetAlpha(0.5)
        CB_RaidPlayers:SetAlpha(0.5)
    else
        CB_RaidPlayers:Enable()
        RaidFontString:SetAlpha(1)
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
        PartyFontString:SetAlpha(0.5)
    else
        CB_PartyPlayers:Enable()
        PartyFontString:SetAlpha(1)
        CB_PartyPlayers:SetAlpha(1)
    end
end)


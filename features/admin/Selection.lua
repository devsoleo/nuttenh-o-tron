function get_selection()
    local invites = {}

    invites["channels"] = {}
    invites["players"] = {}
    
    -- On réinitialise la sélection
    invites["channels"]["GUILD"] = false
    invites["channels"]["RAID"] = false
    invites["channels"]["PARTY"] = false
    invites["players"] = {}

    -- On récupère le channels sélectionnés
    local guild_players = CB_GuildPlayers:GetChecked()
    local raid_players = CB_RaidPlayers:GetChecked()
    local party_players = CB_PartyPlayers:GetChecked()

    if (guild_players == 1) then
        invites["channels"]["GUILD"] = true
    end

    if (raid_players == 1) then
        invites["channels"]["RAID"] = true
    end

    if (party_players == 1) then
        invites["channels"]["PARTY"] = true
    end

    return invites
end

function send_invites(invites, gamekey)
    if (invites["channels"]["GUILD"] == true) then
        SendAddonMessage(PREFIX, gamekey, "GUILD")
    end

    -- Envoie le message d'invitation approprié
    if UnitInRaid("PLAYER") == 1 and invites["channels"]["RAID"] then
        SendAddonMessage(PREFIX, gamekey, "RAID")
    elseif invites["channels"]["PARTY"] then
        SendAddonMessage(PREFIX, gamekey, "PARTY")
    end

    for i, player in ipairs(invites["players"]) do
        -- print("Invitation de " .. player)
    end
end
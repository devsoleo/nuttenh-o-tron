invites = {}
invites["channels"] = {}
invites["players"] = {}

function get_selection()
    -- On réinitialise la sélection
    invites["channels"]["GUILD"] = false
    invites["channels"]["RAID"] = false
    invites["channels"]["PARTY"] = false

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

function add_player_to_selection(player)
    player = trim(player)
    player = player:sub(1,1):upper()..player:sub(2):lower()

    if (player ~= "" and #player > 2) then
        -- invites["players"][#invites["players"] + 1] = player
        table.insert(invites["players"], player)

        add_item_to_list(player)

        return true
    else
        return false
    end
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
        SendAddonMessage(PREFIX, gamekey, "WHISPER", player)
    end
end

function add_item_to_list(item)
    local playerList = PlayerList
    local scrollChild = playerList:GetScrollChild()

    -- Crée une nouvelle ligne de texte
    local line = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    local yPos = -scrollChild.contentHeight - 5
    line:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, yPos)

    -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard
    line:SetText(item)

    -- Met à jour la hauteur du contenu et du scrolling child
    local lineHeight = 20
    scrollChild.contentHeight = scrollChild.contentHeight + lineHeight
    scrollChild:SetHeight(scrollChild.contentHeight)

    -- Met à jour la barre de défilement si elle existe
    if playerList.ScrollBar then
        playerList.ScrollBar:SetMinMaxValues(1, scrollChild.contentHeight)
    end
end

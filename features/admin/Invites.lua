invites = {}
invites["channels"] = {}
invites["players"] = {}

-- On réinitialise la sélection
invites["channels"]["GUILD"] = false
invites["channels"]["RAID"] = false
invites["channels"]["PARTY"] = false
    
function getInviteList()
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

function sendInvites(invites, gamekey)
    local inviteSend = false

    if (invites["channels"]["GUILD"] == true) then
        SendAddonMessage(PREFIX, "invite", "GUILD")
        inviteSend = true
    end

    -- Envoie le message d'invitation approprié
    if UnitInRaid("PLAYER") == 1 and invites["channels"]["RAID"] then
        SendAddonMessage(PREFIX, "invite", "RAID")
        inviteSend = true
    elseif invites["channels"]["PARTY"] then
        SendAddonMessage(PREFIX, "invite", "PARTY")
        inviteSend = true
    end

    for i, player in ipairs(invites["players"]) do
        SendAddonMessage(PREFIX, "invite", "WHISPER", player)
        inviteSend = true
    end

    if (inviteSend) then
        -- On réinitialise les invites avant de stocker les nouvelles
        set_storage("invites", clear_table(get_storage("invites")))
        set_storage("invites", invites)
    end

    return inviteSend
end

-- Fonction qui lit le formulaire afin de déterminer si au moins 1 case à été cochée ou si un joueur à été ajouté
-- TL;DR : fonction qui vérifie si on peut valider le formulaire
function hasInviteToSend()
    local inviteToSend = false

    if (invites["channels"]["GUILD"] == true) then
        inviteToSend = true
    end

    -- Envoie le message d'invitation approprié
    if UnitInRaid("PLAYER") == 1 and invites["channels"]["RAID"] then
        inviteToSend = true
    elseif invites["channels"]["PARTY"] then
        inviteToSend = true
    end

    if (sizeof(invites["players"]) > 0) then
        inviteToSend = true
    end

    return inviteToSend
end

function addPlayerToInviteList(player)
    player = normalizePlayerName(player)

    -- On vérifie que le joueur n'est pas déjà dans la liste
    -- On vérifie que le joueur n'est pas le joueur lui-même
    -- On vérifie que le joueur n'est pas vide
    if (player == nil or array_search(invites["players"], player) ~= nil or player == UnitName("PLAYER")) then
        return false
    end

    -- invites["players"][#invites["players"] + 1] = player
    table.insert(invites["players"], player)
    updateInviteList()

    toggleInviteSubmitButton()

    return true
end

-- graphical
function updateInviteList()
    local lineHeight = 18

    local scrollChild = SF_InvitedPlayerList:GetScrollChild()
    scrollChild.contentHeight = 0

    for i, player in ipairs(invites["players"]) do
        local line = _G["FS_InvitedPlayerListItem" .. i]

        if (line) then
            line:SetText(player)
        else
            line = scrollChild:CreateFontString("FS_InvitedPlayerListItem" .. i, "ARTWORK", "GameFontNormal")
        end
        -- Crée une nouvelle ligne de texte
        local yPos = -scrollChild.contentHeight - 5
        line:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, yPos)

        -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard
        line:SetText(invites["players"][i])

        -- Met à jour la hauteur du contenu et du scrolling child
        scrollChild.contentHeight = scrollChild.contentHeight + lineHeight
        scrollChild:SetHeight(scrollChild.contentHeight)

        -- Met à jour la barre de défilement si elle existe
        if SF_InvitedPlayerList.ScrollBar then
            SF_InvitedPlayerList.ScrollBar:SetMinMaxValues(1, scrollChild.contentHeight)
        end
    end
end

function clearInviteList()
    for i = 1, sizeof(invites["players"]) do
        table.remove(invites["players"], i)
        _G["FS_InvitedPlayerListItem" .. i]:SetText("")
    end

    toggleInviteSubmitButton()
end
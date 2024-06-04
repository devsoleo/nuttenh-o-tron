_G["invites"] = {}
_G["invites"]["channels"] = {}
_G["invites"]["players"] = {}

-- On réinitialise la sélection
_G["invites"]["channels"]["GUILD"] = false
_G["invites"]["channels"]["RAID"] = false
_G["invites"]["channels"]["PARTY"] = false

function displayInviteList()
    if not _G["invites"] or not _G["invites"]["players"] then
        return
    end

    displayList(SF_InvitedPlayerList, _G["invites"]["players"])
end

function getInviteForm()
    -- On récupère le channels sélectionnés
    _G["invites"]["channels"]["GUILD"] = (CB_GuildPlayers:GetChecked() == 1)
    _G["invites"]["channels"]["RAID"] = (CB_RaidPlayers:GetChecked() == 1)
    _G["invites"]["channels"]["PARTY"] = ( CB_PartyPlayers:GetChecked() == 1)

    return invites
end

-- Fonction qui lit le formulaire afin de déterminer si au moins 1 case à été cochée ou si un joueur à été ajouté
-- TL;DR : fonction qui vérifie si on peut valider le formulaire
function isInviteFormEmpty()
    local isEmpty = true

    if (_G["invites"]["channels"]["GUILD"] == true) then
        isEmpty = false
        print("z")
    end

    -- Envoie le message d'invitation approprié
    if UnitInRaid("PLAYER") == 1 and _G["invites"]["channels"]["RAID"] then
        isEmpty = false
        print("a")
    elseif _G["invites"]["channels"]["PARTY"] then
        isEmpty = false
        print("b")
    end

    if (sizeof(_G["invites"]["players"]) > 0) then
        isEmpty = false
        print("c")
    end

    print("isInviteFormEmpty : " .. tostring(isEmpty))

    return isEmpty
end

function sendInvites(invites, gamekey)
    local inviteSend = false

    if (_G["invites"]["channels"]["GUILD"] == true) then
        SendAddonMessage(PREFIX, "invite", "GUILD")
        inviteSend = true
    end

    -- Envoie le message d'invitation approprié
    if UnitInRaid("PLAYER") == 1 and _G["invites"]["channels"]["RAID"] then
        SendAddonMessage(PREFIX, "invite", "RAID")
        inviteSend = true
    elseif _G["invites"]["channels"]["PARTY"] then
        SendAddonMessage(PREFIX, "invite", "PARTY")
        inviteSend = true
    end

    for i, player in ipairs(_G["invites"]["players"]) do
        SendAddonMessage(PREFIX, "invite", "WHISPER", player)
        inviteSend = true
    end

    return inviteSend
end

function clearInviteList()
    for i = 1, sizeof(_G["invites"]["players"]) do
        table.remove(_G["invites"]["players"], i)
        _G["FS_InvitedPlayerListItem" .. i]:SetText("")
    end

    toggleInviteSubmitButton()
end

function checkInvitationAccept(player)
    player = normalizePlayerName(player)
    local valid = false

    -- Has been invited
    if (array_search(get_storage("invites")["players"], player) ~= nil) then
        valid = true
    end

    if get_storage("invites")["channels"]["GUILD"] == true and GetGuildInfo(player) == GetGuildInfo("player") then
        valid = true
    end

    if UnitInRaid("player") == 1 and get_storage("invites")["channels"]["RAID"] == true then
        valid = true
    end

    if get_storage("invites")["channels"]["PARTY"] == true and UnitInParty(player) == 1 then
        valid = true
    end

    -- Already participating
    if (array_search(_G["participants"], player) ~= nil) then
        valid = false
    end

    return valid
end
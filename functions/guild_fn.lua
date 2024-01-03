function guildSendMessage(message)
    SendChatMessage(message, "GUILD")
end

function getPlayerGuildRankIndex(player)
    if player == nil then
        player = "player"
    end

    local guild_name, guild_rank_name, guild_rank_index = GetGuildInfo(player)

    return guild_rank_index
end

function getPlayerGuildRankName(player)
    if player == nil then
        player = "player"
    end

    local guild_name, guild_rank_name, guild_rank_index = GetGuildInfo(player)

    return guild_rank_name
end

function getPlayerGuildName(player)
    if player == nil then
        player = "player"
    end

    local guild_name, guild_rank_name, guild_rank_index = GetGuildInfo(player)

    return guild_name
end
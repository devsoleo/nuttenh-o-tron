function normalizePlayerName(player)
    player = trim(player)
    player = player:sub(1,1):upper()..player:sub(2):lower()

    if (player ~= "" and #player > 2 and #player <= 12) then
        return player
    else
        return nil
    end
end
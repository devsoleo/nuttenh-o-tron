function str_split(str, delim)
    local t = {}

    for sub_str in string.gmatch(str, "[^" .. delim .. "]*") do
        if sub_str ~= nil and string.len(sub_str) > 0 then
            table.insert(t, sub_str)
        end
    end

    return t
end

function str_split_chunk(text, chunkSize)
    text = tostring(text)
    local s = {}

    for i=1, #text, chunkSize do
        s[#s + 1] = text:sub(i, i + chunkSize - 1)
    end

    return s
end

function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function str_split_chunk(text, chunkSize)
	text = tostring(text)
    local s = {}

    for i=1, #text, chunkSize do
        s[#s + 1] = text:sub(i, i + chunkSize - 1)
    end

    return s
end

-- Exemple d'utilisation

function chiffre(texte)
    local cle = "maCleSecrete"

    local chiffre = ""
    local longueurCle = #cle

    for i = 1, #texte do
        local charCode = string.byte(texte, i)
        local cleCode = string.byte(cle, (i - 1) % longueurCle + 1)
        local newCharCode = ((charCode + cleCode) % 256)
        chiffre = chiffre .. string.char(newCharCode)
    end

    return chiffre
end

function dechiffre(texteChiffre)
    local cle = "maCleSecrete"

    local dechiffre = ""
    local longueurCle = #cle

    for i = 1, #texteChiffre do
        local charCode = string.byte(texteChiffre, i)
        local cleCode = string.byte(cle, (i - 1) % longueurCle + 1)
        local newCharCode = ((charCode - cleCode) % 256)
        dechiffre = dechiffre .. string.char(newCharCode)
    end

    return dechiffre
end
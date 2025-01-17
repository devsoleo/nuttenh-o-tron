function B_StartEvent_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")

    print(invites["channels"]["GUILD"])
end

function B_PauseEvent_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function B_StopEvent_OnClick(self)
    clear_storage("invites")

    _G["participants"] = {}

    F_AdminPanel:Hide()

    print("[ADMIN] Event annulé !")
end

function B_KeyApply_OnClick(self)
    local event_key = url_decode(base64_decode(EB_EventKey:GetText()))

    print("Event key : " .. event_key)

    displayMissions(event_key)

    --  set_storage("event_key", EB_EventKey:GetText())
end

function B_SendAlertToPlayers_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed with input : " .. EB_AlertToPlayers:GetText())
end

function displayParticipants()

    displayList(SF_ParticipantsList, _G["participants"])
end

function displayMissions(eventKey)
    if eventKey == nil or eventKey == "" then
        print("[ADMIN] Clé vide !")

        return
    end

    local splitedEventKey = str_split_brackets(eventKey)
    local headers = splitedEventKey[1]
    local missions = splitedEventKey[2]

    local headersList = str_split(headers, ";")
    local missionsList = str_split(missions, ";")

    local mod = function(l, i)
        -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard*$
        local key = missionsList[i]
        local splited_key = str_split(key, "|")

        local m_type = splited_key[1]
        local text = ""

        if (m_type == "K") then
            text = "Kill |c000fff00x" .. splited_key[2] .. " " .. splited_key[3] .. "|r"
        elseif (m_type == "T") then 
            text = "Target |c000fff00" .. splited_key[2]
        end

        l:SetText(text)
    end

    displayList(SF_MissionsList, missionsList, mod)
    -- print("[ADMIN] Missions ajoutées !")
end

-- Fonction de base pour afficher une liste de texte dans un scrollframe
function displayList(sf_element, values, modifier)
    if modifier == nil then
        modifier = function(l) return l end
    end

    local scrollChild = sf_element:GetScrollChild()
    scrollChild.contentHeight = 0

    -- Supprime les lignes précédentes
    local i = 1

    while true do
        local line_name = "FS_" .. SF_MissionsList:GetName():sub(4) .. "Item" .. i
        local line = _G[line_name]

        if (line == nil) then
            break
        else
            line:SetText("")
        end

        i = i + 1
    end

    -- Ajoute les nouvelles lignes
    for i, text in ipairs(values) do
        local line_name = "FS_" .. sf_element:GetName():sub(4) .. "Item" .. i
        local line = _G[line_name]

        if (not line) then
            line = scrollChild:CreateFontString(line_name, "ARTWORK", "GameFontNormal")
        end

        line:SetParent(sf_element)

        -- Crée une nouvelle ligne de texte
        local yPos = -scrollChild.contentHeight - 5
        line:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, yPos)

        -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard
        line:SetText("|c00ff00ff" .. text)

        line = modifier(line, i)

        -- Met à jour la hauteur du contenu et du scrolling child
        scrollChild.contentHeight = scrollChild.contentHeight + 18
        scrollChild:SetHeight(scrollChild.contentHeight)

        -- Met à jour la barre de défilement si elle existe
        if sf_element.ScrollBar then
            sf_element.ScrollBar:SetMinMaxValues(1, scrollChild.contentHeight)
        end
    end
end
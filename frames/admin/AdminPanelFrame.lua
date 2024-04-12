function B_StartEvent_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")

    print(invites["channels"]["GUILD"])
end

function B_PauseEvent_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function B_StopEvent_OnClick(self)
    set_storage("invites", nil)
    F_AdminPanel:Hide()

    print("[ADMIN] Event annulé !")
end

function B_KeyApply_OnClick(self)
    displayMissions(EB_EventKey:GetText())
end

function B_SendAlertToPlayers_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed with input : " .. EB_AlertToPlayers:GetText())
end

function displayInvitedPlayers()
    displayList(SF_PlayerList, get_storage("invites")["players"])
end

function displayMissions(eventKey)
    local missionsList = str_split(eventKey, "_")

    local mod = function(l, i)
        -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard*$
        local key = missionsList[i]
        local splited_key = str_split(key, "-")

        local m_type = splited_key[1]
        local text = ""

        if (m_type == "T") then
            text = "Tuer |c000fff00x" .. splited_key[2] .. " " .. splited_key[3] .. "|r"
        elseif (m_type == "C") then 
            text = "Cibler |c000fff00" .. splited_key[2]
        elseif (m_type == "P") then
            text = "Posséder |c000fff00x" .. splited_key[2] .. " " .. splited_key[3]
        end

        l:SetText(text)
    end

    displayList(SF_MissionsList, missionsList, mod)
end

-- Fonction de base pour afficher une liste de texte dans un scrollframe
function displayList(sf_element, values, modifier)
    if modifier == nil then
        modifier = function(l) return l end
    end

    local scrollChild = sf_element:GetScrollChild()
    scrollChild.contentHeight = 0

    for i, text in ipairs(values) do
        local line_name = "FS_" .. sf_element:GetName():sub(4) .. "Item" .. i
        print(line_name)
        local line = _G[line_name]

        if (not line) then
            line = scrollChild:CreateFontString(line_name, "ARTWORK", "GameFontNormal")
        end

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
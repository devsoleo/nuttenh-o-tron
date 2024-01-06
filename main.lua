-- Author      : Heroes Place - 9
-- Create Date : 12/22/2023 12:29:27 PM

PREFIX = "not-a-prefix"

SLASH_EVENT1, SLASH_EVENT2 = '/event', '/not';
function SlashCmdList.EVENT(msg, editBox)
    local key = msg:match("^(%S*)%s*(.-)$")
    
    if (key ~= nil and key ~= "") then
        InputKey:SetText(key)
        EventKeyFrame:Hide()
        ChoosePlayersFrame:Show()
    else
        EventKeyFrame:Show()
        ChoosePlayersFrame:Hide()
    end
end

function ValidateKeyButton_OnClick()
    -- print("The key is : ".. InputKey:GetText())
    
    EventKeyFrame:Hide()
    ChoosePlayersFrame:Show()
end

function ValidateChoosePlayersButton_OnClick()
    -- ChoosePlayersFrame:Hide()
    send_invites(get_selection(), InputKey:GetText())
end

local function CheckButtonStatus(checkButton)
    if checkButton:GetChecked() then
        print(checkButton:GetName() .. " is enabled")
    else
        print(checkButton:GetName() .. " is disabled")
    end
end

function CB_GuildPlayers_OnClick(self)
    CheckButtonStatus(self)
end

function CB_RaidPlayers_OnClick(self)
    CheckButtonStatus(self)

    CB_PartyPlayers:SetChecked(true)

    if (self:GetChecked()) then
        CB_PartyPlayers:Disable()
    else
        CB_PartyPlayers:Enable()
    end
end

function CB_PartyPlayers_OnClick(self)
    CheckButtonStatus(self)
end

function BackChoosePlayersButton_OnClick(self)
    -- print("Button " .. self:GetName() .. " is pressed")

    ChoosePlayersFrame:Hide()
    EventKeyFrame:Show()
end

function PlayerToListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function TargetToListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

function ClearListButton_OnClick(self)
    print("Button " .. self:GetName() .. " is pressed")
end

-- Test de la scrollframe

function AddLine(name)
    local playerList = PlayerList
    local scrollChild = playerList:GetScrollChild()

    -- Crée une nouvelle ligne de texte
    local line = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    local yPos = -scrollChild.contentHeight - 5
    line:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, yPos)

    -- Définit le texte avec le nom du joueur en rose et le reste en couleur standard
    local pinkColorCode = "|cffffc0cb"
    local endColorCode = "|r"
    line:SetText(pinkColorCode .. name .. endColorCode .. " Lvl.80 v2.0")

    -- Met à jour la hauteur du contenu et du scrolling child
    local lineHeight = 20
    scrollChild.contentHeight = scrollChild.contentHeight + lineHeight
    scrollChild:SetHeight(scrollChild.contentHeight)

    -- Met à jour la barre de défilement si elle existe
    if playerList.ScrollBar then
        playerList.ScrollBar:SetMinMaxValues(1, scrollChild.contentHeight)
    end
end

-- Test de minimap button

function NOT_MinimapButton_Reposition()
    NOT_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MinimapPos)),(80*sin(MinimapPos))-52)
end
    
function NOT_MinimapButtonUnbound_Reposition()
    local xpos,ypos = NOT_MinimapButton:GetLeft(), NOT_MinimapButton:GetBottom()

    NOT_MinimapButtonUnbound:ClearAllPoints();
    NOT_MinimapButtonUnbound:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT", MinimapPosUnboundX, MinimapPosUnboundY)
    if (MinimapButtonUnbind == "1") then
        NOT_MinimapButton:Hide();
    end
    if (MinimapPosUnboundY == NIL) then
        NOT_MinimapButtonUnbound:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT", xpos-16, ypos-16)
        MinimapPosUnboundY = ypos-16
        MinimapPosUnboundX = xpos-16
    end
end

function NOT_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70 -- get coordinates as differences from the center of the minimap
	ypos = ypos/UIParent:GetScale()-ymin-70

	MinimapPos = math.deg(math.atan2(ypos,xpos)) -- save the degrees we are relative to the minimap center
	NOT_MinimapButton_Reposition() -- move the button
end

function NOT_MinimapButtonUnbound_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()

	xpos = xpos/UIParent:GetScale()
	ypos = ypos/UIParent:GetScale()

	MinimapPosUnboundY = ypos
	MinimapPosUnboundX = xpos
	NOT_MinimapButtonUnbound_Reposition() -- move the button
end
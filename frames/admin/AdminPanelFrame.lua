function B_StartEvent_OnClick(self)
	print("Button " .. self:GetName() .. " is pressed")
end

function B_PauseEvent_OnClick(self)
	print("Button " .. self:GetName() .. " is pressed")
end

function B_ShowKey_OnClick(self)
	print("Button " .. self:GetName() .. " is pressed")
end

function B_SendAlertToPlayers_OnClick(self)
	print("Button " .. self:GetName() .. " is pressed with input : " .. EB_AlertToPlayers:GetText())
end


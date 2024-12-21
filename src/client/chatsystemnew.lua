local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

TextChatService.OnIncomingMessage = function(message)
	if (not message.TextSource or not message.TextSource.UserId) then return end

	local player1 = Players.LocalPlayer
	local player2 = Players:GetPlayerByUserId(message.TextSource.UserId)

	if (player1 == player2) then return end

	if (player1:GetAttribute("currentZone") ~= player2:GetAttribute("currentZone")) then
		message.Text = ""
	end
end
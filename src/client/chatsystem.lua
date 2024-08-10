--Script created by "TheGamer101" and modified by "Locos"
local Chat = game:GetService("Chat")
local ChatSettings = require(Chat:WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))

local function Run(ChatService)
	local function WithinProximity(player1, player2)
		if player1 == player2 then return true end

		if player1.Character and player2.Character then
			return player1:GetAttribute("currentZone") == player2:GetAttribute("currentZone")
		end
		
		return false
	end

	local function ProximityChatReplicationFunction(speakerName, message, channelName)
		local speakerObj = ChatService:GetSpeaker(speakerName)
		local channelObj = ChatService:GetChannel(channelName)

		if not speakerObj then return false end		
		if not channelObj then return false end	
		
		if channelObj.Private then return false end

		local playerObj = speakerObj:GetPlayer()

		if not playerObj then return false end

		for i, otherSpeakerName in pairs(channelObj:GetSpeakerList()) do
			local otherSpeakerObj = ChatService:GetSpeaker(otherSpeakerName)
			
			if otherSpeakerObj then
				local otherPlayerObj = otherSpeakerObj:GetPlayer()
				if otherPlayerObj then
					if WithinProximity(playerObj, otherPlayerObj) then
						otherSpeakerObj:SendMessage(message, channelName, speakerName, message.ExtraData)
					end
				end
			end
		end

		return true
	end

	ChatService:RegisterProcessCommandsFunction("proximity_chat", ProximityChatReplicationFunction, ChatSettings.LowPriority)
end

return Run
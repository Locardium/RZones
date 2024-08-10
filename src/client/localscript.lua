local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local zAPI = require(game.ReplicatedStorage:WaitForChild("RZones-RS").API)

local function getMainFolder()
	local mfId = script.Parent:GetAttribute("mfId")

	if (mfId == nil) then
		local timer = time()+5
		repeat 
			mfId = script.Parent:GetAttribute("mfId")

			if time() > timer then
				error("Main folder id not found")
			end
			task.wait()
		until (mfId ~= nil)
	end

	local ws = workspace:GetDescendants()

	for i = 1, #ws do
		local instance = ws[i]
		if instance:GetAttribute("id") == mfId then
			return instance
		end
	end

	return nil
end
local zFolder = getMainFolder()

local Settings = require(zFolder.Settings)

if Settings.topBarInfo then
	local zoneId = require(script.Parent.Icon).new()
	zoneId:setName("zoneId")
	zoneId:setLabel("Lobby")
	zoneId:disableStateOverlay(true)
	zoneId:lock(true)

	if Settings.chatByZone then
		zoneId:setCaption("The chat only works with people who are in this area")
	end

	zAPI.getCurrentZoneChanged(Players.LocalPlayer, function(value)
		zoneId:setLabel(value)
	end)
else
	script:Destroy()
end
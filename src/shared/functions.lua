local Functions = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local regions = script.Parent.Parent.Parent.Regions:GetChildren()

function Functions.findZone(zoneName)
	for i = 1, #regions do
		local region = regions[i]
		if (region.Name == zoneName) then
			return region
		end
	end

	return false
end

function Functions.getPlayer(identifier)
	if (RunService:IsClient() and identifier == nil) then
		return Players.LocalPlayer
	elseif (typeof(identifier) == "number") then
		local players = Players:GetPlayers()
		for i = 1, #players do
			if players[i].UserId == identifier then
				return players[i]
			end
		end
	elseif (typeof(identifier) == "string") then
		local players = Players:GetPlayers()
		for i = 1, #players do
			if players[i].Name:lower() == identifier:lower() then
				return players[i]
			end
		end
	elseif (typeof(identifier) == "Instance" and identifier:IsA("Player")) then
		return identifier
	end

	return nil
end

return Functions
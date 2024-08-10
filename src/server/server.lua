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

local Players = game:GetService("Players")

local playersInZone = {}

--Setup currents players
local players = Players:GetPlayers()
for i = 1, #players do
	players[i]:SetAttribute("currentZone", "NULL")
end

--Setup players
Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("currentZone", "NULL")
end)

--Zones
local function setZone(partTouched, zoneName)
	local player

	if partTouched.Name ~= "Handle" then
		player = Players:GetPlayerFromCharacter(partTouched.Parent)
	else
		player = Players:GetPlayerFromCharacter(partTouched.Parent.Parent)
	end
	
	if not player then return end

	if playersInZone[player.UserId] and playersInZone[player.UserId] == zoneName then return end

	playersInZone[player.UserId] = zoneName
	player:SetAttribute("currentZone", zoneName)
end

local regions = zFolder.Regions:GetChildren()
for i = 1, #regions do
	local region = regions[i]
	if (region:IsA("Part")) then
		region.Touched:Connect(function(partTouched) setZone(partTouched, region.Name) end)
	elseif (region:IsA("Folder")) then
		local regions2 = region:GetChildren()
		for i = 1, #regions2 do
			local region2 = regions2[i]
			region2.Touched:Connect(function(partTouched) setZone(partTouched, region.Name) end)
		end
	end
end
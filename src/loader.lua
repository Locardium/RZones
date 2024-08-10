local Settings = require(script.Parent.Parent.Settings)

local mainFolder = script.Parent.Parent
local scriptsFolder = script.Parent

--Unique ID
local function generateId()
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local id = ""
	for i = 1, 6 do
		local randomIndex = math.random(1, #chars)
		id = id .. chars:sub(randomIndex, randomIndex)
	end
	return "Locos-"..id
end
local folderId = generateId()

mainFolder:SetAttribute("id", folderId)

--Chat system
local chatSystem = script.Parent.Client.ChatSystem

if Settings.chatByZone and game.TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
	warn("'chatByZone' is enable but not working because chat version is not 'LegacyChatService'. Change this in 'TextChatService' -> 'ChatVersion' -> 'LegacyChatService'")
	Settings.chatByZone = false
	chatSystem:Destroy()
elseif Settings.chatByZone and game.TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
	task.spawn(function()
		repeat task.wait() until (game:GetService("Chat").ChatModules)

		chatSystem.Parent = game:GetService("Chat").ChatModules
	end)
else
	chatSystem:Destroy()
end

--Regions
local regions = mainFolder.Regions:GetChildren()
for i = 1, #regions do
	local region = regions[i]
	if (region:IsA("Part")) then
		region.Transparency = 1
	elseif (region:IsA("Folder")) then
		local regions2 = region:GetChildren()
		for i = 1, #regions2 do
			local region2 = regions2[i]
			region2.Transparency = 1
		end
	end
end

--Replicated Storage
local rsFolder = Instance.new("Folder")
rsFolder.Parent = game.ReplicatedStorage
rsFolder.Name = "RZones-RS"
rsFolder:SetAttribute("mfId", folderId)

scriptsFolder.Shared.API.Parent = rsFolder

--Starter Player Scripts
local spsFolder = scriptsFolder.Client
spsFolder.Parent = game.StarterPlayer.StarterPlayerScripts
spsFolder.Name = "RZones-SPS"
spsFolder:SetAttribute("mfId", folderId)

--Server Script Service
local sssFolder = scriptsFolder.Server
sssFolder.Parent = game.ServerScriptService
sssFolder.Name = "RZones-SSS"
sssFolder:SetAttribute("mfId", folderId)

task.wait()
script:Destroy()
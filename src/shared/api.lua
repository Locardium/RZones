local API = {}

repeat task.wait() until game:GetService("RunService"):IsServer() or game:IsLoaded()

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

local Functions = require(zFolder.Scripts.Shared.Functions)

function API.getSettings()
	return require(zFolder.Settings)
end

function API.getCurrentZone(identifier)
	local player = Functions.getPlayer(identifier)
	if (not player) then return false end
	
	return player:GetAttribute("currentZone")
end

function API.getCurrentZoneChanged(identifier, callback)
	local player = Functions.getPlayer(identifier)
	if (not player) then return false end

	local connection = player:GetAttributeChangedSignal("currentZone"):Connect(function()
		callback(player:GetAttribute("currentZone"))
	end)

	return connection
end

function API.getAttributes(zoneName, filterPrefix)
	local zone = Functions.findZone(zoneName)
	if (not zone) then return false end

	local attributes = zone:GetAttributes()

	if (filterPrefix) then
		local newAttributes = {}

		for k,v in pairs(attributes) do
			local splitted = k:split("_")

			if (splitted[1]:lower() == filterPrefix:lower()) then
				newAttributes[k] = v
			end
		end

		return newAttributes
	end

	return attributes
end

function API.getAttribute(zoneName, prefix, attributeName)
	local zone = Functions.findZone(zoneName)
	if (not zone) then return false end

	local attributes = zone:GetAttributes()
	local newAttributes = {}

	for k,v in pairs(attributes) do
		local splitted = k:split("_")
		if (splitted[1]:lower() == prefix:lower() and splitted[2]:lower() == attributeName:lower()) then
			return v
		end
	end

	return false
end

function API.setAttribute(zoneName, prefix, attributeName, value)
	local zone = Functions.findZone(zoneName)
	if (not zone) then return false end
	
	if (prefix:match("_")) then
		prefix:gsub("_", "")
	elseif (prefix:match("-")) then
		prefix:gsub("-", "")
	end

	zone:SetAttribute(prefix.."_"..attributeName, value)
	return true
end

return API
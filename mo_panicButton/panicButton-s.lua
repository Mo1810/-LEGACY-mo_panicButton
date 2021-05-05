--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('Script by Mo1810#4230 - https://discord.gg/Q25mtKms8c')
end)

ESX.RegisterServerCallback('panicButton:getxPlayer', function(cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	while xPlayer == nil do
		xPlayer = ESX.GetPlayerFromId(source)
	end
    cb(xPlayer)
end)

RegisterServerEvent('panicButton:setBlips')
AddEventHandler('panicButton:setBlips', function(officerName, officerServerId, officerPlayer, blipVector)
	TriggerClientEvent('panicButton:setBlips', -1, officerName, officerServerId, officerPlayer, blipVector)
end)

--[[--------------------------]]--
--[[  Created by Mo1810#4230  ]]--
--[[--------------------------]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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
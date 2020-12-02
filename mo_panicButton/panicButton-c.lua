local currentPressed = false
ESX = nil
local xPlayer = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		if IsControlPressed(0, Config.trigger_key) then
			if not currentPressed then
				if ESX.PlayerData.job.name == 'police' then
					currentPressed = true
					if IsControlPressed(0, Config.trigger_key) then
						for i=2, 1, -1 do
							PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
							Citizen.Wait(50)
							PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
							Citizen.Wait(200)
						end
						Citizen.Wait(1000)
						for i=4, 1, -1 do
							PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
							Citizen.Wait(50)
							PlaySound(-1, 'TIMER_STOP', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
							Citizen.Wait(200)
						end
						if IsControlPressed(0, Config.trigger_key) then
							pressPanicButton()
						else
							Citizen.Wait(500)
							currentPressed = false
						end
					else
						currentPressed = false
					end
				else
					notify(_U('panicButton_noCop'))
				end
			else
				notify(_U('panicButton_alreadyPressed'))
			end
		end
		Citizen.Wait(1)
	end
end)

RegisterCommand("panicButton", function()
	if not currentPressed then
		if ESX.PlayerData.job.name == 'police' then
			currentPressed = true
			pressPanicButton()
		else
			notify(_U('panicButton_noCop'))
		end
	else
		notify(_U('panicButton_alreadyPressed'))
	end
end)	

function pressPanicButton()
	if GetEntityHealth(GetPlayerPed(PlayerId())) < 100 then
		currentPressed = false
		notify(_U('panicButton_dead'))
	else
		Citizen.SetTimeout(Config.pressDelay * 60000, function()
			currentPressed = false
		end)
	end
	
	local blipVector = vector3(GetEntityCoords(GetPlayerPed(PlayerId()), true))
	local officerName = GetPlayerName(PlayerId())
	officerServerId = GetPlayerServerId(PlayerId())
	officerPlayer = GetPlayerFromServerId(officerServerId)
	TriggerServerEvent('panicButton:setBlips', officerName, officerServerId, officerPlayer, blipVector)
	Citizen.Wait(2000)
end

RegisterNetEvent('panicButton:setBlips')
AddEventHandler('panicButton:setBlips', function(officerName, officerServerId, officerPlayer, blipVector)
	if ESX.GetPlayerData().job.name == 'police' and GetPlayerName(PlayerId()) ~= officerName then
		local streetName = GetStreetNameAtCoord(blipVector.x, blipVector.y, blipVector.z)
		local zone = GetLabelText(GetNameOfZone(blipVector.x, blipVector.y, blipVector.z))
		blipX = AddBlipForCoord(blipVector.x, blipVector.y, blipVector.z)
		blipP = AddBlipForCoord(blipVector.x, blipVector.y, blipVector.z)
	
		--[[1.Blip PB]]
		SetBlipSprite(blipP, Config.blipP.Sprite)
		SetBlipDisplay(blipP, Config.blipP.Display)
		SetBlipColour(blipP, Config.blipP.Colour)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("PanicButton ("..officerName..")")
		EndTextCommandSetBlipName(blipP)
	
		--[[2.Blip TB]]
		SetBlipSprite(blipX, Config.blipX.Sprite)
		SetBlipScale(blipX, Config.blipX.Scale)
		SetBlipFlashes(blipX, true)
		SetBlipFlashInterval(blipX, 500)
		SetBlipDisplay(blipX, Config.blipX.Display)

		notify(_U('panicButton_police'))
		for i=3, 1, -1 do
		PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(100)
		end
		Citizen.Wait(250)
		for i=3, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(125)
		end
		Citizen.Wait(1500)
		for i=3, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(100)
		end
		Citizen.Wait(250)
		for i=3, 1, -1 do
			PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
			Citizen.Wait(100)
		end
		Citizen.SetTimeout(Config.pressDelay * 60000, function()
			RemoveBlip(blipP)
			RemoveBlip(blipX)
		end)
	else
		if GetPlayerName(PlayerId()) == officerName then 
			notify(_U('panicButton_pressed'))
		end
	end
end)

function notify(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end
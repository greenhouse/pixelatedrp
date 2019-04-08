local Keys = {["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173}

ESX = nil
local menuIsShowed				    = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Character                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_character_select:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
-- 	ESX.TriggerServerCallback('esx_character_select:changechar', function(data)
--
-- 	end)
-- end)

function ShowCharSelectMenu(data)
	ESX.TriggerServerCallback('esx_character_select:getCharList', function(data)
		local elements = {}
		for i = 1, #data, 1 do
			table.insert(
				elements,
				{label = data[i].label, value = data[i].value}
			)
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'charselect',
			{
				title    = _U('charselecttitle'),
				align = 'left',
				elements = elements
			},
			function(data, menu)
				TriggerServerEvent('esx_character_select:getCharSkin', data.current.value)
				Citizen.Wait(1000)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
				ESX.ShowNotification('~g~'.. data.current.label .. ' ~w~' .._U('new_char'))
				menu.close()
			end,
			function(data, menu)
				menu.close()
			end
		)

	end)
end

-- Display markers
if Config.EnableMarker then
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			for i=1, #Config.Zones, 1 do
				if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end)
end

	-- Create blips
	Citizen.CreateThread(function()

	  local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

	  SetBlipSprite (blip, Config.Blip.Sprite)
	  SetBlipDisplay(blip, Config.Blip.Display)
	  SetBlipScale  (blip, Config.Blip.Scale)
	  SetBlipColour (blip, Config.Blip.Colour)
	  SetBlipAsShortRange(blip, true)

	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString('Change Character')
	  EndTextCommandSetBlipName(blip)

	end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Wait(0)
			if IsControlJustReleased(0, Keys['E']) and isInCharSelectMarker and not menuIsShowed then
				ShowCharSelectMenu()
			end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		isInCharSelectMarker  = false
		local currentZone = nil

		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.ZoneSize.x / 2) then
				isInCharSelectMarker  = true
							SetTextComponentFormat('STRING')
            	AddTextComponentString(_U('charselect'))
            	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end

		if isInCharSelectMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInCharSelectMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_character_select:hasExitedMarker')
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if ( IsControlJustPressed(0, 182) ) then
			TriggerEvent('skinchanger:loadSkin', skin)
		end
	end
end)

local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
local PlayerData                   = {}
ESX                                = nil
local jobChecked                   = {}
local gradeChecked                 = nil
local identifierChecked            = nil
local esxLoadedJobs								 = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(14000)
			if ESX ~= nil then
				ESX.TriggerServerCallback('esx_jobswlist:getWhitelistedPlayers', function(identifier , job , jobGrade)
				if identifier then
						jobChecked = job
						identifierChecked = identifier
						gradeChecked = jobGrade
					end
				end)
			end
		Citizen.Wait(4000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #jobChecked, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Whitelist[jobChecked[i]].checkin.x, Config.Whitelist[jobChecked[i]].checkin.y, Config.Whitelist[jobChecked[i]].checkin.z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Whitelist[jobChecked[i]].checkin.x, Config.Whitelist[jobChecked[i]].checkin.y, Config.Whitelist[jobChecked[i]].checkin.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
		for i=1, #jobChecked, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Whitelist[jobChecked[i]].checkout.x, Config.Whitelist[jobChecked[i]].checkout.y, Config.Whitelist[jobChecked[i]].checkout.z, true) < Config.DrawDistance) then
				DrawMarker(Config.offdutyMarkerType, Config.Whitelist[jobChecked[i]].checkout.x, Config.Whitelist[jobChecked[i]].checkout.y, Config.Whitelist[jobChecked[i]].checkout.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.offdutyMarkerColor.r, Config.offdutyMarkerColor.g, Config.offdutyMarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if identifierChecked ~= nil then
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local currentZone = nil
			for i=1, #jobChecked, 1 do
				if(GetDistanceBetweenCoords(coords, Config.Whitelist[jobChecked[i]].checkin.x, Config.Whitelist[jobChecked[i]].checkin.y, Config.Whitelist[jobChecked[i]].checkin.z, true) < Config.ZoneSize.x / 2) then
					SetTextComponentFormat('STRING')
		    	AddTextComponentString('Press ~INPUT_PICKUP~ to sign in as: ~b~' .._U(jobChecked[i]) )
		    	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					if IsControlJustReleased(0, Keys['E']) then
							TriggerServerEvent('esx_jobswlist:setJob', jobChecked[i], gradeChecked[i])
							ESX.ShowNotification('You are now ~g~ON DUTY~w~ as '.._U(jobChecked[i]))
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					      if skin.sex == 0 then
					        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					      else
					        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					      end
					    end)
					end
				end
			end
			for i=1, #jobChecked, 1 do
				if(GetDistanceBetweenCoords(coords, Config.Whitelist[jobChecked[i]].checkout.x, Config.Whitelist[jobChecked[i]].checkout.y, Config.Whitelist[jobChecked[i]].checkout.z, true) < Config.ZoneSize.x / 2) then
					SetTextComponentFormat('STRING')
		    	AddTextComponentString('Press ~INPUT_PICKUP~ to sign out as: ~b~' .._U(jobChecked[i]) )
		    	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					if IsControlJustReleased(0, Keys['E']) then
						TriggerServerEvent('esx_jobswlist:setoffduty', 'unemployed', 0)
						ESX.ShowNotification('You are now ~r~OFF DUTY~w~ as '.._U(jobChecked[i]))

						-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		        --   TriggerEvent('skinchanger:loadSkin', skin)
		        -- end)

						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local isMale = skin.sex == 0

							TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
									TriggerEvent('skinchanger:loadSkin', skin)
									TriggerEvent('esx:restoreLoadout')
								end)
							end)

						end)

					end
				end
			end
		end
	end
end)

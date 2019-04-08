local holdingup = false
local store = ""
local IsEverythingTrue = false
local blipRobbery = nil
local jewlBlip = {}
local jewlBlip_robbed = {}
local PlayerData              = {}
ESX = nil
incircle = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_vangelico_robbery:killblip')
AddEventHandler('esx_vangelico_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:setblip')
AddEventHandler('esx_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:toofarlocal')
AddEventHandler('esx_vangelico_robbery:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function(robb)
	holdingup = false
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0 }
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			else
				local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0 }
			  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	    end
    end)
	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position
		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
    RequestAnimDict( dict )
    Citizen.Wait( 5 )
  end
end

Citizen.CreateThread(function()

	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true

						if IsPedShooting(GetPlayerPed(-1)) and PlayerData.job.name ~= 'police' then

							for i=1, #Config.Blips, 1 do
								jewlBlip[i] = AddBlipForCoord(Config.Blips[i].x, Config.Blips[i].y, Config.Blips[i].z)
								SetBlipSprite(jewlBlip[i],1)
								SetBlipColour(jewlBlip[i],16742399)
								SetBlipScale(jewlBlip[i],0.5)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(_U('jewelsblipmap'))
								EndTextCommandSetBlipName(jewlBlip[i])
								jewlBlip_robbed[i] = false
							end

							TriggerServerEvent('esx_vangelico_robbery:rob', "jewelry")

          end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			for i=1, #Config.Blips, 1 do
				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Blips[i].x, Config.Blips[i].y, Config.Blips[i].z, true) < 0.5 ) then
					if (jewlBlip_robbed[i] == false) then
						DisplayHelpText(_U('field'))

						if IsControlJustReleased(1, 51) then

							local player = GetPlayerPed( -1 )

							if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                RequestNamedPtfxAsset("scr_jewelheist")
              end

							while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                Citizen.Wait(0)
              end

              SetPtfxAssetNextCall("scr_jewelheist")
							StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", Config.Blips[i].x, Config.Blips[i].y, Config.Blips[i].z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
							loadAnimDict( "missheist_jewel" )
							TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
							DisplayHelpText(_U('collectinprogress'))
							DrawSubtitleTimed(5000, 1)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							RemoveBlip(jewlBlip[i])
							TriggerServerEvent('esx_vangelico_robbery:gioielli1')
							PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							jewlBlip_robbed[i] = true

							for _,v in ipairs(jewlBlip_robbed) do
								print(v)
						    if not v then
					        IsEverythingTrue = false
								else
									IsEverythingTrue = true
						    end
							end
						end

					end
				end
			end

			if IsEverythingTrue then
				holdingup = false
				for i=1, #Config.Blips, 1 do
						jewlBlip_robbed[i] = false
				end

				TriggerServerEvent('esx_vangelico_robbery:endrob', "jewelry")
				ESX.ShowNotification(_U('lester'))
				TriggerEvent('skinchanger:getSkin', function(skin)
           if skin.sex == 0 then
              local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0   }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            else
              local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0 }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
             end
          end)
				end

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('esx_vangelico_robbery:toofar', "jewelry")
				holdingup = false

				for i=1, #Config.Blips, 1 do
					RemoveBlip(jewlBlip_robbed[i])
				end

				for i=1, #Config.Blips, 1 do
						jewlBlip_robbed[i] = false
				end
			end
		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_vangelico_robbery:togliblip')
AddEventHandler('esx_vangelico_robbery:togliblip', function(robb)
	for i=1, #Config.Blips, 1 do
		RemoveBlip(jewlBlip_robbed[i])
	end
end)

RegisterNetEvent("lester:createBlip")
AddEventHandler("lester:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 77)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lester")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
		TriggerEvent('lester:createBlip', 77, 706.669, -966.898, 30.413)
    while true do
      Citizen.Wait(0)
      playerPed = GetPlayerPed(-1)
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			if pos then
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 706.669, -966.898, 30.413, true) <= 5 then
					TriggerServerEvent('lester:vendita')
          Citizen.Wait(4000)
          TriggerEvent('skinchanger:getSkin', function(skin)
           if skin.sex == 0 then
              local clothesSkin = { ['bags_1'] = 0, ['bags_2'] = 0 }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            else
							local clothesSkin = { ['bags_1'] = 0, ['bags_2'] = 0 }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end
          end)
				end
			end
    end
end)

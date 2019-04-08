-- Start Gun Control
local skinbag = nil
local WeaponfromTrunk = nil
local color = {r = 37, g = 175, b = 134, alpha = 255} -- Color of the text
local font = 0 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local nbrDisplaying = 0
local tookWeapon = false
local LoadedIn = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(18000)
    TriggerEvent('skinchanger:getSkin', function(skin)
        skinbag = skin['bags_1']
    end)
    Citizen.Wait(300000)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(18000)
    if not LoadedIn then
      LoadedIn = true
    end
  end
end)

-- No gun without trunk
Citizen.CreateThread(function()
  while true do
		Citizen.Wait(20)
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

    if GetSelectedPedWeapon(playerPed) ~= nil then
      if skinbag == 40 or skinbag == 41 or skinbag == 44 or skinbag == 45 or closecar ~= 0 and VehicleInFront() > 0 then
        if skinbag == 40 or skinbag == 41 or skinbag == 44 or skinbag == 45 then
          where = 'bag'
        else
          where = 'trunk'
        end
        for i=1, #Config.StashWeapons, 1 do
          local weaponHash = GetHashKey(Config.StashWeapons[i].name)
          local weaponName = Config.StashWeapons[i].label
          if weaponHash == GetSelectedPedWeapon(playerPed) and not tookWeapon and GetSelectedPedWeapon(playerPed) ~= WeaponfromTrunk then
            tookWeapon = true
            text = '*Grabs ' .. weaponName .. ' from ' .. where .. '*'
            TriggerServerEvent('3dme:shareDisplay', text)
            WeaponfromTrunk = GetSelectedPedWeapon(playerPed)
          end
        end

      else

        for i=1, #Config.StashWeapons, 1 do
          local weaponHash = GetHashKey(Config.StashWeapons[i].name)
          if weaponHash == GetSelectedPedWeapon(playerPed) and WeaponfromTrunk ~= weaponHash then
            SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
            tookWeapon = false
            TriggerEvent('esx:showNotification', 'You dont have a bag or trunk to take out this weapon')
          end
        end

      end
    end

    if GetSelectedPedWeapon(playerPed) ~= WeaponfromTrunk then
      WeaponfromTrunk = nil
      tookWeapon = false
    end
    currentWeapon = GetSelectedPedWeapon(playerPed)
    if currentWeapon ~= -1569615261 and currentWeapon ~= 883325847 and currentWeapon ~= 966099553 and not IsPedInAnyVehicle(playerPed, 1) and LoadedIn then
      if not tookWeapon or WeaponfromTrunk ~= GetSelectedPedWeapon(playerPed) then
        print(GetSelectedPedWeapon(playerPed))
        text = '*Grabs a weapon* '
        TriggerServerEvent('3dme:shareDisplay', text)
        tookWeapon = true
        WeaponfromTrunk = GetSelectedPedWeapon(playerPed)
      end
    end

	end
end)

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.14)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3D(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

-- End Gun control

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}


-- Damgage walk
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if (GetEntityHealth(GetPlayerPed(-1)) < 199) then
			RequestAnimSet("move_injured_generic")
			while not HasAnimSetLoaded("move_injured_generic") do
				Citizen.Wait(0)
			end
			SetPedMovementClipset(GetPlayerPed(-1), "move_injured_generic", 1 )
		else
			ResetPedMovementClipset(GetPlayerPed(-1), 0)
		end
	end
end)

-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1200

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

-- CODE --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)
			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
					end
					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end
			prevPos = currentPos
		end
	end
end)

-- Global Functions
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)
-- End Global functions

--clear cops
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    local playerPed = GetPlayerPed(-1)
    local playerLocalisation = GetEntityCoords(playerPed)
    ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
  end
end)

RegisterNetEvent('esx_mods:notiUser')
AddEventHandler('esx_mods:notiUser', function(title,message)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
    ESX.ShowAdvancedNotification(title, 'Exclusive Life', message , mugshotStr, 1)
    UnregisterPedheadshot(mugshot)
end)


-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(8000)
-- 		ESX.TriggerServerCallback('esx_AntiCheat:getPlayerCurrentMoney', function(source,playerID) end)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(300000)
-- 		ESX.TriggerServerCallback('esx_sneakstatus:onlineTime', function(timePlayed)
-- 			if timePlayed ~= nil then
-- 				timePlayedNew = tonumber(timePlayed + 5)
-- 				TriggerServerEvent('esx_sneakstatus:updateTimePlayed', GetPlayerServerId(PlayerId()), timePlayedNew)
-- 				--ESX.TriggerServerCallback('esx_sneakstatus:updateTimePlayed', function(source,timePlayedNew) end)
-- 			end
-- 		end)
-- 		--ESX.TriggerServerCallback('esx_sneakstatus:onlineTime', function(source,playerID) end)
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		ESX.TriggerServerCallback('esx_autoKick', function(source,playerID) end)
	end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Citizen.Wait(15000)
	ESX.TriggerServerCallback('esx_sneakstatus:Setonline', function(source,playerID) end)
end)

-- Stop drop guns
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(20)
    -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
  end
end)

-- end clear cops

-- Show ID card
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ( IsControlJustPressed(2, 182) ) and GetLastInputMethod( 0 )	 then
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'id_card_menu',
					{
						title    = 'ID Menu',
						align    = 'top-left',
						elements = {
							{label = 'Check your own ID', value = 'check'},
							{label = 'Show id', value = 'show'}
						}
					},
					function(data2, menu2)
						if data2.current.value == 'check' then
							TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
							menu2.close()
						elseif data2.current.value == 'show' then
							local player, distance = ESX.Game.GetClosestPlayer()

							if distance ~= -1 and distance <= 3.0 then
								TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
								menu2.close()
							else
								ESX.ShowNotification('Nobody nearby')
								menu2.close()
							end
						end
					end,
					function(data2, menu2)
						menu2.close()
				end)
		end
	end
end)

local cardOpen 		= false

-- Servern callback
RegisterNetEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(playerData)
	cardOpen = true
	SendNUIMessage({
		action = "open",
		array = playerData
	})
end)

-- Close the ID card
-- Key events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
			SendNUIMessage({
				action = "close"
			})
			cardOpen = false
		end
	end
end)


-- Disable dispatch
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(3500)
-- 		for i = 1, 12 do
-- 			EnableDispatchService(i, false)
-- 		end
-- 		SetPlayerWantedLevel(PlayerId(), 0, false)
-- 		SetPlayerWantedLevelNow(PlayerId(), false)
-- 		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
-- 	end
-- end)
-- End disable dispatch

-- Traffic and Peds
Citizen.CreateThread(function()
    while true
    	do
    		-- These natives has to be called every frame.
        SetVehicle = 0.90
        SetPedDensity = 1.10
        SetParkedVehicle = 0.90
        SetScenarioPed = 0.95
        SetRandomVehicle = 0.90

    SetVehicleDensityMultiplierThisFrame(SetVehicle)
		SetPedDensityMultiplierThisFrame(SetPedDensity)
		SetRandomVehicleDensityMultiplierThisFrame(SetParkedVehicle)
		SetParkedVehicleDensityMultiplierThisFrame(SetRandomVehicle)
		SetScenarioPedDensityMultiplierThisFrame(SetScenarioPed, SetScenarioPed)

		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed)
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);


		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(0)
		SetRandomBoats(0)

		Citizen.Wait(10)
	end

end)
-- No ped
function disableControl()
	DisableControlAction(0, 59, true)
  DisableControlAction(0, Keys["R"], true)
  DisableControlAction(2, 24, true) -- Attack
  DisableControlAction(2, 257, true) -- Attack 2
  DisableControlAction(2, 25, true) -- Aim
  DisableControlAction(2, 263, true) -- Melee Attack 1
  DisableControlAction(0, 24, true) -- Attack
  DisableControlAction(0, 257, true) -- Attack 2
  DisableControlAction(0, 25, true) -- Aim
  DisableControlAction(0, 263, true) -- Melee Attack 1
  DisableControlAction(27, 23, true) -- Also 'enter'?
  DisableControlAction(0, 23, true) -- Also 'enter'?
  DisableControlAction(0, 288, true) -- Disable phone
  DisableControlAction(0,289, true) -- Inventory
  DisableControlAction(0, 289,  true) -- Inventory block
	DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
  DisableControlAction(0, 29,  true) -- Point
  DisablePlayerFiring(GetPlayerPed(-1), true)
	DisableControlAction(2, Keys[','], true) -- Disable animations
  DisableControlAction(0, 82,  true) -- Animations
  DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
  DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
  DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
  DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
  DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
  DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
  DisableControlAction(0, 257, true) -- INPUT_ATTACK2
  DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
  DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
  DisableControlAction(0, 24, true) -- INPUT_ATTACK
  DisableControlAction(0, 25, true) -- INPUT_AIM
	DisableControlAction(0, 75, true)  -- Disable exit vehicle
	DisableControlAction(27, 75, true) -- Disable exit vehicle
	DisableControlAction(0, 65, true) -- Disable f9
	DisableControlAction(0, 167, true) -- Disable f6
	DisableControlAction(2, 59, true) -- Disable steering in vehicle
  ESX.UI.Menu.CloseAll()
end

-- Hands up
Citizen.CreateThread(function()
  local dict = "missminuteman_1ig_2"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(10)
		if IsControlJustPressed(1, 323) then --Start holding X
      if not handsup then
        TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
      else
        handsup = false
        ClearPedTasks(GetPlayerPed(-1))
      end
     end
    end
		while handsup do
			disableControl()
		end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "missminuteman_1ig_2", "handsup_enter", 3) then
			disableControl()
		end
	end
end)

-- end hands up

-- Pointfinger
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Citizen.Wait(10)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Citizen.Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)
-- end pointfinger

-- ID overhead
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local displayIDHeight = 1.5 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end
        for id = 0, 31 do
            if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped )

                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if NetworkIsPlayerTalking(id) then
						red = 0
						green = 0
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
					else
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
					end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
						if NetworkIsPlayerTalking(id) then
							red = 0
							green = 0
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						else
							red = 255
							green = 255
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
						end
                    end
                end
            end
        end
        Citizen.Wait(10)
    end
end)
-- End id over head

-- No rectagle
Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)
-- end no rectagle

-- compass
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/1.98, y - height/2 + 0.005)
end

function drawTxt2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/1.98, y - height/2 + 0.005)
end
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', }
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
		local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]

		for k,v in pairs(directions)do
			direction = GetEntityHeading(GetPlayerPed(-1))
			if(math.abs(direction - k) < 22.5)then
				direction = v
				break;
			end
		end

		if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
			if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
				if direction == 'N' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.306, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.285, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'NE' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.298, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.277, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.277, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
					drawTxt2(x-0.277, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)),curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'E' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.309, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.288, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.288, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
					drawTxt2(x-0.288, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'SE' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.298, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.275, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.275, x+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.275, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'S' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.307, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.285, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.285, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'SW' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.292, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.270, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.270, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.270, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'W' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.303, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.280, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.280, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.280, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				elseif direction == 'NW' then
						drawTxt(x-0.335, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.290, y+0.66, 1.0,1.5,1.4, " | ", border_r, border_g, border_b, border_a)
						drawTxt(x-0.315, y+0.42, 1.0,1.0,1.0, direction, dir_r, dir_g, dir_b, dir_a)
					if tostring(GetStreetNameFromHashKey(var2)) == "" then
						drawTxt2(x-0.266, y+0.45, 1.0,1.0,0.45, current_zone, town_r, town_g, town_b, town_a)
					else
						drawTxt2(x-0.266, y+0.45, 1.0,1.0,0.45, tostring(GetStreetNameFromHashKey(var2)) .. ", " .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], str_around_r, str_around_g, str_around_b, str_around_a)
					end
						drawTxt2(x-0.266, y+0.42, 1.0,1.0,0.55, tostring(GetStreetNameFromHashKey(var1)), curr_street_r, curr_street_g, curr_street_b, curr_street_a)
				end
			end
		end
	end
end)
-- end compass

-- JF_SeatShuffle
-- local disableShuffle = true
-- function disableSeatShuffle(flag)
-- 	disableShuffle = flag
-- end
--
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
-- 			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
-- 				if GetIsTaskActive(GetPlayerPed(-1), 165) then
-- 					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
--
-- RegisterNetEvent("SeatShuffle")
-- AddEventHandler("SeatShuffle", function()
-- 	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
-- 		--disableSeatShuffle(false)
-- 		--Citizen.Wait(5000)
-- 		disableSeatShuffle(true)
-- 	else
-- 		CancelEvent()
-- 	end
-- end)
--
-- RegisterCommand("shuff", function(source, args, raw) --change command here
--     TriggerEvent("SeatShuffle")
-- end, false)

-- V2
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

-- End seatshuffle

-- Disable gun drop
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
  end
end)
-- End Disable gun drop

-- enable pvp
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		SetCanAttackFriendly(GetPlayerPed(-1), true, false)
		NetworkSetFriendlyFireOption(true)
	end
end)
-- End Enable pvp

-- Pause menu
Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', 'Pixelated RP | discord: https://discord.gg/bNycU46')
end)
-- end Pauze menu

-- Crouch
local crouched = false

Citizen.CreateThread( function()
    while true do
        Citizen.Wait( 10 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK

            if ( not IsPauseMenuActive() ) then
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do
                        Citizen.Wait( 100 )
                    end

                    if ( crouched == true ) then
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true
                    end
                end
            end
        end
    end
end )

-- Cross hands
Citizen.CreateThread(function()
  local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(2, 74) and GetLastInputMethod( 0 )  then --Start holding h
			car = GetVehiclePedIsIn(playerPed, false)
        if not handsup and car == 0 then
            TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
            SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
            DisableControlAction(2, Keys['TAB'], true)
            handsup = true
        else
            handsup = false
            ClearPedTasks(GetPlayerPed(-1))
        end
    end
  end
end)

-- No drive By
-- Allow passengers to shoot
local passengerDriveBy = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end)


-- Police car wepaons delete
local vehWeapons = {
	0x1D073A89, -- ShotGun
	0x83BF0278, -- Carbine
	0x5FC3C11, -- Sniper
}

local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
			if(not hasBeenInPoliceVehicle) then
				hasBeenInPoliceVehicle = true
			end
		else
			if(hasBeenInPoliceVehicle) then
				for i,k in pairs(vehWeapons) do
					if(not alreadyHaveWeapon[i]) then
						TriggerServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon",k)
					end
				end
				hasBeenInPoliceVehicle = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			for i=1,#vehWeapons do
				if(HasPedGotWeapon(GetPlayerPed(-1), vehWeapons[i], false)==1) then
					alreadyHaveWeapon[i] = true
				else
					alreadyHaveWeapon[i] = false
				end
			end
		end
		Citizen.Wait(5000)
	end
end)


RegisterNetEvent("PoliceVehicleWeaponDeleter:drop")
AddEventHandler("PoliceVehicleWeaponDeleter:drop", function(wea)
	RemoveWeaponFromPed(GetPlayerPed(-1), wea)
end)

-- Police car weapons delete end

-- Weapon recoil
local scopedWeapons =
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
		177293209,   -- WEAPON_HEAVYSNIPER MKII
		1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do
        if ( hash == v ) then
            return true
        end
    end
    return false
end

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then
          HideHudComponentThisFrame( 14 )
		end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		--print(weapon) -- To get the weapon hash by pressing F8 in game
		-- Disable reticle
		ManageReticle()
		-- Disable melee while aiming (may be not working)
		if IsPedArmed(ped, 6) then
    	DisableControlAction(1, 140, true)
      DisableControlAction(1, 141, true)
      DisableControlAction(1, 142, true)
    end

		-- Disable ammo HUD

		DisplayAmmoThisFrame(false)

		-- Shakycam

		-- Pistol
		if weapon == GetHashKey("WEAPON_STUNGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end

		if weapon == GetHashKey("WEAPON_FLAREGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end

		if weapon == GetHashKey("WEAPON_SNSPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end

		if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end

		if weapon == GetHashKey("WEAPON_PISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end

		if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end

		if weapon == GetHashKey("WEAPON_APPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end

		if weapon == GetHashKey("WEAPON_PISTOL50") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end

		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end

		if weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end

		if weapon == GetHashKey("WEAPON_REVOLVER") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end

		if weapon == GetHashKey("WEAPON_REVOLVER_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
			end
		end

		if weapon == GetHashKey("WEAPON_DOUBLEACTION") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		-- SMG

		if weapon == GetHashKey("WEAPON_MICROSMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end

		if weapon == GetHashKey("WEAPON_COMBATPDW") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end

		if weapon == GetHashKey("WEAPON_SMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end

		if weapon == GetHashKey("WEAPON_SMG_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
			end
		end

		if weapon == GetHashKey("WEAPON_ASSAULTSMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end

		if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end

		if weapon == GetHashKey("WEAPON_MINISMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end

		if weapon == GetHashKey("WEAPON_MG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end

		if weapon == GetHashKey("WEAPON_COMBATMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end

		if weapon == GetHashKey("WEAPON_COMBATMG_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
			end
		end

		-- Rifles

		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end

		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)
			end
		end

		if weapon == GetHashKey("WEAPON_CARBINERIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end

		if weapon == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)
			end
		end

		if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end

		if weapon == GetHashKey("WEAPON_GUSENBERG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end

		if weapon == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)
			end
		end

		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)
			end
		end

		if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		-- Shotgun

		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end

		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
			end
		end

		if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end

		if weapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.12)
			end
		end

		if weapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end

		if weapon == GetHashKey("WEAPON_DBSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end

		if weapon == GetHashKey("WEAPON_AUTOSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end

		if weapon == GetHashKey("WEAPON_MUSKET") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04)
			end
		end

		if weapon == GetHashKey("WEAPON_HEAVYSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.13)
			end
		end

		-- Sniper

		if weapon == GetHashKey("WEAPON_SNIPERRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
			end
		end

		if weapon == GetHashKey("WEAPON_HEAVYSNIPER") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
			end
		end

		if weapon == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
			end
		end

		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end

		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end

		-- Launcher

		if weapon == GetHashKey("WEAPON_GRENADELAUNCHER") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end

		if weapon == GetHashKey("WEAPON_RPG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end

		if weapon == GetHashKey("WEAPON_HOMINGLAUNCHER") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end

		if weapon == GetHashKey("WEAPON_MINIGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)
			end
		end

		if weapon == GetHashKey("WEAPON_RAILGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)

			end
		end

		if weapon == GetHashKey("WEAPON_COMPACTLAUNCHER") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end

		if weapon == GetHashKey("WEAPON_FIREWORK") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
			end
		end

		-- Infinite FireExtinguisher

		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
end)


local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 1.9, -- AP PISTOL
	[2578377531] = 0.6, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.2, -- SMG
	[2024373456] = 0.2, -- SMG MK2
	[4024951519] = 0.2, -- ASSAULT SMG
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.4, -- CARBINE RIFLE
	[4208062921] = 0.5, -- CARBINE RIFLE MK2
	[2937143193] = 0.6, -- ADVANCED RIFLE
	[2634544996] = 0.5, -- MG
	[2144741730] = 0.5, -- COMBAT MG
	[3686625920] = 0.4, -- COMBAT MG MK2
	[487013001] = 0.4, -- PUMP SHOTGUN
	[1432025498] = 0.4, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.7, -- HEAVY SNIPER
	[177293209] = 0.7, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[2009644972] = 0.25, -- SNS PISTOL MK2
	[1627465347] = 0.7, -- GUSENBERG
	[3231910285] = 0.5, -- SPECIAL CARBINE
	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.6, -- BULLPUP RIFLE
	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.9, -- HEAVY SHOTGUN
	[3342088282] = 0.9, -- MARKSMAN RIFLE
	[1785463520] = 0.35, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.6, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
  [1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.65, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.3, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat
					Wait(10)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end

		end
	end
end)
-- End Weapon recoil

-- Cruise Control
local useMph = false -- if false, it will display speed in kph

Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(10)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
      end
      -- Disable speed limiter
      if IsControlPressed(0,172) and IsControlPressed(0,131)  then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Speed limiter disabled")
      -- Enable speed limiter
		elseif IsControlJustReleased(0,173) and IsControlPressed(0,131) then
        cruise = GetEntitySpeed(vehicle)
        SetEntityMaxSpeed(vehicle, cruise)
        if useMph then
          cruise = math.floor(cruise * 2.23694 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." mph.  ~INPUT_CELLPHONE_UP~ to disable.")
        else
          cruise = math.floor(cruise * 3.6 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." km/h. ~INPUT_CELLPHONE_UP~ to disable.")
        end
      end
    else
      resetSpeedOnEnter = true
    end
  end
end)

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

-- End Cruise control


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
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 5.0, 0.0)
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

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


-- GSR
-----------------------------CONFIG LINES--------------------------------------

local toggleWaterClean = true --Set to false if you dont want water to clean off GSR from people who shot

-------------------------------------------------------------------------------



ESX = nil
local hasShot = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

------------ CODE STARTS HERE ---------------

local timer = 3600


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsPedShooting(GetPlayerPed(-1)) and not (hasShot) then
      hasShot = true
		  TriggerServerEvent('addGsrRecord', timer)
    elseif IsPedShooting(GetPlayerPed(-1)) and (hasShot) then
      hasShot = true
      timer = 3600
      TriggerServerEvent('timeUpdate', timer)
		end
	end
end)


Citizen.CreateThread(function()
  while true do
    Wait(0)
    if (hasShot) and timer > 0 then
      timer = timer - 1
      timecheck(timer)
    end

    if timer <= 1 and (hasShot) then
      hasShot = false
      timer = 3600
      TriggerServerEvent('removeGsrRecord')
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(2000)
    if toggleWaterClean and hasShot then
      if IsEntityInWater(GetPlayerPed(-1)) then
        hasShot = false
        TriggerServerEvent('removeGsrRecord')
        TriggerEvent('gsrCleanedNotify')
      end
    end
  end
end)



function timecheck(time)
  if time < 3600 and time > 3500 then
    TriggerServerEvent('timeUpdate', time)
--  elseif time < 2500 and time > 2400 then
--    TriggerServerEvent('timeUpdate', time)
--  elseif time < 2000 and time > 1900 then
--    TriggerServerEvent('timeUpdate', time)
--  elseif time < 1500 and time > 1400 then
--    TriggerServerEvent('timeUpdate', time)
--  elseif time < 1000 and time > 900 then
--    TriggerServerEvent('timeUpdate', time)
--  elseif time < 500 and time > 400 then
--    TriggerServerEvent('timeUpdate', time)
--  elseif time < 250 and time > 200 then
--    TriggerServerEvent('timeUpdate', time)
  elseif time < 100 then
    TriggerServerEvent('timeUpdate', time)
  end
end


------------------------------------------------------------
------              All pNotify Events                ------
------------------------------------------------------------
RegisterNetEvent('noPlayerNotify')
  AddEventHandler('noPlayerNotify', function()
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
     TriggerEvent('esx_mods:notiUser', 'No nearby players','No nearby players.', mugshot , 1)
  end)

  RegisterNetEvent('hasShotNotify')
  AddEventHandler('hasShotNotify', function()
    TriggerEvent('esx_mods:notiUser', 'Sample to test','We are testing it right now please wait.', 'CHAR_BUGSTARS', 1)
    Wait(8000)
    TriggerEvent('esx_mods:notiUser', 'Results', 'Traces of gunpowder were found.', 'CHAR_BUGSTARS' ,1)
  end)

  RegisterNetEvent('hasNotShotNotify')
  AddEventHandler('hasNotShotNotify', function()
    TriggerEvent('esx_mods:notiUser', 'Sample to test','We are testing it right now please wait.', 'CHAR_BUGSTARS', 1)
    Wait(8000)
    TriggerEvent('esx_mods:notiUser', 'Results', 'No traces of gunpowder were found.', 'CHAR_BUGSTARS' ,1)
  end)

  RegisterNetEvent('gsrCleanedNotify')
  AddEventHandler('gsrCleanedNotify', function()
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
     TriggerEvent('esx_mods:notiUser', 'Cleaning','Busy cleaning', mugshot, 1)
     Wait(8000)
     TriggerEvent('esx_mods:notiUser', 'Done', 'You hopped in the water and cleaned off the Gunshot Residue.', mugshot ,1)
  end)
-- End grs

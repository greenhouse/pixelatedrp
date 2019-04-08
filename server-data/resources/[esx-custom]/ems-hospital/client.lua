RegisterNetEvent('HOSPITAL:hospitalize')

local isHospitalized = false
local hospitalIdentifier = 0
local hospitalDuration = 0
local timePassed = 0
local inMorgue = false


AddEventHandler('HOSPITAL:hospitalize', function(customTime, hospIdentifier)
	isHospitalized = true
	hospitalDuration = tonumber(customTime)
	hospitalIdentifier = tonumber(hospIdentifier)
end)



Citizen.CreateThread(function()
	isHospitalized = false
	hospitalIdentifier = 0
	hospitalDuration = 0
	timePassed = 0
	inMorgue = false

	local morgueTeleportLocation = { 264.58, -1353.34, 24.6, 38.01}
	local interiorID = 60418


	function teleportPlayer(playerPed,coords)
		DoScreenFadeOut(500)

		while IsScreenFadingOut() do
			Citizen.Wait(0)
		end

		NetworkFadeOutEntity(playerPed, true, false)
		Wait(500)

		SetEntityCoords(playerPed, coords[1],coords[2],coords[3],coords[4], 0, 0, 1)
		NetworkFadeInEntity(playerPed, 0)
		FreezeEntityPosition(playerPed, true)
		TriggerEvent('esx_ambulancejob:revive')
		Wait(500)

		while (not IsInteriorReady(interiorID)) do
			Wait(100)
		end

		DoScreenFadeIn(500)

		while IsScreenFadingIn() do
			Citizen.Wait(0)
		end

		FreezeEntityPosition(playerPed, false)
	end


	local hospitals = {}

	math.randomseed(GetPlayerServerId(GetPlayerIndex()))

	function createSpawnPoint(x1,x2,y1,y2,z,heading)
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(hospitals,newObject)
	end

	createSpawnPoint(-247, -245, 6329, 6332, 33.5, 0) -- Paleto             | paleto or 1
	createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0) -- Sandy Shores       | sandy or 2
	createSpawnPoint(-448, -448, -340, -329, 35.5, 0) -- Mount Zonah        | zonah or 3
	createSpawnPoint(372, 375, -596, -594, 30.0, 0)   -- Pillbox Hill       | pillbox or 4
	createSpawnPoint(335, 340, -1400, -1390, 33.5, 0) -- Central Los Santos | central or 5



	while true do
		Wait(0)

		if( IsEntityAtCoord(GetPlayerPed(-1), 275.5, -1360.3, 24.1, 3.0, 3.0, 3.0, 0, 1, 0) ) then
			if(isHospitalized) then
				SetEntityCoords(GetPlayerPed(-1), morgueTeleportLocation[1],morgueTeleportLocation[2],morgueTeleportLocation[3],morgueTeleportLocation[4], 0, 0, 1)
			end
		end

		if (isHospitalized) then
			local ped = GetPlayerPed(-1)

			if (timePassed >= hospitalDuration) then
				isHospitalized = false
				inMorgue = false
				Wait(1000)
				timePassed = 0

				if(hospitalIdentifier > 0) then
					local curHosp = hospitals[hospitalIdentifier]
					SetEntityCoords(ped, curHosp.x, curHosp.y, curHosp.z, curHosp.heading, 0, 0, 1)
				else
					SetEntityCoords(ped, 233.5, -1388.5, 30.75, 325, 0, 0, 1)
				end

				TriggerServerEvent('HOSPITAL:released', GetPlayerServerId(GetPlayerIndex()))


			elseif (not inMorgue) then
				teleportPlayer(ped, morgueTeleportLocation)

				FreezeEntityPosition(ped, false)
				inMorgue = true
			else
				if (not (GetInteriorFromEntity(ped) == interiorID) ) then
					inMorgue = false
				end
				Wait(100)
			end
		end
	end
end)


Citizen.CreateThread(function()
	local messageInterval = 30

	while true do
		Wait(0)
		if (isHospitalized and inMorgue) then
			Wait(1000)
			timePassed = timePassed + 1
			local timeLeft = hospitalDuration - timePassed

			if (timeLeft > 0) then
				if( (timeLeft % messageInterval == 0) or (timeLeft == 15) ) then
				TriggerServerEvent('HOSPITAL:reminder', GetPlayerServerId(GetPlayerIndex()), (timeLeft) )
				end
			end

		end
	end
end)

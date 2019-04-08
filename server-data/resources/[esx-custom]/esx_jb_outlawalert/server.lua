ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('thiefInProgress')
AddEventHandler('thiefInProgress', function(street1, street2, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft ~w~"..sex.." ~r~ enter ~w~"..street1.."~r~ at ~w~"..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft~w~"..veh.." ~r~ is ~w~"..sex.." ~r~enter ~w~"..street1.."~r~ at ~w~"..street2)
	end
end)

RegisterServerEvent('thiefInProgressS1')
AddEventHandler('thiefInProgressS1', function(street1, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft ~w~"..sex.." ~r~at ~w~"..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft ~w~"..veh.." ~r~suspect is ~w~"..sex.." ~r~at ~w~"..street1)
	end
end)

RegisterServerEvent('thiefInProgressPolice')
AddEventHandler('thiefInProgressPolice', function(street1, street2, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~Vechicle theft POLICE car ~w~"..sex.." ~r~ on ~w~"..street1.."~r~ at ~w~"..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft POLICE ~w~"..veh.." ~r~ suspect is ~w~"..sex.." ~r~going  ~w~"..street1.."~r~ at ~w~"..street2)
	end
end)

RegisterServerEvent('thiefInProgressS1Police')
AddEventHandler('thiefInProgressS1Police', function(street1, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft POLICE suspect is ~w~"..sex.." ~r~at ~w~"..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "~r~Vehicle theft POLICE ~w~"..veh.." ~r~suspect is ~w~"..sex.." ~r~at ~w~"..street1)
	end
end)

-- RegisterServerEvent('meleeInProgress')
-- AddEventHandler('meleeInProgress', function(street1, street2, sex)
-- 	TriggerClientEvent("outlawNotify", -1, "~r~Fight broke out suspect  is ~w~"..sex.." ~r~between  ~w~"..street1.."~r~ and ~w~"..street2)
-- end)
--
-- RegisterServerEvent('meleeInProgressS1')
-- AddEventHandler('meleeInProgressS1', function(street1, sex)
-- 	TriggerClientEvent("outlawNotify", -1, "~r~Fight broke out suspect is ~w~"..sex.." ~r~at ~w~"..street1)
-- end)


RegisterServerEvent('gunshotInProgress')
AddEventHandler('gunshotInProgress', function(street1, street2, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Gun shot suspect is  ~w~"..sex.." ~r~going in ~w~"..street1.."~r~ and ~w~"..street2)
end)

RegisterServerEvent('gunshotInProgressS1')
AddEventHandler('gunshotInProgressS1', function(street1, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Gun shot suspect is ~w~"..sex.." ~r~at ~w~"..street1)
end)

RegisterServerEvent('thiefInProgressPos')
AddEventHandler('thiefInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('thiefPlace', -1, tx, ty, tz)
end)

RegisterServerEvent('gunshotInProgressPos')
AddEventHandler('gunshotInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('gunshotPlace', -1, gx, gy, gz)
end)

-- RegisterServerEvent('meleeInProgressPos')
-- AddEventHandler('meleeInProgressPos', function(mx, my, mz)
-- 	TriggerClientEvent('meleePlace', -1, mx, my, mz)
-- end)

ESX.RegisterServerCallback('esx_outlawalert:ownvehicle',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil then
		local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
		local plate = vehicleProps.plate

			for _,v in pairs(vehicules) do
				if(plate == v.plate)then
					isFound = true
					break
				end
			end
			cb(isFound)
	end


end)

function getPlayerVehicles(identifier)

	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate})
	end
	return vehicles
end

RegisterServerEvent('eden_garage:debug')
RegisterServerEvent('eden_garage:modifystate')
RegisterServerEvent('eden_garage:pay')


ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage:getVehicles', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, modelname = v.modelname, brand = v.brand})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('eden_garage:getPlayerBrands', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local brands = {}

	MySQL.Async.fetchAll("SELECT brand FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data)
		for _,v in pairs(data) do
			table.insert(brands, {brands = v.brand})
		end
		cb(brands)
	end)
end)
-- Fin --Recupere les véhicules

--Stock les véhicules
ESX.RegisterServerCallback('eden_garage:stockv',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate


		for _,v in pairs(vehicules) do
			if(plate == v.plate)then
				local idveh = v.id
				local vehprop = json.encode(vehicleProps)
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE id=@id",{['@vehprop'] = vehprop, ['@id'] = v.id})
				isFound = true
				break
			end
		end
		cb(isFound)
end)


--Fin stock les vehicules

--Change le state du véhicule

AddEventHandler('eden_garage:modifystate', function(vehicleProps, state)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate
	local state = state

	for _,v in pairs(vehicules) do
		if(plate == v.plate)then
			local idveh = v.id
			MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE id=@id",{['@state'] = state , ['@id'] = v.id})
			break
		end
	end
end)



--Fin change le state du véhicule

--Fonction qui récupere les plates

-- Fin Fonction qui récupere les plates

ESX.RegisterServerCallback('eden_garage:getOutVehicles',function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}
	if xPlayer ~= nil then
		MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier AND state=false",{['@identifier'] = xPlayer.getIdentifier()}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(vehicules, vehicle)
			end
			cb(vehicules)
		end)
	end
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('eden_garage:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		if xPlayer.get('money') >= Config.Price then
			cb(true)
		else
			cb(false)
		end
	end
end)
--Fin Foonction qui check l'argent

--fonction qui retire argent

AddEventHandler('eden_garage:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		xPlayer.removeMoney(Config.Price)
		TriggerClientEvent('esx:showNotification', source, 'You paid ' .. Config.Price)
	end
end)
--Fin fonction qui retire argent


--Recupere les vehicules
function getPlayerVehicles(identifier)

	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate, modelname = v.modelname, brand = v.brand})
	end
	return vehicles
end
--Fin Recupere les vehicules

--Debug
-- AddEventHandler('eden_garage:debug', function(var)
-- 	print(to_string(var))
-- end)


-- Fonction qui change les etats sorti en rentré lors d'un restart
AddEventHandler('onMySQLReady', function()
	MySQL.Sync.execute("UPDATE owned_vehicles SET state=true WHERE state=false", {})
end)
-- Fin Fonction qui change les etats sorti en rentré lors d'un restart

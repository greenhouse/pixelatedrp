ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

local VehiclesForSale = 0

ESX.RegisterServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

    MySQL.Async.fetchAll("SELECT seller, vehicleProps, price FROM vehicles_for_sale", {}, function(result)
        local vehicleTable = {}

        VehiclesForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                VehiclesForSale = VehiclesForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller })
            end
        end

        cb(vehicleTable)
    end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(source, cb, vehicleProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

  local plate = vehicleProps["plate"]

	local isFound = false

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

		for id, v in pairs(ownedVehicles) do
    local modelnamePut = v.modelname
    local brandPut = v.brand
			if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= VehiclesForSale then

                MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, vehicleProps, price,modelname,brand) VALUES (@sellerIdentifier, @vehProps, @vehPrice,@modelname,@brand)",
                    {
						            ["@sellerIdentifier"] = xPlayer["identifier"],
                        ["@vehProps"] = json.encode(vehicleProps),
                        ["@vehPrice"] = price,
                        ["@modelname"] = modelnamePut,
                        ["@brand"] = brandPut
                    }
                )

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})

                TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

				isFound = true
				break

			end

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:buyVehicle", function(source, cb, vehProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local price = price
	local plate = vehProps["plate"]

	if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
		xPlayer.removeAccountMoney("bank", price)

    MySQL.Async.fetchAll('SELECT * FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
			if result[1] ~= nil and result[1]["seller"] ~= nil then
        UpdateCash(result[1]["seller"], price)
        local modelnameNew = result[1].modelname
        local brandNew = result[1].brand
        MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle,state,modelname,brand) VALUES (@plate, @identifier, @vehProps, @state,@modelname,@brand)",
          {
            ["@plate"] = plate,
            ["@identifier"] = xPlayer["identifier"],
            ["@vehProps"] = json.encode(vehProps),
            ["@state"] = '1',
            ["@modelname"] = modelnameNew,
            ["@brand"] = brandNew,

          }
        )
        TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

        MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})

    		cb(true)
			else
				print("Something went wrong, there was no car.")
			end
    end)
	else
		cb(false, xPlayer.getAccount("bank")["money"])
	end
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", {['@identifier'] = identifier}, function(result)

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate
      local modelname = values.modelname
      local brand = values.brand

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate, modelname = modelname, brand = brand })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)

		TriggerClientEvent("esx:showNotification", xPlayer.source, "Someone bought your vehicle and transferred ~g~$" .. cash)
	else
		MySQL.Async.fetchAll('SELECT bank FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
			if result[1]["bank"] ~= nil then
				MySQL.Async.execute("UPDATE users SET bank = @newBank WHERE identifier = @identifier",
					{
						["@identifier"] = identifier,
						["@newBank"] = result[1]["bank"] + cash
					}
				)
			end
		end)
	end
end

Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end

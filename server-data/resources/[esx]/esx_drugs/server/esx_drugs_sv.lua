ESX 						   = nil
local CopsConnected 	              = 0
local PlayersHarvestingCoke         = {}
local PlayersHarvestingCokeTimer    = {}
local PlayersTransformingCoke       = {}
local PlayersTransformingCokeTimer  = {}
local PlayersSellingCoke            = {}
local PlayersSellingCokeTimer       = {}
local PlayersHarvestingMeth         = {}
local PlayersHarvestingMethTimer    = {}
local PlayersTransformingMeth       = {}
local PlayersTransformingMethTimer  = {}
local PlayersSellingMeth            = {}
local PlayersSellingMethTimer       = {}
local PlayersHarvestingWeed         = {}
local PlayersHarvestingWeedTimer    = {}
local PlayersTransformingWeed       = {}
local PlayersTransformingWeedTimer  = {}
local PlayersSellingWeed            = {}
local PlayersSellingWeedTimer       = {}
local PlayersHarvestingOpium        = {}
local PlayersHarvestingOpiumTimer   = {}
local PlayersTransformingOpium      = {}
local PlayersTransformingOpiumTimer = {}
local PlayersSellingOpium           = {}
local PlayersSellingOpiumTimer      = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer ~= nil then
			if xPlayer.job.name == 'police' then
				CopsConnected = CopsConnected + 1
			end
		end
	end

	SetTimeout(120 * 1000, CountCops)

end

CountCops()

--coke
local function HarvestCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	PlayersHarvestingCokeTimer[source] = ESX.SetTimeout(Config.TimeToFarmc, function()

		if PlayersHarvestingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)
			if xPlayer ~= nil then
				local coke = xPlayer.getInventoryItem('coke')
				if coke.limit ~= -1 and coke.count >= coke.limit then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('inv_full_coke'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.addInventoryItem('coke', 1)
					HarvestCoke(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestCoke')
AddEventHandler('esx_drugs:startHarvestCoke', function()

	local _source = source

	if not PlayersHarvestingCoke[_source] then
		PlayersHarvestingCoke[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('pickup_in_prog'))
		HarvestCoke(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopHarvestCoke')
AddEventHandler('esx_drugs:stopHarvestCoke', function()

	local _source = source

	if PlayersHarvestingCoke[_source] then
		PlayersHarvestingCoke[_source] = false
	end

	if PlayersHarvestingCokeTimer[_source] then
		ESX.ClearTimeout(PlayersHarvestingCokeTimer[_source]);
	end

end)

local function TransformCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	PlayersTransformingCokeTimer[source] = ESX.SetTimeout(Config.TimeToProcessc, function()

		if PlayersTransformingCoke[source] == true then

			  local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

				if xPlayer ~= nil then
						local cokeQuantity = xPlayer.getInventoryItem('coke').count
						local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

					if poochQuantity > 40 then
						TriggerClientEvent('esx_drugs:notiUser', source  , _U('too_many_pouches'))
						TriggerClientEvent('esx_drugs:inventoryFullReset', source)
					elseif cokeQuantity < 2 then
						TriggerClientEvent('esx_drugs:notiUser', source  , _U('not_enough_coke'))
						TriggerClientEvent('esx_drugs:inventoryFullReset', source)
					else
						xPlayer.removeInventoryItem('coke', 2)
						xPlayer.addInventoryItem('coke_pooch', 1)

						TransformCoke(source)
					end
				end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformCoke')
AddEventHandler('esx_drugs:startTransformCoke', function()

	local _source = source

	if not PlayersTransformingCoke[_source] then
		PlayersTransformingCoke[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('packing_in_prog'))
		TransformCoke(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopTransformCoke')
AddEventHandler('esx_drugs:stopTransformCoke', function()

	local _source = source

	if PlayersTransformingCoke[_source] then
		PlayersTransformingCoke[_source] = false
	end

	if PlayersTransformingCokeTimer[_source] then
		ESX.ClearTimeout(PlayersTransformingCokeTimer[_source]);
	end

end)

local function SellCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	PlayersSellingCokeTimer[source] = ESX.SetTimeout(Config.TimeToSellc, function()

		if PlayersSellingCoke[source] == true then

			  local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
				if xPlayer ~= nil then
					local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count
					if poochQuantity == 0 then
						TriggerClientEvent('esx_drugs:notiUser', source  , _U('no_pouchs_sale'))
					else
						xPlayer.removeInventoryItem('coke_pooch', 1)
						if CopsConnected == 0 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice)
								TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_coke'))
		        elseif CopsConnected == 1 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice + 5)
		            TriggerClientEvent('esx_drugs:notiUser', source , _U('sold_one_coke'))
		        elseif CopsConnected == 2 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice + 8)
		            TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_coke'))
		        elseif CopsConnected == 3 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice + 12)
		            TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_coke'))
		        elseif CopsConnected == 4 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice + 14)
		            TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_coke'))
		        elseif CopsConnected >= 5 then
		            xPlayer.addAccountMoney('black_money', Config.CokeSellPrice + 16)
		            TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_coke'))
		        end
						SellCoke(source)
					end
				end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCoke')
AddEventHandler('esx_drugs:startSellCoke', function()

	local _source = source
	if not PlayersSellingCoke[_source] then
		PlayersSellingCoke[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('sale_in_prog'))
		SellCoke(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopSellCoke')
AddEventHandler('esx_drugs:stopSellCoke', function()

	local _source = source
	if PlayersSellingCoke[_source] then
		PlayersSellingCoke[_source] = false
	end
	if PlayersSellingCokeTimer[source] then
		ESX.ClearTimeout(PlayersSellingCokeTimer[source])
	end

end)

--meth
local function HarvestMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	PlayersHarvestingMethTimer[source] = ESX.SetTimeout(Config.TimeToFarmm, function()

		if PlayersHarvestingMeth[source] == true then

			local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then
				local meth = xPlayer.getInventoryItem('meth')

				if meth.limit ~= -1 and meth.count >= meth.limit then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('inv_full_meth'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.addInventoryItem('meth', 1)
					HarvestMeth(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestMeth')
AddEventHandler('esx_drugs:startHarvestMeth', function()

	local _source = source

	if not PlayersHarvestingMeth[_source] then
		PlayersHarvestingMeth[_source] = true
		TriggerClientEvent('esx_drugs:notiUser',source  , _U('pickup_in_prog'))
		HarvestMeth(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopHarvestMeth')
AddEventHandler('esx_drugs:stopHarvestMeth', function()
	local _source = source
	if PlayersHarvestingMeth[_source] then
		PlayersHarvestingMeth[_source] = false
	end
	if PlayersHarvestingMethTimer[_source] then
		ESX.ClearTimeout(PlayersHarvestingMethTimer[_source])
	end
end)

local function TransformMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	PlayersTransformingMethTimer[source] = ESX.SetTimeout(Config.TimeToProcessm, function()

		if PlayersTransformingMeth[source] == true then

			  local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then
				local methQuantity = xPlayer.getInventoryItem('meth').count
				local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

				if poochQuantity > 40 then
					TriggerClientEvent('esx_drugs:notiUser',source  , _U('too_many_pouches'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				elseif methQuantity < 2 then
					TriggerClientEvent('esx_drugs:notiUser',source  , _U('not_enough_meth'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.removeInventoryItem('meth', 2)
					xPlayer.addInventoryItem('meth_pooch', 1)

					TransformMeth(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformMeth')
AddEventHandler('esx_drugs:startTransformMeth', function()

	local _source = source

	if not PlayersTransformingMeth[_source] then
		PlayersTransformingMeth[_source] = true
		TriggerClientEvent('esx_drugs:notiUser',source  , _U('packing_in_prog'))
		TransformMeth(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopTransformMeth')
AddEventHandler('esx_drugs:stopTransformMeth', function()

	local _source = source
	if PlayersTransformingMeth[_source] then
		PlayersTransformingMeth[_source] = false
	end

	if PlayersTransformingMethTimer[_source] then
		ESX.ClearTimeout(PlayersTransformingMethTimer[_source])
	end

end)

local function SellMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	PlayersSellingMethTimer[source] = ESX.SetTimeout(Config.TimeToSellm, function()

		if PlayersSellingMeth[source] == true then

			  local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
				if xPlayer ~= nil then
					local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

					if poochQuantity == 0 then
						TriggerClientEvent('esx_drugs:notiUser',source  , _U('no_pouches_sale'))
					else
						xPlayer.removeInventoryItem('meth_pooch', 1)
						if CopsConnected == 0 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice)
								TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        elseif CopsConnected == 1 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 6)
		            TriggerClientEvent('esx_drugs:notiUser',source , _U('sold_one_meth'))
		        elseif CopsConnected == 2 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 8)
		            TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        elseif CopsConnected == 3 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 12)
		            TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        elseif CopsConnected == 4 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 14)
		            TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        elseif CopsConnected == 5 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 16)
		            TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        elseif CopsConnected >= 6 then
		            xPlayer.addAccountMoney('black_money', Config.MethSellPrice + 18)
		            TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_meth'))
		        end
						SellMeth(source)
					end
				end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellMeth')
AddEventHandler('esx_drugs:startSellMeth', function()

	local _source = source

	if not PlayersSellingMeth[_source] then
		PlayersSellingMeth[_source] = true
		TriggerClientEvent('esx_drugs:notiUser',source  , _U('sale_in_prog'))
		SellMeth(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopSellMeth')
AddEventHandler('esx_drugs:stopSellMeth', function()

	local _source = source
	if PlayersSellingMeth[_source] then
		PlayersSellingMeth[_source] = false
	end
	if PlayersSellingMethTimer[source] then
		ESX.ClearTimeout(PlayersSellingMethTimer[source])
	end

end)

--weed
local function HarvestWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	PlayersHarvestingWeedTimer[source] = ESX.SetTimeout(Config.TimeToFarmw, function()

		if PlayersHarvestingWeed[source] == true then

			local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then
				local weed = xPlayer.getInventoryItem('weed')
				if weed.limit ~= -1 and weed.count >= weed.limit then
					TriggerClientEvent('esx_drugs:notiUser',source  , _U('inv_full_weed'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.addInventoryItem('weed', 1)
					HarvestWeed(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestWeed')
AddEventHandler('esx_drugs:startHarvestWeed', function()

	local _source = source

	if not PlayersHarvestingWeed[_source] then
		PlayersHarvestingWeed[_source] = true
		TriggerClientEvent('esx_drugs:notiUser',source  , _U('pickup_in_prog'))
		HarvestWeed(_source)
	end



end)

RegisterServerEvent('esx_drugs:stopHarvestWeed')
AddEventHandler('esx_drugs:stopHarvestWeed', function()

	local _source = source

	if PlayersHarvestingWeed[_source] then
		PlayersHarvestingWeed[_source] = false
	end

	if PlayersHarvestingWeedTimer[_source] then
		ESX.ClearTimeout(PlayersHarvestingWeedTimer[_source])
	end

end)

local function TransformWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	PlayersTransformingWeedTimer[source] = ESX.SetTimeout(Config.TimeToProcessw, function()

		if PlayersTransformingWeed[source] == true then

			local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then

				local weedQuantity = xPlayer.getInventoryItem('weed').count
				local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

				if poochQuantity > 40 then
					TriggerClientEvent('esx_drugs:notiUser',source  , _U('too_many_pouches'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				elseif weedQuantity < 2 then
					TriggerClientEvent('esx_drugs:notiUser',source  , _U('not_enough_weed'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.removeInventoryItem('weed', 2)
					xPlayer.addInventoryItem('weed_pooch', 1)
					TransformWeed(source)
				end

			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformWeed')
AddEventHandler('esx_drugs:startTransformWeed', function()

	local _source = source
	if not PlayersTransformingWeed[_source] then
		PlayersTransformingWeed[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('packing_in_prog'))
		TransformWeed(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopTransformWeed')
AddEventHandler('esx_drugs:stopTransformWeed', function()

	local _source = source

	if PlayersTransformingWeed[_source] then
		PlayersTransformingWeed[_source] = false
	end

	if PlayersTransformingWeedTimer[_source] then
		ESX.ClearTimeout(PlayersTransformingWeedTimer[_source])
	end

end)

local function SellWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	PlayersSellingWeedTimer[source] = ESX.SetTimeout(Config.TimeToSellw, function()

		if PlayersSellingWeed[source] == true then

			local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)

			if xPlayer ~= nil then
				local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

				if poochQuantity == 0 then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('no_pouches_sale'))
				else
					xPlayer.removeInventoryItem('weed_pooch', 1)
	          if CopsConnected == 0 then
	              xPlayer.addAccountMoney('black_money', Config.WeedSellPrice)
								TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_weed'))
	          elseif CopsConnected == 1 then
	              xPlayer.addAccountMoney('black_money', Config.WeedSellPrice + 2)
	              TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_weed'))
	          elseif CopsConnected == 2 then
	              xPlayer.addAccountMoney('black_money', Config.WeedSellPrice + 4)
	              TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_weed'))
	          elseif CopsConnected == 3 then
	              xPlayer.addAccountMoney('black_money', Config.WeedSellPrice + 8)
	              TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_weed'))
	          elseif CopsConnected >= 4 then
	              xPlayer.addAccountMoney('black_money', Config.WeedSellPrice + 12)
	              TriggerClientEvent('esx_drugs:notiUser',source  , _U('sold_one_weed'))
	          end
					SellWeed(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellWeed')
AddEventHandler('esx_drugs:startSellWeed', function()

	local _source = source

	if not PlayersSellingWeed[_source] then
		PlayersSellingWeed[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('sale_in_prog'))
		SellWeed(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopSellWeed')
AddEventHandler('esx_drugs:stopSellWeed', function()

	local _source = source

	if PlayersSellingWeed[_source] then
		PlayersSellingWeed[_source] = false
	end

	if PlayersSellingWeedTimer[_source] then
		ESX.ClearTimeout(PlayersSellingWeedTimer[_source])
	end

end)


--opium

local function HarvestOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	PlayersHarvestingOpiumTimer[source] = ESX.SetTimeout(Config.TimeToFarmo, function()

		if PlayersHarvestingOpium[source] == true then

			local _source = source

			local xPlayer = ESX.GetPlayerFromId(_source)

			if xPlayer ~= nil then
				local opium = xPlayer.getInventoryItem('opium')

				if opium.limit ~= -1 and opium.count >= opium.limit then
					TriggerClientEvent('esx_drugs:notiUser',source , _U('inv_full_opium'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.addInventoryItem('opium', 1)
					HarvestOpium(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestOpium')
AddEventHandler('esx_drugs:startHarvestOpium', function()

	local _source = source

	if not PlayersHarvestingOpium[_source] then
		PlayersHarvestingOpium[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('pickup_in_prog'))
		HarvestOpium(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopHarvestOpium')
AddEventHandler('esx_drugs:stopHarvestOpium', function()

	local _source = source
	if PlayersHarvestingOpium[_source] then
		PlayersHarvestingOpium[_source] = false
	end
	if PlayersHarvestingOpiumTimer[_source] then
		ESX.ClearTimeout(PlayersHarvestingOpiumTimer[_source])
	end
end)

local function TransformOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	PlayersTransformingOpiumTimer[source] = ESX.SetTimeout(Config.TimeToProcesso, function()

		if PlayersTransformingOpium[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then
				local opiumQuantity = xPlayer.getInventoryItem('opium').count
				local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

				if poochQuantity > 40 then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('too_many_pouches'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				elseif opiumQuantity < 2 then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('not_enough_opium'))
					TriggerClientEvent('esx_drugs:inventoryFullReset',source)
				else
					xPlayer.removeInventoryItem('opium', 2)
					xPlayer.addInventoryItem('opium_pooch', 1)

					TransformOpium(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformOpium')
AddEventHandler('esx_drugs:startTransformOpium', function()

	local _source = source

	if not PlayersTransformingOpium[_source] then
		PlayersTransformingOpium[_source] = true
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('packing_in_prog'))
		TransformOpium(_source)
	end


end)

RegisterServerEvent('esx_drugs:stopTransformOpium')
AddEventHandler('esx_drugs:stopTransformOpium', function()

	local _source = source

	if PlayersTransformingOpium[_source] then
	PlayersTransformingOpium[_source] = false
	end

	if PlayersTransformingOpiumTimer[_source] then
		ESX.ClearTimeout(PlayersTransformingOpiumTimer[_source])
	end

end)

local function SellOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	PlayersSellingOpiumTimer[source] = ESX.SetTimeout(Config.TimeToSello, function()

		if PlayersSellingOpium[source] == true then

			local _source = source
  		local xPlayer = ESX.GetPlayerFromId(_source)
			if xPlayer ~= nil then
				local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

				if poochQuantity == 0 then
					TriggerClientEvent('esx_drugs:notiUser', source  , _U('no_pouches_sale'))
				else
					xPlayer.removeInventoryItem('opium_pooch', 1)
					if CopsConnected == 0 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice)
								TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          elseif CopsConnected == 1 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice + 4)
	              TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          elseif CopsConnected == 2 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice + 6)
	              TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          elseif CopsConnected == 3 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice + 8)
	              TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          elseif CopsConnected == 4 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice + 10)
	              TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          elseif CopsConnected >= 5 then
	              xPlayer.addAccountMoney('black_money', Config.OpiumSellPrice + 12)
	              TriggerClientEvent('esx_drugs:notiUser', source  , _U('sold_one_opium'))
	          end
					SellOpium(source)
				end
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellOpium')
AddEventHandler('esx_drugs:startSellOpium', function()

	local _source = source

	if not PlayersSellingOpium[_source] then
		PlayersSellingOpium[_source] = true
		TriggerClientEvent('esx_drugs:notiUser',-1  , _U('sale_in_prog'))
		SellOpium(_source)
	end

end)

RegisterServerEvent('esx_drugs:stopSellOpium')
AddEventHandler('esx_drugs:stopSellOpium', function()

	local _source = source

	if PlayersSellingOpium[_source] then
		PlayersSellingOpium[_source] = false
	end

	if PlayersSellingOpiumTimer[_source] then
		ESX.ClearTimeout(PlayersSellingOpiumTimer[_source])
	end

end)




-- RETURN INVENTORY TO CLIENT
RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
		if xPlayer ~= nil then
	    TriggerClientEvent('esx_drugs:ReturnInventory',
	    	_source,
	    	xPlayer.getInventoryItem('coke').count,
			xPlayer.getInventoryItem('coke_pooch').count,
			xPlayer.getInventoryItem('meth').count,
			xPlayer.getInventoryItem('meth_pooch').count,
			xPlayer.getInventoryItem('weed').count,
			xPlayer.getInventoryItem('weed_pooch').count,
			xPlayer.getInventoryItem('opium').count,
			xPlayer.getInventoryItem('opium_pooch').count,
			xPlayer.job.name,
			xPlayer.job.grade,
			currentZone
	    )
		end
end)

-- Register Usable Item
ESX.RegisterUsableItem('weed', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		xPlayer.removeInventoryItem('weed', 1)
		TriggerClientEvent('esx_drugs:onPot', _source)
		TriggerClientEvent('esx_drugs:notiUser', source  , _U('used_one_weed'))
	end
end)

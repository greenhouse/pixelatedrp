ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

  RegisterNetEvent('drugs:trigger')
  AddEventHandler('drugs:trigger', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_fail')
  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 1)
  			TriggerClientEvent("pNotify:SendNotification", source, {
            text = "trying to convince person to buy the product",
            type = "error",
            queue = "lmao",
            timeout = 2500,
            layout = "Centerleft"
        	})
 	end
end)

RegisterNetEvent('drugs:sell')
AddEventHandler('drugs:sell', function()
  local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
	local meth = xPlayer.getInventoryItem('meth_pooch').count
	local coke 	  = xPlayer.getInventoryItem('coke_pooch').count
	local weed = xPlayer.getInventoryItem('weed_pooch').count
	local opium = xPlayer.getInventoryItem('opium_pooch').count

	local paymentm = math.random (Config.MethSellPrice, Config.MethSellPrice + 22)
	local paymentc = math.random (Config.CokeSellPrice, Config.CokeSellPrice + 30)
	local paymento = math.random (Config.OpiumSellPrice, Config.OpiumSellPrice + 34)
	local paymentw = math.random (Config.WeedSellPrice, Config.WeedSellPrice + 24)

		if coke >= 1 and success == true then
				local sellamount = math.random(1,coke)
				local bags = ""
				paymentc = paymentc * sellamount

				if(sellamount > 1) then
					bags = sellamount.." bags of cocaine"
				else
					bags = "a bags of cocaine"
				end

				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "You have sold "..bags.." for $" .. paymentc ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
				})
				TriggerClientEvent("animation", source)
				xPlayer.removeInventoryItem('coke_pooch', sellamount)
  			xPlayer.addMoney(paymentc)
  			selling = false

  		elseif weed >= 1 and success == true then
				local sellamount = math.random(1,weed)
				local bags = ""
				paymentw = paymentw * sellamount

				if(sellamount > 1) then
					bags = sellamount.." bags of weed"
				else
					bags = "a bag of weed"
				end
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = "You have sold "..bags.." for $" .. paymentw ,
						type = "success",
						progressBar = false,
						queue = "lmao",
						timeout = 2000,
						layout = "CenterLeft"
					})
					TriggerClientEvent("animation", source)
					TriggerClientEvent("test", source)
	  			xPlayer.removeInventoryItem('weed_pooch', sellamount)
	  			xPlayer.addMoney(paymentw)
	  			selling = false
  		  elseif meth >= 1 and success == true then
					local sellamount = math.random(1,meth)
					local bags = ""
					paymentm = paymentm * sellamount

					if(sellamount > 1) then
						bags = sellamount.." bags of meth"
					else
						bags = "a bag of meth"
					end

  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = "You have sold "..bags.." for $" .. paymentm ,
						type = "success",
						progressBar = false,
						queue = "lmao",
						timeout = 2000,
						layout = "CenterLeft"
					})
					TriggerClientEvent("animation", source)
	  			xPlayer.removeInventoryItem('meth_pooch', sellamount)
	  			xPlayer.addMoney(paymentm)
	  			selling = false
	  	elseif opium >= 1 and success == true then
						local sellamount = math.random(1,opium)
						local bags = ""
						paymento = paymento * sellamount

						if(sellamount > 1) then
							bags = sellamount.." bags of opium"
						else
							bags = "a bag of opium"
						end

  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = "You have sold "..bags.." for $" .. paymento ,
						type = "success",
						progressBar = false,
						queue = "lmao",
						timeout = 2000,
						layout = "CenterLeft"
					})
					TriggerClientEvent("animation", source)
					xPlayer.removeInventoryItem('opium_pooch', sellamount)
		  		xPlayer.addMoney(paymento)
		  		selling = false
			elseif selling == true and success == false and notintrested == true then
					TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = "They are not interested",
						type = "error",
						progressBar = false,
						queue = "lmao",
						timeout = 2000,
						layout = "CenterLeft"
					})
  				selling = false
  		elseif meth < 1 and coke < 1 and weed < 1 and opium < 1 then
						TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
						TriggerClientEvent("pNotify:SendNotification", source, {
							text = "You dont have any drugs",
							type = "error",
							progressBar = false,
							queue = "lmao",
							timeout = 2000,
							layout = "CenterLeft"
						})
			elseif copscalled == true and success == false then
				TriggerClientEvent("outlawNotifyc", source)
				TriggerClientEvent("outlawNotify2", -1, "~r~Drug deal~w~ suspect in the city")
  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "They are calling the cops",
					type = "error",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "CenterLeft"
				})
  			selling = false
  		end
	end
end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()
	local percent = math.random(1, 11)
	if percent == 7 or percent == 8 or percent == 9 then
		success = false
		notintrested = true
	elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 and percent ~= 3 then -- 6 , 5 , 4 , 2 , 1
		success = true
		notintrested = false
	else -- 10, 3
		notintrested = false
		success = false
		copscalled = true
	end
end)

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()
	TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = "You moved too far away",
		type = "error",
		progressBar = false,
		queue = "lmao",
		timeout = 2000,
		layout = "CenterLeft"
	})
end)

RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local meth = xPlayer.getInventoryItem('meth_pooch').count
		local coke 	  = xPlayer.getInventoryItem('coke_pooch').count
		local weed = xPlayer.getInventoryItem('weed_pooch').count
		local opium = xPlayer.getInventoryItem('opium_pooch').count

		if meth >= 1 or coke >= 1 or weed >= 1 or opium >= 1 then
			TriggerClientEvent("checkR", source, true)
		else
			TriggerClientEvent("checkR", source, false)
		end
	end
end)

RegisterServerEvent('drugInProgressPos')
AddEventHandler('drugInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('drugPlace', -1, tx, ty, tz)
end)

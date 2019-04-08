ESX  							= nil
--Hotfix
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local timer = 0
local emsonline = false
local policeonline = false
local taxionline = false
local mechaniconline = false
local bankeronline = false
local agentonline = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
				ESX.TriggerServerCallback('stadusrp_getJobsOnline', function(ems, police, taxi, mechanic, banker, agent)
				 if ems > 0 then
					 emsonline = true
				 elseif ems == 0 then
					 emsonline = false
				 end

				 if police > 0 then
					 policeonline = true
				 elseif police == 0 then
					 policeonline = false
				 end

				 if taxi > 0 then
					taxionline = true
					elseif taxi == 0 then
					taxionline = false
				 end

				 if mechanic > 0 then
					 mechaniconline = true
				 elseif mechanic == 0 then
					 mechaniconline = false
				 end

				 if banker > 0 then
					 bankeronline = true
				 elseif banker == 0 then
					 bankeronline = false
				 end

				 if agent > 0 then
					 agentonline = true
				 elseif agent == 0 then
					 agentonline = false
				 end
			end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emsonline == true then
			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(121, 153, 47, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("EMS:")
			DrawText(0.170, 0.798)

			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(121, 153, 47, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("online")
			DrawText(0.192, 0.798)
		end
		if policeonline == true then
			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(14, 132, 234, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Police")
			DrawText(0.170, 0.816)

			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(14, 132, 234, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("online")
			DrawText(0.192, 0.816)
		end
		if mechaniconline == true then
			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(102, 126, 147, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Mech:")
			DrawText(0.170, 0.834)

			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(102, 126, 147, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("online")
			DrawText(0.192, 0.834)

		end
		if bankeronline == true then
			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(147, 102, 126, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Bank:")
			DrawText(0.170, 0.852)

			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(147, 102, 126, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("online")
			DrawText(0.192, 0.852)
		end
		if agentonline == true then
			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(137, 10, 162, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Agent")
			DrawText(0.170, 0.870)

			SetTextFont(6)
			SetTextProportional(1)
			SetTextScale(0.1, 0.35)
			SetTextColour(137, 10, 162, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("online")
			DrawText(0.192, 0.870)
		end
	end
end)

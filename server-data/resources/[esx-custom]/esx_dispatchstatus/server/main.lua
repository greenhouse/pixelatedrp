ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountEMS()

	local xPlayers = ESX.GetPlayers()

	EMSConnected = 0
	PoliceConnected = 0
	TaxiConnected = 0
	MechanicConnected = 0
	BankerConnected = 0
	AgentConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		end
		if xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		end
		if xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		end
		if xPlayer.job.name == 'mecano' then
			MechanicConnected = MechanicConnected + 1
		end
		if xPlayer.job.name == 'banker' then
			BankerConnected = BankerConnected + 1
		end
		if xPlayer.job.name == 'realestateagent' then
			AgentConnected = 	AgentConnected + 1
		end

	end

		--SetTimeout(2000, CountEMS)
end

ESX.RegisterServerCallback('stadusrp_getJobsOnline', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  CountEMS()
	cb(EMSConnected, PoliceConnected, TaxiConnected, MechanicConnected, BankerConnected, AgentConnected)

end)
--hotfix

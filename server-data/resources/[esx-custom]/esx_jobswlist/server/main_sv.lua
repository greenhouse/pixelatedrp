ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_jobswlist:getWhitelistedPlayers', function(source, cb)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll(
			" SELECT identifier,job,grade FROM whitelist_jobs WHERE identifier = @identifier",{
				['@identifier'] = xPlayer.identifier
			},
			function(result)
				local data = {}
				local job = {}
				local jobGrade = {}
				for i=1, #result, 1 do
					identifier = result[i].identifier
					job[i] = result[i].job
					jobGrade[i] = result[i].grade
				end
				cb(identifier,job,jobGrade)
			end)
		end
end)

ESX.RegisterServerCallback('esx_jobswlist:getJobsList', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll(
			" SELECT job FROM whitelist_jobs WHERE identifier = @identifier",{
				['@identifier'] = xPlayer.identifier
			},
			function(result)
				local data = {}
				for i=1, #result, 1 do
					job = result[i].job
				end
			end)
		MySQL.Async.fetchAll(
			"SELECT * FROM jobs WHERE name = @job",
			{
				['@job'] = job
			},
			function(result)
				local data = {}
				for i=1, #result, 1 do
					table.insert(data, {
						value   = result[i].name,
						label   = result[i].label
					})
				end
				cb(data)
		end)
	end
end)

RegisterServerEvent('esx_jobswlist:setJob')
AddEventHandler('esx_jobswlist:setJob', function(job,jobgrade)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		xPlayer.setJob(job, jobgrade)
	end
end)

RegisterServerEvent('esx_jobswlist:setoffduty')
AddEventHandler('esx_jobswlist:setoffduty', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		xPlayer.setJob(job, 0)
	end
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

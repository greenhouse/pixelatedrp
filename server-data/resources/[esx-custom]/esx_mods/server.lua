local ESX = nil
local timeplayed = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "You were AFK for too long.")
end)

AddEventHandler('onMySQLReady', function()
	MySQL.Async.execute('UPDATE users SET online = 0  WHERE online = 1',{ },
	function (result)
		print('All users have been set to offline')
	end)
end)

-- Report Users
TriggerEvent('es:addGroupCommand', 'reportplayer', 'user', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil and args[2] ~= nil and args[3] ~= nil  then
				local _source  = source
				local xPlayer  = ESX.GetPlayerFromId(_source)
				local xPlayerReport  = ESX.GetPlayerFromId(args[1])
				local playerName = GetPlayerName(source)
				local reportedplayer = xPlayerReport.identifier
				MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier LIMIT 1',
				{
					['@identifier'] =  reportedplayer
				},
				function (result)
					userid = result[1].id
					MySQL.Async.execute(
						"INSERT INTO user_reports (reported_by,report_type ,report_comment,userid) VALUES (@reportedby,@report_type,@report_comment,@userid)",{
							['@reportedby'] = playerName,
							['@report_type'] = args[2],
							['@report_comment'] = args[3],
							['@userid'] = userid
						},
						function(result)
							TriggerClientEvent('chatMessage', source, "SYSTEM", {34, 34, 29}, "User has been reported")
						end)
				end)
		else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid input example: /report 22 rdm Player just drove me over.")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end,
{help = 'Report player',
 params = {
	 {name = "id", help = 'Player id'},
	 {name = "Type", help = 'Examples vdm,rdm,fail-rp,rude,cheating'},
	 {name = "Comment", help = 'Player drove me over'},
 	}
 })


ESX.RegisterServerCallback('esx_autoKick', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local playerName = GetPlayerName(source)
	local reason = '';
	if xPlayer ~= nil then
		local identifier =  xPlayer.identifier
		MySQL.Async.fetchAll('SELECT * FROM kicks WHERE steamid = @identifier limit 1',
		{
			['@identifier'] =  identifier
		},
		function (result)
			for i=1, #result, 1 do
				kicked = result[i].kicked
				reason = result[i].reason
				xPlayer.kick(reason)
				SendWebhookMessage('https://discordapp.com/api/webhooks/452607709884317696/1uXAly6hDo0Vpebxb4z0_QFodbSPPQoMN-ZVxOvg48W_3YSZRrdq8enC1tajAvqB_sOb',string.format('```Player Kicked: ' ..playerName.. ' | ' ..reason.. ' ```'))
				MySQL.Async.execute('DELETE FROM kicks WHERE steamid = @identifier',
					{
						['@identifier'] =  identifier
					},
					function(result)
						print('Kick record deleted')
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_sneakstatus:Setonline', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local playerName = GetPlayerName(source)
	if xPlayer ~= nil then
		local identifier =  xPlayer.identifier
		MySQL.Async.execute('UPDATE users SET online = 1 WHERE identifier = @identifier',
		{
			['@identifier'] =  identifier
		},
		function (result)
		end)
	end
end)

AddEventHandler('playerDropped', function(reason)
	local pname = GetPlayerName(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil then
		local identifier =  xPlayer.identifier
		MySQL.Async.execute('UPDATE users SET online = 0 WHERE identifier = @identifier',
		{
			['@identifier'] =  identifier
		},
		function (result)
		end)
	end

end)

function SendWebhookMessage(webhook,message)
	if webhook ~= "false" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

TriggerEvent('es:addGroupCommand', 'goto', 'moderator', function(source, args, user)
	local x = args[1]
	if x == 'legion' then
		TriggerClientEvent("esx:teleport", source, {x = 160.4506072998, y = -979.09448242188, z = 30.091911315918 })
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Location not found!")
	end
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Teleport to location", params = {{name = "loc", help = "Location name"} }})


-- Open ID card
RegisterServerEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(ID, targetID)

	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = ESX.GetPlayerFromId(targetID).source

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (result)
		if (result[1] ~= nil) then
		  playerData = {firstname = result[1].firstname, lastname = result[1].lastname, dateofbirth = result[1].dateofbirth, sex = result[1].sex, height = result[1].height}
		  TriggerClientEvent('jsfour-legitimation:open', _source, playerData)
		end
	end)
end)

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end



RegisterServerEvent('esx_mods:FinePlayer')
AddEventHandler('esx_mods:FinePlayer', function(player, amount, notification)
	local xPlayer  = ESX.GetPlayerFromId(player)
	xPlayer.removeMoney(amount)
	TriggerClientEvent('esx:showNotification', player, notification)
end)

RegisterServerEvent('esx_mods:debug')
AddEventHandler('esx_mods:debug', function(var)
	print(to_string(var))
end)

-- -- ExecCommands
-- function checkCommands()
-- 	local byadmin = ''
-- 	local actionDo = ''
-- 	local actionAmmount = ''
--
-- 	MySQL.Async.fetchAll('SELECT * FROM server_actions', {},
-- 	function (result)
-- 			if result[1] ~= nil then
-- 				--print(dump(result))
-- 				for i=1, #result, 1 do
-- 					local action = result[i].action
-- 					if result[i].action_do ~= nil then
-- 						actionDo = result[i].action_do
-- 					end
-- 					if result[i].byadmin ~= nil then
-- 						byadmin = result[i].byadmin
-- 					else
-- 						byadmin = 'Exclusive Life'
-- 					end
-- 					if result[i].action_ammount ~= nil then
-- 						actionAmmount = result[i].action_ammount
-- 					end
-- 					local actionId = result[i].id
-- 					local findIdentifier = result[i].identifier
-- 					MySQL.Async.fetchAll('SELECT identifier,online FROM users WHERE online = @online AND identifier = @identifier',
-- 					{
-- 						['@online'] = 1,
-- 						['@identifier'] = findIdentifier
-- 					},
-- 					function (data)
-- 						for i=1, #data, 1 do
-- 							if data[i].identifier == findIdentifier then
-- 								local foundPlayer = ESX.GetPlayerFromIdentifier(data[i].identifier)
-- 								if foundPlayer ~= nil then
-- 									local playerServerId = foundPlayer.source
-- 									if action == 'money' then
-- 										foundPlayer.addMoney(tonumber(actionDo))
-- 										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
-- 										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, 'System', 'You got ' .. action , 'You have received ~g~$'..actionDo .. ' ~w~from ~y~'.. byadmin , 'CHAR_BANK_MAZE', 9)
-- 									elseif action == 'weapon' then
-- 										foundPlayer.addWeapon(actionDo,tonumber(actionAmmount))
-- 										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
-- 										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, 'System', 'You got a ' .. action , 'You have received ~g~'..ESX.GetWeaponLabel(actionDo) .. ' ~w~from ~y~'.. byadmin , 'CHAR_AMMUNATION', 7)
-- 									elseif action == 'item' then
-- 										foundPlayer.addInventoryItem(actionDo, tonumber(actionAmmount))
-- 										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
-- 										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, 'System', 'You got a ' .. action , 'You have received ~g~'.. actionDo .. ' ~w~from ~y~'.. byadmin , 'CHAR_SOCIAL_CLUB', 7)
-- 									elseif action == 'revive' then
-- 										TriggerClientEvent('esx_ambulancejob:revive', playerServerId)
-- 										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
-- 										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, 'System', 'You got a ' .. action , 'You have been ~g~revived ~w~ by ~y~'.. byadmin , 'CHAR_MP_MORS_MUTUAL', 7)
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end)
-- 				end
-- 			end
-- 	end)
--
-- end
--
-- function loopCheckCommands()
-- 	checkCommands()
-- 	SetTimeout(60000, function()
-- 		loopCheckCommands()
-- 	end)
-- end
--
-- AddEventHandler('onMySQLReady', function()
-- 	loopCheckCommands()
-- end)

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

-- -- Stop despawn
-- -- Debug printer
-- function dprint(msg)
-- 	if debugMode then
-- 		print(msg)
-- 	end
-- end
--
-- local vehicles = {} -- Table where all the vehicle data will be saved.
--
-- -- Event to replace the id of the despawned vehicle with the id of the replaced vehicle.
-- RegisterServerEvent('sd:updateId')
-- AddEventHandler('sd:updateId', function(oldId, newId)
-- 	for i=1,#vehicles,1 do
-- 		if vehicles[i].id == oldId then
-- 			vehicles[i].id = newId
-- 		end
-- 	end
-- end)
--
-- -- Completes the saving by inserting all the info in the table.
-- function insert(index, id, model, x, y, z, heading)
-- 	vehicles[index] = {
-- 		['id'] = id,
-- 		['model'] = model,
-- 		['position'] = {
-- 			['x'] = x,
-- 			['y'] = y,
-- 			['z'] = z
-- 		},
-- 		['heading'] = heading
-- 	}
-- end
--
-- -- Event to evaluate where should every vehicle be saved in the table.
-- RegisterServerEvent('sd:save')
-- AddEventHandler('sd:save', function(id, model, x, y, z, heading)
-- 	if vehicles[1] then
-- 		for i=1,#vehicles,1 do
-- 			if vehicles[i].id == id then
-- 				insert(i, id, model, x, y, z, heading)
-- 				dprint(model .. '(' .. id ..')' .. 'updated!')
-- 				break
-- 			elseif i == #vehicles then
-- 				insert(#vehicles+1, id, model, x, y, z, heading)
-- 				dprint(model .. '(' .. id ..')' .. 'added!')
-- 			end
-- 		end
-- 	else
-- 		insert(#vehicles+1, id, model, x, y, z, heading)
-- 		dprint(model .. '(' .. id ..')' .. 'added!')
-- 	end
-- end)
--
-- RegisterServerEvent('sd:retrieveTable')
-- AddEventHandler('sd:retrieveTable', function()
-- 	dprint('Checking vehicles...')
-- 	TriggerClientEvent('sd:checkVehs', GetPlayers()[1], vehicles)
-- end)
--
-- AddEventHandler('EnteredVehicle')
-- -- End Stop despawn

-- Police car weapons delete
local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon")
AddEventHandler("PoliceVehicleWeaponDeleter:askDropWeapon", function(wea)
	local isCop = false
  if(not isCop) then
		TriggerClientEvent("PoliceVehicleWeaponDeleter:drop", source, wea)
	end
end)


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
-- Police car weapons delete end

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)


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
AddEventHandler('chatMessage', function(source, n, message)
	cm = stringsplit(message, " ")
	local xPlayer 		= ESX.GetPlayerFromId(source)


		if cm[1] == "/gsr" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				local _source = source
				local identifier = GetPlayerIdentifiers(tPID)[1]
				gsrcheck(source, identifier)
			end
		end
end)


AddEventHandler('esx:playerDropped', function(source)
  local _source = source
  local identifier = GetPlayerIdentifiers(_source)[1]
  MySQL.Async.execute("DELETE FROM gsr WHERE identifier = @identifier",
			{
				['@identifier']   = identifier,
			})
end)

-----------------------------------------------------------------------------
---     ADD / REMOVE Database Items
-----------------------------------------------------------------------------

AddEventHandler('onMySQLReady', function()
	MySQL.Async.execute('DELETE FROM gsr',{})
end)


RegisterNetEvent("removeGsrRecord")
AddEventHandler("removeGsrRecord", function()
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
		MySQL.Async.execute("DELETE FROM gsr WHERE identifier = @identifier",
			{
				['@identifier']   = identifier,
			})
end)


RegisterServerEvent('addGsrRecord')
AddEventHandler('addGsrRecord', function(timer)
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	local time = timer
		MySQL.Async.execute("INSERT INTO gsr ( identifier, time) VALUES (@identifier, @time)",
			    {
			      ['@identifier']   = identifier,
			      ['@time']			= time
			    })
end)

RegisterServerEvent('esx_mods:gsrcheck')
AddEventHandler('esx_mods:gsrcheck', function(identifier)
	local _source = source
	local identifier = GetPlayerIdentifiers(identifier)[1]
	MySQL.Async.fetchAll('SELECT * FROM gsr WHERE identifier=@identifier', {['@identifier'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			TriggerClientEvent('hasShotNotify', _source)
		else
			TriggerClientEvent('hasNotShotNotify', _source)
		end
	end)
end)

function gsrcheck(source, identifier)
	local _source = source
	local identifier = identifier
	MySQL.Async.fetchAll('SELECT * FROM gsr WHERE identifier=@identifier', {['@identifier'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			TriggerClientEvent('hasShotNotify', _source)
		else
			TriggerClientEvent('hasNotShotNotify', _source)
		end
	end)
end


RegisterServerEvent("timeUpdate")
AddEventHandler("timeUpdate", function(time)
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
		MySQL.Async.execute("UPDATE gsr SET time=@time WHERE identifier=@identifier",
			    {
			      ['@time']			= time,
			      ['@identifier']   = identifier
			    })
end)


---------------------------------------------------------------------------
---		This Makes The Commands And Such Work. ** DON'T TOUCH THIS**
---------------------------------------------------------------------------

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- GSR

-- check if job is online
ESX.RegisterServerCallback('esx_mods:checkOnlinePlayersJob', function(source,cb,job)
	MySQL.Async.fetchAll('SELECT job,online FROM users WHERE job = @job AND online = @online',
	{
		['job'] = job,
		['online'] = 1
	},
	function (result)
		if (result[1] ~= nil) then
			cb(true)
		else
			cb(false)
		end
	end)
end)
-- end check if job is online

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

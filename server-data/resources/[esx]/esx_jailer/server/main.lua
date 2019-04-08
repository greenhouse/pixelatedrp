-- jail command, obsolete
-- TriggerEvent('es:addGroupCommand', 'jailEL', 'admin', function(source, args, user)
-- 	if args[1] and GetPlayerName(args[1]) ~= nil and args[2] then
-- 		TriggerEvent('esx_jailerEL:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
-- 	else
-- 		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid player ID or jail time!")
-- 	end
-- end, function(source, args, user)
-- 	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
-- end, {help = "Put a player in jail", params = {{name = "id", help = "target id"}, {name = "time", help = "jail time in minutes"}}})

-- unjail
TriggerEvent('es:addGroupCommand', 'unjail', 'admin', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil then
		TriggerEvent('esx_jailerEL:unjailQuest', tonumber(args[1]))
	else
		TriggerEvent('esx_jailerEL:unjailQuest', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Unjail people from jail", params = {{name = "id", help = "target id"}}})

-- send to jail and register in database
RegisterServerEvent('esx_jailerEL:sendToJail')
AddEventHandler('esx_jailerEL:sendToJail', function(source, jailTime)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Sync.execute("UPDATE jail SET jail_time=@jt WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		else
			MySQL.Async.execute("INSERT INTO jail (identifier,jail_time) VALUES (@identifier,@jail_time)", {['@identifier'] = identifier, ['@jail_time'] = jailTime})
		end
	end)
	TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('jailed_msg', GetPlayerName(source), round(jailTime / 60)))
	TriggerClientEvent('esx_jailerEL:jail', source, jailTime)
end)

-- should the player be in jail?
RegisterServerEvent('esx_jailerEL:checkjail')
AddEventHandler('esx_jailerEL:checkjail', function()
	local player = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(player)[1] -- get steam identifier
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('jailed_msg', GetPlayerName(player), round(gotInfo[1].jail_time / 60)))
			TriggerClientEvent('esx_jailerEL:jail', player, tonumber(gotInfo[1].jail_time))
		end
	end)
end)

RegisterServerEvent('esx_jailerEL:debugJail')
AddEventHandler('esx_jailerEL:debugJail', function()
	local player = source -- cannot parse source to client trigger for some weird reason
	local xuser = GetPlayerName(source)
	print(xuser..' just Jailed someone')
end)

-- unjail via command
RegisterServerEvent('esx_jailerEL:unjailQuest')
AddEventHandler('esx_jailerEL:unjailQuest', function(source)
	if source ~= nil then
		unjail(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_jailerEL:unjailTime')
AddEventHandler('esx_jailerEL:unjailTime', function()
	unjail(source)
end)

-- keep jailtime updated
RegisterServerEvent('esx_jailerEL:updateRemaining')
AddEventHandler('esx_jailerEL:updateRemaining', function(jailTime)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Sync.execute("UPDATE jail SET jail_time=@jt WHERE identifier=@id", {['@id'] = identifier, ['@jt'] = jailTime})
		end
	end)
end)

function unjail(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			MySQL.Async.execute('DELETE from jail WHERE identifier = @id', {['@id'] = identifier})
			TriggerClientEvent('chatMessage', -1, _U('judge'), { 147, 196, 109 }, _U('unjailed', GetPlayerName(target)))
		end
	end)
	TriggerClientEvent('esx_jailerEL:unjail', target)
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

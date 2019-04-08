ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
---
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS

-- ExecCommands
function checkCommands()
	local byadmin = ''
	local actionDo = ''
	local actionAmmount = ''

	MySQL.Async.fetchAll('SELECT * FROM server_actions', {},
	function (result)
			if result[1] ~= nil then
				for i=1, #result, 1 do
					local action = result[i].action
					if result[i].action_do ~= nil then
						actionDo = result[i].action_do
					end
					if result[i].byadmin ~= nil then
						byadmin = result[i].byadmin
					else
						byadmin = 'Pixelated RP'
					end
					if result[i].action_ammount ~= nil then
						actionAmmount = result[i].action_ammount
					end
					local actionId = result[i].id
					local findIdentifier = result[i].identifier
					MySQL.Async.fetchAll('SELECT identifier,online FROM users WHERE online = @online AND identifier = @identifier',
					{
						['@online'] = 1,
						['@identifier'] = findIdentifier
					},
					function (data)
						for i=1, #data, 1 do
							if data[i].identifier == findIdentifier then
								local foundPlayer = ESX.GetPlayerFromIdentifier(data[i].identifier)
								if foundPlayer ~= nil then
									local playerServerId = foundPlayer.source
									if action == 'money' then
										foundPlayer.addMoney(tonumber(actionDo))
										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, Config.Notifications.Title, 'You got ' .. action , 'You have received ~g~$'..actionDo .. ' ~w~from ~y~'.. byadmin , 'CHAR_BANK_MAZE', 9)
									elseif action == 'weapon' then
										foundPlayer.addWeapon(actionDo,tonumber(actionAmmount))
										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, Config.Notifications.Title, 'You got a ' .. action , 'You have received ~g~'..ESX.GetWeaponLabel(actionDo) .. ' ~w~from ~y~'.. byadmin , 'CHAR_AMMUNATION', 7)
									elseif action == 'item' then
										foundPlayer.addInventoryItem(actionDo, tonumber(actionAmmount))
										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, Config.Notifications.Title, 'You got a ' .. action , 'You have received ~g~'.. actionDo .. ' ~w~from ~y~'.. byadmin , 'CHAR_SOCIAL_CLUB', 7)
									elseif action == 'revive' then
										TriggerClientEvent('esx_ambulancejob:revive', playerServerId)
										MySQL.Async.execute('DELETE FROM server_actions WHERE id = @id',{ ['@id'] = actionId })
										TriggerClientEvent('esx:showAdvancedNotification', playerServerId, Config.Notifications.Title, 'You got a ' .. action , 'You have been ~g~revived ~w~ by ~y~'.. byadmin , 'CHAR_MP_MORS_MUTUAL', 7)
									end
								end
							end
						end
					end)
				end
			end
	end)
end

function loopCheckCommands()
	checkCommands()
	SetTimeout(60000, function()
		loopCheckCommands()
	end)
end

AddEventHandler('onMySQLReady', function()
	loopCheckCommands()
end)

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_character_select:getCharList', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = xPlayer.identifier

	MySQL.Async.fetchAll(
		"SELECT * FROM characters WHERE identifier = @identifier AND vaction = '1' ",
		{
			['@identifier'] = steamid,
		},
		function(result)
			local data = {}
			for i=1, #result, 1 do
				table.insert(data, {
					value   = result[i].skinid,
					label   = result[i].firstname ..' '..	 result[i].lastname
				})
			end
			cb(data)
		end
	)
end)


RegisterServerEvent('esx_character_select:getCharSkin')
AddEventHandler('esx_character_select:getCharSkin', function (skinid)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
	local steamid = xPlayer.identifier
  local skinid = skinid

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier",
		{
			['@identifier']		= steamid,
		}, function(result)
			for i=1, #result, 1 do
				oldskin = json.encode(result[i].skin)
				currentskinid = result[i].skinid
				-- Update Skin
				MySQL.Async.execute("UPDATE characters SET skin=@skin, vaction=@vaction WHERE skinid = @skinid",
					{
						['@identifier']		= steamid,
						['@skinid'] = currentskinid,
						['@vaction'] = '1',
						['@skin'] = json.decode(oldskin)
					}, function(result)
						--Get NewSkin
								MySQL.Async.fetchAll("SELECT * FROM characters WHERE skinid = @skinid AND identifier = @identifier",
									{
										['@identifier']		= steamid,
										['@skinid'] = skinid,
									}, function(result)
										for i=1, #result, 1 do
												newskin = json.encode(result[i].skin)
												-- Update Skin in users
												MySQL.Async.execute("UPDATE users SET skin=@skin, firstname=@firstname, lastname=@lastname, skinid=@skinid WHERE identifier = @identifier ",
													{
														['@identifier']		= steamid,
														['@skinid'] = skinid,
														['@skin'] = json.decode(newskin),
														['@firstname'] = result[i].firstname,
														['@lastname'] = result[i].lastname,
													}, function(result)

												end)
												-- Update skin in users end
										end
								end)
								-- Get NewSkin end
				end)
			-- Update skin end
			end
	end)

	MySQL.Async.execute("UPDATE characters SET vaction=@vaction WHERE skinid = @skinid",
		{
			['@identifier']		= steamid,
			['@skinid'] = skinid,
			['@vaction'] = '0',
		}, function(result)

	end)

end)

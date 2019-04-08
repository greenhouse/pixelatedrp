RegisterServerEvent('HOSPITAL:released')
AddEventHandler('HOSPITAL:released', function(from)
	local name = GetPlayerName(from)
	TriggerClientEvent('chatMessage', -1, "Hospital", {200,0,0}, name.." has been released from the hospital.")
end)

function SecondsToDays(seconds)

	return seconds
end

RegisterServerEvent('HOSPITAL:reminder')
AddEventHandler('HOSPITAL:reminder', function(from, seconds)
	TriggerClientEvent('chatMessage', from, "Hospital", {200,0,0}, "You have "..tostring(seconds).." more seconds before you are released from the hospital.")
end)

RegisterServerEvent('HOSPITAL:hospitalize')
AddEventHandler('HOSPITAL:hospitalize', function(player, time, message, hospital)

		local playerid = tonumber(player)

		local userName = GetPlayerName(player)
		local hospitalTime = 0
		local hospitalIdentifier = 0


		hospitalIdentifier = hospital
		hospitalTime = tonumber(time)

		local eventMessage = userName.." was hospitalized for "..tostring(days).." days due to "..tostring(message..".")

		TriggerClientEvent('chatMessage', -1, "Hospital", {200,0,0}, eventMessage)

		TriggerClientEvent('HOSPITAL:hospitalize', player, hospitalTime, hospitalIdentifier)

end)



local usageStringHospital = "Usage: /hospital *id* *seconds* *reason*"
local usageStringER = "Usage: /er *id* *hospital* *seconds* *reason*"


-- AddEventHandler('chatMessage', function(from,name,message)
-- 	if(message:sub(1,1) == "/") then
--
-- 		local args = stringsplit(message, " ")
-- 		local cmd = args[1]
--
--
-- 		if (cmd == "/hospital" or cmd == '/er') then
-- 			CancelEvent()
-- 			local usageString = usageStringHospital
-- 			local ER = false
--
-- 			if(cmd == "/er") then
-- 				usageString = usageStringER
-- 				ER = true
-- 			end
--
-- 			if (args[2] == nil or args[3] == nil or args[4] == nil or (ER and args[5] == nil)) then
-- 				TriggerClientEvent('chatMessage', from, "Hospital", {200,0,0}, usageString)
-- 				return
-- 			end
--
-- 			local playerID = tonumber(args[2])
--
-- 			if(playerID == nil or GetPlayerName(playerID) == nil) then
-- 				-- Invalid player ID
-- 				TriggerClientEvent('chatMessage', from, "Hospital", {200,0,0} , "Invalid PlayerID")
-- 				return
-- 			end
--
-- 			local userName = GetPlayerName(playerID)
-- 			local hospitalTime = 0
-- 			local hospitalIdentifier = 0
--
-- 			if (ER) then
-- 				hospitalTime = tonumber(args[4])
-- 				hospitalIdentifier = tonumber(args[3])
--
--
-- 				if (hospitalIdentifier == nil) then
-- 					local hospitalText = { paleto = 1,sandy = 2,zonah = 3,pillbox = 4,central = 5}
--
-- 					local requestText = string.lower(args[3])
--
-- 					hospitalIdentifier = hospitalText[requestText]
--
-- 					if(hospitalIdentifier == nil) then
-- 						TriggerClientEvent('chatMessage', from, "Hospital", {200,0,0}, usageString)
-- 						return
-- 					end
-- 				end
--
-- 			else
-- 				hospitalIdentifier = 0
-- 				hospitalTime = tonumber(args[3])
-- 			end
--
-- 			if(hospitalTime == nil) then
-- 				TriggerClientEvent('chatMessage', from, "Hospital", {200,0,0} , usageString)
-- 				return
-- 			end
--
-- 			if (hospitalTime > 600) then
-- 				hospitalTime = 600
-- 			end
--
-- 			local hospitalReason = ""
--
-- 			if (ER) then
-- 				hospitalReason = table.concat(args, " ", 5)
-- 			else
-- 				hospitalReason = table.concat(args, " ", 4)
-- 			end
-- 			local days = ''
-- 			local seconds = ''
--
-- 			seconds  = hospitalTime
--
-- 			if seconds >= 300 then
-- 				days = 5
-- 			elseif seconds >= 240 then
-- 				days = 4
-- 			elseif seconds >= 180 then
-- 				days = 3
-- 			elseif seconds >= 120 then
-- 				days = 2
-- 			elseif seconds >= 60 then
-- 				days = 1
-- 			else
-- 				days = seconds
-- 			end
-- 			local strdays = ''
-- 			if days > 1 then
-- 				strdays = 'days'
-- 			else
-- 				strdays = 'day'
-- 			end
-- 			local eventMessage = userName.." was hospitalized for "..tostring(days).." ".. strdays .." due to "..tostring(hospitalReason..".")
--
-- 			TriggerClientEvent('chatMessage', -1, "Hospital", {200,0,0}, eventMessage)
--
-- 			TriggerClientEvent('HOSPITAL:hospitalize', playerID, hospitalTime, hospitalIdentifier)
-- 		end
--
-- 	end
-- end)


-- String splits by the separator.
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

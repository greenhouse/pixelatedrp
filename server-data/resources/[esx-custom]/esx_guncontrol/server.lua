local ESX = nil
local timeplayed = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)

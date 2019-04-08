ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("blanchisseur:BlanchirCash")
AddEventHandler("blanchisseur:BlanchirCash", function(amount)
	local source = source
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= Config.Percentage

	if amount > 0 and account.money >= amount then

		local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
		local washedMoney = math.floor(amount / 100 * (_percent + bonus))

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)

		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Money Wash', false, 'You received :' .. washedMoney .. 'clean money')
	elseif account.money < amount then
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Money Wash', false, 'You dont have that much Dirty money')
	else
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Money Wash', false, 'invaled amount')
end
end)

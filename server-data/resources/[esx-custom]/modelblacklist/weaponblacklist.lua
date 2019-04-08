-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_RAILGUN",
	"WEAPON_RPG",
	"WEAPON_HEAVYSNIPER",
	--"WEAPON_SNIPERRIFLE",
	"WEAPON_REMOTESNIPER",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_STINGER",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"WEAPON_BRIEFCASE",
	"WEAPON_BRIEFCASE_02",
	"WEAPON_BALL",
	"WEAPON_FLARE",
	"WEAPON_EXPLOSION",
	"WEAPON_FIREWORK",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_PROXMINE",
	"WEAPON_FLAREGUN",
	"WEAPON_PIPEBOMB"
}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("This weapon is blacklisted!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end

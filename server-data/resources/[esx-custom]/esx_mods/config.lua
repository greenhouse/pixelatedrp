Config = {}
-- Compass config
-- Use the following variable(s) to adjust the position.
	-- adjust the x-axis (left/right)
	x = 1.000
	-- adjust the y-axis (top/bottom)
	y = 1.000
-- If you do not see the HUD after restarting script you adjusted the x/y axis too far.

-- Use the following variable(s) to adjust the color(s) of each element.
	-- Use the following variables to adjust the color of the border around direction.
	border_r = 255
	border_g = 255
	border_b = 255
	border_a = 100

	-- Use the following variables to adjust the color of the direction user is facing.
	dir_r = 255
	dir_g = 255
	dir_b = 255
	dir_a = 255
	-- Adding this
	
	-- Use the following variables to adjust the color of the street user is currently on.
	curr_street_r = 240
	curr_street_g = 200
	curr_street_b = 80
	curr_street_a = 255

	-- Use the following variables to adjust the color of the street around the player. (this will also change the town the user is in)
	str_around_r = 255
	str_around_g = 255
	str_around_b = 255
	str_around_a = 255

	-- Use the following variables to adjust the color of the city the player is in (without there being a street around them)
	town_r = 255
	town_g = 255
	town_b = 255
	town_a = 255
 -- end compass

 Config.iShotTimer = 1 * 60000 -- 10 mins

 -- Stop depawn config
 intervals = { -- Unit: seconds
 	['save'] = 10, -- How often the vehicles' position should be saved. The save schedule is only useful after game crashes, or disconnects while in vehicle.
 	['check'] = 15 -- How often should it check for despawned vehicles.
 }

 -- -- Make sure to keep a short save interval if you disable any of these two options.
 -- saveOnEnter = true -- Whether the vehicle should be saved right when it's entered. Useful for quick enter and exit.
 -- saveOnExit = true -- Whether the vehicle should be saved once after a player leaves a vehicle.
 --
 -- debugMode = false -- Toggle debug mode (client & server console spam).
 -- -- End stop despawn config
 Config = {}

 -- 'bone' use bonetag https://pastebin.com/D7JMnX1g
 -- x,y,z are offsets

 Config.StashWeapons = {
 	{name = 'WEAPON_GOLFCLUB', label='Golfclub', instash=true},
 	{name = 'WEAPON_ASSAULTSMG', label = 'Assault smg', instash=true},
 	{name = 'WEAPON_COMBATPDW', label = 'Combat pdw', instash=true},
 	{name = 'WEAPON_ASSAULTRIFLE', label = 'Assault rifle', instash=true},
 	{name = 'WEAPON_CARBINERIFLE', label = 'Carbine rifle', instash=true},
 	{name = 'WEAPON_ADVANCEDRIFLE', label= 'Advanced rifle', instash=true},
 	{name = 'WEAPON_SPECIALCARBINE', label= 'Special carbine', instash=true},
 	{name = 'WEAPON_BULLPUPRIFLE', label='Bullpup Rifle', instash=true},
 	{name = 'WEAPON_COMPACTRIFLE', label= 'Compactrifle', instash=true},
 	{name = 'WEAPON_PUMPSHOTGUN', label='Pumpshotgun', instash=true},
 	{name = 'WEAPON_BULLPUPSHOTGUN', label='Bullpup shotgun', instash=true},
 	{name = 'WEAPON_ASSAULTSHOTGUN', label='Assaut shotgun', instash=true},
 	{name = 'WEAPON_HEAVYSHOTGUN', label='Heavy shotgun', instash=true},
 	{name = 'WEAPON_SAWNOFFSHOTGUN', label='Sawoff shotgun', instash=true},
 	{name = 'WEAPON_MUSKET', label='Musket', instash=true},
 	{name = 'WEAPON_DBSHOTGUN', label='DB shotgun', instash=true},
 	{name = 'WEAPON_AUTOSHOTGUN', label='Auto shotgun', instash=true},
 	{name = 'WEAPON_COMBATMG', label='Combat smg', instash=true},
 	{name = 'WEAPON_MG', label='Mg', instash=true},
 	{name = 'WEAPON_SMG', label='SMG', instash=true},
 	{name = 'WEAPON_GUSENBERG', label='Gunseberg', instash=true},
 	-- {name = 'WEAPON_PISTOL', label='Pistol', instash=false},
 	-- {name = 'WEAPON_COMBATPISTOL', label='Combat Pistol', instash=false},
 	-- {name = 'WEAPON_APPISTOL', label='Appistol', instash=false},
 	-- {name = 'WEAPON_PISTOL50', label='Pistol .50', instash=false},
 	-- {name = 'WEAPON_VINTAGEPISTOL', label='Vintage pistol', instash=false},
 	-- {name = 'WEAPON_HEAVYPISTOL', label='Heavy pistol', instash=false},
 	-- {name = 'WEAPON_SNSPISTOL', label='SNS pistol', instash=false},
 	-- {name = 'WEAPON_STUNGUN', label='Stungun', instash=false},
 	-- {name = 'WEAPON_MARKSMANPISTOL', label='Marksman pistol', instash=false},
 	-- {name = 'WEAPON_REVOLVER', label='Revolver', instash=false},
 }

--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000
-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0

-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:
Config.localWeight = {
	bread               = 300,
	water               = 500,
	black_money         = 1, -- poids pour un argent
	coke                = 100,
	coke_pooch          = 100,
	meth                = 100,
	meth_pooch          = 100,
	opium               = 100,
	opium_pooch         = 100,
	weed                = 100,
	weed_pooch          = 100,
	stone			          = 3000,
	washed_stone		= 2000,
	fish								= 200,
	alive_chicken				= 300,
	slaughtered_chicken	= 200,
	packaged_chicken		= 100,
	packaged_chicken		= 100,
	copper		= 100,
	iron		= 100,
	gold		= 100,
	diamond		= 100,
	wood		= 300,
	cutted_wood		= 300,
	packaged_plank		= 300,
	packaged_plank		= 300,
	petrol            = 500,
	whool            = 200,
	clothe            = 100,
	fabric            = 100,
	fixtool            = 600,
	blowpipe            = 900,

	WEAPON_COMBATPISTOL = 1000, -- poid poir une munnition
	WEAPON_PISTOL				= 1000,
	WEAPON_APPISTOL 		= 1000,
	WEAPON_PISTOL50 		= 1000,
	WEAPON_HEAVYPISTOL  = 1000,
	WEAPON_SNSPISTOL    = 1000,
	WEAPON_STUNGUN			= 1000,
	WEAPON_FLAREGUN     = 1000,
	WEAPON_MARKSMANPISTOL = 1000,
	WEAPON_REVOLVER     = 1000,

	WEAPON_MICROSMG   = 3000,
	WEAPON_SMG        = 3000,
	WEAPON_MG         = 3000,
	WEAPON_COMBATMG   = 3000,
	WEAPON_GUSENBERG  = 3000,
	WEAPON_ASSAULTSMG = 3000,
	WEAPON_COMBATPDW  = 3000,

	clip = 3000,
}

Config.VehicleLimit = {
    [0] = 50000, --Compact
    [1] = 70000, --Sedan
    [2] = 100000, --SUV
    [3] = 25000, --Coupes
    [4] = 40000, --Muscle
    [5] = 25000, --Sports Classics
    [6] = 15000, --Sports
    [7] = 12000, --Super
    [8] = 5000, --Motorcycles
    [9] = 90000, --Off-road
    [10] = 300000, --Industrial
    [11] = 70000, --Utility
    [12] = 125000, --Vans
    [13] = 0, --Cycles
    [14] = 500000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0, --Trains
}

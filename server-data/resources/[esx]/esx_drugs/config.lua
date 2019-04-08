Config              = {}
Config.MarkerType   = 27
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 4.0, y = 4.0, z = 3.0}
Config.MarkerColor  = {r = 100, g = 204, b = 100}
Config.RequiredCopsCoke = 0
Config.RequiredCopsMeth = 0
Config.RequiredCopsWeed = 0
Config.RequiredCopsOpium = 0
Config.Locale = 'en'

--default
Config.TimeToFarm    = 11 * 1000
Config.TimeToProcess = 20 * 1000
Config.TimeToSell    = 5  * 1000

--meth
Config.TimeToFarmm    = 10 * 1000 --12
Config.TimeToProcessm = 20 * 1000 --15
Config.TimeToSellm    = 4  * 1000 --4

--coke
Config.TimeToFarmc    = 10 * 1000 --10
Config.TimeToProcessc = 20 * 1000 --14
Config.TimeToSellc    = 4  * 1000

--opium
Config.TimeToFarmo    = 11 * 1000 -- 8
Config.TimeToProcesso = 20 * 1000 --10
Config.TimeToSello    = 4  * 1000

--weed
Config.TimeToFarmw    = 10 * 1000 --7
Config.TimeToProcessw = 20 * 1000 --10
Config.TimeToSellw    = 4  * 1000 --3

Config.Blips = {
	Weed = { x =2221.8190917969, y =5614.8110351563, z =53.9016456604, name ='Weed Factory' }
}

Config.CokeSellPrice = 100
Config.MethSellPrice = 120
Config.WeedSellPrice = 60
Config.OpiumSellPrice = 80

Config.cokeLimit 		= 20
Config.cokeBagLimit = 40

Config.methLimit = 20
Config.methBagLimit = 40

Config.weedLimit = 20
Config.weedBagLimit = 40

Config.opiumLimit = 20
Config.opiumBagLimit = 40

Config.Zones = {
	CokeField =			{x=1090.4058837891,  y=-3195.78125, z=-40.40,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeField2 =			{x=1094.0089111328,  y=-3196.09750, z=-40.40,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeField3 =			{x=1095.8820800781,  y=-3195.2548828125, z=-40.40,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeProcessing =	{x=1100.4555664063, y=-3194.232421875, z=-40.20,	name = _U('coke_processing'),	sprite = 478,	color = 40},
	CokeDealer =		 {x=1691.02, y=3286.67,  z=40.15,	name = _U('coke_dealer'),		sprite = 500,	color = 75},
	MethField =			{x=1005.529296875, 	 y=-3200.3464355469,  z=-39.99,	name = _U('meth_field'),		sprite = 499,	color = 26},
	MethProcessing =	{x=1011.0367431641, y=-3195.7021484375,  z=-39.99,	name = _U('meth_processing'),	sprite = 499,	color = 26},
	MethDealer =		{x=-1639.08, y=-1062.88, z=12.15,	name = _U('meth_dealer'),		sprite = 500,	color = 75},
	WeedField =			{x=1060.1691894531, y=-3196.9636230469,  z=-40.153,	name = _U('weed_field'),		sprite = 496,	color = 52},
	WeedField2 =			{x=1060.6087646484, y=-3202.9436035156,  z=-40.153,	name = _U('weed_field'),		sprite = 496,	color = 52},
	WeedProcessing =	{x=1039.2406005859,  y=-3205.3784179688,  z=-39.12,	name = _U('weed_processing'),	sprite = 496,	color = 52},
	WeedDealer =		{x=-1154.43, y=-1520.99, z=09.63,	name = _U('weed_dealer'),		sprite = 500,	color = 75},
	OpiumField =		{ x=1341.43,	y=4389.84,  z=43.34,	name = _U('opium_field'),		sprite = 51,	color = 60},
	OpiumProcessing =	{x=1337.76, y=4386.05,  z=43.39,	name = _U('opium_processing'),	sprite = 51,	color = 60},
	OpiumDealer =		{x=-1892.33,y=2076.78,z=140.0,	name = _U('opium_dealer'),		sprite = 500,	color = 75},
}

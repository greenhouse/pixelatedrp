Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 27 -- other MarkerType:'https://wiki.gt-mp.net/index.php?title=Marker'
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 24, g = 201, b = 137 } -- other colors:'https://www.w3schools.com/colors/colors_rgb.asp'
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.TheLostMCStations = {

  TheLostMC = {

    Blip = { --More Blips:'https://marekkraus.sk/gtav/blips/list.html'
      Pos     = { x = 980.55590820313, y = -98.454368591309, z = 73.94 },
      Sprite  = 418,
      Display = 4,
      Scale   = 1,
      Colour  = 29,
    },

    AuthorizedWeapons = { --for another Weapons or Vehicle:'http://gta.wikia.com/wiki/The_Lost_MC'
      { name = 'WEAPON_PISTOL',     price = 4000 },
      { name = 'WEAPON_ASSAULTSMG',       price = 50000 },
      --{ name = 'WEAPON_ASSAULTRIFLE',     price = 80000 },
      --{ name = 'WEAPON_PUMPSHOTGUN',      price = 18000 },
      --{ name = 'WEAPON_STUNGUN',          price = 250 },
      { name = 'WEAPON_FLASHLIGHT',       price = 50 },
      --{ name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
      --{ name = 'WEAPON_CARBINERIFLE',     price = 50000 },
    --  { name = 'WEAPON_ADVANCEDRIFLE',    price = 50000 },
      --{ name = 'WEAPON_SNIPERRIFLE',      price = 150000 },
      --{ name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
      { name = 'WEAPON_APPISTOL',         price = 12000 },
      --{ name = 'WEAPON_FLARE',            price = 8000 },
      { name = 'WEAPON_SWITCHBLADE',      price = 500 },
	  { name = 'WEAPON_POOLCUE',          price = 100 },

    },

	AuthorizedVehicles = {
	  { name = 'hexer',          label = 'Hexer' },
	  { name = 'innovation',     label = 'Innovation' },
	  { name = 'daemon',         label = 'Daemon' },
	  { name = 'Zombieb',        label = 'Zombie Chopper' },
	  { name = 'slamvan',        label = 'Slamvan' },
	  { name = 'GBurrito',       label = 'Gang Burrito' },
	  { name = 'sovereign',      label = 'Sovereign' },
	  },

    Cloakrooms = {
      { x = -2125.09, y = 2661.34, z = 2.6 },
    },

    Armories = {
      { x = -2108.32, y = 2683.54, z = 3.0 },
    },

    Vehicles = {
      {
        Spawner    = { x = -2124.04, y = 2688.19, z = 1.96 },
        SpawnPoint = { x = -2138.51, y = 2686.07, z = 1.99 },
        Heading    = 33.00,
      }
    },

	-- Helicopters = {
  --     {
  --       Spawner    = { x = 1985.8848876953, y = 3035.8532714844, z = 47.056331634521 },
  --       SpawnPoint = { x = 1988.7224121094, y = 3033.6520996094, z = 47.056331634521 },
  --       Heading    = 0.0,
  --     }
  --   },

    VehicleDeleters = {
      { x = -2113.59, y = 2687.92, z = 2.05 },
    },

    BossActions = {
      { x = -2166.38, y = 2687.33, z = 1.9 }
    },

  },

}

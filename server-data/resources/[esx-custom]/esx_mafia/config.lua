Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MafiaStations = {

  Mafia = {

    Blip = {
      Pos     = { x = 1399.2149658203, y =1145.3737792969, z = 140.33 },
      Sprite  = 78,
      Display = 4,
      Scale   = 0.8,
      Colour  = 29,
    },

    AuthorizedWeapons = {
      --{ name = 'WEAPON_COMBATPISTOL',     price = 4000 },
      --{ name = 'WEAPON_ASSAULTSMG',       price = 15000 },
      --{ name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
      --{ name = 'WEAPON_PUMPSHOTGUN',      price = 9000 },
      --{ name = 'WEAPON_FLASHLIGHT',       price = 50 },
      --{ name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
      --{ name = 'WEAPON_FLAREGUN',         price = 3000 },
      --{ name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
      --{ name = 'WEAPON_APPISTOL',         price = 12000 },
      --{ name = 'WEAPON_SWITCHBLADE',      price = 500 },
	    --{ name = 'WEAPON_REVOLVER',         price = 6000 },
	    --{ name = 'WEAPON_POOLCUE',          price = 100 },
    },

	  AuthorizedVehicles = {
		  { name = 'schafter3',  label = 'Vehicle Civil' },
		  { name = 'btype',      label = 'Roosevelt' },
		  { name = 'sandking',   label = '4X4' },
		  { name = 'mule3',      label = 'Camion de Transport' },
		  { name = 'guardian',   label = 'Grand 4x4' },
		  { name = 'burrito3',   label = 'Fourgonnette' },
		  { name = 'mesa',       label = 'Tout-Terrain' },
	  },

    Cloakrooms = {
      { x = 1396.3221435547, y = 1138.0621337891, z = 113.45 },
    },

    Armories = {
      { x = 1397.4666748047, y =1164.3740234375, z = 113.45 },
    },

    Vehicles = {
      {
        Spawner    = { x = 1408.0217285156, y = 1116.0635986328, z = 113.95 },
        SpawnPoint = { x = 1427.2208251953, y = 1116.3234863281, z = 113.55 },
        Heading    = 90.0,
      }
    },

	-- Helicopters = {
  --     {
  --       Spawner    = { x = 20.312, y = 535.667, z = 173.627 },
  --       SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
  --       Heading    = 0.0,
  --     }
  --   },

    VehicleDeleters = {
      { x = 1402.0462646484, y = 1117.2263183594, z = 113.98 }
      --{ x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = 1397.0261230469, y = 1131.1170654297, z = 113.45 }
    },

  },

}

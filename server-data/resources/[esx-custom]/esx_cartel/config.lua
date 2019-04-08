Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.CartelStations = {

  Mafia = {

    Blip = {
      Pos     = {  x=-1407.02, y=632.17, z=196.13 },
      Sprite  = 89,
      Display = 4,
      Scale   = 1.2,
      Colour  = 3,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_PISTOL',     price = 4000 },
      { name = 'WEAPON_ASSAULTSMG',       price = 8000 },
      --{ name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
      { name = 'WEAPON_PUMPSHOTGUN',      price = 9000 },
      { name = 'WEAPON_FLASHLIGHT',       price = 50 },
      --{ name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
      --{ name = 'WEAPON_FLAREGUN',         price = 3000 },
      --{ name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
      { name = 'WEAPON_APPISTOL',         price = 3500 },
      { name = 'WEAPON_SWITCHBLADE',      price = 500 },
	    { name = 'WEAPON_REVOLVER',         price = 6000 },
	    { name = 'WEAPON_POOLCUE',          price = 100 },
    },

	  AuthorizedVehicles = {
      { name= 'bentaygast', label = 'Bently 1'},
      { name= 'mcgt4', label = 'Masarati R'},
      { name= 'contgt2011', label = 'Bentley continental GT'},
		  { name = 'btype',      label = 'Roosevelt' },
		  { name = 'sandking',   label = '4X4' },


		  { name = 'guardian',   label = 'Grand 4x4' },
		  { name = 'burrito3',   label = 'Fourgonnette' },
		  { name = 'mesa',       label = 'Tout-Terrain' },
	  },

    Cloakrooms = {
      { x=937.27, y=1248.07, z=373.1 },
      { x=905.75, y=1232.2, z=373.1 },
      { x=920.79, y=1261.87, z=373.1 },
    },

    Armories = {
      { x= 931.43, y=1263.06, z=365.12 },
    },

    Vehicles = {
      {
        Spawner    = { x=906.95, y=1247.1, z=361.11 },
        SpawnPoint = { x=917.85 , y=1248.78,  z=361.11 },
        Heading    = 145.1,
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
      { x=919.5, y=1263.79, z=361.11, r=160, g=9, b=49  }
      --{ x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x=942.96, y=1238.11, z=365.12 } 
    },

  },

}


Config.Missions ={

  MissionName = {
    TimeToComplete = { seconds = 5000 },

    Marker = {
      Type = 27,
      Size = { x = 1.5, y = 1.5, z = 1.0 },
      Color = { r = 209, g = 168, b = 66 }
    },

    MissionStart = {
      x = -1402.27,
      y = 636.05,
      z = 196.15,
      ZoneSize = {x = 2.0, y = 2.0, z = 2.0}
    },

    MissionLocation = {
      x=-1409.04, y=689.72, z=186.2,
      ZoneSize = {x = 2.0, y = 2.0, z = 2.0}
    },

    MissionDeliver = {
      x=-1409.93, y=637.12, z=196.2,
      ZoneSize = {x = 2.0, y = 2.0, z = 2.0}
    }
  }
}

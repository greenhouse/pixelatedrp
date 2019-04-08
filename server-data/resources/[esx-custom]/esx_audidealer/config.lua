Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false
Config.ResellPercentage           = 50
Config.Locale                     = 'en'

Config.Zones = {

  ShopEntering = {
    Pos   = { x = 481.63, y = -1286.36, z = 28.57  },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = {
    Pos     = { x = 480.49, y = -1281.05, z = 28.57 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = -55.0,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = 478.85, y = -1275.59, z = 28.58 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 10.54,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = {
    Pos   = { x = -44.630, y = -1080.738, z = 25.683 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },

}

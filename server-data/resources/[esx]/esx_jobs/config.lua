Config              = {}
Config.DrawDistance = 100.0
Config.Locale = 'en'
Config.Jobs         = {}

Config.PublicZones = {
	EnterBuilding = {
		Pos   = { x = -118.21381378174, y = -607.14227294922, z = 35.280723571777 },
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Blip  = false,
		Name  = _U('reporter_name'),
		Type  = "teleport",
		Hint  = _U('public_enter'),
		Teleport = { x = -139.09838867188, y = -620.74865722656, z = 167.82052612305 }
	},

	ExitBuilding = {
		Pos   = { x = -139.45831298828, y = -617.32312011719, z = 167.82052612305 },
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Blip  = false,
		Name  = _U('reporter_name'),
		Type  = "teleport",
		Hint  = _U('public_leave'),
		Teleport = { x = -113.07, y = -604.93, z = 35.28 },
	},

  EnterBuilding1 = {
    Pos   = { x = -613.09, y = -1624.68, z = 32.01 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Coke Factory",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ enter the Coke Factory",
    Teleport = { x = 1088.787109375, y = -3187.8112792969, z = -39.98 }
  },

  ExitBuilding1 = {
    Pos   = { x = 1088.787109375, y = -3187.8112792969, z = -39.98 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Coke Factory",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to exit the Coke factory",
    Teleport = { x = -613.09, y = -1624.68, z = 32.01 },
  },

  EnterBuilding2 = {
    Pos   = { x =2221.8190917969, y =5614.8110351563, z =53.9016456604 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Weed Factory",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ enter the Weed Factory",
    Teleport = { x = 1066.3944091797, y = -3183.5180664063, z = -40.153  }
  },

  ExitBuilding2 = {
    Pos   = { x = 1066.3944091797, y = -3183.5180664063, z = -40.153 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Weed Factory",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to exit the Weed Factory",
    Teleport = { x = 2221.8190917969, y = 5614.8110351563, z = 53.9016456604 },
  },

  EnterBuildingMoney = {
    Pos   = { x = 614.579956, y = 2784.220703, z =42.50 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Money Laundry",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ enter the Money Laundry",
    Teleport = { x = 1138.4625244141, y = -3198.6254882813, z = -40.65  }
  },

  ExitBuildingMoney = {
    Pos   = { x = 1138.4625244141, y = -3198.6254882813, z = -40.65 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Money Laundry",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to exit Money Laundry",
    Teleport = {  x=614.579956, y=2784.220703, z=42.50 },
  },

  EnterBuildingMeth = {
    Pos   = { x = 1599.95, y = 3587.75, z = 37.77 },
    Size  = {x = 2.3, y = 2.3, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Meth Lab",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ enter the Meth Lab",
    Teleport = { x = 996.91253662109, y = -3200.6020507813, z = -37.39  }
  },

  ExitBuildingMeth = {
    Pos   = { x=996.91253662109, y = -3200.6020507813, z = -37.39 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Meth Lab",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to exit Meth Lab",
    Teleport = {  x = 1599.95, y = 3587.75, z = 37.77},
  },
  EnterBuildingMafia = {
    Pos   = { x = 1410.7860107422, y = 1147.7895507813, z =113.45 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Mafia house",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ enter the Mafia house",
    Teleport = { x=1407.8361816406, y = 1147.2427978516, z = 113.60  }
  },

  ExitBuildingMafia = {
    Pos   = { x=1405.8981933594, y = 1145.2250976563, z = 113.45 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Mafia house",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to exit Mafia house",
    Teleport = {   x = 1409.7065429688, y = 1147.9510498047, z =113.60 },
  },

  EnterBuildingOpium = {
    Pos   = { x = 3599.81, y = 3699.55, z =28.70 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Mafia house",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to take elevator up",
    Teleport = { x=3540.57, y = 3675.54, z = 27.20  }
  },

  ExitBuildingOpium = {
    Pos   = { x=3540.57, y = 3675.54, z = 27.20 },
    Size  = {x = 3.0, y = 3.0, z = 0.2},
    Color = {r = 204, g = 204, b = 0},
    Marker= 27,
    Blip  = false,
    Name  = "Mafia house",
    Type  = "teleport",
    Hint  = "Press ~INPUT_PICKUP~ to take elevator down",
    Teleport = {    x = 3599.81, y = 3699.55, z =28.70 },
  }

}

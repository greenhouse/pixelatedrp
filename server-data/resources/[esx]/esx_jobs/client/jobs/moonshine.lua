-- Scripted By Crxnkeh Dev - Fully Made by Crxnkeh Dev
Config.Jobs.MoonShine
  BlipInfos = {
    Sprite = 310, 
	Color = 70
  },
  Vehicles = { 
    Truck = {
	  Spawner = 1
	  Hash = "RatLoader", 
	  Trailer = "none",
	  HasCaution = true
	}
  }, 
  Zones = {
    CloakRoom = {
	  Pos = {x = 454.16, y = -1305.44, z = 29.71},
	  Size = {x = 3.0, y = 3.0, z = 1.0},
	  Color = {r = 244, g = 223, b = 66},
	  Marker = 1,
	  Blip = true,
	  Name = _U('s_moonshiner_locker'),
	  Type = "cloakroom",                        
	}, 
	
	GatherMash = {
	  Pos = {x = 2789.39, y = -1451.39, z = 1.44},
      Size = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 244, g = 223, b = 66},
      Marker = 1,
      Blip = true
      Name = _U('s_mash'),
      Type = "work",
      Item = { 
        {        	  
          name   = _U('s_mash'),
          db_name= "mash",
          time   = 8000,
          max    = 50,
          add    = 1,
          remove = 1,
          requires = "nothing",
          requires_name = "Nothing",
          drop   = 50
        }
      },		
	  Hint = _U('s_gather_mash'),
	},
	
	BoilMash = {
	  Pos = {x = 1371.3, y = -79.33, z = 79.06},
	  Size = {x = 3.0, y = 3.0, z = 1.0},
	  Color = {r = 244, g = 223, b = 66},
	  Marker =  ,
	  Blip = true
	  Name = _U('s_boil_mash'),
	  Type = "work",
	  Item = {
	    {
		  name   = _U('s_boil_mash'),
          db_name= "boil_mash",
          time   = 8000,
          max    = 50,
          add    = 1,
          remove = 1,
          requires = "mash",
          requires_name = _U('s_mash'),
          drop   = 50
		}
	  },
	  Hint = _U('s_boil_mash'),
	},
	
	JarMash = {
	  Pos = {x = 706.72, y = -965.59, z = 30.36},
	  Size = {x = 3.0, y = 3.0, z = 1.0},
	  Color = {r = 244, g = 223, b = 66},
	  Marker = ,
	  Blip = true
	  Name = _U{'s_jar_mash'},
	  Type = "work",
	  Item = {
	    { 
	      name   = _U('s_jar_mash'),
          db_name= "jar_mash",
          time   = 8000,
          max    = 100,
          add    = 5,
          remove = 1,
          requires = "boil_mash",
          requires_name = _U('s_boil_mash'),
          drop   = 100 
		}
	  },
	  Hint = _U('s_jar_mash'),
	},
	
	SellMash = {
	  Pos = {x = 951.38, y = -201.79, z = 76.06},
	  Size = {x = 3.0, y = 3.0, z = 1.0},
	  Color = {r = 244, g = 233, b = 66},
	  Marker = 1,
	  Blip = true, 
	  Name = _U('s_sell_mash'),
	  Type = "work",
	  Item = {
	    {  
		  name   = _U('s_sell_mash'),
          time   = 9000,
          remove = 1,
          max    = 100,
          price  = 50,
          requires = "jar_mash",
          requires_name = _U('s_jar_mash'),
          drop   = 100 
        }
      },
	  Hint = _U('s_sell_mash')
    },
	
	  VehicleSpawner = {
      Pos   = {x = 484.65, y = -1311.73, z = 29.37},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 66, g = 244, b = 244},
      Marker= 1,
      Blip  = true,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 3500
    },
	
      VehicleSpawnPoint = {
      Pos   = {x = 480.13, y = -1318.49, z = 29.28},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 130.1
    },
	
	VehicleDeletePoint = {
      Pos   = {x = 496.45, y = -1325.04, z = 29.3},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 244, g = 66, b = 66},
      Marker= 1,
      Blip  = false,
      Name  = _U('return_vh'),
      Type  = "vehdelete",
      Hint  = _U('return_vh_button'),
      Spawner = 1,
      Caution = 2000,
      GPS = 0,
      Teleport = 0
	}, 
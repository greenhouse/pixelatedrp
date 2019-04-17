--New custom animations based off DavesEmotes from @davewazere
--https://forum.fivem.net/t/release-daves-emotes/140216 
--Finger Pointing is taken from @Geekness and @Hallux
--https://forum.fivem.net/t/release-finger-pointing-by-geekness/103722
--Ragdoll is from here @callmejaf
--https://forum.fivem.net/t/release-toggle-ragdoll/53668
--Crouch is from wolfknights script @WolfKnight
--https://forum.fivem.net/t/release-crouch-script-1-0-1-now-button-based/14742


-- Commands
-- Salute: 		/e salute 		: Salute your commrads!
-- Bird 1: 		/e finger 		: One hand middle Finger
-- Bird 2: 		/e finger2 		: 2 hands middle finger
-- Surrender: 	/e surrender	: Kneeldown hands behind head surrender
-- Facepalm: 	/e facepalm		: Facepalm
-- Notes: 		/e notes		: Write down notes on paper
-- Brief:		/e brief		: Equip a tactical brief case
-- Brief2:		/e brief2		: Equip a leather brief case
-- Damn:		/e damn			: Throw your arms in disbelief
-- Fail:		/e fail			: Become visibly dissapointed
-- Shrug: 		/e shrug		: Shrug your shoulders
-- Gang1:		/e gang1		: Gang sign 1
-- Gang2:		/e gang2		: Gang sign 2
-- No:			/e no			: Shake your head no
-- Pickbutt:	/e pickbutt		: Pick your butt
-- Grab Crotch:	/e grabcrotch	: Grab your crotch
-- Peace:		/e peace		: Hold peace sign
-- Guard: 		/e guard		: Stand guard
-- Cigar:		/e cigar		: Place cigar in your mouth
-- Cigar2:		/e cigar2		: Place a burnt cigar in your mouth
-- Joint:		/e joint		: Place a joint in your mouth
-- Cig:			/e cig			: Place a cig in your mouth
-- Holdcigar:	/e holdcigar	: Hold a cigar in your hand 
-- Holdcig:		/e holdcig		: Hold a cig in your hand 
-- Holdjoint:	/e holdjoint	: Hold a joint in your hand
-- Dead:		/e dead			: Play dead
-- Holster:		/e holster		: Hand hovers over holster 
-- Slow Clap:	/e slowclap		: Slowly clap your hands
-- Carry a box:	/e box			: Pull out a box and walk around with it
-- Cheer		/e cheer		: Cheer
-- Bum:			/e bum			: Lay on the ground like a bum
-- Wall-lean:	/e leanwall		: Lean against a wall
-- crowd ctrl1:	/e copcrowd		: Calm down a crowd like a cop
-- Crowd ctrl2:	/e copcrowd2	: Control a scene like a cop
-- Cop idle:	/e copidle		: idle like a cop
-- Umbrella:	/e umb			: take out an umbrella
-- Flex: 		/e flex			: Flex your muscles
-- Liftweights: /e liftweights	: Arm curls
-- Yoga:		/e yoga			: Do some yoga
-- Pushups:		/e pushups		: Do some pushups
-- Situps:		/e situps		: Do some situps
-- Striptease1: /e st1 			: Striptease dance ver1
-- Striptease2: /e st2			: Striptease dance ver2
-- STOK: 		/e stok			: Striptease on knees
-- Stripidle1:  /e stripidle 	: Hooker idle ver1
-- Stripidle2:  /e stripidle2	: Hooker idle ver2
-- Stripidle3:  /e stripidle3	: Hooker idle ver3
-- Salsa:	 	/e salsa		: Salsa dance male ver
-- Salsa2:	 	/e salsa2		: Salsa dance female ver
-- Cat's Cradle: /e ccd			: Cat's cradle dance male ver
-- Cat's Cradle2: /e ccd2		: Cat's cradle dance female ver
-- Find the fish: /e ffd   		: Find the fish dance male ver
-- Find the fish2: /e ffd2  	: Find the fish dance female ver
-- Heartpump: 	/e heartpump 	: Heartpump dance male ver
-- Heartpump2: 	/e heartpump2 	: Heartpump dance female ver
-- Oh snap!: 	/e ohsnap		: Oh snap! dance male ver
-- Oh snap!2: 	/e ohsnap2		: Oh snap! dance female ver
-- Raiseroof: 	/e raiseroof	: Raise the Roof dance male ver
-- Raiseroof2: 	/e raiseroof2	: Raise the Roof dance female ver
-- Disco: 		/e disco		: Disco dance male ver
-- Disco2: 		/e disco2		: Disco dance female ver
-- Ground sit:	/e groundsit	: Sit on the ground
-- Lean: 		/e lean			: Lean against a wall (different variations, /e leanwall is the same anim every time)
-- SunbatheB: 	/e sunbatheb	: Lay down and sunbathe your back
-- SunbatheF: 	/e sunbathef	: Lay down and sunbathe your front
-- Clean:		/e clean		: Wipe with a rag
-- Selfie:		/e selfie		: Take a selfie with your phone
-- Smoke:		/e smoke		: Smoke a cigarette
-- Beer: 		/e beer			: Party with a beer
-- Kneel:		/e kneel		: Kneel
-- Binoculars:	/e binoculars	: Look through a pair of binoculars
-- Fishing: 	/e fishing		: Go fishing with a rod
-- Wallspy:		/e wallspy		: Put your ear against the wall 
-- Serveshots:	/e serveshots	: Act as if you're serving shots
-- Writhe: 		/e writhe		: Writhe on the ground as if injured


-- If you want ESX features enabled you can uncomment this stuff
--------------------------------------------------------------------------------------------- ESX SUPPORT ---------------------------------------------------------------------------------------------


--ESX 			    			= nil
--local PlayerData 				= {}

--Citizen.CreateThread(function()
--	while ESX == nil do
--		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--		Citizen.Wait(0)
--	end
--end)

--RegisterNetEvent('esx:playerLoaded')
--AddEventHandler('esx:playerLoaded', function(xPlayer)
--  PlayerData = xPlayer
--end)

--RegisterNetEvent('esx:setJob')
--AddEventHandler('esx:setJob', function(job)
--  PlayerData.job = job
--end)

------------------------------------------------------------------------------------------ END ESX SUPPORT ------------------------------------------------------------------------------------------

local radioActive 				= false
local radioButton				= 303 --- U by default  -- use 57 for f10
local handsUpButton				= 74 --- H by default -- use 73 for X
local Keys = {["X"] = 73}


--- Function for radio chatter function
Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustPressed(0,radioButton)) then
		if (IsControlJustPressed(0,radioButton))  then
			local ped = PlayerPedId()
			--TriggerEvent('chatMessage', 'TESTING ANIMATION')
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = true
	
				if radioActive then
	
					RequestAnimDict( "random@arrests" )
	
					while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
						Citizen.Wait( 100 )
					end
	
					if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
						ClearPedSecondaryTask(ped)
					else
						TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						local prop_name = prop_name
						local secondaryprop_name = secondaryprop_name
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
						--SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					end
				end
			end
		end
	end
end)
	
--- Broke this into two functions because it was bugging out for some reason.
	
Citizen.CreateThread( function()
	
	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustReleased(0,57))  and (radioActive) then
		if (IsControlJustReleased(0,raisehandbutton))  and (radioActive) then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = false
				ClearPedSecondaryTask(ped)
				--SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
			end
		end

			
	end
	
end)


Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		if (IsControlJustPressed(0,handsUpButton))  then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
	
				RequestAnimDict( "random@mugging3" )
	
				while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
					Citizen.Wait( 100 )
				end
	
				if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
					ClearPedSecondaryTask(ped)
				else
					TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
					local prop_name = prop_name
					local secondaryprop_name = secondaryprop_name
					DetachEntity(prop, 1, 1)
					DeleteObject(prop)
					DetachEntity(secondaryprop, 1, 1)
					DeleteObject(secondaryprop)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 47) then --Start holding g
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)


RegisterCommand("e",function(source, args)
	local player = PlayerPedId()

	if tostring(args[1]) == nil then
		print("Invalid syntax, correct syntax is: /e <animation> ")
		return
	else
		if tostring(args[1]) ~= nil then
			local argh = tostring(args[1])
			
			TriggerEvent("chatMessage", "", {255, 255, 255}, "command running")

			for i=1, #Config.Animations, 1 do
				local label = Config.Animations[i].label
				local type = Config.Animations[i].type
				local data = config.Animations[i].data


				if argh == label then

					if type == 'scenario' then
						startScenario(data.anim)
					elseif type == 'anim' then
						startAnim(data.lib, data.anim)
					end
				end
			end
		end
	end				
	
end, false)

----Use /testanimation command, you can use this to easily test new animations---

RegisterCommand("testanim",function(source, args)

	local ad = "mini@drinking" --- insert the animation dic here
	local anim = "shots_barman_c" --- insert the animation name here
	local player = PlayerPedId()
	

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		TriggerEvent('chatMessage', '^2 Testing Animation')
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		elseif IsControlJustReleased(0, Keys['X']) then
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)	

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['X']) and IsInputDisabled(0) and not isDead then
			ClearPedTasks(PlayerPedId())
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end

	end
end)
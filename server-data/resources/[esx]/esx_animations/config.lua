Config = {}

Config.Animations = {

	{
		name  = 'festives',
		label = 'Main Animations',
		items = {
	    {label = "Smoke a cigarette", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
	    {label = "Play music", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
	    {label = "Dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
	    {label = "Drink a beer", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
	    {label = "Drink a beer and dance", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
	    {label = "Air Guitar", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
	    {label = "Air Shagging", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
	    {label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
	    {label = "Smoke a  joint", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
	    {label = "Being drunk", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
	    {label = "Vomit in a car", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Greetings',
		items = {
	    {label = "Greet", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
	    {label = "Shaking hands", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
	    {label = "Bro shake", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
	    {label = "Bro hug", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
	    {label = "Military salute", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'Work animations',
		items = {
	    {label = "Suspect : Surrender to police", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c"}},
	    {label = "Fishing", type = "scenario", data = {anim = "world_human_stand_fishing"}},
	    {label = "Police : investigating", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
	    {label = "Police : Talk on the radio", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
	    {label = "Police : Park attendant", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
	    {label = "Police : Binoculars", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
	    {label = "Agriculture : Harvest", type = "scenario", data = {anim = "world_human_gardener_plant"}},
	    --{label = "Mechanic : repair under vehicle", type = "scenario", data = {anim = "world_human_vehicle_mechanic"}},
	    {label = "Mechanic : repair engine", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
	    {label = "EMS : Check patient", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
	    {label = "Taxi : Talk to customer", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
	    {label = "Taxi : Give the bill", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
	    --{label = "Epicier : donner les courses", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
	    --{label = "Barman : servir un shot", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
	    --{label = "Journaliste : Prendre une photo", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
	    {label = "Take notes", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
	    {label = "Tout métiers : Coup de marteau", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
	    --{label = "Clochard : Faire la manche", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
	    --{label = "Clochard : Faire la statue", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'Fun stuff',
		items = {
	    {label = "Congratulate", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
	    {label = "THumbs up", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
	    {label = "Point", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
	    {label = "Come here", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}},
	    {label = "Bring it on", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
	    {label = "Me?", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
	    {label = "Shoplift", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
	    --{label = "Idling", type = "scenario", data = {lib = "amb@world_human_jog_standing@male@idle_b", anim = "idle_d"}},
	    --{label = "Je suis dans la merde", type = "scenario", data = {lib = "amb@world_human_bum_standing@depressed@idle_a", anim = "idle_a"}},
	    {label = "Facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
	    {label = "Calm your tits ", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
	    {label = "What did I do?", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
	    {label = "Scared", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
	    {label = "Fight?", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
	    {label = "It's not possible!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
	    {label = "Embrace", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
	    --{label = "Doigt d'honneur", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
	    {label = "Wank off", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
	    {label = "Kill yourself", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'sports',
		label = 'Sports',
		items = {
	    {label = "Show your musscles", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
	    {label = "Show off you musscles", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
	    {label = "Pushups", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
	    {label = "Doing abs", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
	    {label = "Yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'Diverse animations',
		items = {
	    {label = "Drink a cup of coffee", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
	    {label = "Sit", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
	    --{label = "Sit on the floor", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
	    --{label = "Lean", type = "scenario", data = {anim = "world_human_leaning"}},
	    --{label = "Lay on your back", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
	    --{label = "Lay on your stomach", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
	    {label = "Clean something", type = "scenario", data = {anim = "world_human_maid_clean"}},
	    {label = "BBQ", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
	    {label = "Stand for being searched", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
	    {label = "Take a selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
	    {label = "Eavedrop", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}},
		}
	},

	{
		name  = 'attitudem',
		label = 'Walk animations',
		items = {
	    {label = "Normal Male", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
	    {label = "Normal Female", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
	    {label = "Depressed", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
	    {label = "Depressed Female", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
	    {label = "Business", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
	    {label = "Determined", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
	    {label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
	    {label = "Stuffed", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
	    {label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
	    {label = "Injured", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
	    {label = "Intimidated", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
	    {label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
	    {label = "Unfortunate", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
	    {label = "Musculair", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
	    {label = "In chock", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
	    {label = "Not happy", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
	    {label = "Tired", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
	    {label = "In a hurry", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
	    {label = "Proud", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
	    {label = "Small steps", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
	    {label = "Shake da booty - female", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
	    {label = "Sassy", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},
	    {label = "Arrogant", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},
	{
		name  = 'porn',
		label = 'PEGI 21',
		items = {
	    {label = "Homme se faire su*** en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
	    {label = "Femme faire une gaterie en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
	    {label = "Homme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
	    {label = "Femme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
	    {label = "Se gratter les couilles", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
	    {label = "Faire du charme", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
	    {label = "Pose michto", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
	    {label = "Montrer sa poitrine", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
	    {label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
	    {label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
	    {label = "Stip Tease au sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
			}
	},

}

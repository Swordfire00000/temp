if not _G.VHUDPlus then
	_G.VHUDPlus = {}
	VHUDPlus.mod_path = ModPath
	VHUDPlus.save_path = SavePath
	VHUDPlus.new_settings_path = VHUDPlus.save_path .. "VanillaHUD_v3.json"
	VHUDPlus.settings_path = VHUDPlus.save_path .. "VanillaHUD.json"
	VHUDPlus.wolf_settings_path = VHUDPlus.save_path .. "WolfHUD_v2.json"
	VHUDPlus.reconnect_data_path = VHUDPlus.save_path .. "VHUDPlus_Reconnect"
	VHUDPlus.tweak_file = "WolfHUDTweakData.lua"
	VHUDPlus.identifier = string.match(VHUDPlus.mod_path, "[\\/]([%w_-]+)[\\/]$") or "VanillaHUD Plus"
	VHUDPlus.fast_net_core = "fast_net_core"
	VHUDPlus.fast_net = "fast_net"
	VHUDPlus.fast_net_friends = "fast_net_friends"
	VHUDPlus.fast_net_filter = "fast_net_filter"

	VHUDPlus.settings = {}
	VHUDPlus.tweak_data = {}

	VHUDPlus.hook_files = VHUDPlus.hook_files or {
		["lib/setups/setup"] 										= { "GameInfoManager.lua", "WaypointsManager.lua" },
		["lib/managers/menumanager"] 								= { "PrePlanManager.lua", "MenuTweaks.lua", "ProfileMenu.lua", "FastNet.lua"  },
		["lib/managers/menumanagerdialogs"] 						= { "MenuTweaks.lua" },
		["lib/managers/chatmanager"] 								= { "MenuTweaks.lua" },
		["lib/managers/crimenetmanager"]							= { "MenuTweaks.lua", "FastNet.lua" },
		["lib/managers/localizationmanager"] 						= { "AdvAssault.lua", "Scripts.lua" },
		["lib/managers/experiencemanager"] 							= { "Scripts.lua" },
		["lib/managers/moneymanager"] 								= { "Scripts.lua" },
		["lib/managers/multiprofilemanager"]						= { "ProfileMenu.lua" },
		["lib/managers/crimespreemanager"]							= { "TabStats.lua" },
		["lib/managers/hudmanager"] 								= { "EnemyHealthCircle.lua", "CustomWaypoints.lua", "EnemyHealthbarAlt.lua" },
		["lib/managers/hudmanagerpd2"] 								= {  "VanillaHUD.lua", "HUDChat.lua", "HUDList.lua", "KillCounter.lua", "DownCounter.lua", "DrivingHUD.lua", "DamageIndicator.lua", "WaypointsManager.lua", "Interaction.lua", "Scripts.lua", "BurstFire.lua", "AdvAssault.lua", "TabStats.lua", "CustomHUD.lua", "ForceReady.lua" },
		["lib/managers/statisticsmanager"] 							= { "KillCounter.lua", "Scripts.lua", "EnemyHealthCircle.lua" },
		["lib/managers/playermanager"] 								= { "GameInfoManager.lua", "BurstFire.lua", "VanillaHUD.lua", "Scripts.lua" },
		["lib/managers/preplanningmanager"] 						= { "PrePlanManager.lua" },
		["lib/managers/hud/huddriving"] 							= { "DrivingHUD.lua" },
		["lib/managers/hud/hudteammate"] 							= { "VanillaHUD.lua", "KillCounter.lua", "DownCounter.lua", "BurstFire.lua", "CustomHUD.lua" },
		["lib/managers/hud/hudtemp"] 								= { "CustomHUD.lua" },
		["lib/managers/hud/hudassaultcorner"] 						= { "Scripts.lua", "AdvAssault.lua" },
		["lib/managers/hud/hudobjectives"] 							= { "EnhancedObjective.lua" },
		["lib/managers/hud/hudheisttimer"] 							= { "EnhancedObjective.lua" },
		["lib/managers/hud/hudchat"] 								= { "HUDChat.lua" },
		["lib/managers/hud/newhudstatsscreen"] 						= { "TabStats.lua", "EnhancedCrewLoadout.lua" },
		["lib/managers/hud/hudinteraction"] 						= { "Interaction.lua" },
		["lib/managers/hud/hudsuspicion"] 							= { "NumbericSuspicion.lua" },
		["lib/managers/hud/hudhitdirection"] 						= { "DamageIndicator.lua" },
		["lib/managers/hud/hudwaitinglegend"] 						= { "CustomHUD.lua" },
		["lib/managers/enemymanager"] 								= { "GameInfoManager.lua", "VanillaHUD.lua" },
		["lib/managers/group_ai_states/groupaistatebase"] 			= { "GameInfoManager.lua", "PacifiedCivs.lua", "DownCounter.lua" },
		["lib/managers/missionassetsmanager"] 						= { "BuyAllAsset.lua" },
		["lib/managers/menu/blackmarketgui"] 						= { "MenuTweaks.lua" },
		["lib/managers/menu/contractboxgui"]						= { "MenuTweaks.lua", "EnhancedCrewLoadout.lua" },
		["lib/managers/menu/crimespreecontractboxgui"] 				= { "EnhancedCrewLoadout.lua" },
		["lib/managers/menu/crimespreedetailsmenucomponent"]		= { "EnhancedCrewLoadout.lua" },
		["lib/managers/menu/missionbriefinggui"]					= { "BuyAllAsset.lua", "EnhancedCrewLoadout.lua", "ProfileMenu.lua" },
		["lib/managers/menu/multiprofileitemgui"]					= { "ProfileMenu.lua" },
		["lib/managers/menu/stageendscreengui"] 					= { "MenuTweaks.lua", "Scripts.lua" },
		["lib/managers/menu/lootdropscreengui"] 					= { "MenuTweaks.lua" },
		["lib/managers/menu/skilltreeguinew"] 						= { "MenuTweaks.lua" },
		["lib/managers/menu/playerinventorygui"]					= { "ProfileMenu.lua" },
		["lib/managers/menu/renderers/menunodeskillswitchgui"] 		= { "MenuTweaks.lua", "ProfileMenu.lua"  },
		["lib/managers/objectinteractionmanager"] 					= { "GameInfoManager.lua", "Scripts.lua", "Interaction.lua" },
		["lib/managers/player/smokescreeneffect"] 					= { "GameInfoManager.lua" },
		["lib/modifiers/boosts/gagemodifiermeleeinvincibility"] 	= { "GameInfoManager.lua" },
		["lib/modifiers/boosts/gagemodifierlifesteal"] 				= { "GameInfoManager.lua" },
		["lib/network/handlers/unitnetworkhandler"] 				= { "GameInfoManager.lua", "NetworkHandler.lua", "DownCounter.lua" },
		["lib/units/props/timergui"] 								= { "GameInfoManager.lua" },
		["lib/units/props/digitalgui"] 								= { "GameInfoManager.lua" },
		["lib/units/props/drill"] 									= { "GameInfoManager.lua" },
		["lib/units/props/securitylockgui"] 						= { "GameInfoManager.lua" },
		["lib/units/civilians/civiliandamage"] 						= { "Scripts.lua", "DamagePopupWolf.lua" },
		["lib/units/enemies/cop/copdamage"] 						= { "GameInfoManager.lua", "KillCounter.lua", "DamagePopup.lua", "DamagePopupWolf.lua", "Test8.lua", "Scripts.lua" },
		["lib/units/cameras/fpcameraplayerbase"] 					= { "WeaponGadgets.lua" },
		["lib/units/equipment/ammo_bag/ammobagbase"] 				= { "GameInfoManager.lua" },
		["lib/units/equipment/bodybags_bag/bodybagsbagbase"] 		= { "GameInfoManager.lua" },
		["lib/units/equipment/doctor_bag/doctorbagbase"] 			= { "DownCounter.lua", "GameInfoManager.lua" },
		["lib/units/equipment/first_aid_kit/firstaidkitbase"] 		= { "GameInfoManager.lua" },
		["lib/units/equipment/ecm_jammer/ecmjammerbase"] 			= { "GameInfoManager.lua", "EquipmentTweaks.lua" },
		["lib/units/equipment/grenade_crate/grenadecratebase"] 		= { "GameInfoManager.lua" },
		["lib/units/equipment/sentry_gun/sentrygunbase"] 			= { "GameInfoManager.lua", "KillCounter.lua" },
		["lib/units/equipment/sentry_gun/sentrygundamage"] 			= { "GameInfoManager.lua" },
		["lib/units/interactions/interactionext"] 					= { "GameInfoManager.lua", "Interaction.lua", "EquipmentTweaks.lua" },
		["lib/units/weapons/akimboweaponbase"] 						= { "BurstFire.lua" },
		["lib/units/weapons/akimboshotgunbase"] 					= { "BurstFire.lua" },
		["lib/units/weapons/sentrygunweapon"] 						= { "GameInfoManager.lua", "EquipmentTweaks.lua", "WeaponGadgets.lua" },
		["lib/units/weapons/weapongadgetbase"]						= { "WeaponGadgets.lua" },
		["lib/units/weapons/weaponlaser"] 							= { "WeaponGadgets.lua" },
		["lib/units/weapons/weaponflashlight"] 						= { "WeaponGadgets.lua" },
		["lib/units/weapons/raycastweaponbase"] 					= { "Scripts.lua", "WeaponGadgets.lua" },
		["lib/units/weapons/newraycastweaponbase"] 					= { "WeaponGadgets.lua", "BurstFire.lua" },
		["lib/units/weapons/npcraycastweaponbase"]					= { "WeaponGadgets.lua" },
		["lib/units/weapons/newnpcraycastweaponbase"]				= { "WeaponGadgets.lua" },
		["lib/units/props/securitycamera"] 							= { "GameInfoManager.lua" },
		["lib/units/beings/player/playerdamage"] 					= { "GameInfoManager.lua", "DamageIndicator.lua", "VanillaHUD.lua" },
		["lib/units/beings/player/playermovement"] 					= { "GameInfoManager.lua", "VanillaHUD.lua" },
		["lib/units/beings/player/playerinventory"] 				= { "GameInfoManager.lua" },
		["lib/units/beings/player/huskplayermovement"] 				= { "DownCounter.lua" },
		["lib/units/beings/player/states/playercivilian"] 			= { "Interaction.lua" },
		["lib/units/beings/player/states/playerdriving"]			= { "Interaction.lua", "WeaponGadgets.lua" },
		["lib/units/beings/player/states/playerstandard"] 			= { "GameInfoManager.lua", "EnemyHealthCircle.lua", "Interaction.lua", "BurstFire.lua", "WeaponGadgets.lua", "VanillaHUD.lua", "EnemyHealthbarAlt.lua" },
		["lib/units/beings/player/states/playermaskoff"] 			= { "GameInfoManager.lua", "WeaponGadgets.lua", "Interaction.lua" },
		["lib/units/beings/player/states/playerbleedout"] 			= { "DownCounter.lua" },
		["lib/units/vehicles/vehicledamage"] 						= { "DamageIndicator.lua" },
		["lib/units/vehicles/vehicledrivingext"] 					= { "CustomWaypoints.lua" },
		["lib/utils/temporarypropertymanager"] 						= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractionbloodthirstbase"] 	= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractionexperthandling"] 	= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractionshockandawe"] 		= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractiondireneed"] 			= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractionunseenstrike"] 		= { "GameInfoManager.lua" },
		["lib/player_actions/skills/playeractiontriggerhappy"] 		= { "GameInfoManager.lua" },
		-- ["lib/player_actions/skills/playeractiontagteam"] 			= { "GameInfoManager.lua" },
		["lib/states/ingamedriving"] 								= { "DrivingHUD.lua" },
		["lib/states/ingamearrested"]								= { "EnemyHealthCircle.lua", "EnemyHealthbarAlt.lua" },
		["lib/states/ingamewaitingforplayers"] 						= { "MenuTweaks.lua" },
		["lib/tweak_data/tweakdata"] 								= { "MenuTweaks.lua" },
		["lib/tweak_data/guitweakdata"] 							= { "MenuTweaks.lua" },
		["lib/tweak_data/timespeedeffecttweakdata"] 				= { "Scripts.lua" },
		["core/lib/managers/menu/items/coremenuitemslider"] 		= { "MenuTweaks.lua" },
		["core/lib/managers/subtitle/coresubtitlepresenter"] 		= { "Scripts.lua" },
		["core/lib/managers/coreenvironmentcontrollermanager"] 		= { "Scripts.lua" },
		["lib/managers/menu/preplanningmapgui"]						= { "PrePlanManager.lua" },
		["lib/managers/hud/hudhitconfirm"] 							= { "Scripts.lua" },
		["lib/units/contourext"] 							        = { "Scripts.lua" },
		["lib/managers/menu/items/contractbrokerheistitem"]			= { "MenuTweaks.lua" },
		["lib/network/base/hostnetworksession"]			            = { "MenuTweaks.lua" },
		["lib/managers/hud/hudplayercustody"]			            = { "VanillaHUD.lua" },
		["lib/units/weapons/shotgun/shotgunbase"] 					= { "BurstFire.lua" },
		["lib/tweak_data/weapontweakdata"] 							= { "Scripts.lua", "BurstFire.lua" },
		["lib/tweak_data/levelstweakdata"]                          = { "Scripts.lua" },
		["lib/network/matchmaking/networkmatchmakingsteam"] 		= { "FastNet.lua" },
		["lib/managers/menu/nodes/menunodeserverlist"]				= { "FastNet.lua" },
		["lib/managers/menu/renderers/menunodetablegui"]			= { "FastNet.lua" },
		["lib/managers/hud/hudpresenter"]			            	= { "Scripts.lua" },
		["core/lib/managers/menu/reference_input/coremenuinput"]	= { "Scripts.lua" },
		["lib/managers/menu/menucomponentmanager"]					= { "MenuTweaks.lua" },
		["lib/network/matchmaking/networkmatchmakingepic"]			= {	"FastNet.lua" },

		--Utils and custom classes...
		["lib/entry"]												= { "Utils/QuickInputMenu.lua", "Utils/LoadoutPanel.lua", "Utils/OutlinedText.lua" },
		["lib/managers/systemmenumanager"] 							= { "Utils/InputDialog.lua" },
		["lib/managers/dialogs/specializationdialog"] 				= { "Utils/InputDialog.lua" },
		["lib/managers/menu/specializationboxgui"] 					= { "Utils/InputDialog.lua" },
	}

	function VHUDPlus:Reset()
		local default_lang = "english"
		for _, filename in pairs(file.GetFiles(self.mod_path .. "/loc/")) do
			local str = filename:match('^(.*).json$')
			if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
				default_lang = str
				break
			end
		end

		VHUDPlus.settings = {
			LANGUAGE 								= default_lang,
			CustomHUD = {
				ENABLED 							= false,
				VanillaCustom 						= true,
				WolfENABLED							= false,
				HUDTYPE								= 2,
				ENABLED_ENHANCED_OBJECTIVE			= false,
				DisableBlend						= false,
				PLAYER = {
					POSITION						= 2,		-- left (1), center (2) or right (3)
					SCALE 							= 1,		--Size of local Player HUD Panel
					OPACITY							= 0.85,
					NAME							= false,
					RANK							= false,
					TRUNCATE_TAGS					= false,
					CHARACTER						= false,
					STATUS							= true,
					EQUIPMENT						= true,
					SPECIAL_EQUIPMENT				= true,
					SPECIAL_EQUIPMENT_ROWS			= 3,
					CALLSIGN						= false,
					STAMINA							= true,
					DOWNCOUNTER						= true,
					NEWDOWNCOUNTER					= false,
					DETECTIONCOUNTER				= true,
					CARRY							= true,
					CONDITION_ICON_COLOR			= "white",
					ARMOR							= true,
					INSPIRE							= true,
					UNDERDOG						= true,
					BULLETSTORM						= true,
					HPS_METER						= true,
					HPS_REFRESH_RATE				= 1,
					SHOW_HPS_CURRENT				= true,
					CURRENT_HPS_TIMEOUT				= 5,
					SHOW_HPS_TOTAL					= true,
					WEAPON = {
						ICON						= 4,
						NAME						= 1,
						AMMO						= 4,
						FIREMODE					= 2,
					},
					KILLCOUNTER = {
						HIDE						= false,
						SHOW_SPECIAL_KILLS 			= true,
						SHOW_HEADSHOT_KILLS			= true,
						COLOR						= "yellow",
					},
					SHOW_ACCURACY					= true,
					SHOW_HP_AP_NUM					= false,
					HPALPHA							= 0.75,
					APALPHA							= 0.75,
				},
				TEAMMATE = {
					POSITION						= 1,		-- left (1), center (2) or right (3)
					SCALE 							= 0.8,		--Size of Teammates/AI's HUD Panels
					OPACITY							= 0.85,
					NAME							= true,
					RANK							= true,
					TRUNCATE_TAGS					= false,
					CHARACTER						= false,
					LATENCY							= true,
					STATUS							= true,
					EQUIPMENT						= true,
					SPECIAL_EQUIPMENT				= true,
					SPECIAL_EQUIPMENT_ROWS			= 3,
					CALLSIGN						= false,
					DOWNCOUNTER						= true,
					NEWDOWNCOUNTER					= false,
					DETECTIONCOUNTER				= true,
					CARRY							= true,
					CONDITION_ICON_COLOR			= "white",
					BUILD = {
						HIDE						= false,
						DURATION					= 15,
					},
					AI_COLOR = {
						USE							= false,
						COLOR						= "white",
					},
					WEAPON = {
						ICON						= 4,
						NAME						= 1,
						AMMO						= 4,
						FIREMODE					= 1,
					},
					INTERACTION = {
						HIDE					= false,		-- Show Interaction
						NUMBER					= true,
						TEXT					= true,
						MIN_DURATION			= 1,
					},
					KILLCOUNTER = {
						HIDE						= false,
						SHOW_SPECIAL_KILLS 			= true,
						SHOW_HEADSHOT_KILLS			= true,
						COLOR						= "yellow",
						SHOW_BOT_KILLS 				= true,
					},
					SHOW_HP_AP_NUM					= false,
					HPALPHA							= 0.75,
					APALPHA							= 0.75,
				},
				HUD_SCALE 						    = 1,
			},
			MISCHUD = {
				ENABLE_IFBG							= false,
				ENABLE_TIME_LEFT                    = true,
				MASK_INSTRUCT                       = true,
				HEADSHOT                            = true,
				JOKER_CONTOUR_NEW                   = false,
				INSPIRE_HINT                        = false,
                SWAN_SONG_EFFECT                    = true,
                KINGPIN_EFFECT                      = true,
				SUB_HEIGHT							= 600,
                SCALE                               = 1,
				SUB				                    = false,
				SHUFFLE_MUSIC                       = false,
				SHOOT_THROUGH_BOTS                  = true,
			},
			HUDChat = {
				ENABLED									= true,
				CHAT_WAIT_TIME							= 10,		--Time before chat fades out, 0 = never
				LINE_HEIGHT								= 15,		--Chat font Size
				WIDTH									= 380,		--Width of the chat window
				MAX_OUTPUT_LINES						= 8,		--Chat Output lines
				MAX_INPUT_LINES							= 5,		--Number of lines of text you can type
				COLORED_BG								= true,		--Colorize the line bg based on the message source
				SCROLLBAR_ALIGN							= 2,		--Alignment of the scroll bar (1 = left, 2 = right)
				SPAM_FILTER								= true,		--Filter PocoHud and NGBTO Chat Spam messages.
				HEISTTIMER								= true,
				Y_POS									= 112,
				X_POS_FIX								= 0,
				HEIGHT									= 100,
				USE_MOUSE								= true,
			},
			EnemyHealthbar = {
				ENABLED 								= true,		--Show healthbars
				SHOW_VEHICLE							= true,		--Show Healthbar for vehicles
				SHOW_POINTER		 					= false,	--Show pointer near the Healthbar, pointing at Healthbar owner
				SCALE									= 75,
				ENEMY_HEALTH_VERTICAL_OFFSET			= 110,
				ENEMY_HEALTH_HORIZONTAL_OFFSET			= 0,
				ENEMY_TEXT_SIZE							= 30,
				IGNORE_CIVILIAN_HEALTH					= true,
				IGNORE_TEAM_AI_HEALTH					= true,
				ENABLED_ALT								= false,
				ENEMY_KILL_COLOR						= "red",
				ENEMY_HURT_COLOR						= "orange",
				SHOW_MULTIPLIED_ENEMY_HEALTH			= true,
			},
			DamageIndicator = {
				ENABLED									= true,
				SIZE									= 150,
				DURATION								= 2,
				MAX_AMOUNT								= 10,
				SHIELD_COLOR							= "gray",
				HEALTH_COLOR							= "red",
				CRIT_COLOR								= "purple",
				VEHICLE_COLOR							= "yellow",
				FRIENDLY_FIRE_COLOR						= "orange",
			},
			DamagePopup = {
				LINUXCOMPAT								= true,
			},
			DamagePopupNew = {
				DAMAGE_KILL_FLASH_SPD					= 4,
				DURATION	 							= 3.5,
				SCALE									= 50,
				FATAL_HIT_CHG_PER_TICK					= 0.5,
				HIT_CHG_PER_TICK						= 0.1,
				DAMAGE_VERT_OFFSET	 					= 60,
				SHOW_DAMAGE_PER_HIT	 					= true,
				COLOR									= "white",
				HEADSHOT_COLOR							= "orange",
				SHOW_RAINBOW_POPUPS                     = false,
				CRITICAL_COLOR 							= "light_purple",
				SHOW_DAMAGE_POPUP_ALT					= true,
				GLOW_COLOR 								= "red",
				DISPLAY_MODE							= 1,
				SKULL_SCALE								= 1.2,
				SKULL_ALIGN								= 1,			-- left (1) or right (2)
				HEIGHT	 								= 20,
				ALPHA	 								= 1,
				SCALE_ALT 								= 1,
			},
			AssaultBanner = {
				USE_CENTER_ASSAULT						= true,
				USE_ADV_ASSAULT							= true,
				WAVE_COUNTER                            = true,
				MUI_ASSAULT_FIX							= false,
				HIDE_CASING_MODE_PANEL					= false,
			},
			HUDSuspicion = {
				ENABLED									= true,
				SCALE									= 0.8,
				SHOW_PERCENTAGE							= true,
				SHOW_PERCENTAGE_OUTLINE					= true,
				SHOW_BARS								= true,
				SHOW_PACIFIED_CIVILIANS					= true,
				SHOW_PACIFIED_CIVILIANS_WOLFDEFAULT     = true,
				SHOW_PACIFIED_CIVILIANS_ALT_ICON        = false,
				REMOVE_ANSWERED_PAGER_CONTOUR 			= true,
				CUSTOM_HUDS_SUPPORT						= false,
			},
			DrivingHUD = {
				ENABLED									= true,		--Show DrivingHUD Panel
				SCALE									= 1,
				SHOW_VEHICLE 							= true,		--Show Vehicle and Teammate Mask Images
				SHOW_HEALTH								= true,
				SHOW_LOOT								= true,
				SHOW_PASSENGERS							= true,
				SHOW_GEAR								= true,
				SHOW_SPEED								= true,
				SHOW_RPM								= true,
				SPEED_IN_MPH 							= false,	--Display Speed in mph
			},
			TabStats = {
				ENABLED									= true,
				CLOCK_MODE								= 3,		-- 1 = disabled, 2 = 12h, 3 = 24h
				COLOR		 							= "rainbow",
				FONT_SIZE		 						= 18,
				SHOW_MASK								= true,
				SHOW_LOOT_NUMBERS						= true,
			},
			CrewLoadout = {
				REPLACE_IN_BRIEFING 					= true,
				SHOW_IN_LOBBY							= true,
				SHOW_IN_CS_LOBBY 						= true,
				SHOW_ON_STATS_PANEL						= true,
                REPLACE_PROFILE_MENU                    = true,
				ENABLE_PEER_PING                        = true,
			},
			HUDList = {
				ENABLED	 								= true,
				PD2StyleBox								= false,
				ORIGNIAL_HOSTAGE_BOX                    = false,
				ENABLE_BG								= false,
				right_list_height_offset				= 50,
				left_list_height_offset					= 60,
				buff_list_height_offset					= 90,
				buff_list_x_offset						= 2,
				mui_buff_fix							= false,
				right_list_scale						= 1,
				left_list_scale							= 1,
				buff_list_scale							= 1,
				right_list_progress_alpha 				= 0.4,
				left_list_progress_alpha 				= 0.4,
				buff_list_progress_alpha 				= 1.0,
				right_list_bg_alpha						= 1.0,
				left_list_bg_alpha						= 1.0,
				list_color	 							= "white",		--Left and Right List font color
				list_color_bg	 						= "black",		--Left and Right List BG color
				civilian_color 							= "white", 		--EnemyCounter Civillian and Hostage icon color
				thug_color 								= "white",		--EnemyCounter Thug and Mobster icon color
				enemy_color 							= "white",		--EnemyCounter Cop and Specials icon color
				guard_color								= "white",
				special_color 							= "white",
				turret_color							= "white",
				shield_color							= "white",
				tank_color								= "white",
				sniper_color							= "white",
				spooc_color								= "white",
				taser_color								= "white",
				medic_color								= "white",
				phalanx_color							= "white",
				buff_icon_color_standard				= "white",
				buff_icon_color_buff					= "white",
				buff_icon_color_debuff_fix				= "debuff",
				buff_icon_color_team_fix				= "team",
				left_list_color							= "white",
				left_list_color_bg						= "black",
				jokers_color							= "white",
				pagers_color							= "white",
				cam_color								= "green",
				bodybags_color							= "white",
				corpse_color							= "white",
				loot_color								= "white",
				special_items_color						= "white",
				timers_color							= "white",
				equipment_color							= "white",
				minions_info_color						= "white",
				pagers_timer_color						= "white",
				ecms_color								= "white",
				ecm_feedback_color						= "white",
				tape_loop_color							= "white",
				LEFT_LIST = {
					show_timers 							= true,     --Drills, time locks, hacking etc.
					show_ammo_bags							= true,  	--Deployables (ammo)
					show_doc_bags							= true,  	--Deployables (doc bags)
					show_first_aid_kits						= false,	--Deployables (first_aid_kits)
					show_body_bags							= true,  	--Deployables (body bags)
					show_grenade_crates						= true,  	--Deployables (grenades)
					show_sentries 							= true,   	--Deployable sentries
					show_ecms 								= true,		--Active ECMs
					show_ecm_retrigger 						= true,  	--Countdown for players own ECM feedback retrigger delay
					show_minions 							= true,  	--Converted enemies, type and health
						show_own_minions_only				= true,	--Only show player-owned minions
					show_pagers 							= true,  	--Show currently active pagers
					show_tape_loop 							= true,  	--Show active tape loop duration
					show_jokers_health_bar					= true,
					show_jokers_kill_counter				= true,
				},
				RIGHT_LIST = {
					show_enemies 							= true,		--Currently spawned enemies
						aggregate_enemies 					= false,  	--Don't split enemies on type; use a single entry for all
					show_turrets 							= true,    	--Show active SWAT turrets
					show_civilians 							= true,  	--Currently spawned, untied civs
					show_hostages 							= true,   	--Currently tied civilian and dominated cops
						aggregate_hostages					= false,
					show_minion_count 						= true,     --Current number of jokered enemies
					show_pager_count 						= true,		--Show number of triggered pagers (only counts pagers triggered while you were present)
					show_cam_count							= true,
					show_bodybags_count						= true,
					show_corpse_count						= false,
					show_loot 								= true,     --Show spawned and active loot bags/piles (may not be shown if certain mission parameters has not been met)
						aggregate_loot		 				= false, 	--Don't split loot on type; use a single entry for all
						separate_bagged_loot		 		= true,     --Show bagged loot as a separate value
						show_aggregate_and_total			= false,
						show_potential_loot					= false,
					show_special_pickups 					= true,    	--Show number of special equipment/items
					SHOW_PICKUP_CATEGORIES = {
					        keycard                             = true,
						crowbar                             = true,
						planks                              = true,
						mission_pickups 					= true,
						gage_packages						= true,
						collectables 						= true,
						valuables 							= true,
					}

				},
				BUFF_LIST = {
					show_buffs 								= true,     --Active effects (buffs/debuffs). Also see HUDList.BuffItemBase.IGNORED_BUFFS table to ignore specific buffs that you don't want listed, or enable some of those not shown by default
					damage_increase							= true,
					damage_reduction						= true,
					melee_damage_increase					= true,
					passive_health_regen 					= true,
					total_dodge_chance 						= true,
					PLAYER_ACTIONS = {
					        anarchist_armor_regeneration            = false,
					        standard_armor_regeneration             = false,
					        weapon_charge                           = false,
					        melee_charge                            = false,
					        reload                                  = false,
					        interact                                = false,
					},
					MASTERMIND_BUFFS = {
						forced_friendship					= true,
						aggressive_reload_aced				= true,
						ammo_efficiency						= true,
						combat_medic						= true,
						combat_medic_passive				= false,
						hostage_taker						= false,
						inspire								= true,
						painkiller							= false,
						partner_in_crime					= false,
						quick_fix							= false,
						uppers								= true,
						inspire_debuff						= true,
						inspire_revive_debuff				= true,
					},
					ENFORCER_BUFFS = {
						bulletproof							= true,
						bullet_storm						= true,
						die_hard							= false,
						overkill							= false,
						underdog							= false,
						bullseye_debuff						= true,
					},
					TECHNICIAN_BUFFS = {
						lock_n_load							= true,
					},
					GHOST_BUFFS = {
						dire_need							= true,
						second_wind							= true,
						sixth_sense							= true,
						old_sixth_sense						= false,
						unseen_strike						= true,
					},
					FUGITIVE_BUFFS = {
						berserker							= true,
						bloodthirst_basic					= false,
						bloodthirst_aced					= true,
						desperado							= true,
						frenzy			 					= false,
						messiah								= true,
						running_from_death					= true,
						swan_song							= false,
						trigger_happy						= false,
						up_you_go							= false,
					},
					PERK_BUFFS = {
						armor_break_invulnerable			= true,
						armor_break_invulnerable_debuff		= true,
						anarchist_armor_recovery_debuff		= true,
						ammo_give_out_debuff				= true,
						armorer								= true,
						biker								= true,
						chico_injector						= false,
						close_contact						= true,
						crew_chief							= true,
						damage_control_debuff 				= false,
						delayed_damage 						= true,
						hostage_situation					= false,
						medical_supplies_debuff				= true,
						grinder								= true,
						tooth_and_claw						= true,
						life_drain_debuff					= true,
						melee_stack_damage					= false,
						overdog								= false,
						maniac								= false,
						muscle_regen						= false,
						pocket_ecm_jammer 					= true,
						pocket_ecm_kill_dodge 				= false,
						sicario_dodge 						= true,
						smoke_screen_grenade 				= true,
						sociopath_debuff					= true,
						tag_team 							= true,
						yakuza								= false,
						copr_ability						= true,
						copycat_health_invul				= true,
						copycat_health_shot					= true,
					},
					GAGE_BOOSTS = {
						invulnerable_buff					= true,
						life_steal_debuff					= true,
					},
					AI_SKILLS = {
						crew_inspire_debuff 				= true,
						crew_throwable_regen 				= true,
						crew_health_regen 					= false,
					},
				},
			},
			CustomWaypoints = {
				WAYPOINTS_COLOR_ENABLE					= true,
				WAYPOINTS_SCALE							= 1,
				WAYPOINTS_COLOR							= "white",
				SHOW_AMMO_BAG 							= true,
				SHOW_DOC_BAG		 					= true,
				SHOW_FIRST_AID_KIT						= false,
				SHOW_BODY_BAG			 				= true,
				SHOW_GRENADE_CRATE			 			= true,
				SHOW_SENTRIES			 				= false,
				SHOW_ECMS								= false,
				SHOW_TIMERS			 					= true,
				SHOW_MINIONS							= true,
				ENABLE_JOKER_FLOATING_NAME			    = true,
				ENABLE_JOKER_FLOATING_HP			    = true,
				ENABLE_JOKER_FLOATING_KILLS			    = true,
				SHOW_PAGER								= false,
				SHOW_SPECIAL_EQUIPMENT					= false,
				LOOT = {
					SHOW								= true,
					ICON								= true,
					OFFSET								= 15,
					BAGGED_OFFSET						= 30,
					ANGLE								= 25,
				},
			},
			INTERACTION = {
				RESTORATION								= true,
				LOCK_MODE 								= 3,			--Disabled (1, Lock interaction, if MIN_TIMER_DURATION is longer then total interaction time (2), or current interaction time(3)
				MIN_TIMER_DURATION 						= 5, 			--Min interaction duration (in seconds) for the toggle behavior to activate
				EQUIPMENT_PRESS_INTERRUPT 				= true, 		--Use the equipment key ('G') to toggle off active interactions
				SHOW_LOCK_INDICATOR						= true,
				SHOW_CIRCLE								= true,
				CIRCLE_SCALE							= 0.8,
				TEXT_SCALE								= 0.8,
				SHOW_INTERRUPT_HINT						= true,
				SHOW_TIME_REMAINING 					= true,			--Show remaining Time in the Interaction-Circle
				SHOW_TIME_REMAINING_OUTLINE				= true,		--Show black outline around remaining Time text
				GRADIENT_COLOR_START					= "white",		--Color, which the timer starts with
				GRADIENT_COLOR							= "light_green",--Color, which the timer reaches on completition
				TIMER_SCALE								= 1,			--Timer scale (also takes CIRCLE_SCALE into account)
				SHOW_RELOAD								= true,
				SHOW_MELEE								= true,
				SUPRESS_NADES_STEALTH					= true,
				HOLD2PICK								= true,
				CUSTOM_HUDS_SUPPORT						= false,
				DRILL_ICONS                             = false,
				HIDEINTERACTIONINSTRUCTIONS				= true,
				HIDEBAGVALUE							= false,
				DRILL_ICONS_X_POS						= 0,
				DRILL_ICONS_Y_POS						= 90,
				DRILL_ICONS_SCALE						= 0.8,
			},
			GADGETS = {
				LASER_AUTO_ON 							= true,
				laser = {
					player = {
						beam 							= { enabled = true, r = 0, g = 1, b = 0, a = 0.15 },
						glow 							= { match_beam = true, r = 0, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 0, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					team = {
						beam 							= { enabled = true, r = 0, g = 1, b = 0, a = 0.05 },
						glow 							= { match_beam = true, r = 0, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 0, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					player_sentry = {
						beam 							= { enabled = true, r = 0, g = 1, b = 0, a = 0.05 },
						glow 							= { match_beam = true, r = 0, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 0, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					team_sentry = {
						beam 							= { enabled = true, r = 0, g = 1, b = 0, a = 0.05 },
						glow 							= { match_beam = true, r = 0, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 0, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					cop_sniper = {
						beam 							= { enabled = true, r = 1, g = 0, b = 0, a = 0.15 },
						glow 							= { match_beam = true, r = 1, g = 0, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 1, g = 0, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					turret_module_active = {
						beam 							= { enabled = true, r = 1, g = 0, b = 0, a = 0.15 },
						glow 							= { match_beam = true, r = 1, g = 0, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 1, g = 0, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					turret_module_rearming = {
						beam 							= { enabled = true, r = 1, g = 1, b = 0, a = 0.11 },
						glow 							= { match_beam = true, r = 1, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 1, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					turret_module_mad = {
						beam 							= { enabled = true, r = 0, g = 1, b = 0, a = 0.15 },
						glow 							= { match_beam = true, r = 0, g = 1, b = 0, a = 0.02 },
						dot 							= { match_beam = true, r = 0, g = 1, b = 0, a = 1 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
				},
				flashlight = {
					player = {
						light 							= { enabled = true, r = 1, g = 1, b = 1, brightness = 1, range = 10, angle = 60 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
					team = {
						light 							= { enabled = true, r = 1, g = 1, b = 1, brightness = 1, range = 10, angle = 60 },
						pulse 							= { enabled = false, min = 0.5, max = 2, frequency = 0.25 },
						rainbow 						= { enabled = false, frequency = 0.25 },
					},
				},
				SHOW_ANGELED_SIGHT						= true,
			},
			EQUIPMENT = {
				SENTRY_AUTO_AP 							= true,
				ECM_FEEDBACK_STEALTH_DISABLED			= true,
				SHAPED_CHARGE_STEALTH_DISABLED			= true,
				KEYCARD_DOORS_DISABLED					= true,
				ENABLE_BURSTMODE						= true,
				REPLACE_JOKER                           = true,
			},
			INVENTORY = {
				SHOW_WEAPON_NAMES 						= true,
				SHOW_WEAPON_MINI_ICONS 					= true,
				USE_REAL_WEAPON_NAMES 					= false,
				SHOW_SKILL_NAMES 						= true,
				SHOW_CUSTOM_INVENTORY_PAGES_NAMES 		= true,
				CUSTOM_TAB_NAMES = {
					primaries 							= { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
					secondaries 						= { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
					masks 								= { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
					melee_weapons 						= { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
				},
				SHOW_HEAT 								= true,
				SHOW_REDUCTION                          = true,
				crnt_colorize							= false,
				crnt_align								= false,
				crnt_size								= 0.9,
				crnt_sort								= true,
				FastNetSortHeistsA						= false,
				FastNETENABLED							= true,
				FASTNETSTANDARDSCENE					= false,
				SHOW_EMPTY_LOBBY						= false,
				CONFIRM_DIALOGS                     	= false,
				SAVE_FILTERS							= true,
				SHOW_SILENT_WEAPONS						= true,
				HiDE_CONTENT_NEWS						= false,
			},
			SkipIt = {
				SKIP_BLACKSCREEN 						= true,		--Skip the blackscreen on mission start
				INSTANT_RESTART							= false,
				STAT_SCREEN_SPEEDUP						= false,
				STAT_SCREEN_DELAY 						= 5,		--Skip the experience screen after X seconds
				AUTOPICK_CARD 							= true,		--Automatically pick a card on lootscreen
				AUTOPICK_CARD_SPECIFIC 					= 4,		--left, center, right, random
				LOOT_SCREEN_DELAY 						= 3,		--Skip the loot screen after X seconds
				NO_SLOWMOTION 							= true,		--Disable mask-up and downed slow motion
			},
			LOBBY_SETTINGS = {
				job_plan = -1,
				kick_option = 1,
				permission = "public",
				reputation_permission = 0,
				drop_in_option = 1,
				team_ai = true,
				team_ai_option = 1,
				auto_kick = true,
				difficulty = "normal",
				one_down = false,
			},
		}
	end

	function VHUDPlus:OutlineText(panel, bg, txt)
        bg.name = nil
        local bgs = {}
        for i = 1, 4 do
            table.insert(bgs, panel:text(bg))
        end
        bgs[1]:set_x(txt:x() - 1)
        bgs[1]:set_y(txt:y() - 1)
        bgs[2]:set_x(txt:x() + 1)
        bgs[2]:set_y(txt:y() - 1)
        bgs[3]:set_x(txt:x() - 1)
        bgs[3]:set_y(txt:y() + 1)
        bgs[4]:set_x(txt:x() + 1)
        bgs[4]:set_y(txt:y() + 1)
        return bgs
    end

	function VHUDPlus:print_log(...)
		local LOG_MODES = self:getTweakEntry("LOG_MODE", "table", {})
		local params = {...}
		local msg_type, text = table.remove(params, #params), table.remove(params, 1)
		if msg_type and LOG_MODES[tostring(msg_type)] then
			if type(text) == "table" or type(text) == "userdata" then
				local function log_table(userdata)
					local text = ""
					for id, data in pairs(userdata) do
						if type(data) == "table" then
							log( id .. " = {")
							log_table(data)
							log("}")
						elseif type(data) ~= "function" then
							log( id .. " = " .. tostring(data) .. "")
						else
							log( "function " .. id .. "(...)")
						end
					end
				end
				if not text[1] or type(text[1]) ~= "string" then
					log(string.format("[VHUDPlus] %s:", string.upper(type(msg_type))))
					log_table(text)
					return
				else
					text = string.format(unpack(text))
				end
			elseif type(text) == "function" then
				msg_type = "error"
				text = "Cannot log function... "
			elseif type(text) == "string" then
				text = string.format(text, unpack(params or {}))
			end
			text = string.format("[VHUDPlus] %s: %s", string.upper(msg_type), text)
			log(text)
			if LOG_MODES.to_console and con and con.print and con.error then
				local t = Application:time()
				text = string.format("%02d:%06.3f\t>\t%s", math.floor(t/60), t%60, text)
				if tostring(msg_type) == "info" then
					con:print(text)
				else
					con:error(text)
				end
			end
		end
	end

	function VHUDPlus:Load()
		local corrupted = false
		local file = io.open(self.new_settings_path, "r")
		local old_vanilla_save = io.open(self.settings_path, "r")
		local wolf_file = io.open(self.wolf_settings_path, "r")
		if file then
			local function parse_settings(table_dst, table_src, setting_path)
				for k, v in pairs(table_src) do
					if type(table_dst[k]) == type(v) then
						if type(v) == "table" then
							table.insert(setting_path, k)
							parse_settings(table_dst[k], v, setting_path)
							table.remove(setting_path, #setting_path)
						else
							table_dst[k] = v
						end
					else
						self:print_log("Error while loading, Setting types don't match (%s->%s)", self:SafeTableConcat(setting_path, "->") or "", k or "N/A", "error")
						corrupted = corrupted or true
					end
				end
			end

			local settings = json.decode(file:read("*all"))
			parse_settings(self.settings, settings, {})
			file:close()
		elseif wolf_file and not old_vanilla_save then
			local function parse_settings(table_dst, table_src, setting_path)
				for k, v in pairs(table_src) do
					if type(table_dst[k]) == type(v) then
						if type(v) == "table" then
							table.insert(setting_path, k)
							parse_settings(table_dst[k], v, setting_path)
							table.remove(setting_path, #setting_path)
						else
							table_dst[k] = v
						end
					else
						self:print_log("Error while loading, Setting types don't match (%s->%s)", self:SafeTableConcat(setting_path, "->") or "", k or "N/A", "error")
						corrupted = corrupted or true
					end
				end
			end
			local wolf_settings = json.decode(wolf_file:read("*all"))
			parse_settings(self.settings, wolf_settings, {})
			if VHUDPlus:getSetting({"CustomHUD", "ENABLED"}, true) then
				VHUDPlus:setSetting({"CustomHUD", "HUDTYPE"}, 3)
				VHUDPlus:setSetting({"CustomHUD", "ENABLED_ENHANCED_OBJECTIVE"}, true)
			end
			if VHUDPlus:getSetting({"DamagePopupNew", "DISPLAY_MODE"}, 2) then
				VHUDPlus:setSetting({"DamagePopupNew", "SHOW_DAMAGE_POPUP_ALT"}, false)
				VHUDPlus:setSetting({"DamagePopupNew", "DISPLAY_MODE"}, 2)
			end
			if VHUDPlus:getSetting({"DamagePopupNew", "DISPLAY_MODE"}, 3) then
				VHUDPlus:setSetting({"DamagePopupNew", "DISPLAY_MODE"}, 3)
				VHUDPlus:setSetting({"DamagePopupNew", "SHOW_DAMAGE_POPUP_ALT"}, false)
			end
			if VHUDPlus:getSetting({"EnemyHealthbar", "ENABLED"}, true) then
				VHUDPlus:setSetting({"EnemyHealthbar", "ENABLED"}, false)
				VHUDPlus:setSetting({"EnemyHealthbar", "ENABLED_ALT"}, true)
			end
			wolf_file:close()
		elseif old_vanilla_save then
			local function parse_settings(table_dst, table_src, setting_path)
				for k, v in pairs(table_src) do
					if type(table_dst[k]) == type(v) then
						if type(v) == "table" then
							table.insert(setting_path, k)
							parse_settings(table_dst[k], v, setting_path)
							table.remove(setting_path, #setting_path)
						else
							table_dst[k] = v
						end
					else
						self:print_log("Error while loading, Setting types don't match (%s->%s)", self:SafeTableConcat(setting_path, "->") or "", k or "N/A", "error")
						corrupted = corrupted or true
					end
				end
			end
			local old_vanilla_settings = json.decode(old_vanilla_save:read("*all"))
			parse_settings(self.settings, old_vanilla_settings, {})
			if not VHUDPlus:getSetting({"CustomHUD", "ENABLED"}, true) then
				VHUDPlus:setSetting({"CustomHUD", "HUDTYPE"}, 1)
			end
			if VHUDPlus:getSetting({"DamagePopupNew", "SHOW_DAMAGE_POPUP_ALT"}, true) then
				VHUDPlus:setSetting({"DamagePopupNew", "DISPLAY_MODE"}, 1)
			end
			old_vanilla_save:close()

		else
			self:print_log("Error while loading, settings file could not be opened (" .. self.new_settings_path .. ")", "error")
		end
		if corrupted then
			self:Save()
			self:print_log("Settings file appears to be corrupted, resaving...", "error")
		end
	end

	function VHUDPlus:Save()
		if table.size(self.settings or {}) > 0 then
			local file = io.open(self.new_settings_path, "w+")
			if file then
				file:write(json.encode(self.settings))
				file:close()
			else
				self:print_log("Error while saving, settings file could not be opened (" .. self.new_settings_path .. ")", "error")
			end
		else
			self:print_log("Error while saving, settings table appears to be empty...", "error")
		end
	end

	function VHUDPlus:createDirectory(path)
		local current = ""
		path = Application:nice_path(path, true):gsub("\\", "/")

		for folder in string.gmatch(path, "([^/]*)/") do
			current = Application:nice_path(current .. folder, true)

			if not self:DirectoryExists(current) then
				if SystemFS and SystemFS.make_dir then
					SystemFS:make_dir(current)
				elseif file and file.CreateDirectory then
					file.CreateDirectory(current)
				end
			end
		end

		return self:DirectoryExists(path)
	end

	function VHUDPlus:DirectoryExists(path)
		if SystemFS and SystemFS.exists then
			return SystemFS:exists(path)
		elseif file and file.DirectoryExists then
			log("")	-- For some weird reason the function below always returns true if we don't log anything previously...
			return file.DirectoryExists(path)
		end
	end

	function VHUDPlus:getVersion()
        local mod = BLT and BLT.Mods:GetMod(VHUDPlus.identifier or "")
		return tostring(mod and mod:GetVersion() or "(n/a)")
	end

	function VHUDPlus:SafeTableConcat(tbl, str)
		local res
		for i = 1, #tbl do
			local val = tbl[i] and tostring(tbl[i]) or "[nil]"
			res = res and res .. str .. val or val
		end
		return res
	end

	function VHUDPlus:getSetting(id_table, default)
		if type(id_table) == "table" then
			local entry = self.settings
			for i = 1, #id_table do
				entry = entry[id_table[i]]
				if entry == nil then
					self:print_log("Requested setting doesn't exists!  (id='" .. self:SafeTableConcat(id_table, "->") .. "', type='" .. (default and type(default) or "n/a") .. "') ", "error")
					return default
				end
			end
			return entry
		end
		return default
	end

	function VHUDPlus:setSetting(id_table, value)
		local entry = self.settings
		for i = 1, (#id_table-1) do
			entry = entry[id_table[i]]
			if entry == nil then
				return false
			end
		end

		if type(entry[id_table[#id_table]]) == type(value) then
			entry[id_table[#id_table]] = value
			return true
		end
	end

	function VHUDPlus:getColorSetting(id_table, default, ...)
		local color_name = self:getSetting(id_table, default)
		return self:getColor(color_name, ...) or default and self:getColor(default, ...)
	end

	function VHUDPlus:getColorID(name)
		if self.tweak_data and type(name) == "string" then
			for i, data in ipairs(self:getTweakEntry("color_table", "table")) do
				if name == data.name then
					return i
				end
			end
		end
	end

	function VHUDPlus:getColor(name, ...)
		if self.tweak_data and type(name) == "string" then
			for i, data in ipairs(self:getTweakEntry("color_table", "table")) do
				if name == data.name then
					return data.color and Color(data.color) or data.color_func and data.color_func(...) or nil
				end
			end
		end
	end

	function VHUDPlus:getTweakEntry(id, val_type, default)
		local value = self.tweak_data[id]
		if value ~= nil and (not val_type or type(value) == val_type) then
			return value
		else
			if default == nil then
				if val_type == "number" then -- Try to prevent crash by giving default value
					default = 1
				elseif val_type == "boolean" then
					default = false
				elseif val_type == "string" then
					default = ""
				elseif val_type == "table" then
					default = {}
				end
			end
			self.tweak_data[id] = default
			self:print_log("Requested tweak_entry doesn't exists!  (id='" .. id .. "', type='" .. tostring(val_type) .. "') ", "error")
			return default
		end
	end

	function VHUDPlus:getCharacterName(character_id, to_upper)
		local name = character_id or "UNKNOWN"
		local character_names = self:getTweakEntry("CHARACTER_NAMES", "table", {})
		local name_table = character_names and character_names[character_id]
		if name_table then
			local level_id = managers.job and managers.job:current_level_id() or "default"
			--VHUDPlus:print_log(level_id, "error")
			local name_id = name_table[level_id] or name_table.default
			name = to_upper and managers.localization:to_upper_text(name_id) or managers.localization:text(name_id)
		end

		return name
	end

	function VHUDPlus:truncateNameTag(name)
		local truncated_name = name:gsub('^%b[]',''):gsub('^%b==',''):gsub('^%s*(.-)%s*$','%1')
		if truncated_name:len() > 0 and name ~= truncated_name then
			name = utf8.char(1031) .. truncated_name
		end
		return name
	end

	if not VHUDPlus.tweak_path then		-- Populate tweak data
		local tweak_path = string.format("%s%s", VHUDPlus.save_path, VHUDPlus.tweak_file)
		if not io.file_is_readable(tweak_path) then
			tweak_path = string.format("%s%s", VHUDPlus.mod_path, VHUDPlus.tweak_file)
		end
		if io.file_is_readable(tweak_path) then
			dofile(tweak_path)
			VHUDPlus.tweak_data = WolfHUDTweakData:new()
		else
			VHUDPlus:print_log(string.format("Tweak Data file couldn't be found! (%s)", tweak_path), "error")
		end
	end

	-- Table with all menu IDs
	VHUDPlus.menu_ids = VHUDPlus.menu_ids or {}

	function VHUDPlus:OptionChanged()
		self:Save()
		if managers and managers.hud and managers.hud._enemy_target then
			managers.hud._enemy_target:update()
		end
	end

	function VHUDPlus:LoadTextures()
		for _, file in pairs(file.GetFiles(VHUDPlus.mod_path.. "assets/guis/textures/")) do
			DB:create_entry(Idstring("texture"), Idstring("assets/guis/textures/".. file:gsub(".texture", "")), VHUDPlus.mod_path.. "assets/guis/textures/".. file)
		end
	end

	function VHUDPlus:SaveRoom(room_id)
		local file = io.open(self.reconnect_data_path, "w+")
		if file then
			file:write(room_id)
			file:close()
		end
	end

	function VHUDPlus:Reconnect()
        local room_id
		local file = io.open(self.reconnect_data_path, "r")
		if file then
			room_id = file:read("*all")
			file:close()
		end
		local lobby_id = VHUDPlus.last_lobby_id or nil
		if lobby_id then
			managers.network.matchmake:join_server(lobby_id)
		else
			managers.menu:show_failed_joining_dialog()
		end
    end

	function VHUDPlus:apply_lobby_filter(diff_filter)
        if diff_filter > 8 then
            managers.network.matchmake:add_lobby_filter("difficulty", diff_filter - 6, "equalto_or_greater_than")
        end
    end

    function VHUDPlus:fix_preset_difficulties(presets)
        for _, preset in pairs(presets or {}) do
            if preset.difficulty_id > 8 then
                local min_difficulty = preset.difficulty_id - 6
                preset.difficulty_id = math.round(min_difficulty + math.rand(8 - min_difficulty))
                preset.difficulty = tweak_data:index_to_difficulty(preset.difficulty_id)
            end
        end
    end

	--callback functions to apply changed settings on the fly
	if not VHUDPlus.apply_settings_clbk then
		VHUDPlus.apply_settings_clbk = {
			["CustomHUD"] = function(setting, value)
				if managers.hud and managers.hud.change_hud_setting then
					local type = table.remove(setting, 1)
					managers.hud:change_hud_setting(type, setting, VHUDPlus:getColor(value) or value)
				end
			end,
			["HUDList"] = function(setting, value)
				if managers.hud and HUDListManager and setting then
					local list = tostring(setting[1])
					local category = tostring(setting[2])
					local option = tostring(setting[#setting])

					if list == "BUFF_LIST" and category ~= "show_buffs" then
						managers.hud:change_bufflist_setting(option, VHUDPlus:getColor(value) or value)
					elseif list == "RIGHT_LIST" and category == "SHOW_PICKUP_CATEGORIES" then
						managers.hud:change_pickuplist_setting(option, VHUDPlus:getColor(value) or value)
					else
						managers.hud:change_list_setting_new(option, VHUDPlus:getColor(value) or value)
					end
				end
			end,
			["EnemyHealthbar"] = function(setting, value)
				if managers.hud and managers.hud.change_enemyhealthbar_setting then
					managers.hud:change_enemyhealthbar_setting(tostring(setting[#setting]), value)
				end
			end,
			["TabStats"] = function(setting, value)
				if managers.hud and managers.hud.change_tabstats_setting then
					managers.hud:change_tabstats_setting(tostring(setting[#setting]), value)
				end
			end,
			["DrivingHUD"] = function(setting, value)
				if managers.hud and managers.hud.change_drivinghud_setting then
					managers.hud:change_drivinghud_setting(tostring(setting[#setting]), VHUDPlus:getColor(value) or value)
				end
			end,
			["GADGETS"] = function(setting, value)
				if WeaponGadgetBase and WeaponGadgetBase.update_theme_setting and #setting >= 4 then
					WeaponGadgetBase.update_theme_setting(setting[1], setting[2], setting[3], setting[4], VHUDPlus:getColor(value) or value)
				end
			end,
		}
	end

	VHUDPlus:Reset()	-- Populate settings table
	VHUDPlus:Load()	-- Load user settings
	VHUDPlus:LoadTextures()

	-- Create Ingame Menus
	dofile(VHUDPlus.mod_path .. "OptionMenus.lua")	-- Menu structure table in seperate file, in order to not bloat the Core file too much.
	local menu_options = VHUDPlus.options_menu_data

	-- Setup and register option menus
	Hooks:Add("MenuManagerSetupCustomMenus", "MenuManagerSetupCustomMenus_WolfHUD", function( menu_manager, nodes )
		local function create_menu(menu_table, parent_id)
			for i, data in ipairs(menu_table) do
				if data.type == "menu" then
					MenuHelper:NewMenu( data.menu_id )
					create_menu(data.options, data.menu_id)
				end
			end
		end

		create_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options")

		MenuHelper:NewMenu( VHUDPlus.fast_net_core )
		MenuHelper:NewMenu( VHUDPlus.fast_net )
		MenuHelper:NewMenu( VHUDPlus.fast_net_friends )
	end)

	--Populate options menus
	Hooks:Add("MenuManagerPopulateCustomMenus", "MenuManagerPopulateCustomMenus_WolfHUD", function(menu_manager, nodes)
		-- Called on setting change
		local function change_setting(setting, value)
			if VHUDPlus:getSetting(setting, nil) ~= value and VHUDPlus:setSetting(setting, value) then
				VHUDPlus:print_log(string.format("Change setting: %s = %s", VHUDPlus:SafeTableConcat(setting, "->"), tostring(value)), "info")	-- Change type back!
				VHUDPlus.settings_changed = true

				local script = table.remove(setting, 1)
				if VHUDPlus.apply_settings_clbk[script] then
					VHUDPlus.apply_settings_clbk[script](setting, value)
				end
			end
		end

		local function add_visible_reqs(menu_id, id, data)
			local visual_clbk_id = id .. "_visible_clbk"
			local enabled_clbk_id = id .. "_enabled_clbk"

			--Add visual callback
			MenuCallbackHandler[visual_clbk_id] = function(self, item)
				for _, req in ipairs(data.visible_reqs or {}) do
					if type(req) == "table" then
						local a = VHUDPlus:getSetting(req.setting, nil)
						if req.equal then
							if a ~= req.equal then
								return false
							end
						elseif type(a) == "boolean" then
							local b = req.invert and true or false
							if a == b then
								return false
							end
						elseif type(a) == "number" then
							local min_value = req.min or a
							local max_value = req.max or a
							if a < min_value or a > max_value then
								return false
							end
						end
					elseif type(req) == "boolean" then
						return req
					end
				end
				return true
			end

			--Add enable callback
			MenuCallbackHandler[enabled_clbk_id] = function(self, item)
				for _, req in ipairs(data.enabled_reqs or {}) do
					if type(req) == "table" then
						local a = VHUDPlus:getSetting(req.setting, nil)
						if req.equal then
							if a ~= req.equal then
								return false
							end
						elseif type(a) == "boolean" then
							local b = req.invert and true or false
							if a == b then
								return false
							end
						elseif type(a) == "number" then
							local min_value = req.min or a
							local max_value = req.max or a
							if a < min_value or a > max_value then
								return false
							end
						end
					elseif type(req) == "boolean" then
						return req
					end
				end
				return true
			end

			--Associate visual callback with item
			local menu = MenuHelper:GetMenu(menu_id)
			for i, item in pairs(menu._items_list) do
				if item:parameters().name == id then
					item._visible_callback_name_list = { visual_clbk_id }
					item._enabled_callback_name_list = { enabled_clbk_id }
					item._create_data = data
					break
				end
			end
		end

		-- Reapply enabled state on all items in the same menu
		local update_visible_clbks = "wolfhud_update_visibility"
		MenuCallbackHandler[update_visible_clbks] = function(self, item)
			local gui_node = item:parameters().gui_node
			if gui_node then
				if item._type ~= "slider" then
					gui_node:refresh_gui(gui_node.node)
					gui_node:highlight_item(item, true)
				end

				for _, row_item in pairs(gui_node.row_items) do
					local option_item = row_item.item
					if option_item._type ~= "divider" and option_item:parameters().name ~= item:parameters().name then
						local enabled = true

						for _, clbk in ipairs(option_item._enabled_callback_name_list or {}) do
							enabled = enabled and self[clbk](self, option_item)
						end

						option_item:set_enabled(enabled)

						gui_node:reload_item(option_item)
					end
				end
			end
		end

		-- item create functions by type
		local create_item_handlers = {
			menu = function(parent_id, offset, data)
				if not table.contains(VHUDPlus.menu_ids, data.menu_id) then
					table.insert(VHUDPlus.menu_ids, data.menu_id)
				end
			end,
			slider = function(menu_id, offset, data, value)
				local id = string.format("%s_%s_slider", menu_id, data.name_id)
				local clbk_id = id .. "_clbk"

				MenuHelper:AddSlider({
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					callback = string.format("%s %s", clbk_id, update_visible_clbks),
					value = value or 0,
					min = data.min_value,
					max = data.max_value,
					step = data.step_size,
					show_value = true,
					menu_id = menu_id,
					priority = offset,
					disabled_color = Color(0.6, 0.6, 0.6),
				})

				--Value changed callback
				MenuCallbackHandler[clbk_id] = function(self, item)
					change_setting(clone(data.value), item:value())
				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			toggle = function(menu_id, offset, data, value)
				local id = string.format("%s_%s_toggle", menu_id, data.name_id)
				local clbk_id = id .. "_clbk"

				if data.invert_value then
					value = not value
				end

				MenuHelper:AddToggle({
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					callback = string.format("%s %s", clbk_id, update_visible_clbks),
					value = value or false,
					menu_id = menu_id,
					priority = offset,
					disabled_color = Color(0.6, 0.6, 0.6),
				})

				--Add visual callback
				MenuCallbackHandler[clbk_id] = function(self, item)
					local value = (item:value() == "on") and true or false

					if data.invert_value then
						value = not value
					end

					change_setting(clone(data.value), value)
				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			multi_choice = function(menu_id, offset, data, value)
				local id = string.format("%s_%s_multi", menu_id, data.name_id)
				local clbk_id = id .. "_clbk"

				local multi_data = {
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					callback = string.format("%s %s", clbk_id, update_visible_clbks),
					items = data.options,
					value = value,
					menu_id = menu_id,
					priority = offset,
					disabled_color = Color(0.6, 0.6, 0.6),
				}

				do	-- Copy of MenuHelper:AddMultipleChoice (Without ipairs for options)
					local data = {
						type = "MenuItemMultiChoice"
					}
					for k, v in pairs( multi_data.items or {} ) do
						table.insert( data, { _meta = "option", text_id = v, value = k } )
					end

					local params = {
						name = multi_data.id,
						text_id = multi_data.title,
						help_id = multi_data.desc,
						callback = multi_data.callback,
						filter = true,
						localize = multi_data.localized,
					}

					local menu = MenuHelper:GetMenu( multi_data.menu_id )
					local item = menu:create_item(data, params)
					item._priority = multi_data.priority
					item:set_value( multi_data.value or 1 )

					if multi_data.disabled then
						item:set_enabled( not multi_data.disabled )
					end

					menu._items_list = menu._items_list or {}
					table.insert( menu._items_list, item )
				end

				MenuCallbackHandler[clbk_id] = function(self, item)
					change_setting(clone(data.value), item:value())
				end

				if data.add_color_options then
					local menu = MenuHelper:GetMenu(menu_id)
					for i, item in pairs(menu._items_list) do
						if item:parameters().name == id then
							item:clear_options()
							for k, v in ipairs(VHUDPlus:getTweakEntry("color_table", "table") or {}) do
								if data.add_rainbow or v.name ~= "rainbow" then
									local color_name = managers.localization:text("wolfhud_colors_" .. v.name)
									color_name = not color_name:lower():find("error") and color_name or string.upper(v.name)
									local params = {
										_meta = "option",
										text_id = color_name,
										value = v.name,
										localize = false,
										color = Color(v.color),
									}
									if v.name == "rainbow" then
										local rainbow_colors = { Color('FE0E31'), Color('FB9413'), Color('F7F90F'), Color('3BC529'), Color('00FFFF'), Color('475DE7'), Color('B444E4'), Color('F46FE6') }
										params.color = rainbow_colors[1]
										for i = 0, color_name:len() do
											params["color" .. i] = rainbow_colors[(i % #rainbow_colors) + 1]
											params["color_start" .. i] = i
											params["color_stop" .. i] = i + 1
										end
									end

									item:add_option(CoreMenuItemOption.ItemOption:new(params))
								end
							end
							item:_show_options(nil)
							item:set_value(value)
							for __, clbk in pairs( item:parameters().callback ) do
								clbk(item)
							end
							break
						end
					end
				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			input = function(menu_id, offset, data)
				local id = string.format("%s_%s_input", menu_id, data.name_id)
				local clbk_id = id .. "_clbk"

				MenuHelper:AddInput({
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					value = tostring(data.value),
					callback = clbk_id,
					menu_id = menu_id,
					priority = offset,
					disabled_color = Color(0.6, 0.6, 0.6),
				})

				MenuCallbackHandler[clbk_id] = function(self, item)
					change_setting(clone(data.value), item:value())
				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			button = function(menu_id, offset, data)
				local id = string.format("%s_%s_button", menu_id, data.name_id)
				local clbk_id = data.clbk or (id .. "_clbk")

				MenuHelper:AddButton({
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					callback = clbk_id,
					menu_id = menu_id,
					priority = offset,
					disabled_color = Color(0.6, 0.6, 0.6),
				})

				MenuCallbackHandler[clbk_id] = MenuCallbackHandler[clbk_id] or function(self, item)

				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			keybind = function(menu_id, offset, data)
				local id = string.format("%s_%s_keybind", menu_id, data.name_id)
				local clbk_id = data.clbk or (id .. "_clbk")

				MenuHelper:AddKeybinding({
					id = id,
					title = data.name_id,
					desc = data.desc_id,
					connection_name = "",
					binding = "",
					button = "",
					callback = clbk_id,
					menu_id = menu_id,
					priority = offset,
					--disabled_color = Color(0.6, 0.6, 0.6),
				})

				MenuCallbackHandler[clbk_id] = MenuCallbackHandler[clbk_id] or function(self, item)

				end

				if data.visible_reqs or data.enabled_reqs then
					add_visible_reqs(menu_id, id, data)
				end
			end,
			divider = function(menu_id, offset, data)
				local id = string.format("%s_divider_%d", menu_id, offset)

				local item_data = {
					type = "MenuItemDivider"
				}
				local params = {
					name = id,
					no_text = not data.text_id,
					text_id = data.text_id,
					localize = "true",
					size = data.size or 8,
					color = tweak_data.screen_colors.text
				}

				local menu = MenuHelper:GetMenu( menu_id )
				local item = menu:create_item( item_data, params )
				item._priority = offset or 0
				menu._items_list = menu._items_list or {}
				table.insert( menu._items_list, item )
			end,
		}

		-- Populate Menus with their menu items
		local function populate_menu(menu_table, parent_id)
			local item_amount = #menu_table
			for i, data in ipairs(menu_table) do
				local value = data.value and VHUDPlus:getSetting(data.value, nil)
				create_item_handlers[data.type](data.parent_id or parent_id, item_amount - i, data, value)

				if data.type == "menu" then
					populate_menu(data.options, data.menu_id)
				end
			end
		end

		populate_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options")

		-- Fast.Net Buttons
		MenuHelper:AddButton({
			id = "play_STEAM_online",
			title = "menu_play_online",
			desc = "menu_play_online_help",
			callback = "find_online_games",
			next_node = VHUDPlus.fast_net,
			menu_id = VHUDPlus.fast_net_core
		})

		MenuHelper:AddButton({
			id = "play_STEAM_online_with_friends",
			title = "menu_play_with_friends",
			desc = "menu_play_with_friends_help",
			callback = "find_online_games_with_friends",
			next_node = VHUDPlus.fast_net_friends,
			menu_id = VHUDPlus.fast_net_core
		})
	end)

	-- Create callbacks and finalize menus
	Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_WolfHUD", function(menu_manager, nodes)
		local back_clbk = "wolfhud_back_clbk"
		local focus_clbk = "wolfhud_focus_clbk"
		local reset_clbk = "wolfhud_reset_clbk"

		-- Add menu back callback
		MenuCallbackHandler[back_clbk] = function(node)
			if VHUDPlus.settings_changed then
				VHUDPlus.settings_changed = nil
				VHUDPlus:Save()
				VHUDPlus:print_log("Settings saved!", "info")
			end
		end

		-- Add focus callback
		MenuCallbackHandler[focus_clbk] = function(node, focus)
			if focus then
				for _, option_item in pairs(node._items) do
					if option_item._type ~= "divider" then
						local enabled = true

						for _, clbk in ipairs(option_item._enabled_callback_name_list or {}) do
							enabled = enabled and MenuCallbackHandler[clbk](node.callback_handler, option_item)
						end

						option_item:set_enabled(enabled)
					end
				end
			end
		end

		-- Add reset menu items callback
		MenuCallbackHandler[reset_clbk] = function(self, item)
			local menu_title = managers.localization:text("wolfhud_reset_options_title")
			local menu_message = managers.localization:text("wolfhud_reset_options_confirm")
			local menu_buttons = {
				[1] = {
					text = managers.localization:text("dialog_yes"),
					callback = function(self, item)
						VHUDPlus:Reset()

						for i, menu_id in ipairs(VHUDPlus.menu_ids) do
							local menu = MenuHelper:GetMenu(menu_id)
							if menu then
								for __, menu_item in ipairs(menu._items_list) do
									local setting = menu_item._create_data and clone(menu_item._create_data.value)
									if menu_item.set_value and setting then
										local value = VHUDPlus:getSetting(setting, nil)
										if value ~= nil then
											local script = table.remove(setting, 1)
											if VHUDPlus.apply_settings_clbk[script] then
												VHUDPlus.apply_settings_clbk[script](setting, value)
											end

											if menu_item._type == "toggle" then
												if menu_item._create_data.invert_value then
													value = not value
												end
												value = (value and "on" or "off")
											end

											menu_item:set_value(value)
										end
									end
								end
							end
						end
						managers.viewport:resolution_changed()

						VHUDPlus.settings_changed = true
						VHUDPlus:print_log("Settings resetted!", "info")
					end,
				},
				[2] = {
					text = managers.localization:text("dialog_no"),
					is_cancel_button = true,
				},
			}
			QuickMenu:new( menu_title, menu_message, menu_buttons, true )
		end

		-- Build Menus and add a button to parent menu
		local function finalize_menu(menu_table, parent_id)
			for i, data in ipairs(menu_table) do
				if data.type == "menu" then
					nodes[data.menu_id] = MenuHelper:BuildMenu(data.menu_id, { back_callback = back_clbk, focus_changed_callback = focus_clbk })
					MenuHelper:AddMenuItem(
						nodes[data.parent_id or parent_id],
						data.menu_id,
						data.name_id,
						data.desc_id,
						data.position or i
					)

					finalize_menu(data.options, data.menu_id)
				end
			end
		end

		finalize_menu({menu_options}, BLT and BLT.Mods.Constants:LuaModOptionsMenuID() or "blt_options") -- BLT.Mods.Constants:LuaModOptionsMenuID() -- Linking to wrong menu ID

		nodes[VHUDPlus.fast_net_core] = MenuHelper:BuildMenu(VHUDPlus.fast_net_core)
		local node_main = nodes.main
		local node_class = CoreMenuNode.MenuNode
		if VHUDPlus:getSetting({"INVENTORY", "FastNETENABLED"}, true) and node_main then
			MenuHelper:AddMenuItem(node_main, VHUDPlus.fast_net_core, "fastnet_sa", "menu_fastnet_help", "crimenet", "before")
		end

		nodes[VHUDPlus.fast_net] = MenuHelper:BuildMenu(VHUDPlus.fast_net)
		VHUDPlus.fast_net_node = nodes[VHUDPlus.fast_net]

		nodes[VHUDPlus.fast_net_friends] = MenuHelper:BuildMenu(VHUDPlus.fast_net_friends)
		VHUDPlus.fast_net_friends_node = nodes[VHUDPlus.fast_net_friends]

		local isWin32 = blt.blt_info().platform == "mswindows"
        local use_standard = VHUDPlus:getSetting({"INVENTORY", "FASTNETSTANDARDSCENE"}, false)
        local scene_background

        if use_standard and isWin32 then
            scene_background = "standard"
        elseif isWin32 then
            scene_background = "safe"
        else
            scene_background = "standard"
        end

		local arguments = {
			_meta = "node",
			[1] = {
				_meta = "legend",
				name = "menu_legend_select"
			},
			[2] = {
				_meta = "legend",
				name = "wolfhud_fastnet_update",
				pc = "true"
			},
			[3] = {
				_meta = "legend",
				name = "wolfhud_fastnet_filters",
				pc = "true"
			},
            [4] = {
				_meta = "legend",
				name = "wolfhud_fastnet_reconnect",
				pc = "true"
			},
			[5] = {
				_meta = "legend",
				name = "menu_legend_back"
			},
			--align_line = 0.5,
			back_callback = "stop_multiplayer",
			gui_class = "MenuNodeTableGui",
			legend = {
				_meta = "legend",
				name = "menu_legend_back",
				_meta = "legend",
				name = "menu_legend_select",
				_meta = "legend",
				name = "wolfhud_fastnet_update",
				_meta = "legend",
				name = "wolfhud_fastnet_filters",
                _meta = "legend",
                name = "wolfhud_fastnet_reconnect"
			},
			menu_components = "",
			modifier = "MenuSTEAMHostBrowser",
			name = VHUDPlus.fast_net,
			refresh = "MenuSTEAMHostBrowser",
			stencil_align = "right",
			stencil_image = "bg_creategame",
			topic_id = "menu_play_online",
			type = "MenuNodeServerList",
			update = "MenuSTEAMHostBrowser",
			scene_state = scene_background
		}
		node_class = CoreSerialize.string_to_classtable(arguments.type)
		nodes[VHUDPlus.fast_net] = node_class:new(arguments)

		local callback_handler = CoreSerialize.string_to_classtable("MenuCallbackHandler")
		nodes[VHUDPlus.fast_net]:set_callback_handler(callback_handler:new())

		local arguments_friends = {
			_meta = "node",
			[1] = {
				_meta = "legend",
				name = "menu_legend_select"
			},
			[2] = {
				_meta = "legend",
				name = "wolfhud_fastnet_update",
				pc = "true"
			},
			[3] = {
				_meta = "legend",
				name = "menu_legend_back"
			},
			--align_line = 0.5,
			back_callback = "stop_multiplayer",
			gui_class = "MenuNodeTableGui",
			legend = {
				_meta = "legend",
				name = "menu_legend_back",
				_meta = "legend",
				name = "menu_legend_select",
				_meta = "legend",
				name = "menu_legend_update"
			},
			menu_components = "",
			modifier = "MenuSTEAMHostBrowser",
			name = VHUDPlus.fast_net_friends,
			refresh = "MenuSTEAMHostBrowser",
			stencil_align = "right",
			stencil_image = "bg_creategame",
			topic_id = "menu_play_online",
			type = "MenuNodeServerList",
			update = "MenuSTEAMHostBrowser",
			scene_state = scene_background
		}
		node_class = CoreSerialize.string_to_classtable(arguments_friends.type)
		nodes[VHUDPlus.fast_net_friends] = node_class:new(arguments_friends)

		local callback_handler = CoreSerialize.string_to_classtable("MenuCallbackHandler")
		nodes[VHUDPlus.fast_net_friends]:set_callback_handler(callback_handler:new())
	end)

	--Add localiszation strings
	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_WolfHUD", function(loc)
        local loc_path = VHUDPlus.mod_path .. "loc/"
		if file.DirectoryExists( loc_path ) then
			loc:load_localization_file(string.format("%s/%s.json", loc_path, VHUDPlus:getSetting({"LANGUAGE"}, "english")))
			loc:load_localization_file(string.format("%s/english.json", loc_path), false)

			if VHUDPlus:getSetting({"INVENTORY", "USE_REAL_WEAPON_NAMES"}, false) then
				loc:load_localization_file(string.format("%s/RealWeaponNames.json", loc_path))
			end
		else
			VHUDPlus:print_log("Localization folder seems to be missing!", "error")
		end

		local localized_strings = {}
		localized_strings["cash_sign"] = VHUDPlus:getTweakEntry("CASH_SIGN", "string", "$")

		if VHUDPlus:getSetting({"MISCHUD", "MASK_INSTRUCT"}, true) then
		    localized_strings["hud_instruct_mask_on"] = ""
		end

		if VHUDPlus:getSetting({"HUDSuspicion", "SHOW_PERCENTAGE"}, true) then
		    localized_strings["hud_suspicion_detected"] = ""
	        end

		-- Hide Skip Message, when auto skip blackscreen is active
		if VHUDPlus:getSetting({"SkipIt", "SKIP_BLACKSCREEN"}, false) then
			localized_strings["hud_skip_blackscreen"] = ""
		end

		if LobbySettings then
            localized_strings["menu_cn_premium_buy_fee_short"] = ""
		end

		-- Add macro $VALUE to all interaction strings
		for interact_id, data in pairs(tweak_data.interaction) do
			if type(data) == "table" and data.text_id and not data.verify_owner then
				if not VHUDPlus:getSetting({"INTERACTION", "HIDEBAGVALUE"}, false) then
					localized_strings[data.text_id] = loc:text(data.text_id, {BTN_INTERACT = "$BTN_INTERACT"}) .. "$VALUE"
				end
				if not VHUDPlus:getSetting({"INTERACTION", "HIDEINTERACTIONINSTRUCTIONS"}, true) then
					localized_strings[data.text_id] = ""
				end
			end
		end
		loc:add_localized_strings(localized_strings)
	end)
end

if MenuNodeMainGui then
	Hooks:PostHook( MenuNodeMainGui , "_add_version_string" , "MenuNodeMainGuiPostAddVersionString_WolfHUD" , function( self )
		if alive(self._version_string) then
			self._version_string:set_text("Payday 2 v" .. Application:version() .. " | VanillaHUD Plus v" .. VHUDPlus:getVersion())
		end
	end)
end

if MenuItemMultiChoice then
	Hooks:PostHook( MenuItemMultiChoice , "setup_gui" , "MenuItemMultiChoicePostSetupGui_WolfHUD" , function( self, node, row_item )
		if self:selected_option() and self:selected_option():parameters().color and row_item.choice_text then
			row_item.choice_text:set_blend_mode("normal")
		end
	end)
end

if MenuNodeGui then
	local _create_legends_original = MenuNodeGui._create_legends
	function MenuNodeGui._create_legends(self, node)
		_create_legends_original(self, node)
		local is_pc = managers.menu:is_pc_controller()
		if is_pc then
			local has_pc_legend = false
			local visible_callback_name, visible_callback
			local t_text = ""
			for i, legend in pairs(node:legends()) do
				visible_callback_name = legend.visible_callback
				visible_callback = nil
				if visible_callback_name then
					visible_callback = callback(node.callback_handler, node.callback_handler, visible_callback_name)
				end
				if (not is_pc or legend.pc) and (not visible_callback or visible_callback(self)) then
					has_pc_legend = has_pc_legend or legend.pc
					local spacing = i > 1 and "  " or ""
					t_text = t_text .. spacing .. utf8.to_upper(managers.localization:text(legend.string_id, {
						BTN_X = managers.localization:btn_macro("menu_update") or managers.localization:get_default_macro("BTN_X"),
						BTN_Y = managers.localization:btn_macro("menu_toggle_filters") or managers.localization:get_default_macro("BTN_Y"),
						BTN_START = managers.localization:btn_macro("menu_respec_tree_all") or managers.localization:get_default_macro("BTN_START"),
						BTN_BACK = managers.localization:btn_macro("back")
					}))
				end
			end
			local text = self._legends_panel:child(0)
			text:set_text(t_text)
			local _, _, w, h = text:text_rect()
			text:set_size(w, h)
			self:_layout_legends()
		else
			local has_pc_legend = false
			local visible_callback_name, visible_callback
			local t_text = ""
			for i, legend in pairs(node:legends()) do
				visible_callback_name = legend.visible_callback
				visible_callback = nil
				if visible_callback_name then
					visible_callback = callback(node.callback_handler, node.callback_handler, visible_callback_name)
				end
				if (not is_pc or legend.pc) and (not visible_callback or visible_callback(self)) then
					has_pc_legend = has_pc_legend or legend.pc
					local spacing = i > 1 and "  " or ""
					t_text = t_text .. spacing .. utf8.to_upper(managers.localization:text(legend.string_id, {
						BTN_X = managers.localization:btn_macro("menu_toggle_legends") or managers.localization:get_default_macro("BTN_X"),
						BTN_Y = managers.localization:btn_macro("menu_update") or managers.localization:get_default_macro("BTN_Y"),
						BTN_START = managers.localization:btn_macro("menu_respec_tree_all") or managers.localization:get_default_macro("BTN_START"),
						BTN_BACK = managers.localization:btn_macro("back")
					}))
				end
			end
			local text = self._legends_panel:child(0)
			text:set_text(t_text)
			local _, _, w, h = text:text_rect()
			text:set_size(w, h)
			self:_layout_legends()
		end
	end
end

if RequiredScript then
	local requiredScript = RequiredScript:lower()

	if VHUDPlus.hook_files[requiredScript] then
		for __, file in ipairs(VHUDPlus.hook_files[requiredScript]) do
			dofile( VHUDPlus.mod_path .. "lua/" .. file )
		end
	end
end

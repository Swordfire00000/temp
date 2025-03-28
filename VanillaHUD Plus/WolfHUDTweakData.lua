WolfHUDTweakData = WolfHUDTweakData or class()
function WolfHUDTweakData:init()
	----------------------------------------------------------------------------------------------------------------------
	-- VHUDPlus Tweak Data																								--
	----------------------------------------------------------------------------------------------------------------------
	-- This file enables access to advanced settings, or those I cannot really implement into ingame menus easily.		--
	-- If you want to save those changes, please copy this file to "Payday 2/mods/saves" and edit that copy instead.	--
	-- You will need to take care of that version beeing up to date on your own. 										--
	-- It will not get changed on updates automatically.																--
	-- If you encounter problems, make sure the contents of this file matches the contents of your customized version.	--
	----------------------------------------------------------------------------------------------------------------------

	-- Determines which messages get logged
	self.LOG_MODE = {
		error = true, 		-- log errors
		warning = true, 	-- log warnings
		info = false, 		-- log infos
		to_console = true 	-- show messages in console (Requires DebugConsole mod)
	}

	-- Currency used ingame
	self.CASH_SIGN = "$"				-- Dollar
	--self.CASH_SIGN = "\194\128"		-- EUR

	-- Maximum amount of Plans, that can be saved per level/map.
	self.MAX_PRE_PLANS = 10
	-- Maximum Length of custom weapon names.
	self.MAX_WEAPON_NAME_LENGTH = 30
	-- Maximum Length of custom Skill set names.
	self.MAX_SKILLSET_NAME_LENGTH = 25
    -- Maximum Length of Profile names.
    self.MAX_PROFILE_NAME_LENGTH = 20

	-- Time within 2 presses of the nade button, to throw a nade in stealth.
	self.STEALTH_NADE_TIMEOUT = 0.25
	-- Time within 2 presses of the interact button, to deploy a shaped charge in stealth.
	self.STEALTH_SHAPED_CHARGE_TIMEOUT = 0.25
	-- Time within 2 presses of the interact button, to close a door using a keycard. (hoxton breakout day 2)
	self.KEYCARD_DOORS_TIMEOUT = 0.25
	-- Time between 2 automatical pickups, when the interaction button remains pressed.
	self.AUTO_PICKUP_DELAY = 0.2

	-- Component Layouts  for Lobby and briefing loadout panels.
	-- The total width and height of those panels are fixed, so adding too many components into a row or column will make them incredibly small.
	-- Available components:
--[[
		name 					-> The name (+ rank in lobby)
		level 					-> The level + infamy
		ping					-> The latency
		playtime 				-> The Steam playtime (in hours)
		character				-> The used character
		skills 					-> The equipped skill build
		perk 					-> The equipped perkdeck
		primary 				-> The primary weapon + used mods
		secondary 				-> The secondary weapon + used mods
		melee_weapon			-> The equipped melee weapon
		grenade 				-> The eqipped throwable
		mask					-> The mask worn
		armor 					-> The armor worn
		deployable 				-> The equipped deployable
		secondary_deployable 	-> The eqipped secondary deployable (in case of Jack of all trades)
--]]
	self.STD_LOBBY_LOADOUT_LAYOUT = {
										{ "playtime", "ping" },
										{ "name" },
										{ "character" },
										{ "skills" },
										{ "perk" },
										{ "primary" },
										{ "secondary" },
										{ "melee_weapon" },
										{ "grenade", "armor" },
										{ "deployable", "secondary_deployable" }
									}
	self.CS_LOBBY_LOADOUT_LAYOUT = {
										{ "playtime", "ping" },
										{ "name" },
										{ "skills" },
										{ "perk" },
										{ "primary", "secondary" },
										{ "grenade", "armor" },
										{ "deployable", "secondary_deployable" }
									}
	self.BRIEFING_LOADOUT_LAYOUT = 	{
										{ "perk", "playtime" },
										{ "skills" },
										{ "primary" },
										{ "secondary" },
										{ "melee_weapon", "grenade" },
										{ "armor", "mask" },
										{ "deployable", "secondary_deployable" }
									}
	self.TAB_LOADOUT_LAYOUT = 		{
										{ "name", "ping", "playtime" },
										{ "skills", "perk" },
									}

	-- Color table
	-- 		Add or remove any color you want
	--		'color' needs to be that colors hexadecimal code
	-- 		'name' will be the name it appears in the selection menus
	self.color_table = {
		{ color = 'FFFFFF', name = "white" 			},
		{ color = 'F2F250', name = "light_yellow" 	},
		{ color = 'F2C24E', name = "light_orange" 	},
		{ color = 'E55858', name = "light_red" 		},
		{ color = 'CC55CC', name = "light_purple" 	},
		{ color = '00FF00', name = "light_green" 	},
		{ color = '00FFFF', name = "light_blue" 	},
		{ color = 'BABABA', name = "light_gray" 	},
		{ color = 'FFFF00', name = "yellow" 		},
		{ color = 'FFA500', name = "orange" 		},
		{ color = 'FF0000', name = "red" 			},
		{ color = '800080', name = "purple" 		},
		{ color = '008000', name = "green" 			},
		{ color = '0000FF', name = "blue" 			},
		{ color = '808080', name = "gray" 			},
		{ color = '000000', name = "black" 			},
		{ color = 'FF7575', name = "debuff" 		},
		{ color = '75FF75', name = "team" 			},
		{ color = nil, name = "rainbow" 			},
	}

	--Unit Name link table
	self.CHARACTER_NAMES = {
		[ "civilian" ] 							= { default = "wolfhud_enemy_civilian" },
		[ "civilian_female" ] 					= { default = "wolfhud_enemy_civilian" },
		[ "civilian_mariachi" ] 				= { default = "wolfhud_enemy_mariachi" },
		[ "captain" ] 							= { default = "wolfhud_enemy_civilian" },
		[ "civilian_no_penalty" ] 				= { default = "wolfhud_enemy_civilian" },
		[ "gangster" ] 							= { default = "wolfhud_enemy_gangster" },
		[ "triad" ] 							= { default = "wolfhud_enemy_triad" },
		[ "biker" ] 							= { default = "wolfhud_enemy_biker" },
		[ "biker_escape" ] 						= { default = "wolfhud_enemy_biker" },
		[ "bolivian_indoors" ]					= { default = "wolfhud_enemy_bolivian_security" },
		[ "bolivian_indoors_mex" ]				= { default = "wolfhud_enemy_bolivian_security_mex" },
		[ "bolivian" ]							= { default = "wolfhud_enemy_bolivian_thug" },
		[ "mobster" ] 							= { default = "wolfhud_enemy_mobster" },
		[ "security" ] 							= { default = "wolfhud_enemy_security" },
		[ "security_undominatable" ] 			= { default = "wolfhud_enemy_security" },
		[ "mute_security_undominatable" ]		= { default = "wolfhud_enemy_security" },
		[ "security_mex" ] 			            = { default = "wolfhud_enemy_security" },
		[ "security_mex_no_pager" ] 			= { default = "wolfhud_enemy_security" },
		[ "gensec" ] 							= { default = "wolfhud_enemy_gensec" },
		[ "cop" ] 								= { default = "wolfhud_enemy_cop" },
		[ "cop_female" ]						= { default = "wolfhud_enemy_cop" },
		[ "cop_scared" ]						= { default = "wolfhud_enemy_cop" },
		[ "fbi" ] 								= { default = "wolfhud_enemy_fbi" },
		[ "swat" ] 								= { default = "wolfhud_enemy_swat" },
		[ "heavy_swat" ] 						= { default = "wolfhud_enemy_heavy_swat" },
		[ "fbi_swat" ] 							= { default = "wolfhud_enemy_swat" },
		[ "fbi_heavy_swat" ] 					= { default = "wolfhud_enemy_heavy_swat" },
        [ "heavy_swat_sniper" ] 				= { default = "wolfhud_enemy_heavy_swat_sniper" },
		[ "city_swat" ] 						= { default = "wolfhud_enemy_city_swat" },
		[ "shield" ] 							= { default = "wolfhud_enemy_shield" },
		[ "spooc" ] 							= { default = "wolfhud_enemy_spook" },
		[ "shadow_spooc"] 						= { default = "wolfhud_enemy_shadow_spook" },
		[ "taser" ] 							= { default = "wolfhud_enemy_taser" },
		[ "sniper" ] 							= { default = "wolfhud_enemy_sniper" },
		[ "medic" ]								= { default = "wolfhud_enemy_medic" },
		[ "tank" ] 								= { default = "wolfhud_enemy_tank" },
		[ "tank_hw" ]							= { default = "wolfhud_enemy_tank_hw" },
		[ "tank_medic" ]						= { default = "wolfhud_enemy_tank_medic" },
		[ "tank_mini" ]							= { default = "wolfhud_enemy_tank_mini" },
		[ "phalanx_minion" ] 					= { default = "wolfhud_enemy_phalanx_minion" },
		[ "phalanx_vip" ] 						= { default = "wolfhud_enemy_phalanx_vip" },
		[ "swat_van_turret_module" ] 			= { default = "wolfhud_enemy_swat_van" },
		[ "ceiling_turret_module" ] 			= { default = "wolfhud_enemy_ceiling_turret" },
		[ "ceiling_turret_module_no_idle" ] 	= { default = "wolfhud_enemy_ceiling_turret" },
		[ "ceiling_turret_module_longer_range" ] = { default = "wolfhud_enemy_ceiling_turret" },
		[ "aa_turret_module" ] 					= { default = "wolfhud_enemy_aa_turret" },
		[ "crate_turret_module" ] 				= { default = "wolfhud_enemy_crate_turret" },
		[ "sentry_gun" ]						= { default = "wolfhud_enemy_sentry_gun" },
		[ "mobster_boss" ] 						= { default = "wolfhud_enemy_mobster_boss" },
		[ "chavez_boss" ]						= { default = "wolfhud_enemy_chavez_boss" },
		[ "drug_lord_boss" ]					= { default = "wolfhud_enemy_druglord_boss" },
		[ "drug_lord_boss_stealth" ]			= { default = "wolfhud_enemy_druglord_boss_stealth" },
		[ "biker_boss" ] 						= { default = "wolfhud_enemy_biker_boss" },
		[ "bank_manager" ] 						= { default = "wolfhud_enemy_bank_manager", dah = "wolfhud_enemy_dah_ralph" },
		[ "inside_man" ] 						= { default = "wolfhud_enemy_inside_man" },
		[ "escort_undercover" ] 				= { default = "wolfhud_enemy_escort_undercover", run = "wolfhud_enemy_escort_heatstreet", rvd1 = "wolfhud_enemy_escort_reservoirdogs" },
		[ "escort_chinese_prisoner" ]			= { default = "wolfhud_enemy_escort_chinese_prisoner" },
		[ "escort_cfo" ]						= { default = "wolfhud_enemy_escort_cfo" },
		[ "drunk_pilot" ] 						= { default = "wolfhud_enemy_drunk_pilot", bph = "wolfhud_enemy_escort_bain_locke", bex = "wolfhud_enemy_escort_it_guy" },
		[ "escort" ] 							= { default = "wolfhud_enemy_escort" },
		[ "boris" ]								= { default = "wolfhud_enemy_boris" },
		[ "spa_vip" ]							= { default = "wolfhud_enemy_spa_vip" },
		[ "spa_vip_hurt" ]						= { default = "wolfhud_enemy_spa_vip_hurt" },
		[ "escort_criminal" ]					= { default = "wolfhud_enemy_vlad" },
		[ "old_hoxton_mission" ] 				= { default = "wolfhud_enemy_locke_mission", hox_1 = "wolfhud_enemy_old_hoxton_mission", hox_2 = "wolfhud_enemy_old_hoxton_mission", rvd1 = "wolfhud_enemy_reservoirdogs", rvd2 = "wolfhud_enemy_reservoirdogs" },
		[ "hector_boss" ] 						= { default = "wolfhud_enemy_hector_boss" },
		[ "hector_boss_no_armor" ] 				= { default = "wolfhud_enemy_hector_boss_no_armor" },
		[ "triad_boss" ] 						= { default = "wolfhud_enemy_yufuwang_armored_boss" },
		[ "triad_boss_no_armor" ] 				= { default = "wolfhud_enemy_yufuwang_no_armor_boss" },
		[ "ranchmanager" ] 						= { default = "wolfhud_enemy_ranchmanager" },
		[ "marshal_marksman" ] 					= { default = "wolfhud_enemy_marshal_marksman" },
		[ "marshal_shield" ] 					= { default = "wolfhud_enemy_marshal_shield" },
		[ "marshal_shield_break" ] 				= { default = "wolfhud_enemy_marshal_shield_break" },
		[ "zeal_heavy_swat" ] 					= { default = "wolfhud_enemy_zeal_heavy_swat" },
		[ "zeal_swat" ] 						= { default = "wolfhud_enemy_zeal_swat" },
		[ "robbers_safehouse" ]					= { default = "wolfhud_enemy_crew", bph = "wolfhud_enemy_kento" },
		[ "butler" ]							= { default = "wolfhud_enemy_butler" },
		[ "vlad" ]								= { default = "wolfhud_enemy_vlad" },
		[ "russian" ] 							= { default = "menu_russian" },
		[ "german" ] 							= { default = "menu_german" },
		[ "spanish" ] 							= { default = "menu_spanish" },
		[ "american" ] 							= { default = "menu_american" },
		[ "jowi" ] 								= { default = "menu_jowi" },
		[ "old_hoxton" ] 						= { default = "menu_old_hoxton" },
		[ "female_1" ] 							= { default = "menu_female_1" },
		[ "clover" ] 							= { default = "menu_female_1" },
		[ "dragan" ] 							= { default = "menu_dragan" },
		[ "jacket" ] 							= { default = "menu_jacket" },
		[ "bonnie" ] 							= { default = "menu_bonnie" },
		[ "sokol" ] 							= { default = "menu_sokol" },
		[ "dragon" ] 							= { default = "menu_dragon" },
		[ "bodhi" ] 							= { default = "menu_bodhi" },
		[ "jimmy" ] 							= { default = "menu_jimmy" },
		[ "sydney" ] 							= { default = "menu_sydney" },
		[ "wild" ]								= { default = "menu_wild" },
		[ "chico" ]								= { default = "menu_chico" },
		[ "terry" ]								= { default = "menu_chico" },
		[ "max" ]								= { default = "menu_max" },
		[ "myh" ]								= { default = "menu_myh" },
		[ "ecp_male" ] 							= { default = "menu_ecp_male" },
		[ "ecp_female" ] 						= { default = "menu_ecp_female" },
		[ "joy" ] 								= { default = "menu_joy" },

		--Restoration Overhaul Enemies
		["boom"] 								= { default = "wolfhud_enemy_boom" },
		["omnia_lpf"] 							= { default = "wolfhud_enemy_omnia_lpf" },
		["summers"] 							= { default = "wolfhud_enemy_summers" },
		["boom_summers"] 						= { default = "wolfhud_enemy_boom_summers" },
		["taser_summers"] 						= { default = "wolfhud_enemy_taser_summers" },
		["medic_summers"] 						= { default = "wolfhud_enemy_medic_summers" },
		["spring"] 								= { default = "wolfhud_enemy_spring" },
		["fbi_vet"] 							= { default = "wolfhud_enemy_fbi_vet" },
		["headless_hatman"] 					= { default = "wolfhud_enemy_hatman" },
		["autumn"] 								= { default = "wolfhud_enemy_autumn" },
		["phalanx_minion_assault"] 				= { default = "wolfhud_enemy_phalanx_minion_assault" },
		["phalanx_vip_break"] 					= { default = "wolfhud_enemy_phalanx_vip_break" },
		["vetlod"] 								= { default = "wolfhud_enemy_fbi_vet" },
		["gensec_guard"] 						= { default = "wolfhud_enemy_gensec" },
		["city_swat_guard"] 					= { default = "wolfhud_enemy_gensec" },
		["cop_forest"] 							= { default = "wolfhud_enemy_cop" },
		["dave"] 								= { default = "wolfhud_enemy_dave" },
		["fbi_vet_boss"] 						= { default = "wolfhud_enemy_fbi_vet" },
		["meme_man"] 							= { default = "wolfhud_enemy_meme" },
		["meme_man_shield"] 					= { default = "wolfhud_enemy_meme_shield" },
		["hrt"] 								= { default = "wolfhud_enemy_fbi" },
		["hrt_titan"] 							= { default = "wolfhud_enemy_fbi_titan" },
		["weekend_dmr"] 						= { default = "wolfhud_enemy_weekend_sniper" },
		["weekend"] 							= { default = "wolfhud_enemy_weekend" },
		["weekend_lmg"] 						= { default = "wolfhud_enemy_weekend_lmg" },
		["weekend_guard"] 						= { default = "wolfhud_enemy_weekend_guard" },
		["weekend_elite_guard"] 				= { default = "wolfhud_enemy_weekend_lmg_guard" },
		["biker_guard"] 						= { default = "wolfhud_enemy_biker_guard" },
		["city_swat_titan"] 					= { default = "wolfhud_enemy_titan_swat" },
		["city_swat_titan_assault"] 			= { default = "wolfhud_enemy_titan_swat_assault" },
		["enforcer"] 							= { default = "wolfhud_enemy_enforcer" },
		["enforcer_assault"] 					= { default = "wolfhud_enemy_enforcer_assault" },
		["tank_black"] 							= { default = "wolfhud_enemy_tank_black" },
		["tank_hw_black"] 						= { default = "wolfhud_enemy_tank_black" },
		["tank_skull"] 							= { default = "wolfhud_enemy_tank_skull" },
		["tank_biker"] 							= { default = "wolfhud_enemy_tank_biker" },
		["tank_titan"] 							= { default = "wolfhud_enemy_tank_titan" },
		["tank_titan_assault"] 					= { default = "wolfhud_enemy_tank_titan" },
		["spooc_titan"] 						= { default = "wolfhud_enemy_spook_titan" },
		["spooc_gangster"] 						= { default = "wolfhud_enemy_spook_gangster" },
		["taser_titan"] 						= { default = "wolfhud_enemy_taser_titan" },
		["taser_titan_reaper"] 					= { default = "wolfhud_enemy_taser_titan" },

		--Crackdown Enemies
		["deathvox_lightar"] 					= { default = "wolfhud_enemy_deathvox_light" },
		["deathvox_heavyar"] 					= { default = "wolfhud_enemy_deathvox_heavy" },
		["deathvox_lightshot"] 					= { default = "wolfhud_enemy_deathvox_light" },
		["deathvox_heavyshot"] 					= { default = "wolfhud_enemy_deathvox_heavy" },
		["deathvox_greendozer"] 				= { default = "wolfhud_enemy_tank" },
		["deathvox_blackdozer"] 				= { default = "wolfhud_enemy_tank" },
		["deathvox_lmgdozer"] 					= { default = "wolfhud_enemy_tank" },
		["deathvox_medicdozer"] 				= { default = "wolfhud_enemy_tank_medic" },
		["deathvox_cloaker"] 					= { default = "wolfhud_enemy_spooc" },
		["deathvox_taser"] 						= { default = "wolfhud_enemy_taser" },
		["deathvox_shield"] 					= { default = "wolfhud_enemy_shield" },
		["deathvox_sniper"] 					= { default = "wolfhud_enemy_sniper" },
		["deathvox_medic"] 						= { default = "wolfhud_enemy_medic" },
		["deathvox_grenadier"] 					= { default = "wolfhud_enemy_boom" },
		["deathvox_guard"] 						= { default = "wolfhud_enemy_security" },
	}

	self:post_init()
end

----------------------------------------- DONT EDIT BELOW THIS LINE!!! ----------------------------------------- DONT EDIT BELOW THIS LINE!!! ----------------------------------------- DONT EDIT BELOW THIS LINE!!! -----------------------------------------

function WolfHUDTweakData:post_init()
	for _, data in ipairs(self.color_table) do
		if data.name == "rainbow" then
			data.color_func = function(frequency)
				local r = Application:time() * 360 * (frequency or 1)
				local r, g, b = (1 + math.sin(r + 0)) / 2, (1 + math.sin(r + 120)) / 2, (1 + math.sin(r + 240)) / 2
				return Color(r, g, b)
			end
		end
	end
end

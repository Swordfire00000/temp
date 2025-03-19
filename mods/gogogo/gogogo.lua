core:module("CoreMissionManager")
core:import("CoreTable")

local level = Global.level_data and Global.level_data.level_id or ""

if Network:is_client() then
elseif level == "alex_3" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 100583 and element.editor_name == "play_pln_gen_bagit_01" then
				element.values.enabled = false
			end
			if element.id == 100581 and element.editor_name == "play_pln_gen_count_17" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "ukrainian_job" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 100896 and element.editor_name == "drv_ukranian_stage1_01_any_01" then
				element.values.enabled = false
			end
			if element.id == 102639 and element.editor_name == "pln_ukranian_stage1_30_any_01" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "arm_for" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 100341 and element.editor_name == "func_dialogue_007" then
				element.values.enabled = false
			end
			if element.id == 102910 and element.editor_name == "pilot_8_imhere" then
				element.values.enabled = false
			end
			if element.id == 104428 and element.editor_name == "Player secures prototype piece" then
				element.values.enabled = false
			end
			if element.id == 104548 and element.editor_name == "Alarm went off" then
				element.values.enabled = false
			end
			if element.id == 104550 and element.editor_name == "Players secured three Cannon" then
				element.values.enabled = false
			end
			if element.id == 104835 and element.editor_name == "Pilot is dropping lance" then
				element.values.enabled = false
			end
			if element.id == 105612 and element.editor_name == "Ammo_Secured" then
				element.values.force_quit_current = true
			end
		end
	end)
elseif level == "arena" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 102617 and element.editor_name == "VO - Play_pln_al1_016" then
				element.values.enabled = false
			end
			if element.id == 102620 and element.editor_name == "VO - Play_pln_al1_019" then
				element.values.enabled = false
			end
			if element.id == 102624 and element.editor_name == "VO - Play_pln_al1_023" then
				element.values.enabled = false
			end
			if element.id == 102853 and element.editor_name == "VO - Play_pln_al1_056 - more c4" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "peta" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 100971 and element.editor_name == "ap_found_again" then
				element.values.enabled = false
			end
			if element.id == 100975 and element.editor_name == "ap_inside_again" then
				element.values.enabled = false
			end
			if element.id == 101003 and element.editor_name == "fan_found_again" then
				element.values.enabled = false
			end
			if element.id == 101367 and element.editor_name == "light_found_again" then
				element.values.enabled = false
			end
			if element.id == 101048 and element.editor_name == "scaf_found_again" then
				element.values.enabled = false
			end
			if element.id == 101134 and element.editor_name == "scaf_found_again" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "dark" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 100900 and element.editor_name == "Play_pln_drk_33" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "bex" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 103304 and element.editor_name == "Play_lox_bex_101" then
				element.values.force_quit_current = true
			end
		end
	end)
end
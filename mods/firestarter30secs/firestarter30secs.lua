core:module("CoreMissionManager")
core:import("CoreTable")

local level = Global.level_data and Global.level_data.level_id or ""

if Network:is_client() then
elseif level == "firestarter_1" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 102654 and element.editor_name == "Play_pln_polin_02" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "framing_frame_3" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 104301 and element.editor_name == "bain13" then
				element.values.enabled = false
			end
			if element.id == 104981 and element.editor_name == "play_pln_gen_lkgo_01" then
				element.values.enabled = false
			end
			if element.id == 105221 and element.editor_name == "vault" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "big" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 106514 and element.editor_name == "func_dialogue_062" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "red2" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 101538 and element.editor_name == "player_in_vault" then
				element.values.enabled = false
			end
			if element.id == 101544 and element.editor_name == "area_player_entered_vault" then
				table.insert(element.values.on_executed, {delay = 0, id = 101543})
				table.insert(element.values.on_executed, {delay = 0, id = 105774})
				table.insert(element.values.on_executed, {delay = 0, id = 106018})
			end
		end
	end)
elseif level == "flat" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 104113 and element.editor_name == "fl4_done" then
				element.values.enabled = false
			end
			if element.id == 104148 and element.editor_name == "fl5_done" then
				element.values.enabled = false
			end
			if element.id == 104146 and element.editor_name == "roof_done" then
				element.values.enabled = false
			end
			if element.id == 104755 and element.editor_name == "go to basement" then
				element.values.enabled = false
			end
		end
	end)
elseif level == "dah" then
	Hooks:PreHook(MissionManager, "_add_script", "scripting_improvements_add_script", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 102332 and element.editor_name == "Play_pln_dah_55" then
				element.values.enabled = false
			end
			if element.id == 102929 and element.editor_name == "Play_pln_dah_108" then
				element.values.enabled = false
			end
		end
	end)
end
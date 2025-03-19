_G.OhNoMoreSkillsets = _G.OhNoMoreSkillsets or {}
OhNoMoreSkillsets._path = ModPath

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_ONMS", function(loc)
	for _, filename in pairs(file.GetFiles(OhNoMoreSkillsets._path .. "loc/")) do
		local str = filename:match('^(.*).txt$')
		if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
			loc:load_localization_file(OhNoMoreSkillsets._path .. "loc/" .. filename)
			break
		end
	end

	loc:load_localization_file(OhNoMoreSkillsets._path .. "loc/english.txt", false)
end)


local onms_original_skilltreetweakdata_init = SkillTreeTweakData.init
function SkillTreeTweakData:init()
	onms_original_skilltreetweakdata_init(self)
	
	self.skill_switches = {
		{
			name_id = "menu_st_skill_switch_1"
		},
		{
			name_id = "menu_st_skill_switch_2",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_3",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_4",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_5",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_6",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_7",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_8",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_9",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_10",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_11",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_12",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_13",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_14",
			locks = {level = 0}
		},
		{
			name_id = "menu_st_skill_switch_15",
			locks = {level = 0}
		},
		-- --------------------------------------------------
		{
			name_id = "onms_set_16",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_17",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_18",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_19",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_20",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_21",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_22",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_23",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_24",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_25",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_26",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_27",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_28",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_29",
			locks = {level = 0}
		},
		{
			name_id = "onms_set_30",
			locks = {level = 0}
		}
	}
end

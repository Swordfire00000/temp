dofile(ModPath .. "vocalheisterscore.lua")

Hooks:Add('LocalizationManagerPostInit', 'vocalheistersmenu_loadlocalization', function(loc)
	loc:load_localization_file(VocalHeisters.ModPath .. 'menu/vocalheisters_en.json', false)
end)

Hooks:Add('MenuManagerInitialize', 'vocalheistersmenu_init', function(menu_manager)

	MenuCallbackHandler.vhsave = function(this, item)
		VocalHeisters:Save()
	end

	MenuCallbackHandler.vh_donothing = function(this, item)
		-- do nothing
	end

	MenuCallbackHandler.vh_enable_sync = function(this, item)
		VocalHeisters.Settings.enable_sync = item:value() == 'on'
		VocalHeisters:Save()
	end

	MenuCallbackHandler.vh_enable_anticipation_lines = function(this, item)
		VocalHeisters.Settings.enable_anticipation_lines = item:value() == 'on'
		VocalHeisters:Save()
	end

	MenuCallbackHandler.vh_disable_voice_line_force_loading = function(this, item)
		VocalHeisters.Settings.disable_voice_line_force_loading = item:value() == 'on'
		VocalHeisters:Save()
	end	

	MenuHelper:LoadFromJsonFile(VocalHeisters.ModPath .. 'menu/vocalheistersmenu.json', VocalHeisters, VocalHeisters.Settings)
end)

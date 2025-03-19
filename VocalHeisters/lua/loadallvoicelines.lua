dofile(ModPath .. "vocalheisterscore.lua")

if not VocalHeisters.Settings.disable_voice_line_force_loading then
	-- Loads all voice lines to avoid some voice lines not working on certain heists
	local job = Global.level_data and Global.level_data.level_id
	if job ~= "chill" and job ~= "chill_combat" then
		PackageManager:load( "levels/narratives/vlad/ukrainian_job/world_sounds" )
		PackageManager:load( "levels/narratives/vlad/jewelry_store/world_sounds" )
		PackageManager:load( "levels/narratives/h_firestarter/stage_3/world_sounds" )
		PackageManager:load( "levels/narratives/elephant/mad/world_sounds" )
	end
end
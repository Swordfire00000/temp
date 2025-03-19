Hooks:PostHook(TeamAILogicTravel, "exit", "exit_bot_weapons", function (data, new_logic_name)
	if Network:is_server() and new_logic_name ~= "travel" then
		-- re check gadget state
		local weapon = data.unit:inventory():equipped_unit()
		local weapon_base = weapon and weapon:base()
		if weapon_base and weapon_base._is_team_ai then
			BotWeapons:check_set_gadget_state(data.unit, weapon_base)
		end
	end
end)

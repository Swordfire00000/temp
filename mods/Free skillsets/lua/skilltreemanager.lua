local onms_original_skilltreemanager_can_unlock_skill_switch = SkillTreeManager.can_unlock_skill_switch
function SkillTreeManager:can_unlock_skill_switch(selected_skill_switch)
	local is_ok, fail_reasons = onms_original_skilltreemanager_can_unlock_skill_switch(self, selected_skill_switch)

	if is_ok then
		local locks = tweak_data.skilltree.skill_switches[selected_skill_switch].locks
		if locks then
			if locks.achievements then
				for _, achievement in pairs(locks.achievements) do
					local ai = managers.achievment:get_info(achievement)
					if not (ai and ai.awarded) then
						is_ok = false
						table.insert(fail_reasons, "achievement")
						locks.achievement = achievement -- otherwise MenuNodeSkillSwitchGui:_create_menu_item() will choke
						break
					end
				end
			end
		end
	end
	
	return is_ok, fail_reasons
end

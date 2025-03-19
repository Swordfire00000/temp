XPBriefings_inContractGui = false

-- helper function because we have to do this exact hook quite a few times
function hookLevelCapTwice(theclass, thestring)
	Hooks:PreHook(theclass, thestring, "fixXP_pre_" .. tostring(theclass) .. "_" .. thestring, function(self, ...)
		XPBriefings_inContractGui = true
	end)
	Hooks:PostHook(theclass, thestring, "fixXP_post_" .. tostring(theclass) .. "_" .. thestring, function(self, ...)
		XPBriefings_inContractGui = false
	end)
end


if RequiredScript == "lib/managers/menu/crimenetcontractgui" then
	hookLevelCapTwice(CrimeNetContractGui, "init")
	hookLevelCapTwice(CrimeNetContractGui, "set_all")
	hookLevelCapTwice(CrimeNetContractGui, "set_potential_rewards")
	hookLevelCapTwice(CrimeNetContractGui, "count_job_base")
	hookLevelCapTwice(CrimeNetContractGui, "count_job_risk")
	hookLevelCapTwice(CrimeNetContractGui, "count_job_stars")
	hookLevelCapTwice(CrimeNetContractGui, "count_difficulty_stars")
-- i don't even know what ingamecontractgui is
elseif RequiredScript == "lib/managers/menu/ingamecontractgui" then
	hookLevelCapTwice(IngameContractGui, "set_potential_rewards")
elseif RequiredScript == "lib/managers/experiencemanager" then
	local orig_cap = ExperienceManager.reached_level_cap
	local orig_get_levels = ExperienceManager.get_levels_gained_from_xp
	
	function ExperienceManager:reached_level_cap(extra_params)
		if XPBriefings_inContractGui then
			-- behave normally when under level 100
			if self:level_cap() > self:current_level() then return false end
			-- pretend to not be at the cap when infamous and under infamy 500 with unfilled pool
			if self:get_current_prestige_xp() == self:get_max_prestige_xp() then return true end
			if self:current_rank() > 0 and self:current_rank() < tweak_data.infamy.ranks then return false end
			return true
		end
		return orig_cap(self, extra_params)
	end

	function ExperienceManager:get_levels_gained_from_xp(xp, extra_params)
		if XPBriefings_inContractGui then
			-- behave normally when under level 100
			if self:level_cap() > self:current_level() then return orig_get_levels(self, xp, extra_params) end
			
			-- give the percentage towards the infamy bank being full
			-- modulo the value for those that have uncapped infamy bank total
			local prestige_xp_needed = self:get_max_prestige_xp()
			
			local xp_needed_to_level = math.max(1, prestige_xp_needed - (self:get_current_prestige_xp() % prestige_xp_needed))
			local level_gained = math.min(xp / xp_needed_to_level, 1)
			return level_gained
		end
		return orig_get_levels(self, xp, extra_params)
	end
end

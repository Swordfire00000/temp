--So, for no reason, all minimum/maximum XP amounts get multiplied by the number of days the heist is
--fix the function to not do that
local original_xp_by_stars = ExperienceManager.get_contract_xp_by_stars

function ExperienceManager:get_contract_xp_by_stars(job_id, job_stars, risk_stars, professional, job_days, extra_params)
	return original_xp_by_stars(self, job_id, job_stars, risk_stars, professional, 1, extra_params)
end
Hooks:Add("LocalizationManagerPostInit","ActuallyUsefulDifficultyDescriptionsLoc",function(loc)
    LocalizationManager:add_localized_strings({
        menu_risk_pd = "Normal (1x XP|1x Payout)\n",
        menu_risk_swat = "Hard (2x XP|2x Payout)\n",
        menu_risk_fbi = "Very hard (5x XP|5x Payout)\n",
        menu_risk_special = "OVERKILL (10x XP|10x Payout)\n",
        menu_risk_easy_wish = "Mayhem (11.5x XP|11x Payout)\n",
        menu_risk_elite = "Death Wish (13x XP|13x Payout)\n",
        menu_risk_sm_wish = "Death Sentence (14x XP|14x Payout)\n",
        menu_stat_job_completed = "Completions: $stat;.",
    })
end)

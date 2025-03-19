dofile(ModPath .. "vocalheisterscore.lua")

-- Play a flashbanged voice line
Hooks:PostHook(PlayerDamage, "on_flashbanged", "vocalheisters_playerdamage_flashbanged", function(self)
    DelayedCalls:Add("vocalheisters_playerdamage_commentflashbang", math.random() + 0.5, function()
        VocalHeisters:Say("g41x_any")
    end)
end)

-- Play a line when getting revived
local last_being_revived_speak_time = 0
Hooks:PostHook(PlayerDamage, "pause_downed_timer", "vocalheisters_playerdamage_pausedowntimer_playreviveline", function(self)
    if (os.clock() - last_being_revived_speak_time) > 10 then
        DelayedCalls:Add("vocalheisters_playerdamage_commentgetrevived", 1, function()
            local line_to_play = "s05a_sin"
            if math.random() > 0.5 then
                line_to_play = "s05b_sin"
            end
            VocalHeisters:SayThirdPersonLine(line_to_play)
            last_being_revived_speak_time = os.clock()
        end)
    end
end)

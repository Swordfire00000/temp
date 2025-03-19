dofile(ModPath .. "vocalheisterscore.lua")

local last_revive_say_t = 0

-- Play a line when reviving a teammate
Hooks:PostHook(PlayerStandard, "_start_action_interact", "vocalheisters_revivecomment", function(self)
    if not self._interact_params or self._interact_params.tweak_data ~= "revive" then
        return
    end

    if(os.clock() - last_revive_say_t) < 5 then
        return
    end

    -- First down line
    local voice_to_say = "s08x_sin"
    if math.random() > 0.5 then
        voice_to_say = "s09a"
    end

    -- Second down line
    -- Get the amount of downs
    local revived_unit = self._interact_params.object
    if revived_unit and revived_unit:base().downs then
        local downs = revived_unit:base().downs
        if downs == 2 then
            voice_to_say = "s09b"
        elseif downs == 3 then
            voice_to_say = "s09c"
        end
    end
    
    VocalHeisters:Say(voice_to_say)

    last_revive_say_t = os.clock()
end)

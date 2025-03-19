dofile(ModPath .. "vocalheisterscore.lua")

-- Comment on end of assault
-- Don't spam the voice line, only play it once every 20 seconds at most
local last_assault_end_speak_time = 0
local assault_mode_speak = function(self, enabled)

    -- Don't play this in the first 1 second of the heist
    local gameTime = TimerManager and TimerManager:game() and TimerManager:game():time()
    if gameTime and gameTime < 1 then
        return
    end

    -- Don't play this if the assault started, or if the last say time was too short ago
    if enabled or (os.clock() - last_assault_end_speak_time) < 20 then
        return
    end

    DelayedCalls:Add("vocalheisters_commentassaultend", VocalHeisters:FloatRandom(5, 8), function()
        -- Only one person in the lobby should comment on the assault ending
        VocalHeisters:SayOnce("p24")
        last_assault_end_speak_time = os.clock()
    end)
end

-- This is called by the host
Hooks:PostHook(GroupAIStateBase, "set_assault_mode", "vocalheisters_setassaultmode", assault_mode_speak)
-- Called by client
Hooks:PostHook(GroupAIStateBase, "sync_assault_mode", "vocalheisters_syncassaultmode", assault_mode_speak)

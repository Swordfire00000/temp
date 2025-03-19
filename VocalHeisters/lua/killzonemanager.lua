dofile(ModPath .. "vocalheisterscore.lua")

-- This isn't even 100% reliable, some instances of teargas don't trigger this but trigger the firedamage function instead
-- On top of that, the FWB thermite triggers this teargas line here too
-- Thanks overkill

-- Play a teargas voice line
local last_gas_speak_time = 0

Hooks:PostHook(KillzoneManager, "_deal_gas_damage", "vocalheisters_killzonemgr_dealgasdamage_teargasline", function(self, unit)
    if not unit or unit ~= managers.player:player_unit() then
        return
    end

    -- Check if the last instance of saying the line was more than 10 seconds ago
    if (os.clock() - last_gas_speak_time) > 10 then
        VocalHeisters:Say("g42x_any")
        last_gas_speak_time = os.clock()
    end
end)

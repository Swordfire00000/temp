dofile(ModPath .. "vocalheisterscore.lua")

-- Which lines to play as a response to Bain announcing an assault
-- 2 and 6 are "30 seconds remaining",
-- 3 and 7 are 20 secs,
-- 4 and 8 are 10 secs remaining
local anticipation_lines = {
    [2] = "g70",
    [3] = nil,
    [4] = "g50",
    [6] = "g70",
    [7] = nil,
    [8] = "g50"
}

-- Say a line when assaults are anticipating
-- STRONGLY recommend using this in conjunction with Kuziz' narrator restoration https://modworkshop.net/mod/28454
-- VoidUI also has this
-- I think without one of those mods, this part doesn't work at all
if VocalHeisters.Settings.enable_anticipation_lines then
    Hooks:PostHook(HUDManager, "sync_assault_dialog", "vocalheisters_sync_assault_dialog_playassaultlines", function(self, index)

        if not anticipation_lines[index] then
            return
        end

        DelayedCalls:Add("vocalheisters_sayassaultline_" .. anticipation_lines[index], VocalHeisters:FloatRandom(4, 7), function()
            VocalHeisters:SayOnceThirdPersonLine(anticipation_lines[index])
        end)
    end)
end

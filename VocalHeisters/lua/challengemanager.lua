dofile(ModPath .. "vocalheisterscore.lua")

-- Comment on a completed side job/challenge
-- Sadly not a PostHook because the return value has to be checked
local check_challenge_completed_orig = ChallengeManager._check_challenge_completed
function ChallengeManager:_check_challenge_completed(...)
    local result = check_challenge_completed_orig(self, ...)

    if result then
        DelayedCalls:Add("vocalheisters_challengecomplete", 2, function()
            VocalHeisters:Say("v46")
        end)
    end

    return result
end

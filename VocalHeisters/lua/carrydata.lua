dofile(ModPath .. "vocalheisterscore.lua")

local function isBagBeingStolen(parent_unit)
    return parent_unit and managers.enemy and managers.enemy:all_enemies()[parent_unit:key()] and true or false
end

-- Comment on the cops stealing the bags
-- For real this time
local last_steal_speak_time = 0

-- Note: this hook is called on both the host and the client. Hooking into UnitNetworkHandler is not necessary.
Hooks:PostHook(CarryData, "link_to", "vocalheisters_linkbag_bagpickedupbyenemy", function(self, parent_unit, keep_collisions)

    -- Check if bag picked up by enemy
    if not isBagBeingStolen(parent_unit) then
        return
    end

    -- Say the line JC
    if last_steal_speak_time and (os.clock() - last_steal_speak_time) > 10 then
        DelayedCalls:Add("vocalheisters_copsarestealingloot", 1.5 + math.random(), function()
            -- Do the check again just to make sure that the bag wasn't "liberated" in the meantime
            if not isBagBeingStolen(parent_unit) then
                return
            end
            VocalHeisters:SayOnce("p31")
        end)
        last_steal_speak_time = os.clock()
    end
end)

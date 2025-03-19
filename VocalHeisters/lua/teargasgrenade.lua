dofile(ModPath .. "vocalheisterscore.lua")

local last_teargas_speak_time = 0

-- A little bit heavier and more redundant than I'd like, but it sure beats overriding the whole function for a silly voice mod
-- This is a prehook because it has to check self._damage_t *before* this function touches it
Hooks:PreHook(TearGasGrenade, "update", "vocalheisters_updateteargasgrenade_speakline", function(self, unit, t, dt)
    if self._damage_t and self._damage_t < t then
        local player = managers.player:player_unit()
		local radius_sq = self.radius * self.radius
		local in_range = player and mvector3.distance_sq(player:position(), self._unit:position()) <= radius_sq

        if player and in_range then
            -- If we get this far, the player *will* be damaged by teargas in the "real" function
            if (os.clock() - last_teargas_speak_time) > 10 then
                VocalHeisters:Say("g42x_any")
                last_teargas_speak_time = os.clock()
            end
        end
    end
end)

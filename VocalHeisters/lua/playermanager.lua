dofile(ModPath .. "vocalheisterscore.lua")

-- Comment on having used your last cable tie
Hooks:PreHook(PlayerManager, "remove_special", "vocalheisterscore_remove_specialequipment", function(self, name)
    local special_equipment = self._equipment.specials[name]

	if not special_equipment then
		return
    end

    local special_amount = special_equipment.amount and Application:digest_value(special_equipment.amount, false)
    
    if special_equipment.is_cable_tie and special_amount == 1 then
        VocalHeisters:Say("s32x_sin")
    end
end)

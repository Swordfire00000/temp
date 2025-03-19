local old_init = WeaponTweakData.init

function WeaponTweakData:init(tweak_data)
    old_init(self, tweak_data)
	for _, weapon in pairs(self) do
		if weapon.desc_id then
			weapon.has_description = true
		end
	end
end
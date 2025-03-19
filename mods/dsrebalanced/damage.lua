function CharacterTweakData:_set_sm_wish()

-- Health of anything non bulldozer related
	self:_multiply_all_hp(6, 1.5)

-- Bulldozer health / is multiplied by 10 / mini is the minigun dozer
	self.tank.HEALTH_INIT = 2400
	self.tank_mini.HEALTH_INIT = 4800
	self.tank_medic.HEALTH_INIT = 2400

-- falloff in meters
	-- 1 - 0 to 1
	-- 2 - 1 to 5
	-- 3 - 5 to 10
	-- 4 - 10 to 20
	-- 3 - 20 to 30+
	
-- Cop Damage

	self.cop.weapon.is_pistol.FALLOFF[1].dmg_mul = 2.5
	self.cop.weapon.is_pistol.FALLOFF[2].dmg_mul = 2
	self.cop.weapon.is_pistol.FALLOFF[3].dmg_mul = 1.5
	self.cop.weapon.is_pistol.FALLOFF[4].dmg_mul = 1
	self.cop.weapon.is_pistol.FALLOFF[5].dmg_mul = 0.5

	self.cop.weapon.is_revolver.FALLOFF[1].dmg_mul = 2.5
	self.cop.weapon.is_revolver.FALLOFF[2].dmg_mul = 2
	self.cop.weapon.is_revolver.FALLOFF[3].dmg_mul = 1.5
	self.cop.weapon.is_revolver.FALLOFF[4].dmg_mul = 1
	self.cop.weapon.is_revolver.FALLOFF[5].dmg_mul = 0.5

	-- Shotgun base damage is 70

	self.cop.weapon.is_shotgun_pump.FALLOFF[1].dmg_mul = 3.5
	self.cop.weapon.is_shotgun_pump.FALLOFF[2].dmg_mul = 3
	self.cop.weapon.is_shotgun_pump.FALLOFF[3].dmg_mul = 2.5
	self.cop.weapon.is_shotgun_pump.FALLOFF[4].dmg_mul = 1.5
	self.cop.weapon.is_shotgun_pump.FALLOFF[5].dmg_mul = 0.5

	self.cop.weapon.is_smg = self.zeal_swat.weapon.is_smg
	
-- Swat damage fall off

	-- AR base damage is 30

	self.zeal_heavy_swat.weapon.is_rifle.FALLOFF[1].dmg_mul = 3.3
	self.zeal_heavy_swat.weapon.is_rifle.FALLOFF[2].dmg_mul = 3
	self.zeal_heavy_swat.weapon.is_rifle.FALLOFF[3].dmg_mul = 2.8
	self.zeal_heavy_swat.weapon.is_rifle.FALLOFF[4].dmg_mul = 2.5
	self.zeal_heavy_swat.weapon.is_rifle.FALLOFF[5].dmg_mul = 2.1

	-- SMG base damage is 10

	self.zeal_swat.weapon.is_smg.FALLOFF[1].dmg_mul = 6.5
	self.zeal_swat.weapon.is_smg.FALLOFF[2].dmg_mul = 6
	self.zeal_swat.weapon.is_smg.FALLOFF[3].dmg_mul = 5.5
	self.zeal_swat.weapon.is_smg.FALLOFF[4].dmg_mul = 4.8
	self.zeal_swat.weapon.is_smg.FALLOFF[5].dmg_mul = 4

	-- Sniper base damage is 10

	self.heavy_swat_sniper.weapon.is_rifle = self.sniper.weapon.is_rifle

	-- Normal // Hard swat

		self.swat.weapon.is_smg = self.zeal_swat.weapon.is_smg

		self.swat.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

		self.heavy_swat.weapon.is_rifle = self.zeal_heavy_swat.weapon.is_rifle

		self.heavy_swat.weapon.is_shotgun = self.cop.weapon.is_shotgun_pump

	-- Very Hard // Overkill swat

		self.fbi_swat.weapon.is_rifle = self.zeal_heavy_swat.weapon.is_rifle

		self.fbi_swat.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

		self.fbi_heavy_swat.weapon.is_rifle = self.zeal_heavy_swat.weapon.is_rifle

		self.fbi_heavy_swat.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

	-- Deathwish // Mayham swat

		self.city_swat.weapon.is_smg = self.zeal_swat.weapon.is_smg
		
		self.city_swat.weapon.rifle = self.zeal_heavy_swat.weapon.is_rifle

		self.city_swat.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

-- Special damage fall off

-- Shields

	-- Smg base damage is 10

	self.shield.weapon.is_smg.FALLOFF[1].dmg_mul = 3
	self.shield.weapon.is_smg.FALLOFF[2].dmg_mul = 2.5
	self.shield.weapon.is_smg.FALLOFF[3].dmg_mul = 2
	self.shield.weapon.is_smg.FALLOFF[4].dmg_mul = 1.5
	self.shield.weapon.is_smg.FALLOFF[5].dmg_mul = 1

	-- Pistol base damage is 10

	self.shield.weapon.is_pistol.FALLOFF[1].dmg_mul = 5
	self.shield.weapon.is_pistol.FALLOFF[2].dmg_mul = 4
	self.shield.weapon.is_pistol.FALLOFF[3].dmg_mul = 3.5
	self.shield.weapon.is_pistol.FALLOFF[4].dmg_mul = 2.8
	self.shield.weapon.is_pistol.FALLOFF[5].dmg_mul = 2

	self.marshal_shield.weapon.is_pistol = self.shield.weapon.is_pistol

-- Marshal

	-- Shotgun marshal base damage is 10

	self.marshal_shield_break.weapon.is_shotgun_mag.FALLOFF[1].dmg_mul = 7.5
	self.marshal_shield_break.weapon.is_shotgun_mag.FALLOFF[2].dmg_mul = 5
	self.marshal_shield_break.weapon.is_shotgun_mag.FALLOFF[3].dmg_mul = 4
	self.marshal_shield_break.weapon.is_shotgun_mag.FALLOFF[4].dmg_mul = 2.5
	self.marshal_shield_break.weapon.is_shotgun_mag.FALLOFF[5].dmg_mul = 1

	-- Marksman base damage is 10

	self.marshal_marksman.weapon.is_rifle.FALLOFF[1].dmg_mul = 15
	self.marshal_marksman.weapon.is_rifle.FALLOFF[2].dmg_mul = 12
	self.marshal_marksman.weapon.is_rifle.FALLOFF[3].dmg_mul = 11.5
	self.marshal_marksman.weapon.is_rifle.FALLOFF[4].dmg_mul = 10.9
	self.marshal_marksman.weapon.is_rifle.FALLOFF[5].dmg_mul = 10

-- Sniper - only has 3 falloff ranges - Base damage 20

	self.sniper.weapon.is_rifle.FALLOFF[1].dmg_mul = 10
	self.sniper.weapon.is_rifle.FALLOFF[2].dmg_mul = 12
	self.sniper.weapon.is_rifle.FALLOFF[3].dmg_mul = 14

-- Taser // medic Taser

	-- Taser must have its own set or will crash due to tase distance value
	-- Taser base damage is 30

	self.taser.weapon.is_rifle.FALLOFF[1].dmg_mul = 3.3
	self.taser.weapon.is_rifle.FALLOFF[2].dmg_mul = 3
	self.taser.weapon.is_rifle.FALLOFF[3].dmg_mul = 2.8
	self.taser.weapon.is_rifle.FALLOFF[4].dmg_mul = 2.5
	self.taser.weapon.is_rifle.FALLOFF[5].dmg_mul = 2.1

	self.medic.weapon.is_rifle = self.zeal_heavy_swat.weapon.is_rifle

	self.medic.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

-- Normal Dozers

	self.tank.weapon.is_shotgun_pump = self.cop.weapon.is_shotgun_pump

	-- Auto shotgun base damage is 30

	self.tank.weapon.is_shotgun_mag.FALLOFF[1].dmg_mul = 3.5
	self.tank.weapon.is_shotgun_mag.FALLOFF[2].dmg_mul = 2.5
	self.tank.weapon.is_shotgun_mag.FALLOFF[3].dmg_mul = 2
	self.tank.weapon.is_shotgun_mag.FALLOFF[4].dmg_mul = 1.5
	self.tank.weapon.is_shotgun_mag.FALLOFF[5].dmg_mul = 1

	-- LMG base damage is 20

	self.tank.weapon.is_lmg.FALLOFF[1].dmg_mul = 4.5
	self.tank.weapon.is_lmg.FALLOFF[2].dmg_mul = 3.5
	self.tank.weapon.is_lmg.FALLOFF[3].dmg_mul = 3.2
	self.tank.weapon.is_lmg.FALLOFF[4].dmg_mul = 2.8
	self.tank.weapon.is_lmg.FALLOFF[5].dmg_mul = 2.2

-- Medic Dozer - base damage is 10

	self.tank_medic.weapon.is_smg.FALLOFF[1].dmg_mul = 4
	self.tank_medic.weapon.is_smg.FALLOFF[2].dmg_mul = 3
	self.tank_medic.weapon.is_smg.FALLOFF[3].dmg_mul = 2
	self.tank_medic.weapon.is_smg.FALLOFF[4].dmg_mul = 1
	self.tank_medic.weapon.is_smg.FALLOFF[5].dmg_mul = 0.5

-- Minigun Dozer - base damage is 20

	self.tank_mini.weapon.mini.FALLOFF[1].dmg_mul = 3.5
	self.tank_mini.weapon.mini.FALLOFF[2].dmg_mul = 2.5
	self.tank_mini.weapon.mini.FALLOFF[3].dmg_mul = 2.1
	self.tank_mini.weapon.mini.FALLOFF[4].dmg_mul = 1.6
	self.tank_mini.weapon.mini.FALLOFF[5].dmg_mul = 1

-- Cloaker

	self.spooc.weapon.is_smg = self.zeal_swat.weapon.is_smg

	self:_process_weapon_usage_table()

	self.flashbang_multiplier = 2
	self.concussion_multiplier = 1

end

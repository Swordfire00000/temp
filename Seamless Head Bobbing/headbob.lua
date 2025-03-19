--[[Recommended value 0.0 - 0.1]]
local running_shake_effect_intensity	= 0.015		--Sprinting		(Default 0.015)
local walking_shake_effect_intensity	= 0.01		--Walking		(Default 0.01)
local crouching_shake_effect_intensity	= 0.005		--Crouching		(Default 0.005)
local ads_shake_intensity				= 0.002		--Aiming		(Default 0.002)

function PlayerStandard:_update_foley(t, input)
	if self._state_data.on_zipline then
		return
	end

	if not self._gnd_ray and not self._state_data.on_ladder then
		if not self._state_data.in_air then
			self._state_data.in_air = true
			self._state_data.enter_air_pos_z = self._pos.z

			self:_interupt_action_running(t)
			self._unit:set_driving("orientation_object")
		end
	elseif self._state_data.in_air then
		self._unit:set_driving("script")

		self._state_data.in_air = false
		local from = self._pos + math.UP * 10
		local to = self._pos - math.UP * 60
		local material_name, pos, norm = World:pick_decal_material(from, to, self._slotmask_bullet_impact_targets)

		self._unit:sound():play_land(material_name)

		if self._unit:character_damage():damage_fall({
			height = self._state_data.enter_air_pos_z - self._pos.z
		}) then
			self._running_wanted = false

			managers.rumble:play("hard_land")
			self._ext_camera:play_shaker("player_fall_damage")
			self:_start_action_ducking(t)
		elseif input.btn_run_state then
			self._running_wanted = true
		end

		self._jump_t = nil
		self._jump_vel_xy = nil

		self._ext_camera:play_shaker("player_land", 0.2)
		managers.rumble:play("land")
	elseif self._jump_vel_xy and t - self._jump_t > 0.3 then
		self._jump_vel_xy = nil

		if input.btn_run_state then
			self._running_wanted = true
		end
	end

	self:_check_step(t)
end

function PlayerStandard:_start_action_running(t)
	if self._slowdown_run_prevent then
		self._running_wanted = false

		return
	end

	if not self._move_dir then
		self._running_wanted = true

		return
	end

	if self:on_ladder() or self:_on_zipline() then
		return
	end

	if self._shooting and not self._equipped_unit:base():run_and_shoot_allowed() or self:_changing_weapon() or self:_is_meleeing() or self._use_item_expire_t or self._state_data.in_air or self:_is_throwing_projectile() or self:_is_charging_weapon() then
		self._running_wanted = true

		return
	end

	if self._state_data.ducking and not self:_can_stand() then
		self._running_wanted = true

		return
	end

	if not self:_can_run_directional() then
		return
	end

	self._running_wanted = false

	if managers.player:get_player_rule("no_run") then
		return
	end

	if not self._unit:movement():is_above_stamina_threshold() then
		return
	end

	if (not self._state_data.shake_player_start_running or not self._ext_camera:shaker():is_playing(self._state_data.shake_player_start_running)) and self._setting_use_headbob then
		self._state_data.shake_player_start_running = self._ext_camera:play_shaker("player_start_running", 0.15)
	end

	self:set_running(true)

	self._end_running_expire_t = nil
	self._start_running_t = t
	self._play_stop_running_anim = nil

	if not self:_is_reloading() or not self.RUN_AND_RELOAD then
		if not self._equipped_unit:base():run_and_shoot_allowed() then
			self._ext_camera:play_redirect(self:get_animation("start_running"))
		else
			self._ext_camera:play_redirect(self:get_animation("idle"))
		end
	end

	if not self.RUN_AND_RELOAD then
		self:_interupt_action_reload(t)
	end

	self:_interupt_action_steelsight(t)
	self:_interupt_action_ducking(t)
end

function PlayerStandard:_get_walk_headbob()
	if self._state_data.using_bipod then
		return 0
	elseif self._state_data.in_steelsight then
		return ads_shake_intensity
	elseif self._state_data.in_air then
		return 0
	elseif self._state_data.ducking then
		return crouching_shake_effect_intensity
	elseif self._running then
		return running_shake_effect_intensity --0.1 * (self._equipped_unit:base():run_and_shoot_allowed() and 0.5 or 1)
	end

	return walking_shake_effect_intensity
end

if string.lower(RequiredScript) == "lib/units/beings/player/states/playerstandard" then
	PlayerStandard.NADE_TIMEOUT = VHUDPlus:getTweakEntry("STEALTH_NADE_TIMEOUT", "number", 0.25)		--Timeout for 2 NadeKey pushes, to prevent accidents in stealth
	PlayerStandard.HIDE_MELEE_RELOAD_PDTH = (PDTHHud and PDTHHud.Options:GetValue("HUD/Interaction"))

	local enter_original = PlayerStandard.enter
	local _update_interaction_timers_original = PlayerStandard._update_interaction_timers
	local _check_action_interact_original = PlayerStandard._check_action_interact
	local _start_action_reload_original = PlayerStandard._start_action_reload
	local _update_reload_timers_original = PlayerStandard._update_reload_timers
	local _interupt_action_reload_original = PlayerStandard._interupt_action_reload
	local _start_action_melee_original = PlayerStandard._start_action_melee
	local _update_melee_timers_original = PlayerStandard._update_melee_timers
	local _do_melee_damage_original = PlayerStandard._do_melee_damage
	local _check_action_throw_grenade_original = PlayerStandard._check_action_throw_grenade

	function PlayerStandard:_update_interaction_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_interaction_timers_original(self, t, ...)
	end

	function PlayerStandard:_check_action_interact(t, input, ...)
		if not self:_check_interact_toggle(t, input) then
			return _check_action_interact_original(self, t, input, ...)
		end
	end

	function PlayerStandard:_check_interaction_locked(t)
		PlayerStandard.LOCK_MODE = VHUDPlus:getSetting({"INTERACTION", "LOCK_MODE"}, 3)						--Lock interaction, if MIN_TIMER_DURATION is longer then total interaction time, or current interaction time
		PlayerStandard.MIN_TIMER_DURATION = VHUDPlus:getSetting({"INTERACTION", "MIN_TIMER_DURATION"}, 5)			--Min interaction duration (in seconds) for the toggle behavior to activate
		local is_locked = false
		if self._interact_params ~= nil then
			local tweak_data = self._interact_params.tweak_data or ""
			local total_timer = self._interact_params.timer or 0
			if PlayerStandard.LOCK_MODE >= 5 then
				is_locked = tweak_data == "corpse_alarm_pager"
			elseif PlayerStandard.LOCK_MODE >= 4 then
				is_locked = (tweak_data == "corpse_alarm_pager" or string.match(tweak_data, "pick_lock"))
			elseif PlayerStandard.LOCK_MODE >= 3 then
				is_locked = self._interact_params and (self._interact_params.timer >= PlayerStandard.MIN_TIMER_DURATION) -- lock interaction, when total timer time is longer then given time
			elseif PlayerStandard.LOCK_MODE >= 2 then
				is_locked = (total_timer  - self._interact_expire_t) >= PlayerStandard.MIN_TIMER_DURATION --lock interaction, when interacting longer then given time
			end
		end

		if self._interaction_locked ~= is_locked then
			managers.hud:set_interaction_bar_locked(is_locked, self._interact_params and self._interact_params.tweak_data or "")
			self._interaction_locked = is_locked
		end
	end

	function PlayerStandard:_check_interact_toggle(t, input)
		PlayerStandard.EQUIPMENT_PRESS_INTERRUPT = VHUDPlus:getSetting({"INTERACTION", "EQUIPMENT_PRESS_INTERRUPT"}, true) 	--Use the equipment key ('G') to toggle off active interactions
		local interrupt_key_press = input.btn_interact_press
		if PlayerStandard.EQUIPMENT_PRESS_INTERRUPT then
			interrupt_key_press = input.btn_use_item_press
		end

		if interrupt_key_press and self:_interacting() then
			self:_interupt_action_interact()
			return true
		elseif input.btn_interact_release and self._interact_params then
			if self._interaction_locked then
				return true
			end
		end
	end

	local hide_int_state = {
		["bleed_out"] = true,
		["fatal"] = true,
		["incapacitated"] = true,
		["arrested"] = true,
		["jerry1"] = true
	}
	function PlayerStandard:enter(...)
		enter_original(self, ...)
		if hide_int_state[managers.player:current_state()] and (self._state_data.show_reload or self._state_data.show_melee) then
			managers.hud:hide_interaction_bar(false)
			self._state_data.show_reload = false
			self._state_data.show_melee = false
		end
	end

	function PlayerStandard:_start_action_reload(t, ...)
		_start_action_reload_original(self, t, ...)
		PlayerStandard.SHOW_RELOAD = VHUDPlus:getSetting({"INTERACTION", "SHOW_RELOAD"}, false)
		if PlayerStandard.SHOW_RELOAD and not hide_int_state[managers.player:current_state()] and not PlayerStandard.HIDE_MELEE_RELOAD_PDTH then
			if self._equipped_unit and not self._equipped_unit:base():clip_full() then
				self._state_data.show_reload = true
				managers.hud:show_interaction_bar(0, self._state_data.reload_expire_t or 0)
				self._state_data.reload_offset = t
			end
		end
	end

	function PlayerStandard:_update_reload_timers(t, ...)
		_update_reload_timers_original(self, t, ...)
		if PlayerStandard.SHOW_RELOAD and not PlayerStandard.HIDE_MELEE_RELOAD_PDTH then
			if self._state_data.show_reload and hide_int_state[managers.player:current_state()] then
				-- managers.hud:hide_interaction_bar(false)
				-- self._state_data.show_reload = false
			elseif not self._state_data.reload_expire_t and self._state_data.show_reload then
				managers.hud:hide_interaction_bar(true)
				self._state_data.show_reload = false
			elseif self._state_data.show_reload then
				managers.hud:set_interaction_bar_width(	t and t - self._state_data.reload_offset or 0, self._state_data.reload_expire_t and self._state_data.reload_expire_t - self._state_data.reload_offset or 0 )
			end
		end
	end

	function PlayerStandard:_interupt_action_reload(...)
		local val = _interupt_action_reload_original(self, ...)
		if self._state_data.show_reload and PlayerStandard.SHOW_RELOAD and not PlayerStandard.HIDE_MELEE_RELOAD_PDTH then
			managers.hud:hide_interaction_bar(false)
			self._state_data.show_reload = false
		end
		return val
	end

	function PlayerStandard:_start_action_melee(t, input, instant, ...)
		local val = _start_action_melee_original(self, t, input, instant, ...)
		if not instant then
			PlayerStandard.SHOW_MELEE = VHUDPlus:getSetting({"INTERACTION", "SHOW_MELEE"}, false)
			if PlayerStandard.SHOW_MELEE and self._state_data.meleeing and not hide_int_state[managers.player:current_state()] and not PlayerStandard.HIDE_MELEE_RELOAD_PDTH then
				self._state_data.show_melee = true
				self._state_data.melee_charge_duration = tweak_data.blackmarket.melee_weapons[managers.blackmarket:equipped_melee_weapon()].stats.charge_time or 1
				managers.hud:show_interaction_bar(0, self._state_data.melee_charge_duration)
			end
		end
		return val
	end

	function PlayerStandard:_update_melee_timers(t, ...)
		local val = _update_melee_timers_original(self, t, ...)
		if PlayerStandard.SHOW_MELEE and self._state_data.meleeing and self._state_data.show_melee and not PlayerStandard.HIDE_MELEE_RELOAD_PDTH then
			local melee_lerp = self:_get_melee_charge_lerp_value(t)
			if hide_int_state[managers.player:current_state()] then
				managers.hud:hide_interaction_bar()
				self._state_data.show_melee = false
			elseif melee_lerp < 1 then
				managers.hud:set_interaction_bar_width(self._state_data.melee_charge_duration * melee_lerp, self._state_data.melee_charge_duration)
			elseif self._state_data.show_melee then
				managers.hud:hide_interaction_bar()
				self._state_data.show_melee = false
			end
		end
		return val
	end

	function PlayerStandard:_do_melee_damage(...)
		if self._state_data.show_melee then
			managers.hud:hide_interaction_bar()
			self._state_data.show_melee = false
		end
		return _do_melee_damage_original(self, ...)
	end

	function PlayerStandard:_check_action_throw_grenade(t, input, ...)
		if input.btn_throw_grenade_press and VHUDPlus:getSetting({"INTERACTION", "SUPRESS_NADES_STEALTH"}, true) then
			if managers.groupai:state():whisper_mode() and (t - (self._last_grenade_t or 0) >= PlayerStandard.NADE_TIMEOUT) then
				self._last_grenade_t = t
				return
			end
		end

		return _check_action_throw_grenade_original(self, t, input, ...)
	end

	local mvec3_dist_sq = mvector3.distance_sq
    local ignored_states = { arrested = 1, bleed_out = 1, fatal = 1, incapacitated = 1 }
    local get_intimidation_action_original = PlayerStandard._get_intimidation_action
    function PlayerStandard:_get_intimidation_action(prime_target, primary_only, detect_only, secondary, ...)
	    local voice_type, new_action, plural = get_intimidation_action_original(self, prime_target, primary_only, detect_only, secondary, ...)
	    if voice_type == "revive" or secondary or detect_only then
		    return voice_type, plural, prime_target
	    end

	    local unit_type_enemy = 0
		local unit_type_civilian = 1
	    local unit_type_teammate = 2
	    if prime_target then
		    if prime_target.unit_type == unit_type_teammate then
			    local record = managers.groupai:state():all_criminals()[prime_target.unit:key()]
			    local current_state_name = self._unit:movement():current_state_name()
			    if not ignored_states[current_state_name] then
				    local rally_skill_data = self._ext_movement:rally_skill_data()
				    if rally_skill_data and mvec3_dist_sq(self._pos, record.m_pos) < rally_skill_data.range_sq then
					    local needs_revive
					    if prime_target.unit:base().is_husk_player then
						    local is_arrested = prime_target.unit:movement():current_state_name() == "arrested"
						    needs_revive = prime_target.unit:interaction():active() and prime_target.unit:movement():need_revive() and not is_arrested
					    else
						    needs_revive = prime_target.unit:character_damage():need_revive()
					    end

					    if needs_revive and managers.player:has_disabled_cooldown_upgrade("cooldown", "long_dis_revive") then
                            local remaining_cooldown = managers.player:get_disabled_cooldown_time("cooldown", "long_dis_revive")
						    if remaining_cooldown > 0 and VHUDPlus:getSetting({"MISCHUD", "INSPIRE_HINT"}, true)then
							    remaining_cooldown = remaining_cooldown - Application:time()
							    managers.hud:show_hint({ text = string.format(managers.localization:to_upper_text("wolfhud_inspire_hint_text"), remaining_cooldown) })
						    end
					    end
				    end
			    end
		    else
			    if (prime_target.unit_type == unit_type_enemy or prime_target.unit_type == unit_type_civilian) then
				    plural = false
			    end
		    end
	    end
	    return voice_type, plural, prime_target
    end

elseif string.lower(RequiredScript) == "lib/units/beings/player/states/playercivilian" then

	local _update_interaction_timers_original = PlayerCivilian._update_interaction_timers
	local _check_action_interact_original = PlayerCivilian._check_action_interact

	function PlayerCivilian:_update_interaction_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_interaction_timers_original(self, t, ...)
	end

	function PlayerCivilian:_check_action_interact(t, input, ...)
		if not self:_check_interact_toggle(t, input) then
			return _check_action_interact_original(self, t, input, ...)
		end
	end

elseif string.lower(RequiredScript) == "lib/units/beings/player/states/playermaskoff" then

	local _update_interaction_timers_original = PlayerMaskOff._update_interaction_timers
	local _check_action_interact_original = PlayerMaskOff._check_action_interact

	function PlayerMaskOff:_update_interaction_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_interaction_timers_original(self, t, ...)
	end

	function PlayerMaskOff:_check_action_interact(t, input, ...)
		if not self:_check_interact_toggle(t, input) then
			return _check_action_interact_original(self, t, input, ...)
		end
	end

elseif string.lower(RequiredScript) == "lib/units/beings/player/states/playerdriving" then

	local _update_action_timers_original = PlayerDriving._update_action_timers
	local _start_action_exit_vehicle_original = PlayerDriving._start_action_exit_vehicle
	local _check_action_exit_vehicle_original = PlayerDriving._check_action_exit_vehicle

	function PlayerDriving:_update_action_timers(t, ...)
		self:_check_interaction_locked(t)
		return _update_action_timers_original(self, t, ...)
	end

	function PlayerDriving:_start_action_exit_vehicle(t)
		if not self:_interacting() then
			return _start_action_exit_vehicle_original(self, t)
		end
	end

	function PlayerDriving:_check_action_exit_vehicle(t, input, ...)
		if not self:_check_interact_toggle(t, input) then
			return _check_action_exit_vehicle_original(self, t, input, ...)
		end
	end

	function PlayerDriving:_check_interact_toggle(t, input)
		PlayerDriving.EQUIPMENT_PRESS_INTERRUPT = VHUDPlus:getSetting({"INTERACTION", "EQUIPMENT_PRESS_INTERRUPT"}, true) 	--Use the equipment key ('G') to toggle off active interactions
		local interrupt_key_press = input.btn_interact_press
		if PlayerDriving.EQUIPMENT_PRESS_INTERRUPT then
			interrupt_key_press = input.btn_use_item_press
		end
		if interrupt_key_press and self:_interacting() then
			self:_interupt_action_exit_vehicle()
			return true
		elseif input.btn_interact_release and self:_interacting() then
			if self._interaction_locked then
				return true
			end
		end
	end

	function PlayerDriving:_check_interaction_locked(t)
		PlayerDriving.LOCK_MODE = VHUDPlus:getSetting({"INTERACTION", "LOCK_MODE"}, 3)						--Lock interaction, if MIN_TIMER_DURATION is longer then total interaction time, or current interaction time
		PlayerDriving.MIN_TIMER_DURATION = VHUDPlus:getSetting({"INTERACTION", "MIN_TIMER_DURATION"}, 5)			--Min interaction duration (in seconds) for the toggle behavior to activate
		local is_locked = false
		if self._exit_vehicle_expire_t ~= nil then
			if PlayerDriving.LOCK_MODE == 3 then
				is_locked = (PlayerDriving.EXIT_VEHICLE_TIMER >= PlayerDriving.MIN_TIMER_DURATION) -- lock interaction, when total timer time is longer then given time
			elseif PlayerDriving.LOCK_MODE == 2 then
				is_locked = self._exit_vehicle_expire_t and (t - (self._exit_vehicle_expire_t - PlayerDriving.EXIT_VEHICLE_TIMER) >= PlayerDriving.MIN_TIMER_DURATION) --lock interaction, when interacting longer then given time
			end
		end

		if self._interaction_locked ~= is_locked then
			managers.hud:set_interaction_bar_locked(is_locked, "")
			self._interaction_locked = is_locked
		end
	end

	function PlayerDriving:_set_camera_limits(mode)
		if mode == "driving" then
			self._camera_unit:base():set_limits(180, 20)
		elseif mode == "passenger" then
			self._camera_unit:base():set_limits(100, 30)
		elseif mode == "shooting" then
			self._camera_unit:base():set_limits(180, 40)
		end
    end

elseif string.lower(RequiredScript) == "lib/managers/hudmanagerpd2" then
	local custom_huds_support = VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false)
	function HUDManager:set_interaction_bar_locked(status, tweak_entry)
		if not custom_huds_support then
			self._hud_interaction:set_locked(status, tweak_entry)
		end
	end

	local show_interact_original = HUDManager.show_interact
	local remove_interact_original = HUDManager.remove_interact

	function HUDManager:press_substitute(text, new)
		return text:gsub("Hold", new)
	end

	function HUDManager.show_interact(self, data)
		if self._interact_visible and not data.force then
			return
		end

		if PlayerStandard.LOCK_MODE == 3 and 0 >= PlayerStandard.MIN_TIMER_DURATION then
			data.text = HUDManager:press_substitute(data.text, "Press")
		end

		self._interact_visible = true
		return show_interact_original(self, data)
	end

	function HUDManager.remove_interact(self)
		self._interact_visible = nil
		return remove_interact_original(self)
	end

	function HUDManager:show_drill_interact(...)
		if VoidUI and VoidUI.options.enable_interact then
			return
		end
	    self._hud_interaction:show_drill_interact(...)
    end

elseif string.lower(RequiredScript) == "lib/managers/hud/hudinteraction" then
	local init_original 				= HUDInteraction.init
	local show_interaction_bar_original = HUDInteraction.show_interaction_bar
	local hide_interaction_bar_original = HUDInteraction.hide_interaction_bar
	local show_interact_original		= HUDInteraction.show_interact
	local remove_interact_original      = HUDInteraction.remove_interact
	local destroy_original				= HUDInteraction.destroy

	local set_interaction_bar_width_original = HUDInteraction.set_interaction_bar_width

	function HUDInteraction:init(...)
		init_original(self, ...)

		local interact_text = self._hud_panel:child(self._child_name_text)
		local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
		self._original_circle_radius = self._circle_radius
		self._original_interact_text_font_size = interact_text:font_size()
		self._original_invalid_text_font_size = invalid_text:font_size()

		if not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
			self:_rescale()
		end

	end

	function HUDInteraction:set_interaction_bar_width(current, total)
		set_interaction_bar_width_original(self, current, total)

		if HUDInteraction.SHOW_TIME_REMAINING then
			local text = string.format("%.1fs", math.max(total - current, 0))
			self._interact_time:set_text(text)
			local perc = current/total
			local show = perc < 1
			local color = math.lerp(HUDInteraction.GRADIENT_COLOR_START, VHUDPlus:getColor(HUDInteraction.GRADIENT_COLOR_NAME, 0.4), perc)
			self._interact_time:set_color(color)
			self._interact_time:set_alpha(1)
			self._interact_time:set_visible(show)
		end
	end

	function HUDInteraction:show_interaction_bar(current, total)
		if not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
			self:_rescale()
		end
		if self._interact_circle_locked then
			self._interact_circle_locked:remove()
			self._interact_circle_locked = nil
		end

		local val = show_interaction_bar_original(self, current, total)

		HUDInteraction.SHOW_LOCK_INDICATOR = VHUDPlus:getSetting({"INTERACTION", "SHOW_LOCK_INDICATOR"}, true)
		HUDInteraction.SHOW_TIME_REMAINING = VHUDPlus:getSetting({"INTERACTION", "SHOW_TIME_REMAINING"}, true) and not (VoidUI and VoidUI.options.enable_interact)
		HUDInteraction.SHOW_TIME_REMAINING_OUTLINE = VHUDPlus:getSetting({"INTERACTION", "SHOW_TIME_REMAINING_OUTLINE"}, false) and not (VoidUI and VoidUI.options.enable_interact)
		HUDInteraction.SHOW_CIRCLE 	= VHUDPlus:getSetting({"INTERACTION", "SHOW_CIRCLE"}, true)
		HUDInteraction.LOCK_MODE = PlayerStandard.LOCK_MODE or 1
		HUDInteraction.GRADIENT_COLOR_NAME = VHUDPlus:getSetting({"INTERACTION", "GRADIENT_COLOR"}, "light_green")
		HUDInteraction.GRADIENT_COLOR_START = VHUDPlus:getColorSetting({"INTERACTION", "GRADIENT_COLOR_START"}, "white")
		if HUDInteraction.SHOW_CIRCLE then
			if HUDInteraction.LOCK_MODE > 1 and HUDInteraction.SHOW_LOCK_INDICATOR and not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
				self._interact_circle_locked = CircleBitmapGuiObject:new(self._hud_panel, {
					radius = self._circle_radius,
					color = self._old_text and Color.green or Color.red,
					blend_mode = "normal",
					alpha = 0.25,
				})
				self._interact_circle_locked:set_position(self._hud_panel:w() / 2 - self._circle_radius, self._hud_panel:h() / 2 - self._circle_radius)
				self._interact_circle_locked._circle:set_render_template(Idstring("Text"))
			end
		else
			HUDInteraction.SHOW_LOCK_INDICATOR = false
			self._interact_circle:set_visible(false)
		end

		if HUDInteraction.SHOW_TIME_REMAINING then
			local fontSize = 32 * (self._circle_scale or 1) * VHUDPlus:getSetting({"INTERACTION", "TIMER_SCALE"}, 1)
			if not self._interact_time then
				self._interact_time = OutlinedText:new(self._hud_panel, {
					name = "interaction_timer",
					visible = false,
					text = "",
					valign = "center",
					align = "center",
					layer = 2,
					color = HUDInteraction.GRADIENT_COLOR_START,
					font = tweak_data.menu.pd2_large_font,
					font_size = fontSize,
					h = 64
				})
			else
				self._interact_time:set_font_size(fontSize)
			end
			local text = string.format("%.1fs", total)
			self._interact_time:set_y(self._hud_panel:center_y() + self._circle_radius - (1.5 * self._interact_time:font_size()))
			self._interact_time:set_text(text)
			self._interact_time:set_outlines_visible(HUDInteraction.SHOW_TIME_REMAINING_OUTLINE)
			self._interact_time:show()
		end

		return val
	end

	function HUDInteraction:hide_interaction_bar(complete, ...)
		if self._interact_circle_locked then
			self._interact_circle_locked:remove()
			self._interact_circle_locked = nil
		end

		if self._interact_time then
			self._interact_time:set_text("")
			self._interact_time:set_visible(false)
		end

		if self._old_text then
			self._hud_panel:child(self._child_name_text):set_text(self._old_text or "")
			self._old_text = nil
		end

		if complete and HUDInteraction.SHOW_CIRCLE then
			local bitmap = self._hud_panel:bitmap({texture = "guis/textures/pd2/hud_progress_active", blend_mode = "add", align = "center", valign = "center", layer = 2, w = 2 * self._circle_radius, h = 2 * self._circle_radius})
			local circle = CircleBitmapGuiObject:new(self._hud_panel, {radius = self._circle_radius, sides = 64, current = 64, total = 64, color = Color.white:with_alpha(1), blend_mode = "normal", layer = 3})
			if alive(bitmap) or alive(circle) then
				bitmap:set_position(bitmap:parent():w() / 2 - bitmap:w() / 2, bitmap:parent():h() / 2 - bitmap:h() / 2)

				circle:set_position(self._hud_panel:w() / 2 - self._circle_radius, self._hud_panel:h() / 2 - self._circle_radius)
				bitmap:animate(callback(self, self, "_animate_interaction_complete"), circle)
			end
		end

		return hide_interaction_bar_original(self, false, ...)
	end

	function HUDInteraction:set_locked(status, tweak_entry)
		if self._interact_circle_locked then
			self._interact_circle_locked._circle:set_color(status and Color.green or Color.red)
		end

		if status then
			self._old_text = self._hud_panel:child(self._child_name_text):text()
			local locked_text = ""
			if VHUDPlus:getSetting({"INTERACTION", "SHOW_INTERRUPT_HINT"}, true) then
				local btn_cancel = PlayerStandard.EQUIPMENT_PRESS_INTERRUPT and (managers.localization:btn_macro("use_item", true) or managers.localization:get_default_macro("BTN_USE_ITEM")) or (managers.localization:btn_macro("interact", true) or managers.localization:get_default_macro("BTN_INTERACT"))
				locked_text = managers.localization:to_upper_text(tweak_entry == "corpse_alarm_pager" and "wolfhud_int_locked_pager" or "wolfhud_int_locked", {BTN_CANCEL = btn_cancel})
			end
			self._hud_panel:child(self._child_name_text):set_text(locked_text)
		end
	end

	function HUDInteraction:show_interact(data)
	    local SCALE = VHUDPlus:getSetting({"INTERACTION", "DRILL_ICONS_SCALE"}, 0.8)
		local X_POSITION = VHUDPlus:getSetting({"INTERACTION", "DRILL_ICONS_X_POS"}, 0)
		local Y_POSITION = VHUDPlus:getSetting({"INTERACTION", "DRILL_ICONS_Y_POS"}, 90)
		local offset_speed, offset_auto

	    if 0 < managers.player:upgrade_level("player", "drill_speed_multiplier", 0) then
            offset_speed = 2.25
            offset_auto  = 1.82
        else
            offset_speed = 1.82
            offset_auto  = 2.25
        end

	    self._drill_skills_panel = self._hud_panel:panel({
		    layer = 1,
		    visible = false,
		    align = "center",
		    y = self._hud_panel:child(self._child_name_text):bottom(),
			x = X_POSITION
	    })

	    self._drill_skills_panel:bitmap({
		    y = Y_POSITION,
		    visible = 0 < managers.player:upgrade_level("player", "drill_speed_multiplier", 0),
		    texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
            texture_rect = { 3 * 80, 6 * 80, 80, 80 },
		    color = Color.white,
		    align = "center",
		    w = 80 * SCALE,
		    h = 80 * SCALE,
		    layer = 2
	    }):set_center_x(self._drill_skills_panel:w() / offset_speed)

	    self._drill_skills_panel:bitmap({
		    y = Y_POSITION,
		    visible = 0 < managers.player:upgrade_level("player", "drill_autorepair_2", 0),
		    texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
            texture_rect = { 5 * 80, 5 * 80, 80, 80 },
		    color = Color.white,
		    align = "center",
		    w = 80 * SCALE,
		    h = 80 * SCALE,
		    layer = 2
	    }):set_center_x(self._drill_skills_panel:w() / offset_auto)

	    self._drill_skills_panel:bitmap({
		    y = Y_POSITION,
		    visible = 0 < managers.player:upgrade_level("player", "silent_drill", 0),
		    texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
		    texture_rect = { 9 * 80, 6 * 80, 80, 80 },
		    color = Color.white,
		    align = "center",
		    w = 80 * SCALE,
		    h = 80 * SCALE,
		    layer = 2
	    }):set_center_x(self._drill_skills_panel:w() / 2 )

	    if managers.player:upgrade_level("player", "silent_drill", 0) and managers.player:upgrade_level("player", "drill_autorepair_1", 0) == 1 then
		    self._drill_skills_panel:bitmap({
				y = Y_POSITION,
			    texture = "guis/textures/pd2/skilltree_2/ace_symbol",
			    h = 100 * SCALE,
			    w = 100 * SCALE,
			    alpha = 1,
			    blend_mode = "add",
			    color = Color.white,
			    layer = 1
		    }):set_center_x(self._drill_skills_panel:w() / 2)
	    end

	    if managers.player:upgrade_level("player", "drill_speed_multiplier", 0) == 2 then
		    self._drill_skills_panel:bitmap({
				y = Y_POSITION,
			    texture = "guis/textures/pd2/skilltree_2/ace_symbol",
			    h = 100 * SCALE,
			    w = 100 * SCALE,
			    alpha = 1,
			    blend_mode = "add",
			    color = Color.white,
			    layer = 1
		    }):set_center_x(self._drill_skills_panel:w() / offset_speed)
	    end

		if not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
			self:_rescale()
		end
		if not self._old_text then
			return show_interact_original(self, data)
		end
	end

	function HUDInteraction:show_drill_interact()
	    self._drill_skills_panel:set_visible(true)
    end

	function HUDInteraction:remove_interact(...)
	    if alive(self._drill_skills_panel) then
		    self._drill_skills_panel:set_visible(false)
        end

	    return remove_interact_original(self, ...)
    end

	function HUDInteraction:destroy()
		if self._interact_time and self._hud_panel then
			self._interact_time:remove()
			self._interact_time = nil
		end
		if self._interact_time_bgs and self._hud_panel then
			for _, bg in pairs(self._interact_time_bgs) do
				self._hud_panel:remove(bg)
			end
			self._interact_time_bgs = nil
		end
		destroy_original(self)
	end

	function HUDInteraction:_rescale(circle_scale, text_scale)
		local circle_scale = circle_scale or VHUDPlus:getSetting({"INTERACTION", "CIRCLE_SCALE"}, 0.8)
		local text_scale = text_scale or VHUDPlus:getSetting({"INTERACTION", "TEXT_SCALE"}, 0.8)
		local interact_text = self._hud_panel:child(self._child_name_text)
		local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
		local changed = false
		if self._circle_scale ~= circle_scale then
			self._circle_radius = self._original_circle_radius * circle_scale
			self._circle_scale = circle_scale
			changed = true
		end
		if self._text_scale ~= text_scale then
			local interact_text = self._hud_panel:child(self._child_name_text)
			local invalid_text = self._hud_panel:child(self._child_ivalid_name_text)
			interact_text:set_font_size(self._original_interact_text_font_size * text_scale)
			invalid_text:set_font_size(self._original_invalid_text_font_size * text_scale)
			self._text_scale = text_scale
			changed = true
		end
		if changed then
			interact_text:set_y(self._hud_panel:h() / 2 + self._circle_radius + interact_text:font_size() / 2)
			invalid_text:set_center_y(interact_text:center_y())
		end
	end
elseif string.lower(RequiredScript) == "lib/units/interactions/interactionext" then
	local _add_string_macros_original = BaseInteractionExt._add_string_macros
	local _interact_blocked_original = IntimitateInteractionExt._interact_blocked
	local selected_original          = BaseInteractionExt.selected
	local jokers = {}

	local function kill_joker()
		while #jokers > 0 do
			local data = table.remove(jokers, 1)

			if alive(data.unit) then
				data.unit:character_damage():damage_mission({ damage = data.unit:character_damage()._HEALTH_INIT + 1 })
				return true
			end
		end

		return false
	end

	function IntimitateInteractionExt:_interact_blocked(...)
		if self.tweak_data == "hostage_convert" and managers.player:chk_minion_limit_reached() and VHUDPlus:getSetting({"EQUIPMENT", "REPLACE_JOKER"}, true) then
			if kill_joker() and not Network:is_server() then
				return not managers.player:has_category_upgrade("player", "convert_enemies") or managers.groupai:state():whisper_mode()
			end
		end
	    local function joker_event(event, key, data)
			if data.owner == managers.network:session():local_peer():id() then
				if event == "set_owner" then
					table.insert(jokers, data)
				else
					for i, data in ipairs(jokers) do
						if alive(data.unit) and tostring(data.unit:key()) == key then
							table.remove(jokers, i)
							break
						end
					end
				end
			end
		end
		managers.gameinfo:register_listener("replace_joker_listener", "minion", "set_owner", joker_event)
		managers.gameinfo:register_listener("replace_joker_listener", "minion", "remove", joker_event)
		return _interact_blocked_original(self, ...)
	end

	function BaseInteractionExt:would_be_bonus_bag(carry_id)
		if managers.loot:get_mandatory_bags_data().carry_id ~= "none" and carry_id and carry_id ~= managers.loot:get_mandatory_bags_data().carry_id then
			return true
		end
		local mandatory_bags_amount = managers.loot:get_mandatory_bags_data().amount or 0
		for _, data in ipairs(managers.loot._global.secured) do
			if not tweak_data.carry.small_loot[data.carry_id] and not tweak_data.carry[data.carry_id].is_vehicle then
				if mandatory_bags_amount > 1 and (managers.loot:get_mandatory_bags_data().carry_id == "none" or managers.loot:get_mandatory_bags_data().carry_id == data.carry_id) then
					mandatory_bags_amount = mandatory_bags_amount - 1
				elseif mandatory_bags_amount <= 1 then
					return true
				end
			end
		end
		return false
	end

	function BaseInteractionExt:get_unsecured_bag_value(carry_id, mult)
		local bag_value = managers.money:get_bag_value(carry_id, mult)
		local bag_skill_bonus = managers.player:upgrade_value("player", "secured_bags_money_multiplier", 1)
		if self:would_be_bonus_bag(carry_id) then
			local stars = managers.job:has_active_job() and managers.job:current_difficulty_stars() or 0
			local money_multiplier = managers.money:get_contract_difficulty_multiplier(stars)
			bag_value =  bag_value + math.round(bag_value * money_multiplier)
		end
		return math.round(bag_value * bag_skill_bonus / managers.money:get_tweak_value("money_manager", "offshore_rate"))
	end

	function BaseInteractionExt:_add_string_macros(macros, ...)
		_add_string_macros_original(self, macros, ...)
		macros.INTERACT = self:_btn_interact() or managers.localization:get_default_macro("BTN_INTERACT") --Ascii ID for RB
		if self._unit:carry_data() then
			local carry_id = self._unit:carry_data():carry_id()
			macros.BAG = managers.localization:text(tweak_data.carry[carry_id]) and managers.localization:text(tweak_data.carry[carry_id].name_id)
			if not (managers.crime_spree and managers.crime_spree:is_active()) then
				macros.VALUE = not tweak_data.carry[carry_id].skip_exit_secure and " (" .. managers.experience:cash_string(self:get_unsecured_bag_value(carry_id, 1)) .. ")" or ""
			else
				macros.VALUE = ""
			end
		else
			macros.VALUE = ""
		end
	end

	function BaseInteractionExt:selected(...)
	    if selected_original(self, ...) and self._unit:base() and self._unit:base().is_drill and VHUDPlus:getSetting({"INTERACTION", "DRILL_ICONS"}, true) and not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
		    managers.hud:show_drill_interact()
	    elseif selected_original(self, ...) and self._unit:base() and self._unit:base().is_saw and VHUDPlus:getSetting({"INTERACTION", "DRILL_ICONS"}, true) and not VHUDPlus:getSetting({"INTERACTION", "CUSTOM_HUDS_SUPPORT"}, false) then
	        managers.hud:show_drill_interact()
	    end
	    return selected_original(self, ...)
    end

elseif string.lower(RequiredScript) == "lib/managers/objectinteractionmanager" then
	ObjectInteractionManager.AUTO_PICKUP_DELAY = VHUDPlus:getTweakEntry("AUTO_PICKUP_DELAY", "number", 0.2)	 --Delay in seconds between auto-pickup procs (0 -> as fast as possible)
	local _update_targeted_original = ObjectInteractionManager._update_targeted
	function ObjectInteractionManager:_update_targeted(player_pos, player_unit, ...)
		_update_targeted_original(self, player_pos, player_unit, ...)

		if VHUDPlus:getSetting({"INTERACTION", "HOLD2PICK"}, true) and alive(self._active_unit) and not self._active_object_locked_data then
			local t = Application:time()
			if self._active_unit:base() and self._active_unit:base().small_loot and managers.menu:get_controller():get_input_bool("interact") and (t >= (self._next_auto_pickup_t or 0)) then
				self._next_auto_pickup_t = t + ObjectInteractionManager.AUTO_PICKUP_DELAY
				local success = self:interact(player_unit)
			end
		end
	end
end

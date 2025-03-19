Hooks:PostHook(CopActionHurt, "_start_ragdoll", "ragdoll_sounds", function(self)
	if self._ragdolled and not self._set_sounds then
		local unit_damage = self._unit:damage()
		unit_damage:set_play_collision_sfx_quite_time(0.3)
		unit_damage._collision_event = "body_fall"
		self._set_sounds = true
		self._unit:set_body_collision_callback(callback(unit_damage, unit_damage, "body_collision_callback"))
	end
end)

Hooks:PostHook(CopActionHurt, "_freeze_ragdoll", "ragdoll_sounds_stop", function(self)
	if self._set_sounds then
		local unit_damage = self._unit:damage()
		unit_damage:set_play_collision_sfx_quite_time(nil)
		self._set_sounds = nil
	end
end)
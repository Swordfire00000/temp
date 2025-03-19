PlayerSound._speak_expire_t = 0

function PlayerSound:sound_callback(instance, event_type, unit, sound_source, label, identifier, position)
	if not alive(unit) then
		return
	end

	unit:sound()._speak_expire_t = 0
	managers.hud:set_mugshot_talk(unit:unit_data().mugshot_id, false)
end

function PlayerSound:_play(sound_name, source_name, talking, callback)
	local source = source_name and Idstring(source_name)
	if talking then
		return self._unit:sound_source(source):post_event(sound_name, self.sound_callback, self._unit, "marker", "end_of_event")
	else
		return self._unit:sound_source(source):post_event(sound_name)
	end
end

function PlayerSound:say(sound_name, sync, important_say, ignore_prefix, callback)
	if self._last_speech then
		self._last_speech:stop()
	end

	local event_id = nil
	if type(sound_name) == "number" then
		event_id = sound_name
		sound_name = nil
	end

	if sync then
		event_id = event_id or SoundDevice:string_to_id(sound_name)
		self._unit:network():send("say", event_id)
	end

	self._last_speech = self:_play(sound_name or event_id, nil, true, callback)
	if not self._last_speech then
		return
	end

	if important_say then
		managers.hud:set_mugshot_talk(self._unit:unit_data().mugshot_id, true)
	end

	self._speak_expire_t = TimerManager:game():time() + 10

	return self._last_speech
end

function PlayerSound:speaking()
	return TimerManager:game():time() < self._speak_expire_t
end

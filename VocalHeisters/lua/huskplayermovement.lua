-- Track people's downs for revive purposes
Hooks:PostHook(HuskPlayerMovement, "_perform_movement_action_enter_bleedout", "vocalheisters_trackdowns_huskplayer_godown", function(self)
    if not self._unit then
        return
    end

    if not self._unit:base().downs then
        self._unit:base().downs = 0
    end

    self._unit:base().downs = self._unit:base().downs + 1
end)

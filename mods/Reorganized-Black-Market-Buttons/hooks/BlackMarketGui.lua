Hooks:PostHook(BlackMarketGui, "_setup", "ReorganizedBlackMarketButtons", function (self)
    local btns = self._btns
    btns.wm_buy_mod._data.prio = 3
    btns.wm_clear_mod_preview._data.prio = 4
    btns.wm_preview_mod._data.prio = 5
    btns.wm_remove_preview._data.prio = 5
    btns.wcc_preview._data.prio = 5
    btns.wcc_cancel_preview._data.prio = 5

    self:show_btns(self._selected_slot)
end)

Hooks:PreHook(BlackMarketGui, "mouse_moved", "ReorganizedBlackMarketButtons", function (self)
    if self._button_highlighted and not self._btns[self._button_highlighted]:visible() then
        self._button_highlighted = nil
    end
end)

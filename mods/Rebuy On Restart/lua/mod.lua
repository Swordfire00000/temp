_G.mitw153 = _G.mitw153 or {}
mitw153.rebuy_on_restart = {}
mitw153.rebuy_on_restart._save_path = SavePath .. "mitw153_rebuy_on_restart.json"
mitw153.rebuy_on_restart._data = {}
mitw153.rebuy_on_restart.already_checked_assets = false

function mitw153.rebuy_on_restart:save()
    local f = io.open(self._save_path, "w")

    if f then
        f:write(json.encode(self._data))
        f:close()
    end
end

function mitw153.rebuy_on_restart:load()
    local f = io.open(self._save_path, "r")

    if f then
        self._data = json.decode(f:read("*all"))
        f:close()
    end
end

local function can_afford_assets()
    for _, asset in ipairs(managers.preplanning._rebuy_assets.assets or {}) do
        if not managers.money:can_afford_preplanning_type(asset.type) then
            return false
        end
    end

    for asset_id in pairs(mitw153.rebuy_on_restart._data) do
        if not managers.money:can_afford_mission_asset(asset_id) then
            return false
        end
    end

    return true
end

if MenuComponentManager then
    local MenuComponentManager_add_game_chat = MenuComponentManager.add_game_chat

    function MenuComponentManager:add_game_chat()
        MenuComponentManager_add_game_chat(self)

        if not managers.assets:is_unlock_asset_allowed() or not can_afford_assets() then
            return
        end

        if managers.preplanning:get_can_rebuy_assets() and managers.preplanning._rebuy_assets.reminder_active then
            managers.preplanning:reserve_rebuy_mission_elements()
            managers.preplanning._rebuy_assets.reminder_active = false
        end

        mitw153.rebuy_on_restart:load()

        for _, asset_id in ipairs(mitw153.rebuy_on_restart._data) do
            local asset = managers.assets:_get_asset_by_id(asset_id)

            if asset and not asset.unlocked and managers.assets:get_asset_can_unlock_by_id(asset_id) then
                managers.assets:unlock_asset(asset_id, true)
            end
        end

        mitw153.rebuy_on_restart._data = {}
    end
end

if GameStateMachine then
    local GameStateMachine_change_state_by_name = GameStateMachine.change_state_by_name

    function GameStateMachine:change_state_by_name(...)
        GameStateMachine_change_state_by_name(self, ...)

        if ((game_state_machine:current_state().check_is_dropin and game_state_machine:current_state():check_is_dropin()) or Utils:IsInHeist()) and not mitw153.rebuy_on_restart.already_checked_assets then
            for _, asset in ipairs(managers.assets._global.assets) do
                if asset.unlocked and asset.can_unlock then
                    mitw153.rebuy_on_restart._data[#mitw153.rebuy_on_restart._data + 1] = asset.id
                end
            end

            mitw153.rebuy_on_restart.already_checked_assets = true
            mitw153.rebuy_on_restart:save()
        end
    end
end

if JobManager then
    local JobManager_start_accumulate_ghost_bonus = JobManager.start_accumulate_ghost_bonus

    function JobManager:start_accumulate_ghost_bonus(...)
        JobManager_start_accumulate_ghost_bonus(self, ...)

        os.remove(mitw153.rebuy_on_restart._save_path)
    end

    local JobManager_set_current_stage = JobManager.set_current_stage

    function JobManager:set_current_stage(...)
        JobManager_set_current_stage(self, ...)

        os.remove(mitw153.rebuy_on_restart._save_path)
    end
end
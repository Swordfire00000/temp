if not MutatorHelper then return end

function BaseMutator:CSLMM_GetModifierData(modifier)
    local modifier = tweak_data.crime_spree.modifiers.loud[modifier]
    local new_data = {}
    for key, value_data in pairs(modifier.data) do
        local value = value_data[1]
        local stack_method = value_data[2]
        if stack_method == "none" then
            new_data[key] = value
        elseif stack_method == "add" then
            new_data[key] = (new_data[key] or 0) + value
        elseif stack_method == "sub" then
            new_data[key] = (new_data[key] or 0) - value
        elseif stack_method == "min" then
            new_data[key] = math.min(new_data[key] or math.huge, value)
        elseif stack_method == "max" then
            new_data[key] = math.max(new_data[key] or -math.huge, value)
        end
    end
    return new_data, modifier.class
end

function BaseMutator:CSLMM_AddMutator(modifier, data_override)
    local data, mutator = self:CSLMM_GetModifierData(modifier)
    managers.modifiers:add_modifier(_G[mutator]:new(data_override or data), "crime_spree")
end

-- Mutators
MutatorAssaultExtender = MutatorAssaultExtender or class(BaseMutator)
MutatorAssaultExtender._type = "MutatorAssaultExtender"
MutatorAssaultExtender.name_id = "mutator_assault_extender"
MutatorAssaultExtender.desc_id = "mutator_assault_extender_desc"
MutatorAssaultExtender.longdesc_id = "menu_cs_modifier_assault_extender"
MutatorAssaultExtender.macros =
{
    duration = tweak_data.crime_spree.modifiers.loud[22].data.duration[1],
    deduction = tweak_data.crime_spree.modifiers.loud[22].data.deduction[1],
    max_hostages = tweak_data.crime_spree.modifiers.loud[22].data.max_hostages[1]
}
MutatorAssaultExtender.categories = {"crime_spree"}
MutatorAssaultExtender.disables_achievements = false
MutatorAssaultExtender.incompatiblities =
{
    "MutatorEndlessAssaults"
}
MutatorAssaultExtender.texture =
{
    path = "cslmm"
}
MutatorAssaultExtender.affects_host_only = false

function MutatorAssaultExtender:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(22)
    end
end

MutatorCloakerArrest = MutatorCloakerArrest or class(BaseMutator)
MutatorCloakerArrest._type = "MutatorCloakerArrest"
MutatorCloakerArrest.name_id = "mutator_cloaker_arrest"
MutatorCloakerArrest.desc_id = "mutator_cloaker_arrest_desc"
MutatorCloakerArrest.longdesc_id = "menu_cs_modifier_cloaker_arrest"
MutatorCloakerArrest.categories = {"crime_spree"}
MutatorCloakerArrest.disables_achievements = false
MutatorCloakerArrest.incompatiblities =
{
    "MutatorCloakerEffect"
}
MutatorCloakerArrest.texture =
{
    path = "cslmm",
    x = 128
}

function MutatorCloakerArrest:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(23)
    end
end

MutatorCloakerSmoke = MutatorCloakerSmoke or class(BaseMutator)
MutatorCloakerSmoke._type = "MutatorCloakerSmoke"
MutatorCloakerSmoke.name_id = "mutator_cloaker_smoke"
MutatorCloakerSmoke.desc_id = "mutator_cloaker_smoke_desc"
MutatorCloakerSmoke.longdesc_id = "menu_cs_modifier_cloaker_smoke"
MutatorCloakerSmoke.categories = {"crime_spree"}
MutatorCloakerSmoke.disables_achievements = false
MutatorCloakerSmoke.incompatiblities =
{
    "MutatorCloakerEffect"
}
MutatorCloakerSmoke.texture =
{
    path = "cslmm",
    x = 256
}

function MutatorCloakerSmoke:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(2)
    end
end

MutatorCloakerTearGas = MutatorCloakerTearGas or class(BaseMutator)
MutatorCloakerTearGas._type = "MutatorCloakerTearGas"
MutatorCloakerTearGas.name_id = "mutator_cloaker_tear_gas"
MutatorCloakerTearGas.desc_id = "mutator_cloaker_tear_gas_desc"
MutatorCloakerTearGas.longdesc_id = "menu_cs_modifier_cloaker_tear_gas"
MutatorCloakerTearGas.macros =
{
    duration = tweak_data.crime_spree.modifiers.loud[10].data.duration[1],
    diameter = tweak_data.crime_spree.modifiers.loud[10].data.diameter[1],
    damage = tweak_data.crime_spree.modifiers.loud[10].data.damage[1]
}
MutatorCloakerTearGas.categories = {"crime_spree"}
MutatorCloakerTearGas.disables_achievements = false
MutatorCloakerTearGas.incompatiblities =
{
    "MutatorCloakerEffect"
}
MutatorCloakerTearGas.texture =
{
    path = "cslmm",
    x = 384
}

function MutatorCloakerTearGas:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(10)
    end
end

MutatorDozerExplosionImmunity = MutatorDozerExplosionImmunity or class(BaseMutator)
MutatorDozerExplosionImmunity._type = "MutatorDozerExplosionImmunity"
MutatorDozerExplosionImmunity.name_id = "mutator_dozer_explosion_immunity"
MutatorDozerExplosionImmunity.desc_id = "menu_cs_modifier_dozer_immune"
MutatorDozerExplosionImmunity.longdesc_id = "mutator_dozer_explosion_immunity_longdesc"
MutatorDozerExplosionImmunity.categories = {"crime_spree"}
MutatorDozerExplosionImmunity.disables_achievements = false
MutatorDozerExplosionImmunity.texture =
{
    path = "cslmm",
    x = 512
}

function MutatorDozerExplosionImmunity:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(20)
    end
end

MutatorDozerRage = MutatorDozerRage or class(BaseMutator)
MutatorDozerRage._type = "MutatorDozerRage"
MutatorDozerRage.name_id = "mutator_dozer_rage"
MutatorDozerRage.desc_id = "mutator_dozer_rage_desc"
MutatorDozerRage.longdesc_id = "menu_cs_modifier_dozer_rage"
MutatorDozerRage.macros =
{
    damage = tweak_data.crime_spree.modifiers.loud[9].data.damage[1]
}
MutatorDozerRage.categories = {"crime_spree"}
MutatorDozerRage.disables_achievements = false
MutatorDozerRage.texture =
{
    path = "cslmm",
    x = 640
}

function MutatorDozerRage:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(9)
    end
end

MutatorHeavies = MutatorHeavies or class(BaseMutator)
MutatorHeavies._type = "MutatorHeavies"
MutatorHeavies.name_id = "mutator_heavies"
MutatorHeavies.desc_id = "mutator_heavies_desc"
MutatorHeavies.categories = {"crime_spree"}
MutatorHeavies.disables_achievements = false
MutatorHeavies.load_priority = 10
MutatorHeavies.texture =
{
    path = "cslmm",
    x = 768
}
MutatorHeavies.affects_host_only = false

function MutatorHeavies:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(6)
    end
end

MutatorMedicAdrenaline = MutatorMedicAdrenaline or class(BaseMutator)
MutatorMedicAdrenaline._type = "MutatorMedicAdrenaline"
MutatorMedicAdrenaline.name_id = "mutator_medic_adrenaline"
MutatorMedicAdrenaline.desc_id = "mutator_medic_adrenaline_desc"
MutatorMedicAdrenaline.longdesc_id = "menu_cs_modifier_medic_adrenaline"
MutatorMedicAdrenaline.macros =
{
    damage = tweak_data.crime_spree.modifiers.loud[14].data.damage[1]
}
MutatorMedicAdrenaline.categories = {"crime_spree"}
MutatorMedicAdrenaline.disables_achievements = false
MutatorMedicAdrenaline.texture =
{
    path = "cslmm",
    y = 128
}

function MutatorMedicAdrenaline:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(14)
    end
end

MutatorMedicDeathwish = MutatorMedicDeathwish or class(BaseMutator)
MutatorMedicDeathwish._type = "MutatorMedicDeathwish"
MutatorMedicDeathwish.name_id = "mutator_medic_deathwish"
MutatorMedicDeathwish.desc_id = "mutator_medic_deathwish_desc"
MutatorMedicDeathwish.longdesc_id = "menu_cs_modifier_medic_deathwish"
MutatorMedicDeathwish.categories = {"crime_spree"}
MutatorMedicDeathwish.disables_achievements = false
MutatorMedicDeathwish.texture =
{
    path = "cslmm",
    x = 128,
    y = 128
}

function MutatorMedicDeathwish:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(17)
    end
end

MutatorMedicDozer = MutatorMedicDozer or class(BaseMutator)
MutatorMedicDozer._type = "MutatorMedicDozer"
MutatorMedicDozer.name_id = "mutator_medic_dozer"
MutatorMedicDozer.desc_id = "mutator_medic_dozer_desc"
MutatorMedicDozer.longdesc_id = "menu_cs_modifier_dozer_medic"
MutatorMedicDozer.categories = {"crime_spree"}
MutatorMedicDozer.disables_achievements = false
MutatorMedicDozer.texture =
{
    path = "cslmm",
    x = 256,
    y = 128
}
MutatorMedicDozer.affects_host_only = false

function MutatorMedicDozer:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(21)
    end
end

MutatorMedicHealSpeed = MutatorMedicHealSpeed or class(BaseMutator)
MutatorMedicHealSpeed._type = "MutatorMedicHealSpeed"
MutatorMedicHealSpeed.name_id = "mutator_medic_heal_speed"
MutatorMedicHealSpeed.desc_id = "mutator_medic_heal_speed_desc"
MutatorMedicHealSpeed.categories = {"crime_spree"}
MutatorMedicHealSpeed.has_options = true
MutatorMedicHealSpeed.disables_achievements = false
MutatorMedicHealSpeed.texture =
{
    path = "cslmm",
    x = 384,
    y = 128
}

function MutatorMedicHealSpeed:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(12, { speed = self:GetValue() })
    end
end

function MutatorMedicHealSpeed:register_values(mutator_manager)
    self:register_value("medic_heal_speed", 20, "speed")
end

function MutatorMedicHealSpeed:name()
    local name = MutatorMedicHealSpeed.super.name(self)

    if self:_mutate_name("medic_heal_speed") then
        return managers.localization:text("mutator_medic_heal_speed") .. " - " .. managers.localization:text("menu_cs_modifier_medic_speed", {speed = tonumber(self:GetValue())})
    else
        return name
    end
end

function MutatorMedicHealSpeed:min()
    return 20
end

function MutatorMedicHealSpeed:max()
    return 40
end

function MutatorMedicHealSpeed:GetValue()
    return self:value("medic_heal_speed")
end

function MutatorMedicHealSpeed:setup_options_gui(node)
    local params = {
        name = "medic_heal_speed_slider",
        callback = "_update_mutator_value",
        text_id = "st_menu_value",
        update_callback = callback(self, self, "_update_value")
    }
    local data_node = {
        show_value = true,
        step = 1,
        type = "CoreMenuItemSlider.ItemSlider",
        decimal_count = 0,
        min = self:min(),
        max = self:max()
    }
    local new_item = node:create_item(data_node, params)
    new_item:set_value(self:GetValue())
    node:add_item(new_item)

    self._node = node

    return new_item
end

function MutatorMedicHealSpeed:_update_value(item)
    self:set_value("medic_heal_speed", math.round(item:value()))
end

function MutatorMedicHealSpeed:reset_to_default()
    self:clear_values()

    if self._node then
        local slider = self._node:item("medic_heal_speed_slider")

        if slider then
            slider:set_value(self:GetValue())
        end
    end
end

function MutatorMedicHealSpeed:options_fill()
    return self:_get_percentage_fill(self:min(), self:max(), self:GetValue())
end

MutatorMedicRage = MutatorMedicRage or class(BaseMutator)
MutatorMedicRage._type = "MutatorMedicRage"
MutatorMedicRage.name_id = "mutator_medic_rage"
MutatorMedicRage.desc_id = "mutator_medic_rage_desc"
MutatorMedicRage.longdesc_id = "menu_cs_modifier_medic_rage"
MutatorMedicRage.macros =
{
    damage = tweak_data.crime_spree.modifiers.loud[24].data.damage[1]
}
MutatorMedicRage.categories = {"crime_spree"}
MutatorMedicRage.disables_achievements = false
MutatorMedicRage.texture =
{
    path = "cslmm",
    x = 512,
    y = 128
}

function MutatorMedicRage:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(24)
    end
end

MutatorMinigunDozer = MutatorMinigunDozer or class(BaseMutator)
MutatorMinigunDozer._type = "MutatorMinigunDozer"
MutatorMinigunDozer.name_id = "mutator_minigun_dozer"
MutatorMinigunDozer.desc_id = "mutator_minigun_dozer_desc"
MutatorMinigunDozer.longdesc_id = "menu_cs_modifier_dozer_minigun"
MutatorMinigunDozer.categories = {"crime_spree"}
MutatorMinigunDozer.disables_achievements = false
MutatorMinigunDozer.texture =
{
    path = "cslmm",
    x = 640,
    y = 128
}
MutatorMinigunDozer.affects_host_only = false

function MutatorMinigunDozer:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        local tweak = tweak_data.group_ai.unit_categories.FBI_tank.unit_types
        if type(tweak) == "table" then -- Should fix a crash when bulldozers are not defined
            local execute = true
            for _, group_tweak in pairs(tweak) do
                if type(group_tweak) ~= "table" then
                    execute = false
                    break
                end
            end
            if execute then
                self:CSLMM_AddMutator(18)
            end
        end
    end
end

MutatorMoreDozers = MutatorMoreDozers or class(BaseMutator)
MutatorMoreDozers._type = "MutatorMoreDozers"
MutatorMoreDozers.name_id = "mutator_more_dozers"
MutatorMoreDozers.desc_id = "mutator_more_dozers_desc"
MutatorMoreDozers.categories = {"crime_spree"}
MutatorMoreDozers.has_options = true
MutatorMoreDozers.disables_achievements = false
MutatorMoreDozers.texture =
{
    path = "cslmm",
    x = 768,
    y = 128
}
MutatorMoreDozers.affects_host_only = false

function MutatorMoreDozers:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(16, { inc = self:GetValue() })
    end
end

function MutatorMoreDozers:register_values(mutator_manager)
    self:register_value("dozer_amount", 2, "amount")
end

function MutatorMoreDozers:name()
    local name = MutatorMoreDozers.super.name(self)

    if self:_mutate_name("dozer_amount") then
        return managers.localization:text("mutator_more_dozers") .. " - " .. managers.localization:text("mutator_more_dozers_activated", {amount = tonumber(self:GetValue())})
    else
        return name
    end
end

function MutatorMoreDozers:min()
    return 2
end

function MutatorMoreDozers:max()
    return 4
end

function MutatorMoreDozers:GetValue()
    return self:value("dozer_amount")
end

function MutatorMoreDozers:setup_options_gui(node)
    local params = {
        name = "dozer_amount_slider",
        callback = "_update_mutator_value",
        text_id = "st_menu_value",
        update_callback = callback(self, self, "_update_value")
    }
    local data_node = {
        show_value = true,
        step = 1,
        type = "CoreMenuItemSlider.ItemSlider",
        decimal_count = 0,
        min = self:min(),
        max = self:max()
    }
    local new_item = node:create_item(data_node, params)
    new_item:set_value(self:GetValue())
    node:add_item(new_item)

    self._node = node

    return new_item
end

function MutatorMoreDozers:_update_value(item)
    self:set_value("dozer_amount", math.round(item:value()))
end

function MutatorMoreDozers:reset_to_default()
    self:clear_values()

    if self._node then
        local slider = self._node:item("dozer_amount_slider")

        if slider then
            slider:set_value(self:GetValue())
        end
    end
end

function MutatorMoreDozers:options_fill()
    return self:_get_percentage_fill(self:min(), self:max(), self:GetValue())
end

MutatorMoreMedics = MutatorMoreMedics or class(BaseMutator)
MutatorMoreMedics._type = "MutatorMoreMedics"
MutatorMoreMedics.name_id = "mutator_more_medics"
MutatorMoreMedics.desc_id = "mutator_more_medics_desc"
MutatorMoreMedics.categories = {"crime_spree"}
MutatorMoreMedics.has_options = true
MutatorMoreMedics.disables_achievements = false
MutatorMoreMedics.texture =
{
    path = "cslmm",
    y = 256
}
MutatorMoreMedics.affects_host_only = false

function MutatorMoreMedics:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(19, { inc = self:GetValue() })
    end
end

function MutatorMoreMedics:register_values(mutator_manager)
    self:register_value("medic_amount", 2, "amount")
end

function MutatorMoreMedics:name()
    local name = MutatorMoreMedics.super.name(self)

    if self:_mutate_name("medic_amount") then
        return managers.localization:text("mutator_more_medics") .. " - " .. managers.localization:text("mutator_more_medics_activated", {amount = tonumber(self:GetValue())})
    else
        return name
    end
end

function MutatorMoreMedics:min()
    return 2
end

function MutatorMoreMedics:max()
    return 4
end

function MutatorMoreMedics:GetValue()
    return self:value("medic_amount")
end

function MutatorMoreMedics:setup_options_gui(node)
    local params = {
        name = "medic_amount_slider",
        callback = "_update_mutator_value",
        text_id = "st_menu_value",
        update_callback = callback(self, self, "_update_value")
    }
    local data_node = {
        show_value = true,
        step = 1,
        type = "CoreMenuItemSlider.ItemSlider",
        decimal_count = 0,
        min = self:min(),
        max = self:max()
    }
    local new_item = node:create_item(data_node, params)
    new_item:set_value(self:GetValue())
    node:add_item(new_item)

    self._node = node

    return new_item
end

function MutatorMoreMedics:_update_value(item)
    self:set_value("medic_amount", math.round(item:value()))
end

function MutatorMoreMedics:reset_to_default()
    self:clear_values()

    if self._node then
        local slider = self._node:item("medic_amount_slider")

        if slider then
            slider:set_value(self:GetValue())
        end
    end
end

function MutatorMoreMedics:options_fill()
    return self:_get_percentage_fill(self:min(), self:max(), self:GetValue())
end

MutatorNoAnimHurts = MutatorNoAnimHurts or class(BaseMutator)
MutatorNoAnimHurts._type = "MutatorNoAnimHurts"
MutatorNoAnimHurts.name_id = "mutator_no_anim_hurts"
MutatorNoAnimHurts.desc_id = "mutator_no_anim_hurts_desc"
MutatorNoAnimHurts.longdesc_id = "menu_cs_modifier_no_hurt"
MutatorNoAnimHurts.categories = {"crime_spree"}
MutatorNoAnimHurts.disables_achievements = false
MutatorNoAnimHurts.texture =
{
    path = "cslmm",
    x = 128,
    y = 256
}

function MutatorNoAnimHurts:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(4)
    end
end

MutatorShieldPhalanx = MutatorShieldPhalanx or class(BaseMutator)
MutatorShieldPhalanx._type = "MutatorShieldPhalanx"
MutatorShieldPhalanx.name_id = "mutator_shield_phalanx"
MutatorShieldPhalanx.desc_id = "mutator_shield_phalanx_desc"
MutatorShieldPhalanx.longdesc_id = "menu_cs_modifier_shield_phalanx"
MutatorShieldPhalanx.categories = {"crime_spree"}
MutatorShieldPhalanx.disables_achievements = false
MutatorShieldPhalanx.texture =
{
    path = "cslmm",
    x = 256,
    y = 256
}

function MutatorShieldPhalanx:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(15)
    end
end

MutatorShieldReflect = MutatorShieldReflect or class(BaseMutator)
MutatorShieldReflect._type = "MutatorShieldReflect"
MutatorShieldReflect.name_id = "mutator_shield_reflect"
MutatorShieldReflect.desc_id = "mutator_shield_reflect_desc"
MutatorShieldReflect.longdesc_id = "menu_cs_modifier_shield_reflect"
MutatorShieldReflect.categories = {"crime_spree"}
MutatorShieldReflect.disables_achievements = false
MutatorShieldReflect.texture =
{
    path = "cslmm",
    x = 384,
    y = 256
}

function MutatorShieldReflect:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(1)
    end
end

MutatorSkulldozer = MutatorSkulldozer or class(BaseMutator)
MutatorSkulldozer._type = "MutatorSkulldozer"
MutatorSkulldozer.name_id = "mutator_skulldozer"
MutatorSkulldozer.desc_id = "mutator_skulldozer_desc"
MutatorSkulldozer.categories = {"crime_spree"}
MutatorSkulldozer.disables_achievements = false
MutatorSkulldozer.texture =
{
    path = "cslmm",
    x = 512,
    y = 256
}
MutatorSkulldozer.affects_host_only = false

function MutatorSkulldozer:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(13)
    end
end

MutatorTaserOvercharge = MutatorTaserOvercharge or class(BaseMutator)
MutatorTaserOvercharge._type = "MutatorTaserOvercharge"
MutatorTaserOvercharge.name_id = "mutator_taser_overcharge"
MutatorTaserOvercharge.desc_id = "mutator_taser_overcharge_desc"
MutatorTaserOvercharge.longdesc_id = "menu_cs_modifier_taser_overcharge"
MutatorTaserOvercharge.macros =
{
    speed = tweak_data.crime_spree.modifiers.loud[5].data.speed[1]
}
MutatorTaserOvercharge.categories = {"crime_spree"}
MutatorTaserOvercharge.disables_achievements = false
MutatorTaserOvercharge.texture =
{
    path = "cslmm",
    x = 640,
    y = 256
}

function MutatorTaserOvercharge:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(5)
    end
end

MutatorZealSniper = MutatorZealSniper or class(BaseMutator)
MutatorZealSniper._type = "MutatorZealSniper"
MutatorZealSniper.name_id = "mutator_zeal_sniper"
MutatorZealSniper.desc_id = "mutator_zeal_sniper_desc"
MutatorZealSniper.longdesc_id = "menu_cs_modifier_heavy_sniper"
MutatorZealSniper.categories = {"crime_spree"}
MutatorZealSniper.disables_achievements = false
MutatorZealSniper.texture =
{
    path = "cslmm",
    x = 768,
    y = 256
}
MutatorZealSniper.affects_host_only = false

function MutatorZealSniper:init_finalize()
    if Network:is_server() and not (managers.crime_spree and managers.crime_spree:is_active()) then
        self:CSLMM_AddMutator(8)
    end
end

MutatorHelper:AddCategory("crime_spree", { string = "menu_gamemode_spree" }) -- Adds custom category to the Mutator selection screen
MutatorHelper:AddTexture("cslmm", ModPath) -- Adds Mutators' texture
MutatorHelper:AddLocalization(ModPath) -- Adds localization for the mutators
MutatorHelper:AddMutator(MutatorAssaultExtender) -- Adds Crime Spree modifiers as Mutators
MutatorHelper:AddMutator(MutatorCloakerArrest)
MutatorHelper:AddMutator(MutatorCloakerSmoke)
MutatorHelper:AddMutator(MutatorCloakerTearGas)
MutatorHelper:AddMutator(MutatorDozerExplosionImmunity)
MutatorHelper:AddMutator(MutatorDozerRage)
MutatorHelper:AddMutator(MutatorHeavies)
MutatorHelper:AddMutator(MutatorMedicAdrenaline)
MutatorHelper:AddMutator(MutatorMedicDeathwish)
MutatorHelper:AddMutator(MutatorMedicDozer)
MutatorHelper:AddMutator(MutatorMedicHealSpeed)
MutatorHelper:AddMutator(MutatorMedicRage)
MutatorHelper:AddMutator(MutatorMinigunDozer)
MutatorHelper:AddMutator(MutatorMoreDozers)
MutatorHelper:AddMutator(MutatorMoreMedics)
MutatorHelper:AddMutator(MutatorNoAnimHurts)
MutatorHelper:AddMutator(MutatorShieldPhalanx)
MutatorHelper:AddMutator(MutatorShieldReflect)
MutatorHelper:AddMutator(MutatorSkulldozer)
MutatorHelper:AddMutator(MutatorTaserOvercharge)
MutatorHelper:AddMutator(MutatorZealSniper)
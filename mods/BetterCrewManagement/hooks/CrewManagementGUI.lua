--[[ ==============================
               Logic
================================ ]]

local function copy_henchmen(from_profile, to_profile, params)
    if from_profile == to_profile then
        return
    end

    if params == nil or params.ai_priority == true then
        to_profile.preferred_henchmen = deep_clone(from_profile.preferred_henchmen)
    end

    if params == nil then
        to_profile.henchmen_loadout = deep_clone(from_profile.henchmen_loadout)
        return
    end

    for i, to_henchman in ipairs(to_profile.henchmen_loadout) do
        local from_henchman = from_profile.henchmen_loadout[i]
        if from_henchman ~= nil then
            if params.mask == true then
                to_henchman.mask = from_henchman.mask
                to_henchman.mask_slot = from_henchman.mask_slot
            end

            if params.primary_weapon == true then
                to_henchman.primary = from_henchman.primary
                to_henchman.primary_slot = from_henchman.primary_slot
            end

            if params.ability == true then
                to_henchman.ability = from_henchman.ability
            end

            if params.boost == true then
                to_henchman.skill = from_henchman.skill
            end

            if params.outfit == true then
                to_henchman.player_style = from_henchman.player_style
                to_henchman.suit_variation = from_henchman.suit_variation
            end

            if params.gloves == true then
                to_henchman.glove_id = from_henchman.glove_id
            end
        end
    end
end

local function reload_crew_management_screen(crew_management_gui_self)
    managers.menu_component:close_crew_management_gui()
    managers.menu_component:create_crew_management_gui(crew_management_gui_self._node)
end

local function reset_current_crew_loadout(crew_management_gui_self)
    local current_profile = managers.multi_profile:current_profile()

    for i, _ in ipairs(current_profile.henchmen_loadout) do
        managers.blackmarket:reset_henchman_loadout(i)
    end

    local preferred = managers.blackmarket:preferred_henchmen()
    for k, v in pairs(preferred) do
        preferred[k] = nil
    end

    managers.multi_profile:save_current()

    reload_crew_management_screen(crew_management_gui_self)
end

local function apply_current_crew_loadout_to_all_profiles(params)
    managers.multi_profile:save_current()

    local current_profile = managers.multi_profile:current_profile()
    for i, profile in pairs(managers.multi_profile._global._profiles) do
        copy_henchmen(current_profile, profile, params)
    end
end

local function apply_current_crew_loadout_to_single_profile(profile_index, params)
    managers.multi_profile:save_current()

    local current_profile = managers.multi_profile:current_profile()
    local selected_profile = managers.multi_profile._global._profiles[profile_index]
    copy_henchmen(current_profile, selected_profile, params)
end

--[[ ==============================
                 GUI
================================ ]]

local font_medium = tweak_data.menu.pd2_medium_font
local font_small = tweak_data.menu.pd2_small_font

local font_size_medium = tweak_data.menu.pd2_medium_font_size
local font_size_small = tweak_data.menu.pd2_small_font_size

local text_color = tweak_data.screen_colors.text
local button_color_normal = tweak_data.screen_colors.button_stage_3
local button_color_hover = tweak_data.screen_colors.button_stage_2

local function show_confirmation_dialog(text, ok_callback)
    managers.system_menu:show({
        title = managers.localization:text("BetterCrewManagement_mod_title"),
        text = text,
        button_list = {
            {
                text = managers.localization:text("dialog_ok"),
                callback_func = function() ok_callback() end
            },
            {
                text = managers.localization:text("dialog_cancel")
            }
        }
    })
end

-- Based on MultiProfileManager:open_quick_select()
local function show_profile_selection_dialog(profile_selected_callback)
    local dialog_data = {
        title = managers.localization:text("BetterCrewManagement_mod_title"),
        text = managers.localization:text("BetterCrewManagement_dialog_text_profile_selection"),
        button_list = {},
        image_blend_mode = "normal",
        text_blend_mode = "add",
        use_text_formating = true,
        w = 480,
        h = 532,
        title_font = font_medium,
        title_font_size = font_size_medium,
        font = font_small,
        font_size = font_size_small,
        text_formating_color = Color.white,
        text_formating_color_table = {},
        clamp_to_screen = true
    }

    local current_profile = managers.multi_profile:current_profile()

    for i, profile in pairs(managers.multi_profile._global._profiles) do
        if profile ~= current_profile then
            local profile_name = profile.name or managers.localization:text("BetterCrewManagement_profile") .. " " .. i

            local confirmation_text = managers.localization:text("BetterCrewManagement_dialog_text_apply_to_other_profile")
                    .. " \"" .. profile_name .. "\"?"

            local confirmation_callback = function() profile_selected_callback(i) end

            table.insert(dialog_data.button_list, {
                text = profile_name,
                callback_func = function()
                    show_confirmation_dialog(confirmation_text, confirmation_callback)
                end
            })
        end
    end

    local divider = { no_text = true, no_selection = true }
    table.insert(dialog_data.button_list, divider)

    table.insert(dialog_data.button_list, {
        text = managers.localization:text("dialog_cancel"),
        cancel_button = true
    })

    managers.system_menu:show_buttons(dialog_data)
end

local callback_id_apply_to_single = "better_crew_management_callback_apply_to_other_profile"
local callback_id_apply_to_all = "better_crew_management_callback_apply_to_all_profiles"
local callback_id_reset_crew_loadout = "better_crew_management_callback_reset_crew_loadout"

local function initialize_button_callbacks(crew_management_gui_self)
    crew_management_gui_self[callback_id_apply_to_single] = function()
        local callback = function(profile_index)
            apply_current_crew_loadout_to_single_profile(profile_index)
        end
        show_profile_selection_dialog(callback)
    end

    crew_management_gui_self[callback_id_apply_to_all] = function()
        local callback = function()
            apply_current_crew_loadout_to_all_profiles()
        end
        local confirmation_text = managers.localization:text("BetterCrewManagement_dialog_text_apply_to_all_profiles")
        show_confirmation_dialog(confirmation_text, callback)
    end

    crew_management_gui_self[callback_id_reset_crew_loadout] = function()
        local callback = function()
            reset_current_crew_loadout(crew_management_gui_self)
        end
        local confirmation_text = managers.localization:text("BetterCrewManagement_dialog_text_reset_crew_loadout")
        show_confirmation_dialog(confirmation_text, callback)
    end
end

local function apply_border_to_panel(panel)
    BoxGuiObject:new(panel, { sides = { 1, 1, 2, 1 } })
end

local function apply_background_to_panel(panel)
    panel:rect({
        alpha = 0.4,
        layer = -1,
        color = Color.black
    })
end

local function apply_blur_to_panel(panel)
    panel:bitmap({
        texture = "guis/textures/test_blur_df",
        layer = -1,
        halign = "scale",
        alpha = 1,
        render_template = "VertexColorTexturedBlur3D",
        valign = "scale",
        w = panel:w(),
        h = panel:h()
    })
end

local function count_panel_children(panel)
    if panel == nil or panel:children() == nil or not next(panel:children()) then
        return 0
    else
        return #panel:children()
    end
end

local function build_better_crew_management_panel(crew_management_gui_self)
    local padding = 5
    local intended_content_items = 4

    local content_panel_width = 180
    local content_panel_height = intended_content_items * font_size_small

    local wrapper_panel_width = content_panel_width + (padding * 2)
    local wrapper_panel_height = content_panel_height + (padding * 2)

    local panel_to_align_against = crew_management_gui_self._1_panel
    local wrapper_panel_x = panel_to_align_against ~= nil and panel_to_align_against:left() - wrapper_panel_width - 10 or nil
    local wrapper_panel_y = panel_to_align_against ~= nil and panel_to_align_against:top() or 200

    local bcm_wrapper_panel = crew_management_gui_self._panel:panel({
        w = wrapper_panel_width,
        h = wrapper_panel_height,
        x = wrapper_panel_x,
        y = wrapper_panel_y
    })
    apply_border_to_panel(bcm_wrapper_panel)
    apply_background_to_panel(bcm_wrapper_panel)
    apply_blur_to_panel(bcm_wrapper_panel)

    local bcm_content_panel = bcm_wrapper_panel:panel({
        w = content_panel_width,
        h = content_panel_height,
        x = padding,
        y = padding
    })
    return bcm_content_panel
end

local function add_text_to_panel(panel, text_id)
    panel:text({
        text = managers.localization:to_upper_text(text_id),
        font = font_small,
        font_size = font_size_small,
        color = text_color
    })
end

local function add_button_to_panel(crew_management_gui_self, panel, button_text_id, button_callback_id)
    local clickable_area_panel = panel:panel({
        h = font_size_small,
        y = count_panel_children(panel) * font_size_small
    })

    local panel_text = clickable_area_panel:text({
        text = managers.localization:to_upper_text(button_text_id),
        font = font_small,
        font_size = font_size_small,
        color = button_color_normal
    })

    local button_callback = callback(crew_management_gui_self, crew_management_gui_self, button_callback_id)

    local panel_button = CrewManagementGuiButton:new(crew_management_gui_self, button_callback, true)
    panel_button._panel = clickable_area_panel
    panel_button._normal_col = button_color_normal
    panel_button._select_col = button_color_hover

    function panel_button:_selected_changed(state)
        panel_text:set_color(state and self._select_col or self._normal_col)
    end
end

local function initialize_better_crew_management(crew_management_gui_self)
    initialize_button_callbacks(crew_management_gui_self)

    local bcm_panel = build_better_crew_management_panel(crew_management_gui_self)
    add_text_to_panel(bcm_panel, "BetterCrewManagement_mod_title")

    add_button_to_panel(crew_management_gui_self, bcm_panel,
        "BetterCrewManagement_panel_button_apply_to_other_profile",
        callback_id_apply_to_single)

    add_button_to_panel(crew_management_gui_self, bcm_panel,
        "BetterCrewManagement_panel_button_apply_to_all_profiles",
        callback_id_apply_to_all)

    add_button_to_panel(crew_management_gui_self, bcm_panel,
        "BetterCrewManagement_panel_button_reset_crew_loadout",
        callback_id_reset_crew_loadout)
end

--[[ ==============================
               Hooks
================================ ]]

Hooks:PostHook(CrewManagementGui, "init", "BetterCrewManagement_CrewManagementGui_init_post",
    function(self, ws, fullscreen_ws, node)
        initialize_better_crew_management(self)
    end)

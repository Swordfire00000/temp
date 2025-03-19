local Idstring = Idstring
local math_random = math.random
local pairs = pairs
local Rotation = Rotation
local table_insert = table.insert
local Vector3 = Vector3

local M_blackmarket
local M_menu_scene
local M_weapon_factory

local T_weapon = tweak_data.weapon
local T_character = tweak_data.character

local Hooks = Hooks

local idstring_idle_menu = Idstring('idle_menu')

local pose_rotation_offsets = {
	husk_akimbo1 = -2,
	husk_bullpup = -8,
	husk_generic1 = 5,
	husk_generic2 = 32,
	husk_generic4 = 42,
	husk_infamous1 = 2,
	husk_infamous2 = 6,
	husk_infamous3 = 8,
	husk_infamous4 = 14,
	husk_lmg = 28,
	husk_m249 = 32,
	husk_m95 = 6,
	husk_minigun = -10,
	husk_mosconi = 4,
	husk_pistol1 = 56,
	husk_r93 = -38,
	husk_ray = 16,
	husk_saw1 = 82,
	husk_shotgun1 = 12,
	husk_rifle1 = 8,
	husk_rifle2 = 8,
	lobby_generic_idle1 = -10,
	lobby_generic_idle2 = 8,
	lobby_generic_idle3 = 5,
	lobby_generic_idle4 = -6,
	lobby_minigun_idle1 = -10,
}

local usable_poses = {
	generic = {
		'husk_generic1',
		'lobby_generic_idle1',
		'lobby_generic_idle2',
		'lobby_generic_idle3',
		'lobby_generic_idle4',
	},
	lmg = {
		"husk_lmg",
	},
	m249 = {
		"husk_m249",
	},
	m95 = {
		"husk_m95",
	},
	r93 = {
		"husk_r93",
	},
}

local player_pos = {0, 20, -142}
local player_rot = 180

local ai_pos_offset = {65, 34, -4}
local ai_rot_offset = 12

local function get_position(index)
	if index then
		if index == 1 then
			return Vector3(player_pos[1] - ai_pos_offset[1], player_pos[2] + ai_pos_offset[2], player_pos[3] + ai_pos_offset[3])
		elseif index == 2 then
			return Vector3(player_pos[1] + ai_pos_offset[1], player_pos[2] + ai_pos_offset[2], player_pos[3] + ai_pos_offset[3])
		end
		return Vector3(player_pos[1] - (ai_pos_offset[1] * 2), player_pos[2] + (ai_pos_offset[2] * 2), player_pos[3] + (ai_pos_offset[3] * 2))
	end
	return Vector3(player_pos[1], player_pos[2], player_pos[3])
end

local function get_rotation(pose_id, index)
	local pose_offset = pose_rotation_offsets[pose_id] or 0
	if index then
		if index == 1 then
			return Rotation(player_rot + ai_rot_offset + pose_offset, -0, 0)
		elseif index == 2 then
			return Rotation(player_rot - ai_rot_offset + pose_offset, -0, 0)
		end
		return Rotation(player_rot + (2 * ai_rot_offset) + pose_offset, -0, 0)
	end
	return Rotation(player_rot + pose_offset, -0, 0)
end

local function get_ai_pose(index)
	local primary = M_blackmarket:get_crafted_category_slot('primaries', M_blackmarket:henchman_loadout(index).primary_slot)
	local weapon_id = primary and primary.weapon_id or M_weapon_factory:get_weapon_id_by_factory_id(T_character[M_menu_scene._picked_character_position[index]].weapon.weapons_of_choice.primary:gsub('_npc', ''))
	local category = T_weapon[weapon_id].categories[1]
	if usable_poses[weapon_id] and math_random() > 0.4 then
		return usable_poses[weapon_id][1]
		-- return usable_poses[weapon_id][math_random(usable_poses[weapon_id])]
	end
	if usable_poses[category] and math_random() > 0.4 then
		return usable_poses[category][1]
		-- return usable_poses[category][math_random(usable_poses[category])]
	end
	return usable_poses.generic[math_random(#usable_poses.generic)]
end

local previous_node
Hooks:PostHook(MenuComponentManager, 'set_active_components', 'MenuManager_open_menu_CB', function(_, _, node)
	local node_name = node and node._parameters.name
	if node_name ~= previous_name then
		previous_name = node_name
		if node_name == 'main' then
			M_blackmarket:verfify_crew_loadout()

			local unit, anim_state_machine
			for i = 1, 3 do
				M_menu_scene:set_henchmen_loadout(i)
				unit = M_menu_scene._henchmen_characters[i]
				unit:set_position(get_position(i))
				local pose_id = get_ai_pose(i)
				unit:set_rotation(get_rotation(pose_id, i))
				anim_state_machine = unit:anim_state_machine()
				anim_state_machine:set_parameter(unit:play_redirect(idstring_idle_menu), pose_id, 1)
				anim_state_machine:set_animation_time_all_segments(math_random())
			end
		end
	end
end)

Hooks:PostHook(MenuSceneManager, '_set_up_templates', 'MenuSceneManager__set_up_templates_CB', function(self)
	local managers = managers
	M_blackmarket = managers.blackmarket
	M_menu_scene = self
	M_weapon_factory = managers.weapon_factory
	
	local standard_template = self._scene_templates.standard
	standard_template.use_character_grab = nil
	standard_template.character_pos = get_position()
	standard_template.henchmen_characters_visible = true
end)

Hooks:PreHook(MenuSceneManager, '_set_character_unit_pose', 'MenuSceneManager__set_character_unit_pose_CB', function(_, pose, unit)
	unit:set_rotation(get_rotation(pose))
end)
ContourExt.fadeout_start_percent = 0.8

local idstr_material = Idstring("material")
local idstr_contour_color = Idstring("contour_color")
local idstr_contour_opacity = Idstring("contour_opacity")

local mvec3_dis_sq = mvector3.distance_sq
local mvec3_mul = mvector3.multiply
local mvec3_set = mvector3.set

local tmp_vec1 = Vector3()

Hooks:PreHook(ContourExt, "init", "smooth_contours_init", function(self)
	self._allow_occlusion = true
end)

-- parent unit handles everything through it's contour extension now, this is an absolutely moronic way to handle this
function ContourExt:apply_to_linked() end

local add_orig = ContourExt.add
function ContourExt:add(...)
	local removed_occlusion = self._removed_occlusion
	local setup = add_orig(self, ...)
	if setup.fadeout_t then
		setup.fadeout_start_t = math.lerp(TimerManager:game():time(), setup.fadeout_t, self.fadeout_start_percent)
		setup.fadeout_length = setup.fadeout_t - setup.fadeout_start_t
	end

	if not removed_occlusion and self._removed_occlusion then
		self:_set_allow_occlusion(false)
	end

	return setup
end

function ContourExt:_remove(index, sync, is_element)
	local setup = self._contour_list and self._contour_list[index]

	if not setup then
		return
	end

	if is_element and setup.ref_c_element then
		setup.ref_c_element = setup.ref_c_element - 1

		if setup.ref_c_element <= 0 then
			setup.ref_c_element = nil
		end
	end

	if setup.ref_c and setup.ref_c > 1 then
		setup.ref_c = setup.ref_c - 1

		return
	end

	local was_swap = nil

	if setup.data.material_swap_required then
		local base_ext = self._unit:base()

		if base_ext and base_ext.set_material_state then
			local should_swap = true

			for _, other_setup in ipairs(self._contour_list) do
				if setup ~= other_setup and other_setup.data.material_swap_required then
					should_swap = false

					break
				end
			end

			if should_swap then
				was_swap = true

				base_ext:set_material_state(true)
			end
		end
	end

	if #self._contour_list == 1 then
		self:_set_allow_occlusion(true)

		if not was_swap then
			self:_upd_opacity(0)
		end
	end

	self._last_opacity = nil

	table.remove(self._contour_list, index)

	if #self._contour_list == 0 then
		self._contour_list = nil
		self._materials = nil
	elseif index == 1 then
		self:_apply_top_preset()
	end

	if sync then
		local sync_unit = self._unit
		local u_id = self._unit:id()

		if u_id == -1 then
			sync_unit, u_id = nil
			local corpse_data = managers.enemy:get_corpse_unit_data_from_key(self._unit:key())

			if corpse_data then
				u_id = corpse_data.u_id
			end
		end

		if u_id then
			managers.network:session():send_to_peers_synched("sync_contour_remove", sync_unit, u_id, table.index_of(ContourExt.indexed_types, setup.type))
		else
			Application:error("[ContourExt:_remove] Unit isn't network-synced and isn't a registered corpse, can't sync. ", self._unit)
		end
	end

	if self._update_enabled then
		self:_chk_update_state()
	end

	if setup.data.damage_bonus or setup.data.damage_bonus_distance then
		self:_chk_damage_bonuses()
	end

	if setup.data.trigger_marked_event then
		self:_chk_mission_marked_events()
	end
end

function ContourExt:update(unit, t, dt)
	self._materials = nil -- lod changes seem to break the material cache, so i'm just refreshing it every frame

	local index = 1
	while self._contour_list and index <= #self._contour_list do
		local setup = self._contour_list[index]
		if setup.fadeout_t and setup.fadeout_t < t then
			self:_remove(index)
		else
			local data = setup.data
			local is_current = index == 1
			local opacity = nil
			if is_current and data.ray_check then
				local turn_on = nil
				local cam_pos = managers.viewport:get_current_camera_position()
				if cam_pos then
					turn_on = mvec3_dis_sq(cam_pos, unit:movement():m_com()) > 16000000
					turn_on = turn_on or unit:raycast("ray", unit:movement():m_com(), cam_pos, "slot_mask", self._slotmask_world_geometry, "report")
				end

				local target_opacity = turn_on and 1 or 0
				if data.persistence then
					opacity = math.step(self._last_opacity or 0, target_opacity, dt / data.persistence)
				else
					opacity = target_opacity
				end
			end

			if setup.flash_t then
				if t > setup.flash_t then
					setup.flash_t = t + setup.flash_frequency
					setup.flash_on = not setup.flash_on
				end

				if is_current then
					opacity = (setup.flash_t - t) / setup.flash_frequency
					opacity = setup.flash_on and 1 - opacity or opacity
				end
			elseif is_current and setup.fadeout_start_t then
				opacity = (t - setup.fadeout_start_t) / setup.fadeout_length
				opacity = 1 - math.max(opacity, 0)
			end

			if opacity then
				self:_upd_opacity(opacity)
			end

			index = index + 1
		end
	end
end

function ContourExt:_get_child_units()
	local units = {}
	local linked_units = self._unit.spawn_manager and self._unit:spawn_manager() and self._unit:spawn_manager():linked_units()
	if linked_units then
		local spawned_units = self._unit:spawn_manager():spawned_units()
		for unit_id in pairs(linked_units) do
			local unit_desc = spawned_units[unit_id]
			if unit_desc and alive(unit_desc.unit) then
				table.insert(units, unit_desc.unit)
			end
		end
	end

	return units
end

function ContourExt:_get_materials()
	local materials = {}
	local function add_materials(unit)
		for _, material in ipairs(unit:get_objects_by_type(idstr_material)) do
			if material:variable_exists(idstr_contour_color) and material:variable_exists(idstr_contour_opacity) then
				table.insert(materials, material)
			end
		end
	end

	add_materials(self._unit)

	for _, unit in ipairs(self:_get_child_units()) do
		add_materials(unit)
	end

	return materials
end

function ContourExt:_upd_opacity(opacity, is_retry)
	if opacity == self._last_opacity then
		return
	end

	self._materials = self._materials or self:_get_materials()

	for _, material in ipairs(self._materials) do
		if alive(material) then
			material:set_variable(idstr_contour_opacity, opacity)
		elseif not is_retry then
			self._last_opacity = opacity
			return self:update_materials()
		end
	end

	self._last_opacity = opacity -- set too early in vanilla so retrying the function returns immediately
	self:_upd_color(is_retry, nil, opacity) -- pass is_retry so it doesn't waste time invalidating the cache if it didn't fix itself here
end

function ContourExt:_upd_color(is_retry, no_child_upd, opacity)
	local setup = self._contour_list and self._contour_list[1]
	if not setup then
		return
	end

	local contour_color = setup.color or setup.data.color
	if not contour_color then
		return
	end

	opacity = opacity or 1
	local color = tmp_vec1

	mvec3_set(color, contour_color)
	mvec3_mul(color, opacity)

	self._materials = self._materials or self:_get_materials()

	for _, material in ipairs(self._materials) do
		if alive(material) then
			material:set_variable(idstr_contour_color, color)
		elseif not is_retry then
			return self:update_materials()
		end
	end
end

function ContourExt:_set_allow_occlusion(state)
	if self._allow_occlusion == state then
		return
	end

	self._allow_occlusion = state

	local occ_manager = managers.occlusion
	local occ_func = state and occ_manager.add_occlusion or occ_manager.remove_occlusion

	occ_func(occ_manager, self._unit)

	for _, unit in ipairs(self:_get_child_units()) do
		occ_func(occ_manager, unit)
	end
end

function ContourExt:update_materials()
	if self._contour_list then
		self._materials = nil

		local opacity = self._last_opacity or 1
		self._last_opacity = nil

		self:_upd_opacity(opacity, true) -- opacity also updates colour
	end
end

function ContourExt:add_child_unit(unit)
	if not self._allow_occlusion then
		managers.occlusion:remove_occlusion(unit)
	end

	self:update_materials()
end

Hooks:PreHook(ContourExt, "destroy", "smooth_contours_destroy", function(self)
	self:_set_allow_occlusion(true)
end)
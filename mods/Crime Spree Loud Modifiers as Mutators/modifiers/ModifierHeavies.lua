local _f_init = ModifierHeavies.init
function ModifierHeavies:init(data)
    self:FixTable()
    _f_init(self, data)
end

function ModifierHeavies:FixTable()
    if managers.crime_spree and managers.crime_spree:is_active() then
        return
    end
    -- Normal, Hard
    -- America
    self.unit_swaps["units/payday2/characters/ene_swat_1/ene_swat_1"] = "units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1"
    self.unit_swaps["units/payday2/characters/ene_swat_2/ene_swat_2"] = "units/payday2/characters/ene_swat_heavy_r870/ene_swat_heavy_r870"

    -- Russia
    self.unit_swaps["units/pd2_dlc_mad/characters/ene_akan_cs_swat_ak47_ass/ene_akan_cs_swat_ak47_ass"] = "units/pd2_dlc_mad/characters/ene_akan_cs_heavy_r870/ene_akan_cs_heavy_r870"
    self.unit_swaps["units/pd2_dlc_mad/characters/ene_akan_cs_swat_r870/ene_akan_cs_swat_r870"] = "units/pd2_dlc_mad/characters/ene_akan_cs_heavy_r870/ene_akan_cs_heavy_r870"

    -- Zombie
    self.unit_swaps["units/pd2_dlc_hvh/characters/ene_swat_hvh_1/ene_swat_hvh_1"] = "units/pd2_dlc_hvh/characters/ene_swat_heavy_hvh_1/ene_swat_heavy_hvh_1" 
    self.unit_swaps["units/pd2_dlc_hvh/characters/ene_swat_hvh_2/ene_swat_hvh_2"] = "units/pd2_dlc_hvh/characters/ene_swat_heavy_hvh_r870/ene_swat_heavy_hvh_r870"

    -- Mayhem, Death Wish
    -- America
    self.unit_swaps["units/payday2/characters/ene_city_swat_1/ene_city_swat_1"] = "units/payday2/characters/ene_city_heavy_r870/ene_city_heavy_r870"
    self.unit_swaps["units/payday2/characters/ene_city_swat_r870/ene_city_swat_r870"] = "units/payday2/characters/ene_city_heavy_g36/ene_city_heavy_g36"

    -- Russia
    self.unit_swaps["units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_ak47_ass/ene_akan_fbi_swat_dw_ak47_ass"] = "units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870"
    self.unit_swaps["units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870"] = "units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36"

    -- Zombie
    self.unit_swaps["units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_1/ene_fbi_swat_hvh_1"] = "units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_1/ene_fbi_heavy_hvh_1"
    self.unit_swaps["units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2"] = "units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_r870/ene_fbi_heavy_hvh_r870"

    -- Death Sentence
    -- America
    self.unit_swaps["units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat"] = "units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy"

    -- These do not spawn naturally, but other mods can still spawn them
    self.unit_swaps["units/payday2/characters/ene_city_swat_2/ene_city_swat_2"] = "units/payday2/characters/ene_city_heavy_r870/ene_city_heavy_r870"
    self.unit_swaps["units/payday2/characters/ene_city_swat_3/ene_city_swat_3"] = "units/payday2/characters/ene_city_heavy_g36/ene_city_heavy_g36"
end
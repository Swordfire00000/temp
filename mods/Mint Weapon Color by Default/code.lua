Hooks:PreHook(BlackMarketGui, "equip_weapon_color_callback", "ColorAlwaysMint", function(self, data)
    data.cosmetic_quality = "mint"
end)
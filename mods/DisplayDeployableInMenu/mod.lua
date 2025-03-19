Hooks:PostHook(MenuSceneManager, "init", "DisplayDeployableInMenu", function(self)
    self._scene_templates.standard.characters_deployable_visible = true
    self._scene_templates.lobby.characters_deployable_visible = true
    self._scene_templates.inventory.characters_deployable_visible = true
    self._scene_templates.crime_spree_lobby.characters_deployable_visible = true
	self._scene_templates.blackmarket_armor.characters_deployable_visible = true
end)
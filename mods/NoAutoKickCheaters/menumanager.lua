
-- From Lua 5.2
-- http://stackoverflow.com/questions/7183998/in-lua-what-is-the-right-way-to-handle-varargs-which-contains-nil/7186820#7186820
local function table_pack(...)
	return {n = select("#", ...), ...}
end

local MenuCrimeNetContractInitiator__modify_node_actual = MenuCrimeNetContractInitiator.modify_node
function MenuCrimeNetContractInitiator:modify_node(...)
	local args = table_pack(...)
	local data = args[2]

	if data ~= nil and type(data) == "table" and MenuCallbackHandler ~= nil then
		if not Global.game_settings.single_player and not data.server and not MenuCallbackHandler:lobby_exist() then
			-- Stomp the default setting, but only when there is no lobby active (since the checkbox doesn't show up when
			-- choosing new contracts while in an existing lobby)
			Global.game_settings.auto_kick = false
		end
	end

	return MenuCrimeNetContractInitiator__modify_node_actual(self, ...)
end

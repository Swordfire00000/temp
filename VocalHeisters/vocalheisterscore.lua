if not VocalHeisters then
    _G.VocalHeisters = {}
    VocalHeisters.ModPath = ModPath
    VocalHeisters.SavePath = SavePath .. "/vocalheisters.json"

    VocalHeisters.Settings = {
        disable_voice_line_force_loading = false,
        enable_sync = true,
        enable_anticipation_lines = true
    }

    -- Dice roll value that determines which peer will say voice lines that should only be played once.
    -- Example: at the end of an assault, only the player with the highest dice roll should comment on the assault ending
    -- This number is sent and received over the network as a string.
    VocalHeisters.SayOnceDiceRoll = math.random(1, 1000)
    VocalHeisters.LostDiceRoll = false

    -- Holds other players' diceroll values
    VocalHeisters.PeersWithMod = {}

    -- Saving menu settings
    function VocalHeisters:Save()
        local file = io.open(self.SavePath, "w+")
        if file then
            file:write(json.encode(VocalHeisters.Settings))
            file:close()
        end
    end

    -- Loading menu settings
    function VocalHeisters:Load()
        local file = io.open(self.SavePath, "r")
        if file then
            local fileSettings = json.decode(file:read("*all")) or {}
            for k, v in pairs(fileSettings) do
                self.Settings[k] = v
            end
            file:close()
        end
    end
    
    -- Immediately load and write data so that defaults exist
    --VocalHeisters:Load()

    -- If the config is corrupt, just calling Load() directly would cause an error and would *SILENTLY* prevent the below functions from being defined,
    -- causing really sneaky crashes later on. By loading it in a separately included file instead, *that file* might give an error,
    -- but the Save() call will then fix everything by overwriting it with default settings.
    dofile(ModPath .. "loadconfig.lua")

    -- Save settings right away to write new defaults and fix corrupt config files
    VocalHeisters:Save()

    -- Generic function that makes the player say a voice line
    function VocalHeisters:Say(voice_id)
        if Utils:IsInHeist() and not Utils:IsInCustody() and Utils:IsInGameState() then
            -- Thanks BLT and PD2 for forcing me to add even more of this nonsense
            if managers and managers.player and managers.player:local_player() and managers.player:local_player():sound() then
                managers.player:local_player():sound():say(voice_id, self.Settings.enable_sync, false)
            end
        end
    end

    -- Function that makes the player say a voice line, but only if they have not lost the dice roll.
    function VocalHeisters:SayOnce(voice_id)
        if not self.LostDiceRoll then
            self:Say(voice_id)
        end
    end

    -- Function that makes the player say lines that are normally third-person only
    function VocalHeisters:SayThirdPersonLine(voice_id)
        if Utils:IsInHeist() and not Utils:IsInCustody() and Utils:IsInGameState() then
            if managers and managers.player and managers.player:local_player() and managers.player:local_player():sound() and managers.player:local_player():sound()._unit then
                managers.player:local_player():sound()._unit:sound_source():set_switch("int_ext", "third")
                managers.player:local_player():sound():say(voice_id, self.Settings.enable_sync, false)
                managers.player:local_player():sound()._unit:sound_source():set_switch("int_ext", "first")
            end
        end
    end

    -- Same as SayOnce *and* SayThirdPersonLine.
    -- Says a voice line only if the diceroll hasn't been lost,
    -- and allows the local player to hear lines that are normally thirdperson-only
    function VocalHeisters:SayOnceThirdPersonLine(voice_id)
        if not self.LostDiceRoll then
            self:SayThirdPersonLine(voice_id)
        end
    end

    -- Should be called every time a new dice roll value is received, recalculates dice roll value.
    function VocalHeisters:_recalculate_dice_roll()
        self.LostDiceRoll = false

        for peer, roll in pairs(self.PeersWithMod) do
            if peer and roll and roll > self.SayOnceDiceRoll then
                self.LostDiceRoll = true
            end
        end
    end

    -- Get a random voice delay instead of always the same 5 seconds
    function VocalHeisters:FloatRandom(min, max)
        return math.random() + math.random(min, max - 1)
    end

    -- The following things below are networking functions, these are disabled if sync is disabled.
    -- Unsynced clients should not participate in the dicerolls.
    -- This may result in local SayOnce voiceline duplication if at least one person has sync enabled and you have it disabled.
    -- I can't do anything about this.
    -- Solution: don't disable sync ;)
    if VocalHeisters.Settings.enable_sync then
        -- On network load complete, tell peers that you have Vocal Heisters installed.
        -- Also give them your dice roll number, which is used for determining who says an end of assault line.
        Hooks:Add('BaseNetworkSessionOnLoadComplete', 'BaseNetworkSessionOnLoadComplete_VocalHeisters', function(local_peer, id)
            LuaNetworking:SendToPeers("vocalheisters_hello", tostring(math.floor(VocalHeisters.SayOnceDiceRoll)))
        end)

        -- Same as above, if a single peer joins then tell them your dice roll.
        Hooks:Add('BaseNetworkSessionOnPeerEnteredLobby', 'BaseNetworkSessionOnPeerEnteredLobby_VocalHeisters', function(peer, peer_id)
            LuaNetworking:SendToPeer(peer_id, "vocalheisters_hello", tostring(math.floor(VocalHeisters.SayOnceDiceRoll)))
        end)
        
        -- Network data receiving function
        Hooks:Add('NetworkReceivedData', 'NetworkReceivedData_VocalHeisters', function(sender, messageType, data)
            -- Acknowledge that a peer has this mod installed and store their dice roll number
            if messageType == "vocalheisters_hello" then
                VocalHeisters.PeersWithMod[sender] = tonumber(data)
                VocalHeisters:_recalculate_dice_roll()
            end
        end)

        -- If a peer leaves, remove them from the list
        Hooks:Add('BaseNetworkSessionOnPeerRemoved', 'BaseNetworkSessionOnPeerRemoved_VocalHeisters', function(peer, peer_id, reason)
            VocalHeisters.PeersWithMod[peer_id] = nil
            VocalHeisters:_recalculate_dice_roll()
        end)
    end
end

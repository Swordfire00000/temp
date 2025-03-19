-- Reset players' tracked revives when they use a doctor bag
Hooks:PostHook(UnitNetworkHandler, "sync_doctor_bag_taken", "vocalheisters_downstracker_medicbagusage", function(self, unit)
    if not unit then
        return
    end

    if not unit:base().downs then
        unit:base().downs = 0
    end
end)

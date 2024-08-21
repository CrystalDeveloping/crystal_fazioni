local ox_inventory = exports.ox_inventory

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for k, v in pairs(Config.fazioni) do
            ox_inventory:RegisterStash(v['job'].."_stash1", "Deposito 1", 75, 20000000, false, v['job'])
            ox_inventory:RegisterStash(v['job'].."_stash2", "Deposito 2", 75, 20000000, false, v['job'])
            ox_inventory:RegisterStash(v['job'].."_stash3", "Deposito 3", 75, 20000000, false, v['job'])
        end
    end
end)
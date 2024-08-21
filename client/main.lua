ESX = exports.es_extended:getSharedObject()
PlayerData = {}

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

for k,v in pairs(Config.fazioni) do
    if v.blipenable then
        local blip = AddBlipForCoord(v.blipcord[1], v.blipcord[2], v.blipcord[3])
        SetBlipSprite(blip, v.blip)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.blipScale)
        SetBlipColour(blip, v.blipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blipText)
        EndTextCommandSetBlipName(blip)
    end
    
    if v.deposito1 then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.deposito1[1], v.deposito1[2], v.deposito1[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per aprire il deposito',
            action = function ()
                exports.ox_inventory:openInventory('stash', v.job .. "_stash1")
            end
         })
    end

    if v.deposito2 then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.deposito2[1], v.deposito2[2], v.deposito2[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per aprire il deposito',
            action = function ()
                exports.ox_inventory:openInventory('stash', v.job .. "_stash2")
            end
         })
    end

    if v.deposito3 then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.deposito3[1], v.deposito3[2], v.deposito3[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per aprire il deposito',
            action = function ()
                exports.ox_inventory:openInventory('stash', v.job .. "_stash3")
            end
         })
    end

    if v.camerino then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.camerino[1], v.camerino[2], v.camerino[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per aprire il camerino',
            action = function ()
                exports['fivem-appearance']:openWardrobe()
            end
         })
    end

    if v.garage1 and v.garage1.pos then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.garage1.pos[1], v.garage1.pos[2], v.garage1.pos[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per aprire il garage',
            action = function ()
                ApriGarage(v.job)
            end
         })
    end

    if v.garage_deposito then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.garage_deposito[1], v.garage_deposito[2], v.garage_deposito[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per depositora il veicolo',
            action = function ()
                if IsPedInAnyVehicle(PlayerPedId()) then
                    ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    ESX.ShowNotification('Veicolo depositato con successo')
                else
                    ESX.ShowNotification('Non sei in un veicolo', 'error')
                end
            end
         })
    end

    if v.bossmenu then
        exports['crystal_lib']:CRYSTAL().gridsystem({ 
            pos = vector3(v.bossmenu[1], v.bossmenu[2], v.bossmenu[3]),
            rot = vector3(90.0, 90.0, 90.0),
            scale = vector3(0.8, 0.8, 0.8),
            textureName = 'marker',
            saltaggio = false,
            permission = v.job,
            msg = 'Premi [E] per depositora il bossmenu',
            action = function ()
                if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'viceboss' then
                    print('inserisci al posto del print, l\'export del tuo bossmenu')
                else
                    ESX.ShowNotification('Non puoi aprire il bossmenu', 'error')
                end
            end
         })
    end

end

---------- funzione garage -----------

function ApriGarage(job)
    for k, v in pairs(Config.fazioni) do
        if v.job == job and v.garage1 and v.garage1.vehicles then
            local elements = v.garage1.vehicles
            if #elements == 0 then
                table.insert(elements, {label = 'Veicoli non Disponibili', value = 'null'})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_fazioni',
            { 
                title = 'Garage', 
                align = 'bottom-right', 
                elements = elements 
            }, function(data, menu)
                if data.current.value ~= 'null' and data.current.model then
                    menu.close()

                    -- Ensure v.garage1.spawn is accessed correctly here
                    if ESX.Game.IsSpawnPointClear(v.garage1.spawn, 3.5) then
                        ESX.Game.SpawnVehicle(data.current.model, v.garage1.spawn, v.garage1.heading, function(vehicle)
                            SetVehicleLivery(vehicle, v.livrea or 0)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

                            if job == v.job then
                                SetVehicleCustomPrimaryColour(vehicle, v.garage1.color.rgb1, v.garage1.color.rgb2, v.garage1.color.rgb3)
                            end
                        end)
                    else
                        ESX.ShowNotification('Il punto di spawn è occupato', 'error')
                    end
                end
            end, function(data, menu) 
                menu.close() 
            end)
        end
    end
end

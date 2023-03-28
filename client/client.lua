QBCore = exports['qb-core']:GetCoreObject()

local setCopsOnline = false
local setCopsOffline = false

function ApplyWantedLevel(level)
    Citizen.CreateThread(function()
        QBCore.Functions.TriggerCallback("phade-aipolice:server:GetCops", function(copCount)  
            if copCount == 0 then 
                local wantedLevel = GetPlayerWantedLevel(PlayerId())
                local newWanted = wantedLevel + level
                if newWanted > Config.MaxWantedLevel then
                    newWanted = Config.MaxWantedLevel 
                end
                ClearPlayerWantedLevel(PlayerId())
                SetPlayerWantedLevelNow(PlayerId(),false)
                Citizen.Wait(10)
                SetPlayerWantedLevel(PlayerId(),newWanted,false)
                SetPlayerWantedLevelNow(PlayerId(),false)
            end
        end)
    end)
end

exports('ApplyWantedLevel', ApplyWantedLevel)

if Config.PoliceEventHandlers ~= nil then
    for k, v in pairs(Config.PoliceEventHandlers) do
        AddEventHandler(Config.PoliceEventHandlers[k].event, function ()
            ApplyWantedLevel(Config.PoliceEventHandlers[k].wantedLevel)
        end)
    end
end

RegisterNetEvent('phade-aipolice:refresh', function(amountCops)
    if amountCops > 0 and not setCopsOnline then
        setCopsOnline = true
        setCopsOffline = false
        TriggerEvent('qb-smallresources:client:CopsOnline')
        -- TriggerEvent('phade-aipolice:client:SetCopsOnline')
    elseif amountCops == 0 and not setCopsOffline then
        setCopsOffline = true
        setCopsOnline = false
        TriggerEvent('phade-aipolice:client:SetCopsOffline')
        -- TriggerEvent('qb-smallresources:client:CopsOffline')
    end
end)

RegisterNetEvent('phade-aipolice:client:ApplyWantedLevel', function(level)
    QBCore.Functions.TriggerCallback("phade-aipolice:server:GetCops", function(copCount)  
        if copCount > 0 then 
            ApplyWantedLevel(0)
        else
            ApplyWantedLevel(level)
        end
    end)
end)

RegisterNetEvent('phade-aipolice:client:SetCopsOffline', function()
    SetAudioFlag("PoliceScannerDisabled", false)
    SetCreateRandomCops(true)
    SetCreateRandomCopsNotOnScenarios(true)
    SetCreateRandomCopsOnScenarios(true)
    DistantCopCarSirens(false)

    for k, v in pairs(Config.DispatchTypes) do
        if Config.DispatchTypes[k].enabled then
            EnableDispatchService(k, true)
        elseif not Config.DispatchTypes[k].enabled then
            EnableDispatchService(k, false)
        end
    end
 
    SetMaxWantedLevel(Config.MaxWantedLevel)
end)
 
RegisterNetEvent('phade-aipolice:client:SetCopsOnline', function()
    SetAudioFlag("PoliceScannerDisabled", true)
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)
    DistantCopCarSirens(false)

    for i = 1, 15 do
        EnableDispatchService(i, false)
    end
 
    SetMaxWantedLevel(0)

    if Config.RemoveVehicleGenerators then
        RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 346.51)
        RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) 
        RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) 
        RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) 
        RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0)
        RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) 
        RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) 
        RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) 
    end
end)






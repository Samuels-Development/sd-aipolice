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
                local playerVehicle = GetVehiclePedIsIn(PlayerId(), true)
                if playerVehicle ~= 0 then
                    SetVehicleIsWanted(playerVehicle, true)
                end
            end
        end)
    end)
end

exports('ApplyWantedLevel', ApplyWantedLevel)

if Config.PoliceEventHandlers ~= nil then
    for k, _ in pairs(Config.PoliceEventHandlers) do
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
        TriggerEvent('phade-aipolice:client:SetCopsOnline')
    elseif amountCops == 0 and not setCopsOffline then
        setCopsOffline = true
        setCopsOnline = false
        TriggerEvent('phade-aipolice:client:SetCopsOffline')
        TriggerEvent('qb-smallresources:client:CopsOffline')
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

    for _, v in pairs(Config.DispatchTypes) do
        if v.enable then
            EnableDispatchService(v.dispatchType, true)
        else
            EnableDispatchService(v.dispatchType, false)
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


CreateThread(function ()
    local taskedVehicles = {}
    while true do
        if GetPlayerWantedLevel(PlayerId()) >= 1 and setCopsOffline then  -- If wanted and player police is offline
            local allVehicles = QBCore.Functions.GetVehicles()
            for _, v in pairs(allVehicles) do  -- Loop over all vehicles (big yikes, but what can we do)
                if GetVehicleClass(v) == 18 then  -- If vehicle is an emergency vehicle class 
                    CreateThread(function ()  -- Spawn a thread (i.e; Scheduled task that runs pseudo async)
                        local carPos = GetEntityCoords(v)
                        local policeInCar = GetPedInVehicleSeat(v, -1)
                        if policeInCar then  -- If the emergency vehicle has a driver
                            if Config.EnablePursitOnlyVehicleOccurence and v % Config.PursiutCarModulo == 0 then  -- If we want vehicles to be chase only vehicles
                                TaskVehicleChase(policeInCar, PlayerPedId())  -- Task chase
                                SetTaskVehicleChaseBehaviorFlag(policeInCar, 1, true)  -- Set behaviour to ramming and pitting
                                SetSirenKeepOn(v, true)  -- Turn on sirens, since setting task disables them
                                taskedVehicles[v] = policeInCar  -- Save this info, so we can remove this task once the chase is over
                            end
                            local carheading = GetEntityHeading(policeInCar)
                            local cameraman = CreatePed(0, GetHashKey('s_m_y_cop_01'), carPos.x, carPos.y, carPos.z+10, carheading, true, false)
                            SetPedAsCop(cameraman)  -- Creating the cameraman police officer; This will make the vehicles vision cone actually function
                            SetEntityInvincible(cameraman, true)
                            SetEntityVisible(cameraman, false, 0)
                            SetEntityCompletelyDisableCollision(cameraman, true, false)
                            SetPedAiBlipHasCone(cameraman, false)  -- Turn off the cone visibility so we don't have double cones on radar
                            Wait(250)
                            DeletePed(cameraman)  -- Remove the cameraman after the quarter second it exists
                        end
                    end)
                end
            end
            Wait(200)
        else  -- If wanted level subsides OR player police comes online
            for car, driver in pairs(taskedVehicles) do  -- Loop over the vehicles previously tasked for chasing
                TaskVehicleMission(driver, car, nil, 1, 0, 0, 0, 0, false)  -- Set their mission to cruise
                SetSirenKeepOn(car, false)  -- Turn off the siren
            end
            taskedVehicles = {}
            Wait(5000)
        end
    end
end)

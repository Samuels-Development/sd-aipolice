local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('phade-aipolice:server:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        for k, v in pairs(Config.PoliceJobs) do
            if Player.PlayerData.job.name == Config.PoliceJobs[k].job then
                if Config.PoliceJobs[k].dutyCheck then
                    if Player.PlayerData.job.onduty then
                        amount = amount + 1
                    end
                else
                    amount = amount + 1
                end
            end
        end
    end
    cb(amount)
end)
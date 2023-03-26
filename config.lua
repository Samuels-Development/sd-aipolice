Config = {}

Config.MaxWantedLevel = 5

Config.RemoveVehicleGenerators = true --Remove PD vehicle generators when pd go online

Config.PoliceJobs = {
    [1] = {
        job = 'police',
        dutyCheck = true,
    },
  --[2] = {
  --    job = 'bcso'       --If you have multiple police jobs, just uncomment this, and follow the same pattern,
  --    dutyCheck = true,
  --},
  --[3] = {
  --    job = 'sasp'       --If you have multiple police jobs, just uncomment this, and follow the same pattern,
  --    dutyCheck = true,
  --},
}

--To trigger it you can use this event: or the event handler below
--TriggerEvent('phade-aipolice:client:ApplyWantedLevel', level)

Config.PoliceEventHandlers = {
    [1] = {
        event = 'electronickit:UseElectronickit',
        wantedLevel = 4,
    },
    [2] = {
        event = 'lockpicks:UseLockpick',
        wantedLevel = 2,
    },
}

Config.DispatchTypes = {
    [0] = {
        dispatchType = 'DT_Invalid',
        enable = true -- set to false to turn off
    },
    [1] = {
        dispatchType = 'DT_PoliceAutomobile',
        enable = true
    },
    [2] = {
        dispatchType = 'DT_PoliceHelicopter',
        enable = true
    },
    [3] = {
        dispatchType = 'DT_FireDepartment',
        enable = true
    },
    [4] = {
        dispatchType = 'DT_SwatAutomobile',
        enable = true
    },
    [5] = {
        dispatchType = 'DT_AmbulanceDepartment',
        enable = true
    },
    [6] = {
        dispatchType = 'DT_PoliceRiders',
        enable = true
    },
    [7] = {
        dispatchType = 'DT_PoliceVehicleRequest',
        enable = true
    },
    [8] = {
        dispatchType = 'DT_PoliceRoadBlock',
        enable = true
    },
    [9] = {
        dispatchType = 'DT_PoliceAutomobileWaitPulledOver',
        enable = true
    },
    [10] = {
        dispatchType = 'DT_PoliceAutomobileWaitCruising',
        enable = true
    },
    [11] = {
        dispatchType = 'DT_Gangs',
        enable = true
    },
    [12] = {
        dispatchType = 'DT_SwatHelicopter',
        enable = true
    },
    [13] = {
        dispatchType = 'DT_PoliceBoat',
        enable = true
    },
    [14] = {
        dispatchType = 'DT_ArmyVehicle',
        enable = true
    },
    [15] = {
        dispatchType = 'DT_BikerBackup',
        enable = true
    }
}
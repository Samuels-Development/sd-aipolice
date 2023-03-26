This resource is fairly basic. Essentially, you can add an event to your scripts, that will add a specified amount of 'Wanted Stars' like in normal GTA. Police etc. will then pursue the player till he loses them.


#Credits

This script was created in large-part by phade#9756. Bag yourself some, quite frankly, amazing resources, by checking out his store @ https://phades-development.tebex.io/ or his discord @ https://discord.gg/Dh8E37Xt3t  
A couple touch-ups were made by me. :)


#Installation

1.) First you want to go to qb-smallresources/config.lua and find the following:

```Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}```

You can either remove these entires entirely or set them all to false to look like this:

```Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = false,
    [`s_m_y_sheriff_01`] = false,
    [`s_m_y_cop_01`] = false,
    [`s_f_y_sheriff_01`] = false,
    [`s_f_y_cop_01`] = false,
    [`s_m_y_hwaycop_01`] = false,
}```

2.) Go to qb-smallresources/client/ignore.lua and find the following:

```CreateThread(function()
	for dispatchService, enabled in pairs(Config.DispatchServices) do
		EnableDispatchService(dispatchService, enabled)
	end

	local wantedLevel = 0
	if Config.EnableWantedLevel then
		wantedLevel = 5
	end

	SetMaxWantedLevel(wantedLevel)
end)```

You'll want to comment out the entire code block, by using --[[ code ]]-- or by adding '--' in front of each individual line.

3.) In the same file, find the following:

```CreateThread(function() -- all these should only need to be called once
	if Config.DisableAmbience then
		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
		SetAudioFlag("DisableFlightMusic", true)
	end
	SetAudioFlag("PoliceScannerDisabled", true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	DistantCopCarSirens(false)
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW
end)```

You are going to want to comment out everything below the if Config.DisableAmbience block, so like this below:

```CreateThread(function() -- all these should only need to be called once
	if Config.DisableAmbience then
		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
		SetAudioFlag("DisableFlightMusic", true)
	end
	--[[ SetAudioFlag("PoliceScannerDisabled", true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	DistantCopCarSirens(false)
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW--]]
end)```'

4.) Head back over to the qb-smallresources/config.lua and find the following:

```Config.Disable = {
    disableHudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    disableControls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true -- false disables ammo display
}```

We are going to want to remove the '1' from disableHudComponents, so it should look like this:

```disableHudComponents = {2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22},```

5.) Now you're going to want to go to qb-smallresources/client/hudcomponents.lua and add the following to the top of the file:

```local copsOnline = false
 
RegisterNetEvent('qb-smallresources:client:CopsOnline', function()
	copsOnline = true
end)
 
RegisterNetEvent('qb-smallresources:client:CopsOffline', function()
	copsOnline = false
end)```

6.) Finally, you're going to want to scroll down, in the same file (hudcomponents.lua) and you are going to paste this into the CreateThread.

```if copsOnline then
	HideHudComponentThisFrame(1) -- 1 : WANTED_STARS
end```

When you're done, it should look like this:

```CreateThread(function()
    while true do

        -- Hud Components

        if copsOnline then
	       HideHudComponentThisFrame(1) -- 1 : WANTED_STARS
        end

        for i = 1, #disableHudComponents do
            HideHudComponentThisFrame(disableHudComponents[i])
        end

        for i = 1, #disableControls do
            DisableControlAction(2, disableControls[i], true)
        end

        DisplayAmmoThisFrame(displayAmmo)
        
        -- Density

        SetParkedVehicleDensityMultiplierThisFrame(Config.Density['parked'])
        SetVehicleDensityMultiplierThisFrame(Config.Density['vehicle'])
        SetRandomVehicleDensityMultiplierThisFrame(Config.Density['multiplier'])
        SetPedDensityMultiplierThisFrame(Config.Density['peds'])
        SetScenarioPedDensityMultiplierThisFrame(Config.Density['scenario'], Config.Density['scenario']) -- Walking NPC Density
        Wait(0)
    end
end)```


Now you're done and ready to run from some cops!


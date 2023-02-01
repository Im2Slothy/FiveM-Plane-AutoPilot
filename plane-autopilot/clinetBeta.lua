local autopilot = false
local plane = nil
local targetSpeed = 0
local targetHeight = 0
local targetHeading = 0

-- This thread is responsible for getting the current plane the player is in
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyPlane(playerPed) then
            plane = GetVehiclePedIsIn(playerPed)
        else
            plane = nil
        end
    end
end)

-- This function will handle the chat input
RegisterCommand( "ap", function()
    -- Check if the autopilot is currently activated
    if autopilot == false then
        -- Activating the autopilot
        autopilot = true
        targetSpeed = GetEntitySpeed(plane)
        targetHeight = GetEntityHeightAboveGround(plane)
        targetHeading = GetEntityHeading(plane)
        TriggerEvent('chatMessage', 'Auto Pilot', {255,255,255}, 'Activated')
        TriggerServerEvent('autopilot:activate', targetSpeed, targetHeight)
    elseif autopilot == true then
        -- Deactivating the autopilot
        autopilot = false
        TriggerEvent('chatMessage', 'Auto Pilot', {255,255,255}, 'Deactivated')
        TriggerServerEvent('autopilot:deactivate')
    end
end, false )
TriggerEvent( "chat:addSuggestion", "/ap", "Start Auto Pilot for the plane you're in" )

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)

    -- Only run the following code if the player is in a plane
    if plane ~= nil then
        if autopilot then
            -- Check if the plane has crashed -- BETA FEATURE
            if GetEntityHealth(plane) <= 0 and not crashed then
                autopilot = false
                crashed = true
                TriggerEvent('chatMessage', 'Auto Pilot', {255,255,255}, 'Deactivated due to crash')
                TriggerServerEvent('autopilot:deactivate')
            end
    
            -- Get the current speed and heading of the plane
            local speed = GetEntitySpeed(plane)
            local heading = GetEntityHeading(plane)
    
            -- Set the speed and heading of the plane
            SetEntityMaxSpeed(plane, targetSpeed)
            SetEntityHeading(plane, heading)
    
            -- Get the current position of the plane
            local x, y, z = GetEntityCoords(plane)
    
            -- Check if `y` has a value
            if y ~= nil then
            -- Calculate the next position of the plane based on the speed and heading
            local new_x = x + math.cos(math.rad(heading)) * speed * 0.01
            local new_y = y + math.sin(math.rad(heading)) * speed * 0.01
            local new_z = z + math.sin(math.rad(heading)) * speed * 0.01
    
            -- Set the new position of the plane
            SetEntityCoords(plane, new_x, new_y, new_z, true, true, true)
            end
        end
    end  
  end
end)


-- Event that is triggered when the auto-pilot status is updated
RegisterNetEvent('autopilot:update')
AddEventHandler('autopilot:update', function(autoPilot)
    -- Store the updated auto-pilot status
    autopilot = autoPilot
end)

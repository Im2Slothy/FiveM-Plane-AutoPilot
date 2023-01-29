local plane = nil
local targetSpeed = 0
local targetHeight = 0
local autopilot = false

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

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    
    if plane ~= nil then
      if IsControlPressed(0, 73) then -- Check if 'I' key is held
        if autopilot == false then
          autopilot = true
          targetSpeed = GetEntitySpeed(plane)
          targetHeight = GetEntityHeightAboveGround(plane)
          TriggerEvent('chatMessage', 'Auto Pilot', {255,255,255}, 'Activated')
        elseif autopilot == true then
          autopilot = false
          TriggerEvent('chatMessage', 'Auto Pilot', {255,255,255}, 'Deactivated')
        end
      end
      
      if autopilot then
        SetEntityMaxSpeed(plane, targetSpeed)
        SetEntityCoords(plane, GetEntityCoords(plane).x, GetEntityCoords(plane).y, targetHeight, true, true, true)
      end
    end
  end
end)

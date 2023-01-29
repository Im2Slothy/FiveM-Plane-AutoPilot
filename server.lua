local autoPilot = {}

-- Event that is triggered when a player activates the auto-pilot
RegisterServerEvent('autopilot:activate')
AddEventHandler('autopilot:activate', function(speed, height)
    -- Get the source player
    local source = source

    -- Store the player's auto-pilot status and settings
    autoPilot[source] = {
        speed = speed,
        height = height
    }

    -- Broadcast the updated auto-pilot status to all players
    TriggerClientEvent('autopilot:update', -1, autoPilot)
end)

-- Event that is triggered when a player deactivates the auto-pilot
RegisterServerEvent('autopilot:deactivate')
AddEventHandler('autopilot:deactivate', function()
    -- Get the source player
    local source = source

    -- Remove the player's auto-pilot status and settings
    autoPilot[source] = nil

    -- Broadcast the updated auto-pilot status to all players
    TriggerClientEvent('autopilot:update', -1, autoPilot)
end)

-- Event that is triggered when a player joins the game
AddEventHandler('playerConnecting', function()
    -- Broadcast the current auto-pilot status to the new player
    TriggerClientEvent('autopilot:update', source, autoPilot)
end)

-- Event that is triggered when a player leaves the game
AddEventHandler('playerDropped', function(reason)
    -- Get the source player
    local source = source

    -- Remove the player's auto-pilot status and settings
    autoPilot[source] = nil

    -- Broadcast the updated auto-pilot status to all players
    TriggerClientEvent('autopilot:update', -1, autoPilot)
end)

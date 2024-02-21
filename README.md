Config = {}

Config.DebugMode = false
Config.ShowOfflinePlayerOnly = true -- or false, depending on what you need
Config.UpdateInterval = 10000 -- Update time in milliseconds
Config.MarkerDisplayTime = 20000


-- Key bindings settings
Config.Keys = {
    PressKey = 137 -- CapsLock key code
}

-- Cooldown timer settings
Config.Cooldown = {
    time = 1000, -- 9 seconds in milliseconds
    messageOnPress = "CapsLock pressed",
    messageCooldown = "Please wait for the cooldown to expire before pressing again"
}

-- Text display settings
Config.MarkerDrawText = {
    scale = 0.35,
    font = 4,
    proportional = 1,
    colour = {255, 255, 255, 215},
    textCentre = 1,
}

-- Marker settings
Config.Marker = {
    id = 42,
    scale = {1.0, 1.0, 1.0},
    color = {255, 255, 255},
    alpha = 100,
    drawDistance = 5.0,  -- Виправлено тут
    heightAdjustment = 0.05,
    textHeightAdjustment = 0.5,
}

-- Language settings
Config.lang = {
    updatedPlayerData = "Player data updated: %s, status: Online",
    playerNowOffline = "Player %s (ID: %s) is now Offline",
    playerDisconnected = "Player %s disconnected: %s",
    playerDropped = "Player %s left the server (Reason: %s)",
    playerDisconnectedMarker = "Disconnected player: %s (ID: %s), coordinates saved.",
    playerDataRequested = "Player data requested from %s",
    sendingPlayerData = "Sending data for %s: %s",
    sendingMarkers = "Sent data for all players to the client for marker creation.",
    playerDisconnectedMarkerCreated = "Disconnected player: %s (ID: %s), coordinates saved.",
    playerDisconnectCheck = "Sent data for all players to the client for marker creation.",
    requestDataReceived = "Data request received from %s",
    sendingDataTo = "Sending data to %s: %s",
    onlineStatus = "Online",
    offlineStatus = "Offline",
    markerText = "ID: %s %s [%s] %s"
}

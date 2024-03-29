RegisterNetEvent('createExitMarker')
AddEventHandler('createExitMarker', function(coords, playerName, playerID, dateTime, identifier, isOnline)
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + Config.MarkerDisplayTime
        while GetGameTimer() < endTime do
            Citizen.Wait(0)

            if Config.ShowOfflinePlayerOnly and not isOnline or not Config.ShowOfflinePlayerOnly and isOnline then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - vector3(coords.x, coords.y, coords.z))
                local drawDistance = 10.0 -- Встановіть максимальну відстань, на якій маркер має бути видимим

                if distance < drawDistance then
                    DrawMarker(42, coords.x, coords.y, coords.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)
                    local statusText = isOnline and Config.lang.onlineStatus or Config.lang.offlineStatus
                    local markerText = string.format(Config.lang.markerText, playerID, playerName, statusText, dateTime)
                    DrawText3D(coords.x, coords.y, coords.z + 0.5, markerText)
                end
            end
        end
    end)
end)

-- Функція для відображення тексту в тривимірному просторі (без змін)
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local lastPressedTime = 0

-- Основний цикл для відстеження натискання CapsLock
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, Config.Keys.PressKey) then
            local currentTime = GetGameTimer()
            if currentTime - lastPressedTime > Config.Cooldown.time then
                print(Config.Cooldown.messageOnPress)
                TriggerServerEvent('requestPlayerData')
                lastPressedTime = currentTime
            else
                print(Config.Cooldown.messageCooldown)
            end
        end
    end
end)
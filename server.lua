-- Ініціалізація масиву для зберігання даних гравців
local playerData = {}
local PlayersDisconnected = {}
local QBCore = exports['qb-core']:GetCoreObject()

function UpdatePlayerData()
    local currentPlayers = {}
    for _, playerId in ipairs(GetPlayers()) do
        local ped = GetPlayerPed(playerId)
        if ped then
            local coords = GetEntityCoords(ped)
            local dateTime = os.date('%Y-%m-%d %H:%M:%S', os.time())
            local identifiers = GetPlayerIdentifiers(playerId)
            local identifier = nil
            for _, id in pairs(identifiers) do
                if string.find(id, "license:") then
                    identifier = id
                    break
                end
            end

            playerData[playerId] = {
                coords = coords,
                dateTime = dateTime,
                playerName = GetPlayerName(playerId),
                playerID = playerId,
                identifier = identifier,
                isOnline = true
            }
            currentPlayers[playerId] = true
            if Config.DebugMode then
                print(string.format(Config.lang.updatedPlayerData, playerData[playerId].playerName))
            end
        end
    end

    for playerId, data in pairs(playerData) do
        if not currentPlayers[playerId] and data.isOnline then
            data.isOnline = false
            if Config.DebugMode then
                print(string.format(Config.lang.playerNowOffline, data.playerName, playerId))
            end
        end
    end
end

-- Цикл оновлення даних гравця кожні 10 секунд
Citizen.CreateThread(function()
    while true do
        UpdatePlayerData()
        Citizen.Wait(Config.UpdateInterval) -- Використання затримки з конфігу
    end
end)

-- Функція для обробки "від'єднання" гравця
function PlayerDisconnect(_source)
    local data = playerData[_source]
    if data then
        TriggerClientEvent('createExitMarker', _source, data.coords, data.playerName, data.playerID, data.dateTime)
        if Config.DebugMode then
            print(string.format(Config.lang.playerDisconnectedMarker, data.playerName, _source))
        end
    end
end

-- Реєстрація команди playerdisconnectcheck
RegisterCommand('playerdisconnectcheck', function(source, args, rawCommand)
    for playerId, data in pairs(playerData) do
        TriggerClientEvent('createExitMarker', source, data.coords, data.playerName, data.playerID, data.dateTime, data.identifier, data.isOnline)
    end
    if Config.DebugMode then
        print(Config.lang.sendingMarkers)
    end
end, false)


RegisterServerEvent('requestPlayerData')
AddEventHandler('requestPlayerData', function()
    local _source = source
    if Config.DebugMode then
        print(string.format(Config.lang.requestDataReceived, _source))
    end
    for playerId, data in pairs(playerData) do
        if Config.DebugMode then
            print(string.format(Config.lang.sendingDataTo, data.playerName, tostring(data.isOnline)))
        end
        TriggerClientEvent('createExitMarker', _source, data.coords, data.playerName, data.playerID, data.dateTime, data.identifier, data.isOnline)
    end
end)


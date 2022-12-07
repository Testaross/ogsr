gsrData = {}

RegisterNetEvent("beginTest")
AddEventHandler("beginTest", function(args)
    local src = source
    local number = tonumber(args)
    if args ~= nil then 
        CancelEvent()
        local identifier = GetPlayerIdentifiers(number)[1]
        if identifier ~= nil then
            gsrcheck(source, identifier)
        end
    end
end)

RegisterNetEvent("removeGSR")
AddEventHandler("removeGSR", function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if gsrData[identifier] ~= nil then
        gsrData[identifier] = nil
    end
end)

RegisterServerEvent('beginGSR')
AddEventHandler('beginGSR', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    gsrData[identifier] = os.time(os.date("!*t")) + Config.gsrTime
end)

function gsrcheck(source, identifier)
    local src = source
    if gsrData[identifier] ~= nil then
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Test comes back POSITIVE (Has Shot)'})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Test comes back NEGATIVE (Has Not Shot)'})
    end
end

lib.callback.register('Update', function(source)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if gsrData[identifier] ~= nil then
        return true
    else
        return false
    end
end)

function removeGSR()
    for k, v in pairs(gsrData) do
        if v <= os.time(os.date("!*t")) then
            gsrData[k] = nil
        end
    end
end

function gsrTimer()
    removeGSR()
    SetTimeout(Config.gsrAutoRemove, gsrTimer)
end
gsrTimer()

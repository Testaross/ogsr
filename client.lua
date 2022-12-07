local hasShot = false
local playerPed = cache.ped


local function boomboompow()
    while true do
        if murderTime == true then
			break
		end
        Wait(0)
        if IsPedShooting(playerPed) then
            TriggerServerEvent('beginGSR', timer)
            hasShot = true
            Wait(Config.gsrUpdate)
        end
    end
end

CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            if murderTime == true then
                break
            end
            if IsEntityInWater(playerPed) then
                lib.notify({
                    title = '!?1?!?!?',
                    description = 'You begin cleaning off the Gunshot Residue... stay in the water.',
                    type = 'inform'
                })
				Wait(100)
                if lib.progressBar({
                    duration = Config.waterCleanTime,
                    label = 'Washing Off GSR',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                }) then 
                    if IsEntityInWater(playerPed) then
                        hasShot = false
                        TriggerServerEvent('removeGSR')
                        lib.notify({
                            title = '!?1?!?!?',
                            description = 'You washed off all the Gunshot Residue in the water.',
                            type = 'inform'
                        })
                    else
                        lib.notify({
                            title = '!?1?!?!?',
                            description = 'You left the water too early and did not wash off the gunshot residue.',
                            type = 'error'
                        })
                    end
                end
				Wait(Config.waterCleanTime)
            end
        end
    end
end)

function status()
    if hasShot then
        lib.callback('Update', false, function(cb)
            if not cb then
                hasShot = false
            end
        end) 
    end
end

function updateStatus()
    status()
    SetTimeout(Config.gsrUpdateStatus, updateStatus)
end
updateStatus()

exports.ox_target:addGlobalPlayer({
    {
        icon = '',
        label = 'GSR Test',
        groups = 'police',
        canInteract = function(entity, distance, coords, name)
            return distance < 1.5 
        end,
        onSelect = function(data)
            TriggerServerEvent('beginTest', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
    }
})

AddEventHandler('ox_inventory:currentWeapon', function(data)
    if data then
        murderTime = false
        CreateThread(boomboompow)
    else
		murderTime = true
    end
end)

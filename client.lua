
local ped = cache.ped
local shot = false
local lastShot = 0
local timeInWater = 0
local beenInWater = false

if LocalPlayer.state.shot then
    shot = true 
end

local function boomerremover()
	while true do
		local sleep = 1
        if KillThread == true then
            break
        end
        if IsPedShooting(ped) then
                print('here')
                lastShot = GetGameTimer()
                shot = true
                LocalPlayer.state:set('shot', true, true)
                sleep = 1000
        end
        Wait(sleep)
	end
end


lib.onCache('weapon', function(value)
    if value then
        KillThread = false
        CreateThread(boomerremover)
    else
        KillThread = true
    end
end)

CreateThread(function(boomerremover)
	while true do
        Wait(100)
        if shot == true then
            if IsEntityInWater(ped) then
                if inWater == false then
                    timeInWater = GetGameTimer()
                end
                beenInWater = true
                inWater = true
            else
                inWater = false
                beenInWater = false
                timeInWater = 0
            end
        end
        local timer = GetGameTimer()
        if shot and beenInWater and timer - timeInWater >= (Config.clearGSRinWater * 60 * 1000) then
            ClearPedBloodDamage(ped)
            ClearPedEnvDirt(ped)
            ResetPedVisibleDamage(ped)
            lib.notify({
                description = 'GSR Washed off',
                type = 'error'
            })
            LocalPlayer.state:set('shot', false, true)
            shot = false
        end
        if shot and timer - lastShot >= (Config.clearGSR * 60 * 1000) then
            lib.notify({
                description = 'GSR Washed off',
                type = 'error'
            })
            LocalPlayer.state:set('shot', false, true)
            shot = false
        end 
    end
end)

exports.ox_target:addGlobalPlayer({
    {
        icon = '',
        label = 'GSR Test',
        groups = 'police',
        canInteract = function(entity, distance, coords, name)
            return distance < 1.5 
        end,
        onSelect = function(data)
            TriggerServerEvent('gsrTest', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
    }
})


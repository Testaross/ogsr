local shot = false
local lastShot = 0
local timeInWater = 0
local beenInWater = false
local GetGameTimer = GetGameTimer
local inWater = false

if LocalPlayer.state.shot then
    shot = true 
    lastShot = LocalPlayer.state.lastShot
end

CreateThread(function()
	while true do
        Wait(100)
	local ped = (Config.oxLib and cache.ped or PlayerPedId())
        local shot = LocalPlayer.state.shot
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
        local lastShot = LocalPlayer.state.lastShot
        if shot and beenInWater and timer - timeInWater >= (Config.clearGSRinWater * 60 * 1000) then
            ClearPedBloodDamage(ped)
            ClearPedEnvDirt(ped)
            ResetPedVisibleDamage(ped)
            ShowNotification({
                description = 'GSR Washed off',
                type = 'error'
            })
            LocalPlayer.state:set('shot', false, true)
            shot = false
        end
        if shot and timer - lastShot >= (Config.clearGSR * 60 * 1000) then
            ShowNotification({
                description = 'GSR has faded',
                type = 'error'
            })
            LocalPlayer.state:set('shot', false, true)
            shot = false
        end 
    end
end)


function GetClosestPlayer(coords, max_dist)
    local closest_id, closest_dist
    for k, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
	local dist = #(coords - GetEntityCoords(ped))
        if DoesEntityExist(ped) and dist <= max_dist and (not closest_dist or closest_dist > dist) then
            closest_id, closest_dist = ped, dist
        end
    end
    return closest_id, closest_dist
end

function GSRTest(ped)
	local ped = (ped and ped or GetClosestPlayer())
	if ped then 
		if PermissionCheck("gsr") then 
			TriggerServerEvent('gsrTest', GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped)))
		else
			ShowNotification("There is nobody around to test.")
		end
	else
		ShowNotification("There is nobody around to test.")
	end
end

RegisterNetEvent("ogsr:notify", function(data) 
	ShowNotification("There is nobody around to test.")
end)

AddTarget()

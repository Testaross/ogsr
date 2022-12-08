RegisterNetEvent('gsrTest', function(target)
	local src = source
	local ply = Player(target)
	if ply.state.shot == true then
        	TriggerClientEvent('ogsr:notify', src, {type = 'success', description = 'Test comes back POSITIVE (Has Shot)'})
	else
        	TriggerClientEvent('ogsr:notify', src, {type = 'error', description = 'Test comes back NEGATIVE (Has Not Shot)'})
	end
end)

AddEventHandler("startProjectileEvent", function(sender, data) 
	local lastShot = GetGameTimer()
    	Player(sender).state:set('shot', true, true)
	Player(sender).state:set('lastShot', lastShot, true)
end)

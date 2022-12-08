RegisterNetEvent('gsrTest', function(target)
	local src = source
	local ply = Player(target)
	if ply.state.shot == true then
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Test comes back POSITIVE (Has Shot)'})
	else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Test comes back NEGATIVE (Has Not Shot)'})
	end
end)

RegisterNetEvent('ox_inventory:updateWeapon', function(action)
    if action ~= 'ammo' then return end
    local lastShot = GetGameTimer()
    Player(source).state:set('shot', true, true)
    Player(source).state:set('lastShot', lastShot, true)
end)



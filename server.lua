
RegisterNetEvent('gsrTest', function(target)
	local src = source
	local ply = Player(target)
	if ply.state.shot == true then
		print('yes')
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Test comes back POSITIVE (Has Shot)'})
	else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Test comes back NEGATIVE (Has Not Shot)'})
	end
end)



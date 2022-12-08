Config                          = {}
Config.gsrUpdate                = 1 * 1000          
Config.waterClean               = true              
Config.waterCleanTime           = 30 * 1000         
Config.gsrTime                  = 30 * 60          
Config.gsrAutoRemove            = 10 * 60 * 1000    
Config.gsrUpdateStatus          = 5 * 60 * 1000     

Config.oxInventory = (GetResourceState('ox_inventory') ~= 'missing')
Config.oxLib = (GetResourceState('ox_lib') ~= 'missing')

function AddTarget()
    if Config.oxInventory then 
        exports.ox_target:addGlobalPlayer({
            {
                icon = '',
                label = 'GSR Test',
                groups = 'police',
                distance = 1.5,
                onSelect = function(data)
                    TriggerServerEvent('gsrTest', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
                end
            }
        })
    end
end

function ShowNotification(data)
    if Config.oxLib then 
        lib.notify(data)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(data.description)
        EndTextCommandThefeedPostTicker(false, true)
    end
end

function PermissionCheck(name)
    if (name == "gsr") then 
        return true
    end
end

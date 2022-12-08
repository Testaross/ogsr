Config                          = {}
Config.gsrUpdate                = 1 * 1000          
Config.waterClean               = true              
Config.waterCleanTime           = 30 * 1000         
Config.gsrTime                  = 30 * 60          
Config.gsrAutoRemove            = 10 * 60 * 1000    
Config.gsrUpdateStatus          = 5 * 60 * 1000     

Config.oxInventory = (GetResourceState('ox_inventory') ~= 'missing')
Config.oxLib = (GetResourceState('ox_lib') ~= 'missing')
Config.oxTarget = (GetResourceState('ox_target') ~= 'missing')

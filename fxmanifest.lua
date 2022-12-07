fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'testarossa'

shared_script '@ox_lib/init.lua'

server_scripts {
	'config.lua',
	'server.lua',
}

client_scripts {
	'config.lua',
	"client.lua"
}


fx_version 'cerulean'
game 'gta5' 

author 'Mo1810'
version '1.1.1'

server_scripts {
	"@es_extended/locale.lua",
	"panicButton-s.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}

client_scripts {
	"@es_extended/locale.lua",
	"panicButton-c.lua",
	"config.lua",
	"locales/de.lua",
	"locales/en.lua"
}

shared_scripts {
	"@es_extended/imports.lua"
}

dependencies {
	'es_extended'
}

fx_version 'bodacious'
game 'gta5' 

author 'Mo1810#4230'
version '1.1.0'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
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

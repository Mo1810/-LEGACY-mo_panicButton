fx_version 'bodacious'
game 'gta5' 

author 'Mo1810#4230'
version '1.0.0'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"panicButton-s.lua",
	"config.lua",
	"locales/de.lua"
}

client_scripts {
	"@es_extended/locale.lua",
	"panicButton-c.lua",
	"config.lua",
	"locales/de.lua"
}

dependencies {
	'es_extended'
}
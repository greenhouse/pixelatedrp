version '1.0.0'

description "Wlist jobs By SneakGaming"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'server/main_sv.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'client/main_cl.lua'
}

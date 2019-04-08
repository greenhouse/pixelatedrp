resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Dispatch status'

ui_page 'html/scoreboard.html'

server_scripts {
	'@es_extended/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua'
}

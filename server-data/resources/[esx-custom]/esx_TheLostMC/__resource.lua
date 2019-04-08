resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

Server 'For ESX' --not for Vrp don´t work

description 'esx_TheLostMC'

version '1.0.0'

server_scripts {
  '@es_extended/locale.lua',
  'locales/de.lua',
  'locales/en.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/de.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua'
}

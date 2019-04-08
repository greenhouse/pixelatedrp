-- Manifest
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency 'essentialmode'

client_script {
    'client.lua',
	   'GUI.lua',
     'config.lua',
}

server_scripts {
	'server.lua',
  'config.lua',
}

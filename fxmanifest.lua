fx_version 'cerulean'
games {'gta5'}
lua54 'yes'


author 'Marko Players'
description 'Player Info'
version '1.0.0'

client_script {
  'client.lua',
} 
server_script {
  'server.lua',
} 

shared_script 'config.lua'

--ui_page 'ui/index.html'

files { 
  'ui/*',
}

escrow_ignore {
  'config.lua',
}
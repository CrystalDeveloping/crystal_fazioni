fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'Alga11'
client_scripts {
    'client/*.*',
}

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/**.lua',
  }server_scripts { '@mysql-async/lib/MySQL.lua' }

shared_scripts {
    'shared/**.*',
    'shared/cfg.lua',
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}
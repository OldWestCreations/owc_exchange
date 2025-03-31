game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
version '1.0.2'
lua54 'yes'

author '@HerrScaletta | Old West Creations'
description 'Simple currency exchange script for VorpCore RedM'

client_scripts { 
    'config.lua',
    'client.lua'
}

server_scripts { 
    'config.lua',
    'server.lua'
}

vorp_checker 'yes'
vorp_name '^5 OldWestCreation ^4version Check^3'
vorp_github 'https://github.com/OldWestCreations/owc_exchange' 

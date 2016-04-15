-- yates_server.lua --

--[[
	I have commented everything as much as I thought necessary, if you have any questions please PM me on Unreal Software.
	My U.S.G.N ID is 21431, my current username is Yates (it will probably remain so).

	I recommend you not change anything in this file. If you want to make small changes, use the settings file
	which has predefined variables and that sort of thing.
	If you want to change something but can't find out how; double check the settings and documentation - it's there, trust me.
]]--

_DIR = "sys/lua/Y.A.T.E.S/"

print("\169000255255[YATES]: Setting the settings..")
dofile(_DIR.."yates_settings.lua")
print("\169000255255[YATES]: Configuring the configuration..")
dofile(_DIR.."yates_config.lua")
print("\169000255255[YATES]: Hooking the hooks..")
dofile(_DIR.."yates_hooks.lua")
print("\169000255255[YATES]: Functioning the functions.. Or something..")
dofile(_DIR.."yates_functions.lua")
print("\169000255255[YATES]: Loading say commands..")
dofile(_DIR.."yates_sayCommands.lua")
print("\169000255255[YATES]: Loading data..")
dofile(_DIR.."data/data_yates.lua")
dofile(_DIR.."data/data_group.lua")
dofile(_DIR.."data/data_player.lua")
print("\169000255255[YATES]: Checking first use..")
checkInitialAuth()

-- You may remove this, but I'd rather you not. People can't see it anyway.
print("\169000255255[YATES]: Thank you for using Y.A.T.E.S.")
print("\169000255255[YATES]: Creator: Yates, U.S.G.N ID 21431.")
-- yates_server.lua --

--[[
	I have commented everything as much as I thought necessary, if you have any questions please PM me on Unreal Software.
	My U.S.G.N. ID is 21431, my current username is Yates (it will probably remain so).
]]--

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

--[[
	Checks where the script is located
	@return string
]]
function scriptPath()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

-- This will make sure the folder name of where Y.A.T.E.S is located gets used in _DIR
local path = scriptPath()
path = string.sub(path,1,-2)
sys, lua, path, core = path:match("([^,]+)/([^,]+)/([^,]+)/([^,]+)")

-- Dofiling a script in Y.A.T.E.S for some reason (I made the plugin crap for that, so you have no reason to do it) you can use this as the path!
_DIR = "sys/lua/"..path.."/"

print("\169100255255[Y.A.T.E.S]: Setting the settings..")
dofile(_DIR.."core/yates_settings.lua")
print("\169100255255[Y.A.T.E.S]: Configuring the configuration..")
dofile(_DIR.."core/yates_config.lua")
print("\169100255255[Y.A.T.E.S]: Hooking the hooks..")
dofile(_DIR.."core/yates_hooks.lua")
print("\169100255255[Y.A.T.E.S]: Functioning the functions..")
dofile(_DIR.."core/yates_functions.lua")
print("\169100255255[Y.A.T.E.S]: Localizing the languages..")
getLanguageData()
print("\169100255255[Y.A.T.E.S]: "..lang("info", 4, yates.setting.language))
print("\169100255255[Y.A.T.E.S]: Loading say commands..")
dofile(_DIR.."core/yates_sayCommands.lua")
print("\169100255255[Y.A.T.E.S]: Loading console commands..")
dofile(_DIR.."core/yates_consoleCommands.lua")
print("\169100255255[Y.A.T.E.S]: Loading data..")
dofileLua(_DIR.."storage/data/data_yates.lua", true)
dofileLua(_DIR.."storage/data/data_group.lua", true)
dofileLua(_DIR.."storage/data/data_player.lua", true)
dofileLua(_DIR.."storage/data/data_plugin.lua", true)
print("\169100255255[Y.A.T.E.S]: Checking first use..")
checkAuth()
print("\169100255255[Y.A.T.E.S]: Loading plugins..")
loadPlugins()
print("\169100255255[Y.A.T.E.S]: Versioning the version..?")
checkVersion()
setTransferList(yates.setting.transferlist_response)

-- You may remove this, but I'd rather you not. People can't see it anyway.
print(" ")
print("\169100255255[Y.A.T.E.S]: "..lang("info", 1))
print("\169100255255[Y.A.T.E.S]: "..lang("info", 2, "Yates", 21431))

function addhook()
	yatesLog(lang("error", 2), "ERROR")
	return
end
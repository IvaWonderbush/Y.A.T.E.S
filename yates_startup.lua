-- yates_server.lua --

--[[
	I have commented everything as much as I thought necessary, if you have any questions please PM me on Unreal Software.
	My U.S.G.N ID is 21431, my current username is Yates (it will probably remain so).

	I recommend you not change anything in this file. If you want to make small changes, use the settings file
	which has predefined variables and that sort of thing.
	If you want to change something but can't find out how; double check the settings and documentation - it's there, trust me.
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
sys, lua, path = path:match("([^,]+)/([^,]+)/([^,]+)")

-- Dofiling a script in Y.A.T.E.S for some reason (I made the add-on crap for that, so you have no reason to do it) you can use this as the path!
_DIR = "sys/lua/"..path.."/"

print("\169000255255[Y.A.T.E.S]: Setting the settings..")
dofile(_DIR.."yates_settings.lua")
print("\169000255255[Y.A.T.E.S]: Configuring the configuration..")
dofile(_DIR.."yates_config.lua")
print("\169000255255[Y.A.T.E.S]: Hooking the hooks..")
dofile(_DIR.."yates_hooks.lua")
print("\169000255255[Y.A.T.E.S]: Functioning the functions.. Or something..")
dofile(_DIR.."yates_functions.lua")
print("\169000255255[Y.A.T.E.S]: Loading say commands..")
dofile(_DIR.."yates_sayCommands.lua")
print("\169000255255[Y.A.T.E.S]: Loading data..")
dofileLua(_DIR.."data/data_yates.lua", true)
dofileLua(_DIR.."data/data_group.lua", true)
dofileLua(_DIR.."data/data_player.lua", true)
print("\169000255255[Y.A.T.E.S]: Checking first use..")
checkInitialAuth()

-- You may remove this, but I'd rather you not. People can't see it anyway.
print("\169000255255[Y.A.T.E.S]: Thank you for using Y.A.T.E.S.")
print("\169000255255[Y.A.T.E.S]: Creator: Yates, U.S.G.N ID 21431.")
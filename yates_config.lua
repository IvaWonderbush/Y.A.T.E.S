-- yates_config.lua --

-- General configuration. This is seen as the general server setup, for more information please visit http://www.thomasyates.nl/docs
yates.setting.check_version = true

yates.setting.say_prefix = "!"

yates.setting.message_prefix = "[Y.A.T.E.S]: "

yates.setting.group_default = "default"

yates.setting.date = os.date("%d").."-"..os.date("%m").."-"..os.date("%Y")
yates.setting.time = os.date("%I:%M %p")

-- Enables/disables the use of @C, true enables the use, false disables the use.
yates.setting.at_c = false
yates.setting.at_c_replacement = ""

-- Colours
clr = {
	["yates"] = {
		["default"] 	= "\169255255255",
		["info"] 		= "\169100255255",
		["success"] 	= "\169100255100",
		["warning"] 	= "\169255100100",
		["alert"] 		= "\169255255100"
	},
	["ply"] = {
		["spec"] 		= "\169255220000",
		["ct"] 			= "\169050150255",
		["t"] 			= "\169255025000",
		["tdm"] 		= "\169000255000"
	}
}

-- Constant variables. Used to set player or group fields to a certain value other than a numeric or string.
yates.constant = {
	["false"] = false,
	["true"] = true
}

--[[
	WARNING:
	Do not touch the _PLAYER or _GROUP tables if you do not know how to!
	Everything player and group defined can be changed IN-GAME, so editing this is pretty pointless
	unless you want to define data if data_player or data_group cannot be loaded or are empty.
	I would advise not to do this as data_player and data_group override this data anyway.
	BE WARNED.
]]--

-- This can set default player values if the data_player cannot be loaded.
_PLAYER = {
	-- This gives the player with the U.S.G.N ID 21431 (Me, Yates, the author) a purple colour. Keep it here if you want me to enjoy the colour purple.
	[21431] = {
		colour = "180000250"
	}
}

-- This sets the default groups if the data_group file cannot be loaded.
_GROUP = {
	["admin"] = {
		prefix = "[Admin]",
		colour = "255025000",
		level = 99,
		commands = {
			"all"
		}
	},
	["default"] = {
		colour = "255255255",
		level = 1,
		commands = {
			"help",
			"auth"
		}
	}
}
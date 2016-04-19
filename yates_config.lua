-- yates_config.lua --

-- When using a command, the prefix is default !, changing this to @ would result in everyone have to say @help for example
yates_say_prefix = "!"

-- Server message prefix, changing it to "[SERVER]: " would result in server messages displaying like: [SERVER]: You have kicked <player name>
yates_message_prefix = "[Y.A.T.E.S]: "

-- Default group, used for people who have no group or as default placement after a group has been removed which contained players
yates_group_default = "default"

-- Default group colour on creation of a group if a colour is not supplied
yates_group_default_colour = "\169100255255"

-- Log date and time used for example the log file titles
yates_date = os.date("%d").."-"..os.date("%m").."-"..os.date("%Y")
yates_time = os.date("%I:%M %p")

-- Disable using @C, 1 is true, 0 is false
yates_at_c = 1

-- If @C is disabled, this will be used as replacement. Leave empty for no replacement at all
yates_at_c_replacement = ""

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

-- Constant variables, used to set player or group fields to a certain value other than a numeric or string
const = {
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

-- This can set default player values if the data_player cannot be loaded
_PLAYER = {}

-- This sets the default groups if the data_group file cannot be loaded
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
			"all"
		}
	}
}
-- yates_config.lua --

-- General configuration. This is seen as the general server setup, for more information please visit http://www.thomasyates.nl/docs
-- NOTE: If you are a Windows user and you cannot establish connection to get the current live verion please install Git (https://git-scm.com) and make sure you enable the use of Unix tools in the Windows terminal
yates.setting.check_version = true
yates.setting.update_version = false -- Currently not in use

-- WANT ADMIN AND ACCESS TO EVERYTHING? THIS IS THE VARIABLE YOU CHANGE!
-- The following U.S.G.N ID will be given access to all of the available commands within Y.A.T.E.S. This person should preferrably be you.
yates.setting.auth_usgn = 0 -- example: 21431 ->NOT<- "21431"

-- The prefix for say commands. The prefix / is reserved by Counter-Strike 2D and cannot be used
yates.setting.say_prefix = "!"

-- The prefix for all outputting methods unless overwritten
yates.setting.message_prefix = "[Y.A.T.E.S]: "

-- Fallback for undefined variables, it is recommended to keep this default unless you know what you're getting into
yates.setting.group_default = "default"

-- Time and date variables used in log files
yates.setting.date = os.date("%d").."-"..os.date("%m").."-"..os.date("%Y")
yates.setting.time = os.date("%H:%M:%S")

-- Enables/disables the use of @C, true enables the use, false disables the use
yates.setting.at_c = false
yates.setting.at_c_replacement = "at_c"

-- Enables/disables the saving of the mute time.This keeps the player muted even after he rejoins. Will only work on people that are logged into a U.S.G.N. account
yates.setting.mute_save = true

-- The default mute time in seconds if none is provided
yates.setting.mute_time_default = 30

-- The max time a player can be muted for in seconds. If you don't fully trust your administration team to not be dicks, set this to 60 seconds or something ;)
yates.setting.mute_time_max = 60

-- Enables/disables the response when Y.A.T.E.S adds a ->NEW<- file to the transfer list. Good for debugging, bad for saving console space
yates.setting.transferlist_response = false

-- Colours, do not remove these entries! You may add new ones
clr = {
	["yates"] = {
		["default"] 	= "\169255255255",
		["chat"] 		= "\169255255255",
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

-- Constant variables. Used to set player or group fields to a certain value other than a numeric or string
yates.setting.constant = {
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
_PLAYER = {
	-- This gives the player with the U.S.G.N. ID 21431 (Me, Yates, the author) a purple colour. Keep it here if you want me to enjoy the colour purple (purple is my favourite colour, now you know..)
	[21431] = {
		colour = "180000250"
	}
}

-- This sets the default groups if the data_group file cannot be loaded
_GROUP = {
	["admin"] = {
		prefix = "[Admin]",
		colour = "255025000",
		level = 99,
		commands = {
			"all",
		},
	},
	["moderator"] = {
		prefix = "[Moderator]",
		colour = "025255000",
		level = 90,
		commands = {
			"hide",
			"god",
			"mute",
			"unmute",
			"kick",
			"ban",
			"banusgn",
			"unban",
			"spawn",
			"kill",
			"slap",
			"equip",
			"strip",
			"goto",
			"goback",
			"bring",
			"bringback",
			"make",
			"playerinfo",
			"undo",
		},
	},
	["default"] = {
		colour = "255255255",
		level = 1,
		commands = {
			"help",
			"pm",
			"credits",
		},
	},
}
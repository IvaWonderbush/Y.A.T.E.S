-- yates_config.lua --

-- General configuration. This is seen as the general server setup, for more information please visit http://www.thomasyates.nl/docs
-- NOTE: If you are a Windows user and you cannot establish connection to get the current live verion please install Git (https://git-scm.com) and make sure you enable the use of Unix tools in the Windows terminal
yates.settings.check_version = true
yates.settings.update_version = false -- Currently not in use

-- WANT ADMIN AND ACCESS TO EVERYTHING? THIS IS THE VARIABLE YOU CHANGE!
-- The following U.S.G.N. ID will be given access to all of the available commands within Y.A.T.E.S. This person should preferrably be you.
yates.settings.auth_usgn = 21431 -- example: 21431 **NOT**: "21431"

-- The shortcode of the language you want to use within Y.A.T.E.S
yates.settings.language = "en"

-- The prefix for say commands. The prefix / is reserved by Counter-Strike 2D and cannot be used
yates.settings.say_prefix = "!"

-- The prefix for all outputting methods unless overwritten
yates.settings.message_prefix = "[SERVER]: "

-- Fallback for undefined variables, it is recommended to keep this default unless you know what you're getting into
yates.settings.group_default = "default"

-- Time and date variables used in log files
yates.settings.date = os.date("%d").."-"..os.date("%m").."-"..os.date("%Y")
yates.settings.time = os.date("%H:%M:%S")

-- Enables/disables the logging of command usage
yates.settings.log_commands = true

-- Enables/disables the use of @C, true enables the use, false disables the use
yates.settings.at_c = false
yates.settings.at_c_replacement = "at_c"

-- Enables/disables the saving of the mute time.This keeps the player muted even after he rejoins. Will only work on people that are logged into a U.S.G.N. account
yates.settings.mute_save = true

-- The default mute time in seconds if none is provided
yates.settings.mute_time_default = 30

-- The max time a player can be muted for in seconds. If you don't fully trust your administration team to not be dicks, set this to 60 seconds or something ;)
yates.settings.mute_time_max = 60

-- Enables/disables the response when Y.A.T.E.S adds a **NEW** file to the transfer list. Good for debugging, bad for saving console space
yates.settings.transferlist_response = false

-- Colours, do not remove these entries! You may add new ones
_COLOURS = {
	["yates"] = {
		["default"] 	= "\169255255255",
		["chat"] 		= "\169255255255",
		["info"] 		= "\169100255255",
		["success"] 	= "\169100255100",
		["error"] 		= "\169255100100",
		["notice"] 		= "\169255255100"
	},
	["team"] = {
		["spec"]		= "\169255220000",
		["ct"] 			= "\169050150255",
		["t"] 			= "\169255025000",
		["tdm"] 		= "\169000255000"
	}
}

-- Constant variables. Used to set player or group fields to a certain value other than a numeric or string
yates.settings.constants = {
	["false"] = false,
	["true"] = true,
	["nil"] = nil, -- This doesn't actually register as Lua table entries set to nil don't exist but at least you know you can use it
}

--[[
	WARNING:
	Do not touch the _PLAYERS or _GROUPS tables if you do not know how to!
	Everything player and group defined can be changed IN-GAME, so editing this is pretty pointless
	unless you want to define data if data_player or data_group cannot be loaded or are empty.
	I would advise not to do this as data_player and data_group override this data anyway.
	BE WARNED.
]]--

-- This can set default player values if the data_player cannot be loaded
_PLAYERS = {
	-- This gives the player with the U.S.G.N. ID 21431 (Me, Yates, the author) a purple colour. Keep it here if you want me to enjoy the colour purple (purple is my favourite colour, now you know..)
	[21431] = {
		colour = "180000250"
	}
}

-- This sets the default groups if the data_group file cannot be loaded
_GROUPS = {
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
			"help",
			"pm",
			"credits",
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
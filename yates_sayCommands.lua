--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more

	Want to add commands?
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.func.say.auth()
	if player(_id, "usgn") == 0 then
		yatesMessage(id, "You need to be logged in to a U.S.G.N. account to do this!", "warning")
		return
	end

	if not _tbl[2] then
		yatesMessage(id, "You need to provide an authentication token!", "warning")
		return
	end

 	if _YATES.auth_token ~= true then
		if _tbl[2] == _YATES.auth_token then
			yatesMessage(_id, "Authentication complete! Thank you for using Y.A.T.E.S, "..player(_id,"name")..".", "success")	
			yatesMessage(_id, "If you want a detailed tutorial on how everything works, go ahead and say "..yates.setting.say_prefix.."tutorial", "info")
			_YATES.auth_token = true
			_YATES.auth_usgn = player(_id, "usgn")
			_PLAYER[_YATES.auth_usgn] = {}
			_PLAYER[_YATES.auth_usgn].commands = {"all"}
			table.insert(_YATES.disabled_commands, "auth")

			saveData(_YATES, "data_yates.lua")
			saveData(_PLAYER, "data_player.lua")
		else
			yatesMessage(id, "Incorrect authentication token.", "warning")	
		end
	else
		yatesMessage(id, "The initial authentication has already been complete!", "warning")
	end
end
setSayHelp("auth", "<token>")
setSayDesc("auth", "Authenticates the server owner or server administrator and grants access to all commands on success.")

function yates.func.say.help()
	local usgn = player(_id, "usgn") or 0
	local everything = false

	if _tbl[2] then
		if yates.say.help[_tbl[2]] then
			yatesMessage(_id, "Usage:", "info")
			yatesMessage(_id, yates.setting.say_prefix..yates.say.help[_tbl[2]], "default", false)
			if yates.say.desc[_tbl[2]] then
				yatesMessage(_id, yates.say.desc[_tbl[2]], "default", false)
			end
			yatesMessage(_id, "", false, false)
			yatesMessage(_id, "A parameter is wrapped with < >, a parameter that is optional is wrapped with [ ].", "info")
			yatesMessage(_id, "Additional parameter elaboration is displayed behind a parameter wrapped with ( ).", "info")
		else
			yatesMessage(_id, "There is no help for this command!", "alert")
		end
	else
		if _PLAYER[usgn] and _PLAYER[usgn].commands then
			for k, v in spairs(_PLAYER[usgn].commands) do
				if v == "all" then
					everything = true
					break
				end
				yatesMessage(_id, yates.setting.say_prefix..v, "default", false)
			end
		end
		if everything ~= true then
			for k, v in spairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates.setting.group_default)].commands) do
				if v == "all" then
					everything = true
					break
				end
				yatesMessage(_id, yates.setting.say_prefix..v, "default", false)
			end
		end
		if everything == true then
			for k, v in spairs(yates.func.say) do
				if #k > 0 then
					yatesMessage(_id, yates.setting.say_prefix..k, "default", false)
				end
			end
		end
		yatesMessage(_id, "For more information about a command, say "..yates.setting.say_prefix.."help <command>", "info")
		yatesMessage(_id, "If the list is too long for you, open your console.", "info")
	end
end
setSayHelp("help", "[<cmd>]")

function yates.func.say.pm()
	local message = ""

	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if _tbl[3] then
		for i = 3, #_tbl do
    		if message == "" then
				message = _tbl[i]
			else
				message = message.." ".._tbl[i]
			end
		end
	end

	action("pm", _id, _tbl[2], message)

	yatesMessage(_id, "[->] [".._tbl[2].."] "..player(_tbl[2], "name")..": "..message, "info", "[PM]: ")
	yatesMessage(_tbl[2], "[<-] [".._id.."] "..player(_id, "name")..": "..message, "info", "[PM]: ")
end
setSayHelp("pm", "<id> <message>")
setSayDesc("pm", "Sends a private message (pm) to the accoding player.")

function yates.func.say.credits()
	yatesMessage(_id, "Y.A.T.E.S was made by Yates, U.S.G.N. ID 21431.", "info")
	yatesMessage(_id, "Crucial functions and assistance provided by EngiN33R, U.S.G.N. ID 7749.", "info")
end
setSayHelp("credits")

function yates.func.say.lua()
	local script = _txt:sub(6)
	if script then
		yatesMessage(_id, tostring(assert(loadstring(script))() or "Command executed!"), "success")
	end
end
setSayHelp("lua", "<cmd>")
setSayDesc("lua", "Be very careful when using this command, there are no checks - it is simply executed!")

function yates.func.say.plugin()
	if not _tbl[2] then
        yatesMessage(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help plugin for a list of sub-commands.", "warning")
        return 1
    end

	if _tbl[2] == "list" then
		yatesMessage(_id, "List of plugins:", "info")
		for _, all in pairs(_PLUGIN["on"]) do
			yatesMessage(_id, all, "success", false)
		end
		for _, all in pairs(_PLUGIN["off"]) do
			yatesMessage(_id, all, "warning", false)
		end
	elseif _tbl[2] == "menu" then
		print("menu")
	elseif _tbl[2] == "enable" then
		if _tbl[3] then
			for k, v in pairs(_PLUGIN["off"]) do
				if v == _tbl[3] then
					os.rename(_DIR.."plugins/_"..v, _DIR.."plugins/"..v)
					yates.plugin[v] = {}
					yates.plugin[v]["dir"] = _DIR.."plugins/"..v.."/"
					dofileLua(yates.plugin[v]["dir"].."/startup.lua")
					_PLUGIN["on"][#_PLUGIN["on"]+1] = v
					_PLUGIN["off"][k] = nil
					yatesMessage(_id, "The plugin has been enabled!", "success")
					cachePluginData()
					checkForceReload()
					setUndo(_id, "!plugin disable ".._tbl[3])
					return 1
				end
			end
			for k, v in pairs(_PLUGIN["on"]) do
				if v == _tbl[3] then
					yatesMessage(_id, "This plugin is already running!", "warning")
					return 1
				end
			end
			yatesMessage(_id, "This plugin does not exist!", "warning")
		else
			yatesMessage(_id, "You have not provided a plugin name!", "warning")
		end
	elseif _tbl[2] == "disable" then
		if _tbl[3] then
			for k, v in pairs(_PLUGIN["on"]) do
				if v == _tbl[3] then
					os.rename(_DIR.."plugins/"..v, _DIR.."plugins/_"..v)
					_PLUGIN["off"][#_PLUGIN["off"]+1] = v
					_PLUGIN["on"][k] = nil
					yatesMessage(_id, "The plugin has been disabled!", "success")
					yatesMessage(_id, "Please reload the server Lua using "..yates.setting.say_prefix.."hardreload (preferred) or "..yates.setting.say_prefix.."softreload", "info")
					setUndo(_id, "!plugin enable ".._tbl[3])
					return 1
				end
			end
			for k, v in pairs(_PLUGIN["off"]) do
				if v == _tbl[3] then
					yatesMessage(_id, "This plugin is already disabled!", "warning")
					return 1
				end
			end
			yatesMessage(_id, "This plugin does not exist!", "warning")
		else
			yatesMessage(_id, "You have not provided a plugin name!", "warning")
		end
	elseif _tbl[2] == "info" then
		if _tbl[3] then
			if _PLUGIN["info"][_tbl[3]] then
				yatesMessage(_id, "Plugin information:", "info")
				if _PLUGIN["info"][_tbl[3]]["title"] then
					yatesMessage(_id, "Title: ".._PLUGIN["info"][_tbl[3]]["title"], false, false)
				else
					yatesMessage(_id, "No title has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["author"] then
					yatesMessage(_id, "Author: ".._PLUGIN["info"][_tbl[3]]["author"], false, false)
				else
					yatesMessage(_id, "No author has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["usgn"] then
					yatesMessage(_id, "U.S.G.N. ID: ".._PLUGIN["info"][_tbl[3]]["usgn"], false, false)
				else
					yatesMessage(_id, "No U.S.G.N. ID has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["version"] then
					yatesMessage(_id, "Version: ".._PLUGIN["info"][_tbl[3]]["version"], false, false)
				else
					yatesMessage(_id, "No version has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["description"] then
					yatesMessage(_id, "Description: ".._PLUGIN["info"][_tbl[3]]["description"], false, false)
				else
					yatesMessage(_id, "No description has been provided by the plugin or has not been cached!", false, false)
				end
			else
				yatesMessage(_id, "No information has been provided by the plugin or has not been cached!", "warning")
			end
		else
			yatesMessage(_id, "You have not provided a plugin name!", "warning")
		end
	end
end
setSayHelp("plugin", "list / menu / <info/enable/disable> <plugin>")
setSayDesc("plugin", "General command to show information about (a) plugin(s) or to enable/disable them.")

function yates.func.say.command()
	if not _tbl[2] then
        yatesMessage(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help command for a list of sub-commands.", "warning")
        return 1
    end

    if _tbl[2] == "list" then
		yatesMessage(_id, "List of disabled commands:", "info")
		for _, all in pairs(_YATES.disabled_commands) do
			yatesMessage(_id, all, "warning", false)
		end
	elseif _tbl[2] == "enable" then
		if _tbl[3] then
			for k, v in pairs(_YATES.disabled_commands) do
				if _tbl[3] == v then
					_YATES.disabled_commands[k] = nil
				end
			end
			yatesMessage(_id, "The command has been enabled.", "success")
			setUndo(_id, "!command disable ".._tbl[3])
			saveData(_YATES, "data_yates.lua")
		else
			yatesMessage(_id, "You have not provided a command!", "warning")
		end
	elseif _tbl[2] == "disable" then
		if _tbl[3] == "command" then
			yatesMessage(_id, "Funny you.. You cannot disable this command of course!", "warning")
			return
		end

		if _tbl[3] then
			table.insert(_YATES.disabled_commands, _tbl[3])
			yatesMessage(_id, "The command has been disabled.", "success")
			setUndo(_id, "!command enable ".._tbl[3])
			saveData(_YATES, "data_yates.lua")
		else
			yatesMessage(_id, "You have not provided a command!", "warning")
		end
	end
end
setSayHelp("plugin", "list / <enable/disable> <command>")
setSayDesc("plugin", "General command to show information about disabled commands or to enable/disable them.")

function yates.func.say.softreload()
	if not _tbl[2] then
		_tbl[2] = 0
	end
	timer(tonumber(_tbl[2]*1000), "parse", "lua softReload()")
	yatesMessage(_id, "The server lua has been reloaded.", "success")
	yatesMessage(_id, "When adding major changes to the script, please use "..yates.setting.say_prefix.."hardreload instead.", "info")
end
setSayHelp("softreload", "[<delay>] (in seconds)")
setSayDesc("softreload", "Reloads Y.A.T.E.S Lua scripts and plugins. Use hardreload if you are not sure everything will work.")

function yates.func.say.hardreload()
	if not _tbl[2] then
		_tbl[2] = 0
	end
	timer(tonumber(_tbl[2]*1000), "parse", "lua hardReload()")
	yatesMessage(false, "We are reloading our lua scripts! Please stay.", "success")
end
setSayHelp("hardreload", "[<delay>] (in seconds)")
setSayDesc("hardreload", "Reloads Y.A.T.E.S Lua scripts and plugins by changing the map. Preferred over softreload.")

--[[ Currently not in use
function yates.func.say.prefix()
	if yates.player[_id].prefix then
		yates.player[_id].prefix = false
		yatesMessage(_id, "Your tag is no longer visible.", "success")
	else
		yates.player[_id].prefix = true
		yatesMessage(_id, "Your tag is now visible.", "success")
	end
end
setSayHelp("prefix")
setSayDesc("prefix", "Toggles your prefix. Useful if you want to hide your identity to spot hackers and still chat.")
]]--

function yates.func.say.god()
	if yates.player[_id].god then
		yates.player[_id].god = false
		yatesMessage(_id, "You are no longer in God mode.", "success")
	else
		yates.player[_id].god = true
		yatesMessage(_id, "You are now in God mode.", "success")
	end
end
setSayHelp("god")
setSayDesc("god", "Turns on God mode. During this mode you cannot be dealt damage (you can still die).")

function yates.func.say.mute()
	local reason = ""

	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		yatesMessage(_id, "You did not define a time. The default of "..yates.setting.mute_time_default.." seconds will be used instead.", "info")
		_tbl[3] = yates.setting.mute_time_default
	else
		if tonumber(_tbl[3]) == nil then
			yatesMessage(_id, "You need to define a time, you gave something else instead.", "warning")
			return
		end

		if tonumber(_tbl[3]) > yates.setting.mute_time_max then
			yatesMessage(_id, "You cannot mute a player longer than "..yates.setting.mute_time_default.." seconds!", "warning")
			return
		end

		if tonumber(_tbl[3]) < 1 then
			yatesMessage(_id, "You cannot mute a player for less than 1 second!", "warning")
			return
		end
	end
	_tbl[3] = tonumber(_tbl[3])

	if _tbl[4] then
		for i = 4, #_tbl do
    		if reason == "" then
				reason = _tbl[i]
			else
				reason = reason.." ".._tbl[i]
			end
		end
	end
	if reason == "" then
		reason = "No reason defined."
	end

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to mute this player!", "warning")
		return 1
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been muted.", "success")
	yatesMessage(_tbl[2], "You have been muted for ".._tbl[3].." seconds. Reason: "..reason, "warning")
	yates.player[_tbl[2]].mute_time = _tbl[3]
	yates.player[_tbl[2]].mute_reason = reason
	setUndo(_id, "!unmute ".._tbl[2])

	if yates.setting.mute_save then
		if player(_tbl[2], "usgn") > 0 then
			if not _PLAYER[player(_tbl[2], "usgn")] then
				_PLAYER[player(_tbl[2], "usgn")] = {}
			end

			_PLAYER[player(_tbl[2], "usgn")].mute_time = _tbl[3]
			_PLAYER[player(_tbl[2], "usgn")].mute_reason = reason
			saveData(_PLAYER, "data_player.lua")
		end
	end
end
setSayHelp("mute", "<id> [<duration>] (default "..yates.setting.mute_time_default.." seconds) [<reason>]")
setSayDesc("mute", "Mutes the player. The player is then no longer allowed to talk.")

function yates.func.say.unmute()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if _PLAYER[player(_tbl[2], "usgn")] and _PLAYER[player(_tbl[2], "usgn")].mute_time then
		_PLAYER[player(_tbl[2], "usgn")].mute_time = nil
		if _PLAYER[player(_tbl[2], "usgn")].mute_reason then
			_PLAYER[player(_tbl[2], "usgn")].mute_reason = nil
		end
		saveData(_PLAYER, "data_player.lua")
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been unmuted.", "success")
	yatesMessage(_tbl[2], "You have been unmuted.", "info")
	setUndo(_id, "!mute ".._tbl[2].." "..yates.player[_tbl[2]].mute_time.." "..yates.player[_tbl[2]].mute_reason)
	yates.player[_tbl[2]].mute_time = 0
	yates.player[_tbl[2]].mute_reason = ""
end
setSayHelp("unmute", "<id>")
setSayDesc("unmute", "Unmutes the player.")

function yates.func.say.kick()
	local reason = ""

	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if _tbl[3] then
		for i = 3, #_tbl do
    		if reason == "" then
				reason = _tbl[i]
			else
				reason = reason.." ".._tbl[i]
			end
		end
	end

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to kick this player!", "warning")
		return 1
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been kicked.", "success")
	parse("kick ".._tbl[2].." \""..reason.."\"")
end
setSayHelp("kick", "<id> [<reason>]")

function yates.func.say.ban()
	local reason = ""

	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		_tbl[3] = 0
	end

	if _tbl[4] then
		for i = 4, #_tbl do
    		if reason == "" then
				reason = _tbl[i]
			else
				reason = reason.." ".._tbl[i]
			end
		end
	end

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to ban this player!", "warning")
		return 1
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been banned.", "success")
	parse("banip "..player(_tbl[2], "ip").." ".._tbl[3].." \""..reason.."\"")
	if checkUsgn(_tbl[2], false) then
		parse("banusgn "..player(_tbl[2], "usgn").." ".._tbl[3].." \""..reason.."\"")
	end
end
setSayHelp("ban", "<id> [<duration>] (0 for infinite, -1 for server setting) [<reason>]")

function yates.func.say.banusgn()
	local reason = ""

	if not _tbl[2] or tonumber(_tbl[2]) == nil then
		yatesMessage(_id, "You have not provided a U.S.G.N. ID!", "warning")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
	end

	if _tbl[4] then
		for i = 4, #_tbl do
    		if reason == "" then
				reason = _tbl[i]
			else
				reason = reason.." ".._tbl[i]
			end
		end
	end

	yatesMessage(_id, "The U.S.G.N. ID ".._tbl[2].." has been banned.", "success")
	parse("banusgn ".._tbl[2].." ".._tbl[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._tbl[2])
end
setSayHelp("banusgn", "<U.S.G.N.> [<duration>] (0 for infinite, -1 for server setting) [<reason>]")

function yates.func.say.banip()
	local reason = ""

	if not _tbl[2] then
		yatesMessage(_id, "You have not provided an IP!", "warning")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
	end

	if _tbl[4] then
		for i = 4, #_tbl do
    		if reason == "" then
				reason = _tbl[i]
			else
				reason = reason.." ".._tbl[i]
			end
		end
	end

	yatesMessage(_id, "The IP ".._tbl[2].." has been banned.", "success")
	parse("banip ".._tbl[2].." ".._tbl[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._tbl[2])
end
setSayHelp("banip", "<ip> [<duration>] (0 for infinite, -1 for server setting) [<reason>]")

function yates.func.say.unban()
	if not _tbl[2] then
		yatesMessage(_id, "You have not provided a U.S.G.N. ID or IP!", "warning")
		return 1
	end

	yatesMessage(_id, "The U.S.G.N. ID/IP ".._tbl[2].." has been unbanned.", "success")
	parse("unban ".._tbl[2])
end
setSayHelp("unban", "<U.S.G.N./ip>")

function yates.func.say.unbanall()
	yatesMessage(_id, "All of the bans have been removed!", "success")
	parse("unbanall")
end
setSayHelp("unbanall")
setSayDesc("unbanall", "Removes all the bans from the ban list (EVERYTHING WILL BE LOST).")

function yates.func.say.map()
	if not _tbl[2] then
		yatesMessage(_id, "You have not provided a map name!", "warning")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
	end
	timer(tonumber(_tbl[3]*1000), "parse", "map ".._tbl[2])
	yatesMessage(false, "We are changing the map! Please stay.", "success")
end
setSayHelp("map", "<map> [<delay>] (in seconds)")
setSayDesc("map", "Changes the map of the server.")

function yates.func.say.spawn() -- @TODO: Loop through all spawn entities and spawn if x & y are not given
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to spawn this player!", "warning")
		return 1
	end

	if player(_tbl[2], "team") == 0 then
		yatesMessage(_id, "This player is on the spectators team, you cannot spawn him!", "warning")
		return 1
	end

	if player(_tbl[2], "health") > 0 then
		yatesMessage(_id, "This player is already alive!", "warning")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
		_tbl[4] = 0
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been spawned.", "success")
	parse("spawnplayer ".._tbl[2].." ".._tbl[3].." ".._tbl[4])
end
setSayHelp("spawn", "<id> [<tilex>] [<tiley>]")
setSayDesc("spawn", "Spawns the player, if no x and y are provided the player will be spawn at a random spawn entity.")

function yates.func.say.kill()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to kill this player!", "warning")
		return 1
	end

	if player(_id, "health") == 0 then
		yatesMessage(_id, "You can not kill a dead player!", "warning")
		return 1
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been killed.", "success")
	parse("killplayer ".._tbl[2])
end
setSayHelp("kill", "<id>")
setSayDesc("kill", "Kills the target player.")

function yates.func.say.slap()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		yatesMessage(_id, "You do not have permission to slap this player!", "warning")
		return 1
	end

	yatesMessage(_id, player(_tbl[2], "name").." has been slapped.", "success")
	yatesMessage(_tbl[2], "You have been slapped.", "warning")
	parse("slap ".._tbl[2])
end
setSayHelp("slap", "<id>")
setSayDesc("slap", "Slaps the target player.")

function yates.func.say.equip()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		yatesMessage(_id, "You have not provided a weapon id!", "warning")
		return 1
	end

	parse("equip ".._tbl[2].." ".._tbl[3])
	setUndo(_id, "!strip ".._tbl[2].." ".._tbl[3])
end
setSayHelp("equip", "<id> <weapon id>")

function yates.func.say.strip()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		yatesMessage(_id, "You have not provided a weapon id!", "warning")
		return 1
	end

	parse("strip ".._tbl[2].." ".._tbl[3])
	setUndo(_id, "!equip ".._tbl[2].." ".._tbl[3])
end
setSayHelp("strip", "<id> <weapon id>")

function yates.func.say.goto()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	yates.player[_id].tp[1] = player(_id, "x")
	yates.player[_id].tp[2] = player(_id, "y")
	parse("setpos ".._id.." "..player(_tbl[2], "x").." "..player(_tbl[2], "y"))
end
setSayHelp("goto", "<id>")
setSayDesc("goto", "Teleports you to a player.")

function yates.func.say.goback()
	if not yates.player[_id].tp[1] then
		yatesMessage(_id, "You do not have an original location!", "warning")
		return 1
	end

	parse("setpos ".._id.." "..yates.player[_id].tp[1].." "..yates.player[_id].tp[2])
end
setSayHelp("goback")
setSayDesc("goback", "Teleports you back to your original location before teleportation.")

function yates.func.say.bring()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	yates.player[_tbl[2]].tp[1] = player(_tbl[2], "x")
	yates.player[_tbl[2]].tp[2] = player(_tbl[2], "y")
	parse("setpos ".._tbl[2].." "..player(_id, "x").." "..player(_id, "y"))
end
setSayHelp("bring", "<id>")
setSayDesc("bring", "Teleports a player to you.")

function yates.func.say.bringback()
	if not _tbl[2] then
		yatesMessage(_id, "You have not provided a player id!", "warning")
		return 1
	end

	if not player(_tbl[2], "exists") then
		yatesMessage(_id, "This player does not exist!", "warning")
		return 1
	end

	_tbl[2] = tonumber(_tbl[2])

	if not yates.player[_tbl[2]].tp[1] then
		yatesMessage(_id, "This player does not have an original location!", "warning")
		return 1
	end

	parse("setpos ".._tbl[2].." "..yates.player[_tbl[2]].tp[1].." "..yates.player[_tbl[2]].tp[2])
end
setSayHelp("bringback", "<id>")
setSayDesc("bringback", "Teleports a player to his original location before teleportation.")

function yates.func.say.make()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if _tbl[3] == "0" or _tbl[3] == "spec" then
		_tbl[3] = "spec"
	elseif _tbl[3] == "1" or _tbl[3] == "t" then
		_tbl[3] = "t"
	elseif _tbl[3] == "2" or _tbl[3] == "ct" then
		_tbl[3] = "ct"
	else
		yatesMessage(_id, "This team does not exist!", "warning")
		yatesMessage(_id, "Please use spec (or 0), t (or 1) or ct (or 2) to set a player's team.", "info")
		return 1
	end

	parse("make".._tbl[3].." ".._tbl[2])
end
setSayHelp("make", "<id> <team> (id or abbreviation)")
setSayDesc("make", "Sets a player to the given team.")

function yates.func.say.playerinfo()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	yatesMessage(_id, "Player data information.", "info")
	yatesMessage(_id, _tbl[2], "info", "(ID): ")
	yatesMessage(_id, player(_tbl[2], "name"), "info", "(Name): ")
	if player(_tbl[2], "rcon") then
        yatesMessage(_id, "Logged in.", "info", "(RCon): ")
    else
        yatesMessage(_id, "Not logged in.", "info", "(RCon): ")
    end
    yatesMessage(_id, player(_tbl[2], "ip"), "info", "(IP): ")
    yatesMessage(_id, player(_tbl[2], "usgn"), "info", "(U.S.G.N.): ")
    yatesMessage(_id, player(_tbl[2], "idle").." seconds.", "info", "(Idle): ")
end
setSayHelp("playerinfo", "<id>")
setSayDesc("playerinfo", "Displays player information.")

function yates.func.say.playerprefix()
	if not checkUsgn(_tbl[2]) then
		return 1
	end

	local id = _tbl[2]

	_tbl[5] = _tbl[3]
	_tbl[4] = "prefix"
	_tbl[3] = player(_tbl[2], "usgn")
	_tbl[2] = "edit"

	if not _PLAYER[_tbl[3]] then
		_PLAYER[_tbl[3]] = {}
		undo = "!playerprefix "..id.." /nil"
	end

	if _PLAYER[_tbl[3]].prefix then
		undo = "!playerprefix "..id.." ".._PLAYER[_tbl[3]].prefix
	else
		undo = "!playerprefix "..id.." /nil"
	end

	if yates.func.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playerprefix", "<id> <prefix>")
setSayDesc("playerprefix", "Sets a player's say prefix.")

function yates.func.say.playercolour()
	if not checkUsgn(_tbl[2]) then
		return 1
	end

	local id = _tbl[2]

	_tbl[5] = _tbl[3]
	_tbl[4] = "colour"
	_tbl[3] = player(_tbl[2], "usgn")
	_tbl[2] = "edit"
	
	if not _PLAYER[_tbl[3]] then
		_PLAYER[_tbl[3]] = {}
		undo = "!playercolour "..id.." /nil"
	end

	if _PLAYER[_tbl[3]].colour then
		undo = "!playercolour "..id.." ".._PLAYER[_tbl[3]].colour
	else
		undo = "!playercolour "..id.." /nil"
	end

	print(undo)

	if yates.func.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playercolour", "<id> <colour>")
setSayDesc("playercolour", "Sets a player's say colour.")

function yates.func.say.playerlevel()
	if not checkUsgn(_tbl[2]) then
		return 1
	end

	local id = _tbl[2]
	
	_tbl[5] = _tbl[3]
	_tbl[4] = "level"
	_tbl[3] = player(_tbl[2], "usgn")
	_tbl[2] = "edit"
	
	if not _PLAYER[_tbl[3]] then
		_PLAYER[_tbl[3]] = {}
		undo = "!playerlevel "..id.." /nil"
	end

	if _PLAYER[_tbl[3]].level then
		undo = "!playerlevel "..id.." ".._PLAYER[_tbl[3]].level
	else
		undo = "!playerlevel "..id.." /nil"
	end

	if yates.func.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playerlevel", "<id> <level>")
setSayDesc("playerlevel", "Sets a player's level.")

function yates.func.say.playergroup()
	if not checkUsgn(_tbl[2]) then
		return 1
	end

	local id = _tbl[2]
	
	_tbl[5] = _tbl[3]
	_tbl[4] = "group"
	_tbl[3] = player(_tbl[2], "usgn")
	_tbl[2] = "edit"
	
	if not _PLAYER[_tbl[3]] then
		_PLAYER[_tbl[3]] = {}
		undo = "!playergroup "..id.." /nil"
	end

	if _PLAYER[_tbl[3]].group then
		undo = "!playergroup "..id.." ".._PLAYER[_tbl[3]].group
	else
		undo = "!playergroup "..id.." /nil"
	end

	if yates.func.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playergroup", "<id> <group>")
setSayDesc("playergroup", "Sets a player's group.")

function yates.func.say.player()
	if not _tbl[2] then
        yatesMessage(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help player for a list of sub-commands.", "warning")
        return 1
    end

	if _tbl[2] == "list" then
        yatesMessage(_id, "List of U.S.G.N.'s saved in data_player. Use !player info <U.S.G.N.> for more info.", "info")
        for k, v in pairs(_PLAYER) do
            yatesMessage(_id, k, false, false)
        end
    elseif _tbl[2] == "info" then

    	if not _tbl[3] then
	        yatesMessage(_id, "You need to supply a player (U.S.G.N.) ID you wish to view the information of!", "warning")
	        return 1
	    end
	    _tbl[3] = tonumber(_tbl[3])

		if _PLAYER[_tbl[3]] then
			if _tbl[4] then
				yatesMessage(_id, "Developer player information.", "info")
				local info = table.val_to_str(_PLAYER[_tbl[3]])
				info = info:gsub("©","")
				info = info:gsub("\169","")

				yatesMessage(_id, "_PLAYER[\"".._tbl[3].."\"] = "..info, "default", false)
			else
				yatesMessage(_id,"Player data information.","info")
				for k, v in pairs(_PLAYER[_tbl[3]]) do
					if type(v) ~= "table" then
						v = tostring(v)
						v = v:gsub("©","")
						v = v:gsub("\169","")
					end
					yatesMessage(_id, k.." = "..table.val_to_str(v), "default", false)
				end
			end
			return 1
		end
		yatesMessage(_id, "This player data does not exist!", "warning")
		return 1

	elseif _tbl[2] == "edit" then
    	if not _tbl[3] then
            yatesMessage(_id, "You need to supply a U.S.G.N. ID for the player data you want to edit.", "warning")
            return 1
        end
        _tbl[3] = tonumber(_tbl[3])

    	if not _PLAYER[_tbl[3]] then
    		_PLAYER[_tbl[3]] = {}
		end

        if _PLAYER[_tbl[3]] then
			if not _tbl[4] then
	            yatesMessage(_id, "You need to supply the field you want to edit.", "warning")
	            return 1
	        end

	        if not _tbl[5] then
	            yatesMessage(_id, "You need to supply a new variable for the field.", "warning")
	            return 1
	        end

        	editPlayer(_tbl[3], _tbl[4])
    		yatesMessage(_id, "The player ".._tbl[3].." has been edited!", "success")
        	return 1
        end
        yatesMessage(_id, "This player data does not exist!", "warning")
    end
end
setSayHelp("player", "list / info <id> / edit <U.S.G.N.> <field> <new entry>")
setSayDesc("player", "A general command used to display information about players and edit their data.")

function yates.func.say.groupprefix()
	local undo = false

	_tbl[5] = _tbl[3]
	_tbl[4] = "prefix"
	_tbl[3] = _tbl[2]
	_tbl[2] = "edit"

	if checkGroup(_tbl[3], false) then
		if _GROUP[_tbl[3]].prefix then
			undo = "!groupprefix ".._tbl[3].." ".._GROUP[_tbl[3]].prefix
		else
			undo = "!groupprefix ".._tbl[3].." /nil"
		end
	end

	if yates.func.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("groupprefix", "<group> <prefix>")
setSayDesc("groupprefix", "Sets a group's say prefix.")

function yates.func.say.groupcolour()
	local undo = false

	_tbl[5] = _tbl[3]
	_tbl[4] = "colour"
	_tbl[3] = _tbl[2]
	_tbl[2] = "edit"

	if checkGroup(_tbl[3], false) then
		if _GROUP[_tbl[3]].colour then
			undo = "!groupcolour ".._tbl[3].." ".._GROUP[_tbl[3]].colour
		else
			undo = "!groupcolour ".._tbl[3].." /nil"
		end
	end

	if yates.func.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("groupcolour", "<group> <colour>")
setSayDesc("groupcolour", "Sets a group's say colour.")

function yates.func.say.grouplevel()
	local undo = false

	_tbl[5] = _tbl[3]
	_tbl[4] = "level"
	_tbl[3] = _tbl[2]
	_tbl[2] = "edit"

	if checkGroup(_tbl[3], false) then
		if _GROUP[_tbl[3]].level then
			undo = "!grouplevel ".._tbl[3].." ".._GROUP[_tbl[3]].level
		else
			undo = "!grouplevel ".._tbl[3].." /nil"
		end
	end

	if yates.func.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("grouplevel", "<group> <level>")
setSayDesc("grouplevel", "Sets a group's level.")

function yates.func.say.group()
    if not _tbl[2] then
        yatesMessage(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help group for a list of sub-commands.", "warning")
        return 1
    end

    if _tbl[2] == "list" then
        yatesMessage(_id, "List of current groups, with their colour, prefix, name and level.", "info")
        for k, v in pairs(_GROUP) do
            yatesMessage(_id, k.." ".._GROUP[k].level.." "..(_GROUP[k].prefix or ""), _GROUP[k].colour, false)
        end
    elseif _tbl[2] == "info" then
    	if not _tbl[3] then
            yatesMessage(_id, "You need to supply a group name you wish to view the information of!", "warning")
            return 1
        end

		if _GROUP[_tbl[3]] then
			if _tbl[4] then
				yatesMessage(_id, "Developer group information.", "info")
				local info = table.val_to_str(_GROUP[_tbl[3]])
				info = info:gsub("©", "")
				info = info:gsub("\169", "")

				yatesMessage(_id, "_GROUP[\"".._tbl[3].."\"] = "..info, "default", false)
				return 1
			end

			yatesMessage(_id, "List of group fields and their values.", "info")
			for k, v in pairs(_GROUP[_tbl[3]]) do
				if type(v) ~= "table" then
					v = tostring(v)
					v = v:gsub("©", "")
					v = v:gsub("\169", "")
				end
				yatesMessage(_id, k.." = "..table.val_to_str(v), "default", false)
			end
			return 1
		end
		yatesMessage(_id, "This group does not exist!", "warning")
    elseif _tbl[2] == "add" then
        if not _tbl[3] then
            yatesMessage(_id, "You need to supply a name for the group!", "warning")
            return 1
        end

        if not _GROUP[_tbl[3]] then
			local cmds = ""

            if not _tbl[4] then
                _tbl[4] = (yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)
                yatesMessage(_id, "You did not enter a group level, the default level will be used instead: "..(yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)..".", "alert")
            end
            if not _tbl[5] then
                _tbl[5] = (yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour)
                yatesMessage(_id, "You did not enter a group colour, the default color will be used instead: "..(yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour).."Lorem Ipsum.", "alert")
            else
            	_tbl[5] = "\169".._tbl[5]
        	end
            if not _tbl[6] then
                _tbl[6] = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                yatesMessage(_id, "You did not enter any group commands, the following default commands will be used instead:", "alert")
                local tbl = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                for i = 1, #tbl do
            		if cmds == "" then
						cmds = tbl[i]
					else
						cmds = cmds..", "..tbl[i]
					end
				end
				yatesMessage(_id, cmds, "default", false)
            else
            	for i = 6, #_tbl do
            		if cmds == "" then
						cmds = _tbl[i]
					else
						cmds = cmds..", ".._tbl[i]
					end
				end
			end
			setUndo(_id, "!group del ".._tbl[3])
            addGroup(_tbl[3], _tbl[4], _tbl[5], cmds)
            yatesMessage(_id, "The group ".._tbl[3].." has been added!", "success")
            return 1
        end
        yatesMessage(_id, "This group already exists!", "warning")
    elseif _tbl[2] == "del" or _tbl[2] == "delete" then
    	if not _tbl[3] then
            yatesMessage(_id, "You need to supply the group name you want to delete.", "warning")
            return 1
        end

		if _GROUP[_tbl[3]] then
			if not _tbl[4] then
	            yatesMessage(_id, "You did not enter a new group, the default group will be used instead: "..yates.setting.group_default..".", "alert")
	            _tbl[4] = yates.setting.group_default
	        end

	        if not _GROUP[_tbl[4]] then
	        	yatesMessage(_id, "The new group for the players in the old group does not exist!", "warning")
	        	return 1
        	end

        	deleteGroup(_tbl[3], _tbl[4])
    		yatesMessage(_id, "The group ".._tbl[3].." has been deleted!", "success")
			return 1
		end
		yatesMessage(_id, "This group does not exist!", "warning")
    elseif _tbl[2] == "edit" then
    	if not _tbl[3] then
            yatesMessage(_id, "You need to supply a name for the group you are going to edit.", "warning")
            return 1
        end

        if _GROUP[_tbl[3]] then
			if not _tbl[4] then
	            yatesMessage(_id, "You need to supply the field you want to edit.", "warning")
	            return 1
	        end

	        if not _tbl[5] then
	            yatesMessage(_id, "You need to supply a new variable for the field.", "warning")
	            return 1
	        end

        	editGroup(_tbl[3], _tbl[4])
    		yatesMessage(_id, "The group ".._tbl[3].." has been edited!", "success")
        	return 1
        end
        yatesMessage(_id, "This group does not exist!", "warning")
    end
end
setSayHelp("group", "list / info <group> / add <group> [<level>] [<colour>] [<commands>] / del(ete) <group> [<new group>] / edit <group> <field> <new entry>")
setSayDesc("group", "A general command used to display information about groups and edit them.")

function yates.func.say.undo()
	if not _PLAYER[player(_id, "usgn")] or not _PLAYER[player(_id, "usgn")].undo then
		yatesMessage(_id, "You have not executed any command to undo!", "warning")
		return 1
	end

	yatesMessage(_id, "Executing the following command: ".._PLAYER[player(_id, "usgn")].undo, "info")
	yates.hook.say(_id, _PLAYER[player(_id, "usgn")].undo)
end
setSayHelp("undo")
setSayDesc("undo", "Certain commands have an undo option, this command will undo the most recent undoable command.")
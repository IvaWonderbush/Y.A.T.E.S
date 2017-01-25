-- yates_sayCommands.lua --

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

function yates.func.say.help()
	local usgn = player(_id, "usgn") or 0
	local everything = false

	if _tbl[2] then
		if yates.say.help[_tbl[2]] then
			msg2(_id, lang("help", 4), "info")
			msg2(_id, yates.setting.say_prefix..yates.say.help[_tbl[2]], "default", false)
			if yates.say.desc[_tbl[2]] then
				msg2(_id, yates.say.desc[_tbl[2]], "default", false)
			end
			msg2(_id, "", false, false)
			msg2(_id, lang("help", 5), "info")
			msg2(_id, lang("help", 6), "info")
		else
			msg2(_id, lang("help", 7), "notice")
		end
	else
		if _PLAYER[usgn] and _PLAYER[usgn].commands then
			for k, v in spairs(_PLAYER[usgn].commands) do
				if v == "all" then
					everything = true
					break
				end
				msg2(_id, yates.setting.say_prefix..v, "default", false)
			end
		end
		if everything ~= true then
			for k, v in spairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates.setting.group_default)].commands) do
				if v == "all" then
					everything = true
					break
				end
				msg2(_id, yates.setting.say_prefix..v, "default", false)
			end
		end
		if everything == true then
			for k, v in spairs(yates.func.say) do
				if #k > 0 then
					msg2(_id, yates.setting.say_prefix..k, "default", false)
				end
			end
		end
		msg2(_id, lang("help", 8, yates.setting.say_prefix), "info")
		msg2(_id, lang("help", 9), "info")
	end
end
setSayHelp("help", lang("help", 1))
setSayDesc("help", lang("help", 2))

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

	msg2(_id, "[->] [".._tbl[2].."] "..player(_tbl[2], "name")..": "..message, "info", "[PM]: ")
	msg2(_tbl[2], "[<-] [".._id.."] "..player(_id, "name")..": "..message, "info", "[PM]: ")
end
setSayHelp("pm", lang("pm", 1))
setSayDesc("pm", lang("pm", 2))

function yates.func.say.credits()
	msg2(_id, lang("credits", 1, "Yates", 21431), "info")
	msg2(_id, lang("credits", 2, "EngiN33R", 7749), "info")
end

function yates.func.say.ls()
	local script = _txt:sub(4)
	if script then
		msg2(_id, tostring(assert(loadstring(script))() or lang("ls", 3)), "success")
	end
end
setSayHelp("ls", lang("ls", 1))
setSayDesc("ls", lang("ls", 2))

function yates.func.say.plugin()
	if not _tbl[2] then
        msg2(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help plugin for a list of sub-commands.", "error")
        return 1
    end

	if _tbl[2] == "list" then
		msg2(_id, "List of plugins:", "info")
		for _, all in pairs(_PLUGIN["on"]) do
			msg2(_id, all, "success", false)
		end
		for _, all in pairs(_PLUGIN["off"]) do
			msg2(_id, all, "error", false)
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
					dofile(yates.plugin[v]["dir"].."/startup.lua")
					_PLUGIN["on"][#_PLUGIN["on"]+1] = v
					_PLUGIN["off"][k] = nil
					msg2(_id, "The plugin has been enabled!", "success")
					yates.func.cachePluginData()
					yates.func.checkForceReload()
					setUndo(_id, "!plugin disable ".._tbl[3])
					return 1
				end
			end
			for k, v in pairs(_PLUGIN["on"]) do
				if v == _tbl[3] then
					msg2(_id, "This plugin is already running!", "error")
					return 1
				end
			end
			msg2(_id, "This plugin does not exist!", "error")
		else
			msg2(_id, "You have not provided a plugin name!", "error")
		end
	elseif _tbl[2] == "disable" then
		if _tbl[3] then
			for k, v in pairs(_PLUGIN["on"]) do
				if v == _tbl[3] then
					os.rename(_DIR.."plugins/"..v, _DIR.."plugins/_"..v)
					_PLUGIN["off"][#_PLUGIN["off"]+1] = v
					_PLUGIN["on"][k] = nil
					msg2(_id, "The plugin has been disabled!", "success")
					msg2(_id, "Please reload the server Lua using "..yates.setting.say_prefix.."hardreload (preferred) or "..yates.setting.say_prefix.."softreload", "info")
					setUndo(_id, "!plugin enable ".._tbl[3])
					return 1
				end
			end
			for k, v in pairs(_PLUGIN["off"]) do
				if v == _tbl[3] then
					msg2(_id, "This plugin is already disabled!", "error")
					return 1
				end
			end
			msg2(_id, "This plugin does not exist!", "error")
		else
			msg2(_id, "You have not provided a plugin name!", "error")
		end
	elseif _tbl[2] == "info" then
		if _tbl[3] then
			if _PLUGIN["info"][_tbl[3]] then
				msg2(_id, "Plugin information:", "info")
				if _PLUGIN["info"][_tbl[3]]["title"] then
					msg2(_id, "Title: ".._PLUGIN["info"][_tbl[3]]["title"], false, false)
				else
					msg2(_id, "No title has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["author"] then
					msg2(_id, "Author: ".._PLUGIN["info"][_tbl[3]]["author"], false, false)
				else
					msg2(_id, "No author has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["usgn"] then
					msg2(_id, "U.S.G.N. ID: ".._PLUGIN["info"][_tbl[3]]["usgn"], false, false)
				else
					msg2(_id, "No U.S.G.N. ID has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["version"] then
					msg2(_id, "Version: ".._PLUGIN["info"][_tbl[3]]["version"], false, false)
				else
					msg2(_id, "No version has been provided by the plugin or has not been cached!", false, false)
				end
				if _PLUGIN["info"][_tbl[3]]["description"] then
					msg2(_id, "Description: ".._PLUGIN["info"][_tbl[3]]["description"], false, false)
				else
					msg2(_id, "No description has been provided by the plugin or has not been cached!", false, false)
				end
			else
				msg2(_id, "No information has been provided by the plugin or has not been cached!", "error")
			end
		else
			msg2(_id, "You have not provided a plugin name!", "error")
		end
	end
end
setSayHelp("plugin", lang("plugin", 1))
setSayDesc("plugin", lang("plugin", 2))

function yates.func.say.command()
	if not _tbl[2] then
        msg2(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help command for a list of sub-commands.", "error")
        return 1
    end

    if _tbl[2] == "list" then
		msg2(_id, "List of disabled commands:", "info")
		for _, all in pairs(_YATES.disabled_commands) do
			msg2(_id, all, "error", false)
		end
	elseif _tbl[2] == "enable" then
		if _tbl[3] then
			for k, v in pairs(_YATES.disabled_commands) do
				if _tbl[3] == v then
					_YATES.disabled_commands[k] = nil
				end
			end
			msg2(_id, "The command has been enabled.", "success")
			setUndo(_id, "!command disable ".._tbl[3])
			saveData(_YATES, "data_yates.lua")
		else
			msg2(_id, "You have not provided a command!", "error")
		end
	elseif _tbl[2] == "disable" then
		if _tbl[3] == "command" then
			msg2(_id, "Funny you.. You cannot disable this command of course!", "error")
			return
		end

		if _tbl[3] then
			table.insert(_YATES.disabled_commands, _tbl[3])
			msg2(_id, "The command has been disabled.", "success")
			setUndo(_id, "!command enable ".._tbl[3])
			saveData(_YATES, "data_yates.lua")
		else
			msg2(_id, "You have not provided a command!", "error")
		end
	end
end
setSayHelp("command", lang("command", 1))
setSayDesc("command", lang("command", 2))

function yates.func.say.hardreload()
	if not _tbl[2] then
		_tbl[2] = 0
	end
	timer(tonumber(_tbl[2]*1000), "parse", "lua hardReload()")
	msg(lang("hardreload", 3), "success")
end
setSayHelp("hardreload", lang("hardreload", 1))
setSayDesc("hardreload", lang("hardreload", 2))


function yates.func.say.hide()
	yates.func.toggleHide(_id)
end
setSayHelp("hide")
setSayDesc("hide", lang("hide", 1))

function yates.func.say.god()
	yates.func.toggleGod(_id)
end
setSayHelp("god")
setSayDesc("god", lang("god", 1))

function yates.func.say.mute()
	local reason = ""

	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		msg2(_id, lang("mute", 3, yates.setting.mute_time_default), "info")
		_tbl[3] = yates.setting.mute_time_default
	else
		if tonumber(_tbl[3]) > yates.setting.mute_time_max then
			msg2(_id, lang("mute", 4, yates.setting.mute_time_max), "error")
			return
		end

		if tonumber(_tbl[3]) < 1 then
			msg2(_id, lang("mute", 5), "error")
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
		reason = lang("mute", 9)
	end

	if not compareLevel(_id, _tbl[2]) then
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	msg2(_id, lang("mute", 6, player(_tbl[2], "name")), "success")
	msg2(_tbl[2], lang("mute", 7, yates.player[id].mute_time), "error")
	msg2(_tbl[2], lang("mute", 10, "Reason", yates.player[id].mute_reason), "info")
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
setSayHelp("mute", lang("mute", 1, yates.setting.mute_time_default))
setSayDesc("mute", lang("mute", 2))

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

	msg2(_id, lang("unmute", 3, player(_tbl[2], "name")), "success")
	msg2(_tbl[2], lang("unmute", 4), "info")
	setUndo(_id, "!mute ".._tbl[2].." "..yates.player[_tbl[2]].mute_time.." "..yates.player[_tbl[2]].mute_reason)
	yates.player[_tbl[2]].mute_time = 0
	yates.player[_tbl[2]].mute_reason = ""
end
setSayHelp("unmute", lang("unmute", 1))
setSayDesc("unmute", lang("unmute", 2))

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
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	msg2(_id, lang("kick", 3, player(_tbl[2], "name")), "success")
	parse("kick ".._tbl[2].." \""..reason.."\"")
end
setSayHelp("kick", lang("kick", 1))
setSayDesc("kick", lang("kick", 2))

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
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	msg2(_id, lang("ban", 3, player(_tbl[2], "name")), "success")
	parse("banip "..player(_tbl[2], "ip").." ".._tbl[3].." \""..reason.."\"")
	if checkUsgn(_tbl[2], false) then
		parse("banusgn "..player(_tbl[2], "usgn").." ".._tbl[3].." \""..reason.."\"")
	end
end
setSayHelp("ban", lang("ban", 1))
setSayDesc("ban", lang("ban", 2))

function yates.func.say.banusgn()
	local reason = ""

	if not _tbl[2] or tonumber(_tbl[2]) == nil then
		msg2(_id, lang("validation", 7), "error")
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

	msg2(_id, lang("banusgn", 3, _tbl[2]), "success")
	parse("banusgn ".._tbl[2].." ".._tbl[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._tbl[2])
end
setSayHelp("banusgn", lang("banusgn", 1))
setSayDesc("banusgn", lang("banusgn", 2))

function yates.func.say.banip()
	local reason = ""

	if not _tbl[2] then
		msg2(_id, lang("validation", 8), "error")
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

	msg2(_id, lang("banip", 3, _tbl[2]), "success")
	parse("banip ".._tbl[2].." ".._tbl[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._tbl[2])
end
setSayHelp("banip", lang("banip", 1))
setSayDesc("banip", lang("banip", 2))

function yates.func.say.unban()
	if not _tbl[2] then
		msg2(_id, lang("validation", 9), "error")
		return 1
	end

	msg2(_id, lang("unban", 3, _tbl[2]), "success")
	parse("unban ".._tbl[2])
end
setSayHelp("unban", lang("unban", 1))
setSayDesc("unban", lang("unban", 2))

function yates.func.say.unbanall()
	msg2(_id, lang("unbanall", 2), "success")
	parse("unbanall")
end
setSayHelp("unbanall")
setSayDesc("unbanall", lang("unbanall", 1))

function yates.func.say.map()
	if not _tbl[2] then
		msg2(_id, lang("validation", 10), "error")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
	end
	timer(tonumber(_tbl[3]*1000), "parse", "map ".._tbl[2])
	msg(lang("map", 3), "success")
end
setSayHelp("map", lang("map", 1))
setSayDesc("map", lang("map", 2))

function yates.func.say.spawn() -- @TODO: Loop through all spawn entities and spawn if x & y are not given
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	if player(_tbl[2], "team") == 0 then
		msg2(_id, lang("spawn", 3), "error")
		return 1
	end

	if player(_tbl[2], "health") > 0 then
		msg2(_id, lang("spawn", 4), "error")
		return 1
	end

	if not _tbl[3] then
		_tbl[3] = 0
		_tbl[4] = 0
	end

	msg2(_id, lang("spawn", 5, player(_tbl[2], "name")), "success")
	parse("spawnplayer ".._tbl[2].." ".._tbl[3].." ".._tbl[4])
end
setSayHelp("spawn", lang("spawn", 1))
setSayDesc("spawn", lang("spawn", 2))

function yates.func.say.kill()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	if player(_tbl[2], "health") == 0 then
		msg2(_id, lang("kill", 3), "error")
		return 1
	end

	msg2(_id, lang("kill", 4, player(_tbl[2], "name")), "success")
	parse("killplayer ".._tbl[2])
end
setSayHelp("kill", lang("kill", 1))
setSayDesc("kill", lang("kill", 2))

function yates.func.say.slap()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not compareLevel(_id, _tbl[2]) then
		msg2(_id, lang("validation", 2), "error")
		return 1
	end

	msg2(_tbl[2], lang("slap", 3), "error")
	msg2(_id, lang("slap", 4, player(_tbl[2], "name")), "success")
	parse("slap ".._tbl[2])
end
setSayHelp("slap", lang("slap", 1))
setSayDesc("slap", lang("slap", 2))

function yates.func.say.equip()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		msg2(_id, lang("validation", 11), "error")
		return 1
	end

	msg2(_tbl[2], lang("equip", 3, _tbl[3]), "info")
	msg2(_id, lang("equip", 4, player(_tbl[2], "name"), _tbl[3]), "success")

	parse("equip ".._tbl[2].." ".._tbl[3])
	setUndo(_id, "!strip ".._tbl[2].." ".._tbl[3])
end
setSayHelp("equip", lang("equip", 1))
setSayDesc("equip", lang("equip", 2))

function yates.func.say.strip()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	if not _tbl[3] then
		msg2(_id, lang("validation", 11), "error")
		return 1
	end

	msg2(_tbl[2], lang("strip", 3, _tbl[3]), "info")
	msg2(_id, lang("strip", 4, player(_tbl[2], "name"), _tbl[3]), "success")

	parse("strip ".._tbl[2].." ".._tbl[3])
	setUndo(_id, "!equip ".._tbl[2].." ".._tbl[3])
end
setSayHelp("strip", lang("strip", 1))
setSayDesc("strip", lang("strip", 2))

function yates.func.say.goto()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	yates.player[_id].tp[1] = player(_id, "x")
	yates.player[_id].tp[2] = player(_id, "y")
	parse("setpos ".._id.." "..player(_tbl[2], "x").." "..player(_tbl[2], "y"))
end
setSayHelp("goto", lang("goto", 1))
setSayDesc("goto", lang("goto", 2))

function yates.func.say.goback()
	if not yates.player[_id].tp[1] then
		msg2(_id, lang("goback", 2), "error")
		return 1
	end

	parse("setpos ".._id.." "..yates.player[_id].tp[1].." "..yates.player[_id].tp[2])
end
setSayHelp("goback")
setSayDesc("goback", lang("goback", 1))

function yates.func.say.bring()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	yates.player[_tbl[2]].tp[1] = player(_tbl[2], "x")
	yates.player[_tbl[2]].tp[2] = player(_tbl[2], "y")
	parse("setpos ".._tbl[2].." "..player(_id, "x").." "..player(_id, "y"))
end
setSayHelp("bring", lang("bring", 1))
setSayDesc("bring", lang("bring", 2))

function yates.func.say.bringback()
	if not _tbl[2] then
		msg2(_id, lang("validation", 12), "error")
		return 1
	end

	if not player(_tbl[2], "exists") then
		msg2(_id, lang("validation", 4), "error")
		return 1
	end

	_tbl[2] = tonumber(_tbl[2])

	if not yates.player[_tbl[2]].tp[1] then
		msg2(_id, lang("bringback", 3), "error")
		return 1
	end

	parse("setpos ".._tbl[2].." "..yates.player[_tbl[2]].tp[1].." "..yates.player[_tbl[2]].tp[2])
end
setSayHelp("bringback", lang("bringback", 1))
setSayDesc("bringback", lang("bringback", 2))

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
		msg2(_id, lang("make", 3), "error")
		msg2(_id, lang("make", 4), "info")
		return 1
	end

	parse("make".._tbl[3].." ".._tbl[2])
end
setSayHelp("make", lang("make", 1))
setSayDesc("make", lang("make", 2))

function yates.func.say.playerinfo()
	if not checkPlayer(_tbl[2]) then
		return 1
	end
	_tbl[2] = tonumber(_tbl[2])

	msg2(_id, "Player data information.", "info")
	msg2(_id, _tbl[2], "info", "(ID): ")
	msg2(_id, player(_tbl[2], "name"), "info", "(Name): ")
	if player(_tbl[2], "rcon") then
        msg2(_id, "Logged in.", "info", "(RCon): ")
    else
        msg2(_id, "Not logged in.", "info", "(RCon): ")
    end
    msg2(_id, player(_tbl[2], "ip"), "info", "(IP): ")
    msg2(_id, player(_tbl[2], "usgn"), "info", "(U.S.G.N.): ")
    msg2(_id, player(_tbl[2], "idle").." seconds.", "info", "(Idle): ")
end
setSayHelp("playerinfo", lang("playerinfo", 1))
setSayDesc("playerinfo", lang("playerinfo", 2))

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
setSayHelp("playerprefix", lang("playerprefix", 1))
setSayDesc("playerprefix", lang("playerprefix", 2))

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
setSayHelp("playercolour", lang("playercolour", 1))
setSayDesc("playercolour", lang("playercolour", 2))

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
setSayHelp("playerlevel", lang("playerlevel", 1))
setSayDesc("playerlevel", lang("playerlevel", 2))

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
setSayHelp("playergroup", lang("playergroup", 1))
setSayDesc("playergroup", lang("playergroup", 2))

function yates.func.say.player()
	if not _tbl[2] then
        msg2(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help player for a list of sub-commands.", "error")
        return 1
    end

	if _tbl[2] == "list" then
        msg2(_id, "List of U.S.G.N.'s saved in data_player. Use !player info <U.S.G.N.> for more info.", "info")
        for k, v in pairs(_PLAYER) do
            msg2(_id, k, false, false)
        end
    elseif _tbl[2] == "info" then

    	if not _tbl[3] then
	        msg2(_id, "You need to supply a player (U.S.G.N.) ID you wish to view the information of!", "error")
	        return 1
	    end
	    _tbl[3] = tonumber(_tbl[3])

		if _PLAYER[_tbl[3]] then
			if _tbl[4] then
				msg2(_id, "Developer player information.", "info")
				local info = table.valueToString(_PLAYER[_tbl[3]])
				info = info:gsub("©","")
				info = info:gsub("\169","")

				msg2(_id, "_PLAYER[\"".._tbl[3].."\"] = "..info, "default", false)
			else
				msg2(_id,"Player data information.","info")
				for k, v in pairs(_PLAYER[_tbl[3]]) do
					if type(v) ~= "table" then
						v = tostring(v)
						v = v:gsub("©","")
						v = v:gsub("\169","")
					end
					msg2(_id, k.." = "..table.valueToString(v), "default", false)
				end
			end
			return 1
		end
		msg2(_id, lang("validation", 4), "error")
		return 1

	elseif _tbl[2] == "edit" then
    	if not _tbl[3] then
            msg2(_id, "You need to supply a U.S.G.N. ID for the player data you want to edit.", "error")
            return 1
        end
        _tbl[3] = tonumber(_tbl[3])

    	if not _PLAYER[_tbl[3]] then
    		_PLAYER[_tbl[3]] = {}
		end

        if _PLAYER[_tbl[3]] then
			if not _tbl[4] then
	            msg2(_id, "You need to supply the field you want to edit.", "error")
	            return 1
	        end

	        if not _tbl[5] then
	            msg2(_id, "You need to supply a new variable for the field.", "error")
	            return 1
	        end

        	editPlayer(_tbl[3], _tbl[4])
    		msg2(_id, "The player ".._tbl[3].." has been edited!", "success")
        	return 1
        end
        msg2(_id, lang("validation", 4), "error")
    end
end
setSayHelp("player", lang("player", 1))
setSayDesc("player", lang("player", 2))

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
setSayHelp("groupprefix", lang("groupprefix", 1))
setSayDesc("groupprefix", lang("groupprefix", 2))

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
setSayHelp("groupcolour", lang("groupcolour", 1))
setSayDesc("groupcolour", lang("groupcolour", 2))

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
setSayHelp("grouplevel", lang("grouplevel", 1))
setSayDesc("grouplevel", lang("grouplevel", 2))

function yates.func.say.group()
    if not _tbl[2] then
        msg2(_id, "You have not provided a sub-command, say "..yates.setting.say_prefix.."help group for a list of sub-commands.", "error")
        return 1
    end

    if _tbl[2] == "list" then
        msg2(_id, "List of current groups, with their colour, prefix, name and level.", "info")
        for k, v in pairs(_GROUP) do
            msg2(_id, k.." ".._GROUP[k].level.." "..(_GROUP[k].prefix or ""), _GROUP[k].colour, false)
        end
    elseif _tbl[2] == "info" then
    	if not _tbl[3] then
            msg2(_id, "You need to supply a group name you wish to view the information of!", "error")
            return 1
        end

		if _GROUP[_tbl[3]] then
			if _tbl[4] then
				msg2(_id, "Developer group information.", "info")
				local info = table.valueToString(_GROUP[_tbl[3]])
				info = info:gsub("©", "")
				info = info:gsub("\169", "")

				msg2(_id, "_GROUP[\"".._tbl[3].."\"] = "..info, "default", false)
				return 1
			end

			msg2(_id, "List of group fields and their values.", "info")
			for k, v in pairs(_GROUP[_tbl[3]]) do
				if type(v) ~= "table" then
					v = tostring(v)
					v = v:gsub("©", "")
					v = v:gsub("\169", "")
				end
				msg2(_id, k.." = "..table.valueToString(v), "default", false)
			end
			return 1
		end
		msg2(_id, lang("validation", 5), "error")
    elseif _tbl[2] == "add" then
        if not _tbl[3] then
            msg2(_id, "You need to supply a name for the group!", "error")
            return 1
        end

        if not _GROUP[_tbl[3]] then
			local cmds = ""

            if not _tbl[4] then
                _tbl[4] = (yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)
                msg2(_id, "You did not enter a group level, the default level will be used instead: "..(yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)..".", "notice")
            end
            if not _tbl[5] then
                _tbl[5] = (yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour)
                msg2(_id, "You did not enter a group colour, the default color will be used instead: "..(yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour).."Lorem Ipsum.", "notice")
            else
            	_tbl[5] = "\169".._tbl[5]
        	end
            if not _tbl[6] then
                _tbl[6] = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                msg2(_id, "You did not enter any group commands, the following default commands will be used instead:", "notice")
                local tbl = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                for i = 1, #tbl do
            		if cmds == "" then
						cmds = tbl[i]
					else
						cmds = cmds..", "..tbl[i]
					end
				end
				msg2(_id, cmds, "default", false)
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
            msg2(_id, "The group ".._tbl[3].." has been added!", "success")
            return 1
        end
        msg2(_id, "This group already exists!", "error")
    elseif _tbl[2] == "del" or _tbl[2] == "delete" then
    	if not _tbl[3] then
            msg2(_id, "You need to supply the group name you want to delete.", "error")
            return 1
        end

		if _GROUP[_tbl[3]] then
			if not _tbl[4] then
	            msg2(_id, "You did not enter a new group, the default group will be used instead: "..yates.setting.group_default..".", "notice")
	            _tbl[4] = yates.setting.group_default
	        end

	        if not _GROUP[_tbl[4]] then
	        	msg2(_id, "The new group for the players in the old group does not exist!", "error")
	        	return 1
        	end

        	deleteGroup(_tbl[3], _tbl[4])
    		msg2(_id, "The group ".._tbl[3].." has been deleted!", "success")
			return 1
		end
		msg2(_id, lang("validation", 5), "error")
    elseif _tbl[2] == "edit" then
    	if not _tbl[3] then
            msg2(_id, "You need to supply a name for the group you are going to edit.", "error")
            return 1
        end

        if _GROUP[_tbl[3]] then
			if not _tbl[4] then
	            msg2(_id, "You need to supply the field you want to edit.", "error")
	            return 1
	        end

	        if not _tbl[5] then
	            msg2(_id, "You need to supply a new variable for the field.", "error")
	            return 1
	        end

        	editGroup(_tbl[3], _tbl[4])
    		msg2(_id, "The group ".._tbl[3].." has been edited!", "success")
        	return 1
        end
        msg2(_id, lang("validation", 5), "error")
    end
end
setSayHelp("group", lang("group", 1))
setSayDesc("group", lang("group", 2))

function yates.func.say.undo()
	if not _PLAYER[player(_id, "usgn")] or not _PLAYER[player(_id, "usgn")].undo then
		msg2(_id, lang("undo", 2), "error")
		return 1
	end

	msg2(_id, lang("undo", 3, _PLAYER[player(_id, "usgn")].undo), "info")
	yates.hook.say(_id, _PLAYER[player(_id, "usgn")].undo)
end
setSayHelp("undo")
setSayDesc("undo", lang("undo", 1))

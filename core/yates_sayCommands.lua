-- yates_sayCommands.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful hooks and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more

	Want to add commands?
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.funcs.say.help()
	yates.funcs.help(_id, _words[2])
end
setSayHelp("help", lang("help", 1))
setSayDesc("help", lang("help", 2))

function yates.funcs.say.pm()

	local message = ""
	if _words[3] then
		message = table.toString(_words, 3)
	end

	yates.funcs.pm(_id, _words[2], message)
end
setSayHelp("pm", lang("pm", 1))
setSayDesc("pm", lang("pm", 2))

function yates.funcs.say.credits()
	yates.funcs.credits(_id)
end

function yates.funcs.say.ls()
	local command = _text:sub(5)

	yates.funcs.ls(_id, command)
end
setSayHelp("ls", lang("ls", 1))
setSayDesc("ls", lang("ls", 2))

function yates.funcs.say.clear()
	for i = 1, 100 do
		msg("", false, "")
	end
	msg2(_id, lang("clear", 2), "success")
end
setSayHelp("clear")
setSayDesc("clear", lang("clear", 1))

function yates.funcs.say.plugin()
	if not _words[2] then
		msg2(_id, lang("validation", 10, yates.settings.say_prefix, "plugin"), "error")
		return 1
	end

	if _words[2] == "list" then
		msg2(_id, "List of plugins:", "info")
		for _, all in pairs(_PLUGINS["on"]) do
			msg2(_id, all, "success", false)
		end
		for _, all in pairs(_PLUGINS["off"]) do
			msg2(_id, all, "error", false)
		end
	elseif _words[2] == "enable" then

		if _words[3] then

			for k, v in pairs(_PLUGINS["off"]) do
				if v == _words[3] then
					os.rename(_DIR.."plugins/_"..v, _DIR.."plugins/"..v)
					yates.plugins[v] = {}
					yates.plugins[v]["dir"] = _DIR.."plugins/"..v.."/"
					dofile(yates.plugins[v]["dir"].."/startup.lua")
					_PLUGINS["on"][#_PLUGINS["on"]+1] = v
					_PLUGINS["off"][k] = nil
					msg2(_id, lang("plugin", 5), "success")
					yates.funcs.cachePluginData()
					yates.funcs.checkForceReload()
					setUndo(_id, "!plugin disable ".._words[3])
					return 1
				end
			end

			for k, v in pairs(_PLUGINS["on"]) do
				if v == _words[3] then
					msg2(_id, lang("plugin", 6), "error")
					return 1
				end
			end

			msg2(_id, lang("validation", 3, lang("global", 6)), "error")
			return 1
		end

		msg2(_id, lang("validation", 8, lang("global", 7)), "error")
		return 1

	elseif _words[2] == "disable" then

		if _words[3] then

			for k, v in pairs(_PLUGINS["on"]) do
				if v == _words[3] then
					os.rename(_DIR.."plugins/"..v, _DIR.."plugins/_"..v)
					_PLUGINS["off"][#_PLUGINS["off"]+1] = v
					_PLUGINS["on"][k] = nil
					msg2(_id, lang("plugin", 7), "success")
					msg2(_id, lang("plugin", 9, yates.settings.say_prefix), "info")
					setUndo(_id, "!plugin enable ".._words[3])
					return 1
				end
			end

			for k, v in pairs(_PLUGINS["off"]) do
				if v == _words[3] then
					msg2(_id, lang("plugin", 8), "error")
					return 1
				end
			end

			msg2(_id, lang("validation", 3, lang("global", 6)), "error")
			return 1
		end

		msg2(_id, lang("validation", 8, lang("global", 7)), "error")
		return 1

	elseif _words[2] == "info" then

		if _words[3] then

			if _PLUGINS["info"][_words[3]] then
				msg2(_id, "Plugin information:", "info")
				if _PLUGINS["info"][_words[3]]["title"] then
					msg2(_id, "Title: ".._PLUGINS["info"][_words[3]]["title"], false, false)
				end
				if _PLUGINS["info"][_words[3]]["author"] then
					msg2(_id, "Author: ".._PLUGINS["info"][_words[3]]["author"], false, false)
				end
				if _PLUGINS["info"][_words[3]]["usgn"] then
					msg2(_id, "U.S.G.N. ID: ".._PLUGINS["info"][_words[3]]["usgn"], false, false)
				end
				if _PLUGINS["info"][_words[3]]["version"] then
					msg2(_id, "Version: ".._PLUGINS["info"][_words[3]]["version"], false, false)
				end
				if _PLUGINS["info"][_words[3]]["description"] then
					msg2(_id, "Description: ".._PLUGINS["info"][_words[3]]["description"], false, false)
				end
			else
				msg2(_id, lang("plugin", 10), "error")
				return 1
			end

		end

		msg2(_id, lang("validation", 8, lang("global", 7)), "error")
		return 1
	end

	msg2(_id, lang("validation", 10, yates.settings.say_prefix, "plugin"), "error")
end
setSayHelp("plugin", lang("plugin", 1))
setSayDesc("plugin", lang("plugin", 2))

function yates.funcs.say.command()
	if not _words[2] then
		msg2(_id, lang("validation", 10, yates.settings.say_prefix, "command"), "error")
		return 1
	end

	if _words[2] == "list" then
		msg2(_id, lang("command", 3), "info")
		for _, all in pairs(_YATES.disabled_commands) do
			msg2(_id, all, "error", false)
		end
	elseif _words[2] == "enable" then
		if _words[3] then
			for k, v in pairs(_YATES.disabled_commands) do
				if _words[3] == v then
					_YATES.disabled_commands[k] = nil
				end
			end
			msg2(_id, lang("command", 4), "success")
			setUndo(_id, "!command disable ".._words[3])
			saveData(_YATES, "data_yates.lua")
			return
		end

		msg2(_id, lang("validation", 8, lang("global", 1)), "error")
	elseif _words[2] == "disable" then
		if _words[3] == "command" then
			msg2(_id, lang("command", 6), "error")
			return
		end

		if _words[3] then
			table.insert(_YATES.disabled_commands, _words[3])
			msg2(_id, lang("command", 5), "success")
			setUndo(_id, "!command enable ".._words[3])
			saveData(_YATES, "data_yates.lua")
			return
		end

		msg2(_id, lang("validation", 8, lang("global", 1)), "error")
	end

	msg2(_id, lang("validation", 10, yates.settings.say_prefix, "command"), "error")
end
setSayHelp("command", lang("command", 1))
setSayDesc("command", lang("command", 2))

function yates.funcs.say.reload()
	yates.funcs.reload()
end
setSayHelp("reload", lang("reload", 1))
setSayDesc("reload", lang("reload", 2))

function yates.funcs.say.hide()
	yates.funcs.toggleHide(_id)
end
setSayHelp("hide")
setSayDesc("hide", lang("hide", 1))

function yates.funcs.say.god()
	yates.funcs.toggleGod(_id)
end
setSayHelp("god")
setSayDesc("god", lang("god", 1))

function yates.funcs.say.mute()

	local reason = ""
	if _words[4] then
		reason = table.toString(_words, 4)
	end

	yates.funcs.mute(_id, _words[2], _words[3], reason)
end
setSayHelp("mute", lang("mute", 1, yates.settings.mute_time_default))
setSayDesc("mute", lang("mute", 2))

function yates.funcs.say.unmute()
	yates.funcs.unmute(_id, _words[2])
end
setSayHelp("unmute", lang("unmute", 1))
setSayDesc("unmute", lang("unmute", 2))

function yates.funcs.say.kick()
	local reason = ""

	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if _words[3] then
		reason = table.toString(_words, 3)
	end

	if reason == "" then
		reason = lang("mute", 9)
	end

	if not yates.funcs.compareLevel(_id, _words[2]) then
		msg2(_id, lang("validation", 2, lang("global", 2)), "error")
		return 1
	end

	msg2(_id, lang("kick", 3, player(_words[2], "name")), "success")
	parse("kick ".._words[2].." \""..reason.."\"")
end
setSayHelp("kick", lang("kick", 1))
setSayDesc("kick", lang("kick", 2))

function yates.funcs.say.ban()
	local reason = ""

	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not _words[3] then
		_words[3] = 0
	end

	if _words[4] then
		reason = table.toString(_words, 4)
	end

	if reason == "" then
		reason = lang("mute", 9)
	end

	if not yates.funcs.compareLevel(_id, _words[2]) then
		msg2(_id, lang("validation", 2, lang("global", 2)), "error")
		return 1
	end

	local ip = player(_words[2], "ip")
	local usgn = player(_words[2], "usgn")

	msg2(_id, lang("ban", 3, player(_words[2], "name")), "success")
	parse("banip "..ip.." ".._words[3].." \""..reason.."\"")
	if yates.funcs.checkUsgn(_words[2], false) then
		parse("banusgn "..usgn.." ".._words[3].." \""..reason.."\"")
	end
end
setSayHelp("ban", lang("ban", 1))
setSayDesc("ban", lang("ban", 2))

function yates.funcs.say.banusgn()
	local reason = ""

	if not _words[2] or tonumber(_words[2]) == nil then
		msg2(_id, lang("validation", 8, lang("global", 14)), "error")
		return 1
	end

	if not _words[3] then
		_words[3] = 0
	end

	if _words[4] then
		reason = table.toString(_words, 4)
	end

	if reason == "" then
		reason = lang("mute", 9)
	end

	msg2(_id, lang("banusgn", 3, _words[2]), "success")
	parse("banusgn ".._words[2].." ".._words[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._words[2])
end
setSayHelp("banusgn", lang("banusgn", 1))
setSayDesc("banusgn", lang("banusgn", 2))

function yates.funcs.say.banip()
	local reason = ""

	if not _words[2] then
		msg2(_id, lang("validation", 8, lang("global", 15)), "error")
		return 1
	end

	if not _words[3] then
		_words[3] = 0
	end

	if _words[4] then
		reason = table.toString(_words, 4)
	end

	if reason == "" then
		reason = lang("mute", 9)
	end

	msg2(_id, lang("banip", 3, _words[2]), "success")
	parse("banip ".._words[2].." ".._words[3].." \""..reason.."\"")
	setUndo(_id, "!unban ".._words[2])
end
setSayHelp("banip", lang("banip", 1))
setSayDesc("banip", lang("banip", 2))

function yates.funcs.say.unban()
	if not _words[2] then
		msg2(_id, lang("validation", 8, lang("global", 14)), "error")
		msg2(_id, lang("validation", 8, lang("global", 15)), "error")
		return 1
	end

	if not yates.funcs.confirm() then
		return false
	end

	msg2(_id, lang("unban", 3, _words[2]), "success")
	parse("unban ".._words[2])
end
setSayHelp("unban", lang("unban", 1))
setSayDesc("unban", lang("unban", 2))

function yates.funcs.say.unbanall()
	if not yates.funcs.confirm() then
		return false
	end

	msg2(_id, lang("unbanall", 2), "success")
	parse("unbanall")
end
setSayHelp("unbanall")
setSayDesc("unbanall", lang("unbanall", 1))

function yates.funcs.say.map()
	if not _words[2] then
		msg2(_id, lang("validation", 8, lang("global", 13)), "error")
		return 1
	end

	if not _words[3] then
		_words[3] = 0
	end
	timer(tonumber(_words[3]*1000), "parse", "map ".._words[2])
	msg(lang("map", 3), "success")
end
setSayHelp("map", lang("map", 1))
setSayDesc("map", lang("map", 2))

function yates.funcs.say.spawn()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not yates.funcs.compareLevel(_id, _words[2]) then
		msg2(_id, lang("validation", 2, lang("global", 2)), "error")
		return 1
	end

	if player(_words[2], "team") == 0 then
		msg2(_id, lang("spawn", 3), "error")
		return 1
	end

	if player(_words[2], "health") > 0 then
		msg2(_id, lang("spawn", 4), "error")
		return 1
	end

	if not _words[3] then
		local entities = entitylist(player(_words[2], "team") - 1)
		local list = {}

		for _, e in pairs(entities) do
			table.insert(list, {e.x, e.y})
		end

		if #list > 0 then
			_words[3] = list[math.random(#list)][1] * 32 + 16
			_words[4] = list[math.random(#list)][2] * 32 + 16
		else
			_words[3] = 0
			_words[4] = 0
		end
	end

	msg2(_id, lang("spawn", 5, player(_words[2], "name")), "success")
	parse("spawnplayer ".._words[2].." ".._words[3].." ".._words[4])
end
setSayHelp("spawn", lang("spawn", 1))
setSayDesc("spawn", lang("spawn", 2))

function yates.funcs.say.kill()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not yates.funcs.compareLevel(_id, _words[2]) then
		msg2(_id, lang("validation", 2, lang("global", 2)), "error")
		return 1
	end

	if player(_words[2], "health") == 0 then
		msg2(_id, lang("kill", 3), "error")
		return 1
	end

	msg2(_id, lang("kill", 4, player(_words[2], "name")), "success")
	parse("killplayer ".._words[2])
end
setSayHelp("kill", lang("kill", 1))
setSayDesc("kill", lang("kill", 2))

function yates.funcs.say.slap()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not yates.funcs.compareLevel(_id, _words[2]) then
		msg2(_id, lang("validation", 2, lang("global", 2)), "error")
		return 1
	end

	msg2(_words[2], lang("slap", 3), "error")
	msg2(_id, lang("slap", 4, player(_words[2], "name")), "success")
	parse("slap ".._words[2])
end
setSayHelp("slap", lang("slap", 1))
setSayDesc("slap", lang("slap", 2))

function yates.funcs.say.equip()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not _words[3] then
		msg2(_id, lang("validation", 9, lang("global", 9)), "error")
		return 1
	end

	msg2(_words[2], lang("equip", 3, itemtype(_words[3], "name")), "info")
	msg2(_id, lang("equip", 4, player(_words[2], "name"), itemtype(_words[3], "name")), "success")

	parse("equip ".._words[2].." ".._words[3])
	setUndo(_id, "!strip ".._words[2].." ".._words[3])
end
setSayHelp("equip", lang("equip", 1))
setSayDesc("equip", lang("equip", 2))

function yates.funcs.say.strip()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if not _words[3] then
		msg2(_id, lang("validation", 8, lang("global", 3)), "error")
		return 1
	end

	msg2(_words[2], lang("strip", 3, itemtype(_words[3], "name")), "info")
	msg2(_id, lang("strip", 4, player(_words[2], "name"), itemtype(_words[3], "name")), "success")

	parse("strip ".._words[2].." ".._words[3])
	setUndo(_id, "!equip ".._words[2].." ".._words[3])
end
setSayHelp("strip", lang("strip", 1))
setSayDesc("strip", lang("strip", 2))

function yates.funcs.say.goto()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	yates.players[_id].tp[1] = player(_id, "x")
	yates.players[_id].tp[2] = player(_id, "y")
	parse("setpos ".._id.." "..player(_words[2], "x").." "..player(_words[2], "y"))
end
setSayHelp("goto", lang("goto", 1))
setSayDesc("goto", lang("goto", 2))

function yates.funcs.say.goback()
	if not yates.players[_id].tp[1] then
		msg2(_id, lang("goback", 2), "error")
		return 1
	end

	parse("setpos ".._id.." "..yates.players[_id].tp[1].." "..yates.players[_id].tp[2])
end
setSayHelp("goback")
setSayDesc("goback", lang("goback", 1))

function yates.funcs.say.bring()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	yates.players[_words[2]].tp[1] = player(_words[2], "x")
	yates.players[_words[2]].tp[2] = player(_words[2], "y")
	parse("setpos ".._words[2].." "..player(_id, "x").." "..player(_id, "y"))
end
setSayHelp("bring", lang("bring", 1))
setSayDesc("bring", lang("bring", 2))

function yates.funcs.say.bringback()
	if not _words[2] then
		msg2(_id, lang("validation", 8, lang("global", 3)), "error")
		return 1
	end

	if not player(_words[2], "exists") then
		msg2(_id, lang("validation", 3, lang("global", 2)), "error")
		return 1
	end

	_words[2] = tonumber(_words[2])

	if not yates.players[_words[2]].tp[1] then
		msg2(_id, lang("bringback", 3), "error")
		return 1
	end

	parse("setpos ".._words[2].." "..yates.players[_words[2]].tp[1].." "..yates.players[_words[2]].tp[2])
end
setSayHelp("bringback", lang("bringback", 1))
setSayDesc("bringback", lang("bringback", 2))

function yates.funcs.say.make()
	if not yates.funcs.checkPlayer(_words[2]) then
		return 1
	end
	_words[2] = tonumber(_words[2])

	if _words[3] == "0" or _words[3] == "spec" then
		_words[3] = "spec"
	elseif _words[3] == "1" or _words[3] == "t" then
		_words[3] = "t"
	elseif _words[3] == "2" or _words[3] == "ct" then
		_words[3] = "ct"
	else
		msg2(_id, lang("make", 3), "error")
		msg2(_id, lang("make", 4), "info")
		return 1
	end

	parse("make".._words[3].." ".._words[2])
end
setSayHelp("make", lang("make", 1))
setSayDesc("make", lang("make", 2))

function yates.funcs.say.playerprefix()
	if not yates.funcs.checkUsgn(_words[2]) then
		return 1
	end

	local id = _words[2]
	local undo = false

	_words[5] = _words[3]
	_words[4] = "prefix"
	_words[3] = player(_words[2], "usgn")
	_words[2] = "edit"

	if not _PLAYERS[_words[3]] then
		_PLAYERS[_words[3]] = {}
		undo = "!playerprefix "..id.." /nil"
	end

	if _PLAYERS[_words[3]].prefix then
		undo = "!playerprefix "..id.." ".._PLAYERS[_words[3]].prefix
	else
		undo = "!playerprefix "..id.." /nil"
	end

	if yates.funcs.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playerprefix", lang("playerprefix", 1))
setSayDesc("playerprefix", lang("playerprefix", 2))

function yates.funcs.say.playercolour()
	if not yates.funcs.checkUsgn(_words[2]) then
		return 1
	end

	local id = _words[2]
	local undo = false

	_words[5] = _words[3]
	_words[4] = "colour"
	_words[3] = player(_words[2], "usgn")
	_words[2] = "edit"

	if not _PLAYERS[_words[3]] then
		_PLAYERS[_words[3]] = {}
		undo = "!playercolour "..id.." /nil"
	end

	if _PLAYERS[_words[3]].colour then
		undo = "!playercolour "..id.." ".._PLAYERS[_words[3]].colour
	else
		undo = "!playercolour "..id.." /nil"
	end

	if yates.funcs.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playercolour", lang("playercolour", 1))
setSayDesc("playercolour", lang("playercolour", 2))

function yates.funcs.say.playerlevel()
	if not yates.funcs.checkUsgn(_words[2]) then
		return 1
	end

	local id = _words[2]
	local undo = false

	_words[5] = _words[3]
	_words[4] = "level"
	_words[3] = player(_words[2], "usgn")
	_words[2] = "edit"

	if not _PLAYERS[_words[3]] then
		_PLAYERS[_words[3]] = {}
		undo = "!playerlevel "..id.." /nil"
	end

	if _PLAYERS[_words[3]].level then
		undo = "!playerlevel "..id.." ".._PLAYERS[_words[3]].level
	else
		undo = "!playerlevel "..id.." /nil"
	end

	if yates.funcs.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playerlevel", lang("playerlevel", 1))
setSayDesc("playerlevel", lang("playerlevel", 2))

function yates.funcs.say.playergroup()
	if not yates.funcs.checkUsgn(_words[2]) then
		return 1
	end

	local id = _words[2]
	local undo = false

	_words[5] = _words[3]
	_words[4] = "group"
	_words[3] = player(_words[2], "usgn")
	_words[2] = "edit"

	if not _PLAYERS[_words[3]] then
		_PLAYERS[_words[3]] = {}
		undo = "!playergroup "..id.." /nil"
	end

	if _PLAYERS[_words[3]].group then
		undo = "!playergroup "..id.." ".._PLAYERS[_words[3]].group
	else
		undo = "!playergroup "..id.." /nil"
	end

	if yates.funcs.say.player() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("playergroup", lang("playergroup", 1))
setSayDesc("playergroup", lang("playergroup", 2))

function yates.funcs.say.player()
	if not _words[2] then
		msg2(_id, lang("validation", 10, yates.settings.say_prefix, "player"), "error")
		return 1
	end

	if _words[2] == "list" then
		msg2(_id, lang("player", 3, yates.settings.say_prefix), "info")
		for k, v in pairs(_PLAYERS) do
			msg2(_id, k, false, false)
		end
		return 1
	elseif _words[2] == "info" then

		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 14)), "error")
			return 1
		end
		_words[3] = tonumber(_words[3])

		if _PLAYERS[_words[3]] then
			msg2(_id, lang("player", 4), "info")

			if _words[4] then
				local info = table.valueToString(_PLAYERS[_words[3]])
				info = info:gsub("©","")
				info = info:gsub("\169","")

				msg2(_id, "_PLAYERS[\"".._words[3].."\"] = "..info, "default", false)
				return 1
			end

			for k, v in pairs(_PLAYERS[_words[3]]) do
				if type(v) ~= "table" then
					v = tostring(v)
					v = v:gsub("©","")
					v = v:gsub("\169","")
				end
				msg2(_id, k.." = "..table.valueToString(v), "default", false)
			end
			return 1
		end
		msg2(_id, lang("validation", 3, lang("global", 14)), "error")

	elseif _words[2] == "edit" then
		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 14)), "error")
			return 1
		end
		_words[3] = tonumber(_words[3])

		if not _PLAYERS[_words[3]] then
			_PLAYERS[_words[3]] = {}
		end

		if _PLAYERS[_words[3]] then
			if not _words[4] then
				msg2(_id, lang("validation", 8, lang("global", 18)), "error")
				return 1
			end

			if not _words[5] then
				msg2(_id, lang("validation", 8, lang("global", 20)), "error")
				return 1
			end

			yates.funcs.editPlayer(_words[3], _words[4])
			msg2(_id, lang("player", 5, _words[3]), "success")
			return 1
		end
	end

	msg2(_id, lang("validation", 10, yates.settings.say_prefix, "player"), "error")
end
setSayHelp("player", lang("player", 1))
setSayDesc("player", lang("player", 2))

function yates.funcs.say.groupprefix()
	local undo = false

	_words[5] = _words[3]
	_words[4] = "prefix"
	_words[3] = _words[2]
	_words[2] = "edit"

	if yates.funcs.checkGroup(_words[3], false) then
		if _GROUPS[_words[3]].prefix then
			undo = "!groupprefix ".._words[3].." ".._GROUPS[_words[3]].prefix
		else
			undo = "!groupprefix ".._words[3].." /nil"
		end
	end

	if yates.funcs.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("groupprefix", lang("groupprefix", 1))
setSayDesc("groupprefix", lang("groupprefix", 2))

function yates.funcs.say.groupcolour()
	local undo = false

	_words[5] = _words[3]
	_words[4] = "colour"
	_words[3] = _words[2]
	_words[2] = "edit"

	if yates.funcs.checkGroup(_words[3], false) then
		if _GROUPS[_words[3]].colour then
			undo = "!groupcolour ".._words[3].." ".._GROUPS[_words[3]].colour
		else
			undo = "!groupcolour ".._words[3].." /nil"
		end
	end

	if yates.funcs.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("groupcolour", lang("groupcolour", 1))
setSayDesc("groupcolour", lang("groupcolour", 2))

function yates.funcs.say.grouplevel()
	local undo = false

	_words[5] = _words[3]
	_words[4] = "level"
	_words[3] = _words[2]
	_words[2] = "edit"

	if yates.funcs.checkGroup(_words[3], false) then
		if _GROUPS[_words[3]].level then
			undo = "!grouplevel ".._words[3].." ".._GROUPS[_words[3]].level
		else
			undo = "!grouplevel ".._words[3].." /nil"
		end
	end

	if yates.funcs.say.group() then
		if undo then
			setUndo(_id, undo)
		end
	end
end
setSayHelp("grouplevel", lang("grouplevel", 1))
setSayDesc("grouplevel", lang("grouplevel", 2))

function yates.funcs.say.group()
	if not _words[2] then
		msg2(_id, lang("validation", 10, yates.settings.say_prefix, "group"), "error")
		return 1
	end

	if _words[2] == "list" then
		msg2(_id, lang("group", 3), "info")
		for k, v in pairs(_GROUPS) do
			msg2(_id, k.." ".._GROUPS[k].level.." "..(_GROUPS[k].prefix or ""), _GROUPS[k].colour, false)
		end
		return 1
	elseif _words[2] == "info" then
		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 4)), "error")
			return 1
		end

		if _GROUPS[_words[3]] then
			msg2(_id, lang("group", 4), "info")

			if _words[4] then
				local info = table.valueToString(_GROUPS[_words[3]])
				info = info:gsub("©", "")
				info = info:gsub("\169", "")

				msg2(_id, "_GROUPS[\"".._words[3].."\"] = "..info, "default", false)
				return 1
			end

			for k, v in pairs(_GROUPS[_words[3]]) do
				if type(v) ~= "table" then
					v = tostring(v)
					v = v:gsub("©", "")
					v = v:gsub("\169", "")
				end
				msg2(_id, k.." = "..table.valueToString(v), "default", false)
			end
			return 1
		end
		msg2(_id, lang("validation", 3, lang("global", 4)), "error")

	elseif _words[2] == "add" then
		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 5)), "error")
			return 1
		end

		if not _GROUPS[_words[3]] then
			local cmds = ""

			if not _words[4] then
				_words[4] = (yates.settings.group_default_level or _GROUPS[yates.settings.group_default].level)
				msg2(_id, lang("group", 5, (yates.settings.group_default_level or _GROUPS[yates.settings.group_default].level)), "notice")
			end

			if not _words[5] then
				_words[5] = (yates.settings.group_default_colour or _GROUPS[yates.settings.group_default].colour)
				msg2(_id, lang("group", 6, (yates.settings.group_default_colour or _GROUPS[yates.settings.group_default].colour)), "notice")
			else
				_words[5] = "\169".._words[5]
			end

			if not _words[6] then
				_words[6] = (yates.settings.group_default_commands or _GROUPS[yates.settings.group_default].commands)
				msg2(_id, lang("group", 7), "notice")
				cmds = (yates.settings.group_default_commands or _GROUPS[yates.settings.group_default].commands)
				msg2(_id, table.toString(cmds, 1, ", "), "default", false)
			else
				cmds = table.toString(_words, 6, " ")
				cmds = string.toTable(cmds)
			end

			setUndo(_id, "!group del ".._words[3])
			yates.funcs.addGroup(_words[3], _words[4], _words[5], cmds)
			msg2(_id, lang("group", 8, _words[3]), "success")
			return 1
		end
		msg2(_id, lang("group", 9), "error")
		return 1

	elseif _words[2] == "del" or _words[2] == "delete" then
		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 4)), "error")
			return 1
		end

		if _GROUPS[_words[3]] then
			if not yates.funcs.confirm() then
				return false
			end

			if not _words[4] then
				msg2(_id, lang("group", 10, yates.settings.group_default), "notice")
				_words[4] = yates.settings.group_default
			end

			if not _GROUPS[_words[4]] then
				msg2(_id, lang("validation", 8, lang("global", 4)), "error")
				return 1
			end

			yates.funcs.deleteGroup(_words[3], _words[4])
			msg2(_id, lang("group", 11, _words[3]), "success")
			return 1
		end
		msg2(_id, lang("validation", 3, lang("global", 4)), "error")
		return 1

	elseif _words[2] == "edit" then
		if not _words[3] then
			msg2(_id, lang("validation", 8, lang("global", 4)), "error")
			return 1
		end

		if _GROUPS[_words[3]] then
			if not _words[4] then
				msg2(_id, lang("validation", 8, lang("global", 19)), "error")
				return 1
			end

			if not _words[5] then
				msg2(_id, lang("validation", 8, lang("global", 20)), "error")
				return 1
			end

			yates.funcs.editGroup(_words[3], _words[4])
			msg2(_id, lang("group", 12, _words[3]), "success")
			return 1
		end
		msg2(_id, lang("validation", 3, lang("global", 4)), "error")
		return 1
	end

	msg2(_id, lang("validation", 10, yates.settings.say_prefix, "group"), "error")
end
setSayHelp("group", lang("group", 1))
setSayDesc("group", lang("group", 2))

function yates.funcs.say.undo()
	if not _PLAYERS[_usgn] or not _PLAYERS[_usgn].undo then
		msg2(_id, lang("undo", 2), "error")
		return 1
	end

	msg2(_id, lang("undo", 3, _PLAYERS[_usgn].undo), "info")
	yates.hooks.say(_id, _PLAYERS[_usgn].undo, true)

	_PLAYERS[_usgn].undo = false
end
setSayHelp("undo")
setSayDesc("undo", lang("undo", 1))

function yates.funcs.say.yes()
	if not yates.players[_id].confirm_command then
		msg2(_id, lang("yes", 2), "error")
		return 1
	end

	yates.players[_id].confirm = true

	msg2(_id, lang("yes", 3, yates.players[_id].confirm_command), "info")
	yates.hooks.say(_id, yates.players[_id].confirm_command, true)

	yates.players[_id].confirm_command = false
end
setSayHelp("yes")
setSayDesc("yes", lang("yes", 1))

function yates.funcs.say.no()
	if not yates.players[_id].confirm_command then
		msg2(_id, lang("no", 2), "error")
		return 1
	end

	msg2(_id, lang("no", 3, yates.players[_id].confirm_command), "info")
	yates.players[_id].confirm_command = false
end
setSayHelp("no")
setSayDesc("no", lang("no", 1))

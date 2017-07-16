-- yates_hooks.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful hooks and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.hooks.always()
	hook("always")
end
_addhook("always", "yates.hooks.always")

function yates.hooks.attack(id)
	hook("attack", id)
end
_addhook("attack", "yates.hooks.attack")

function yates.hooks.attack2(id, mode)
	hook("attack2", id, mode)
end
_addhook("attack2", "yates.hooks.attack2")

function yates.hooks.bombdefuse(id)
	hook("bombdefuse", id)

    return filter("bombdefuse", id) or 0
end
_addhook("bombdefuse", "yates.hooks.bombdefuse")

function yates.hooks.bombexplode(id, tilex, tiley)
	hook("bombexplode", id, tilex, tiley)

    return filter("bombexplode", id, tilex, tiley) or 0
end
_addhook("bombexplode", "yates.hooks.bombexplode")

function yates.hooks.bombplant(id, tilex, tiley)
	hook("bombplant", id, tilex, tiley)

    return filter("bombplant", id, tilex, tiley) or 0
end
_addhook("bombplant", "yates.hooks.bombplant")

function yates.hooks.destroy(tilex, tiley, id) -- yates.hooks.break
	hook("destroy", tilex, tiley, id)
end
_addhook("break", "yates.hooks.destroy")

function yates.hooks.build(id, type, tilex, tiley, mode, objectid)
	hook("build", id, type, tilex, tiley, mode, objectid)

    return filter("build", id, type, tilex, tiley, mode, objectid) or 0
end
_addhook("build", "yates.hooks.build")

function yates.hooks.buildattempt(id, type, tilex, tiley, mode)
	hook("buildattempt", id, type, tilex, tiley, mode)

    return filter("buildattempt", id, type, tilex, tiley, mode) or 0
end
_addhook("buildattempt", "yates.hooks.buildattempt")

function yates.hooks.buy(id, weapon)
	hook("buy", id, weapon)

    return filter("buy", id, weapon) or 0
end
_addhook("buy", "yates.hooks.buy")

function yates.hooks.clientdata(id, mode, data1, data2)
	hook("clientdata", id, mode, data1, data2)
end
_addhook("clientdata", "yates.hooks.clientdata")

function yates.hooks.collect(id, iid, type, ain, a, mode)
	hook("collect", id, iid, type, ain, a, mode)
end
_addhook("collect", "yates.hooks.collect")

function yates.hooks.die(victim, killer, weapon, x, y, objectid)
	hook("die", victim, killer, weapon, x, y, objectid)

    return filter("die", victim, killer, weapon, x, y, objectid) or 0
end
_addhook("die", "yates.hooks.die")

function yates.hooks.dominate(id, team, tilex, tiley)
	hook("dominate", id, team, tilex, tiley)

    return filter("dominate", id, team, tilex, tiley) or 0
end
_addhook("dominate", "yates.hooks.dominate")

function yates.hooks.drop(id, iid, type, ain, a, mode, tilex, tiley)
	hook("drop", id, iid, type, ain, a, mode, tilex, tiley)

    return filter("drop", id, iid, type, ain, a, mode, tilex, tiley) or 0
end
_addhook("drop", "yates.hooks.drop")

function yates.hooks.endround(mode)
	hook("endround", mode)
end
_addhook("endround", "yates.hooks.endround")

function yates.hooks.flagcapture(id, team, tilex, tiley)
	hook("flagcapture", id, team, tilex, tiley)

    return filter("flagcapture", id, team, tilex, tiley) or 0
end
_addhook("flagcapture", "yates.hooks.flagcapture")

function yates.hooks.flagtake(id, team, tilex, tiley)
	hook("flagtake", id, team, tilex, tiley)

    return filter("flagtake", id, team, tilex, tiley) or 0
end
_addhook("flagtake", "yates.hooks.flagtake")

function yates.hooks.flashlight(id, mode)
	hook("flashlight", id, mode)
end
_addhook("flashlight", "yates.hooks.flashlight")

function yates.hooks.hit(id, source, weapon, hpdmg, apdmg, rawdmg, object)
	if yates.players[id].god then
		return filter("hitGod", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 1
	end

	hook("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object)

    return filter("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 0
end
_addhook("hit", "yates.hooks.hit")

function yates.hooks.hitzone(imageid, id, objectid, weapon, x, y, damage)
	hook("hitzone", imageid, id, objectid, weapon, x, y, damage)

    return filter("hitzone", imageid, id, objectid, weapon, x, y, damage) or 0
end
_addhook("hitzone", "yates.hooks.hitzone")

function yates.hooks.hostagerescue(id, tilex, tiley)
	hook("hostagerescue", id, tilex, tiley)
end
_addhook("hostagerescue", "yates.hooks.hostagerescue")

function yates.hooks.join(id)
	yates.players[id] = {}
	yates.players[id].hide = false
	yates.players[id].god = false
	yates.players[id].mute_time = 0
	yates.players[id].mute_reason = ""
	yates.players[id].confirm = false
	yates.players[id].confirm_command = false
	yates.players[id].tp = {}

	if _PLAYERS[player(id, "usgn")] and _PLAYERS[player(id, "usgn")].mute_time and _PLAYERS[player(id, "usgn")].mute_time > 0 then
		yates.players[id].mute_time = _PLAYERS[player(id, "usgn")].mute_time
		yates.players[id].mute_reason = _PLAYERS[player(id, "usgn")].mute_reason

		msg2(id, "Welcome back! You are still muted for "..yates.players[id].mute_time.." seconds", "error")
		hook("joinMute", id)
	end

	hook("join", id)
end
_addhook("join", "yates.hooks.join")

function yates.hooks.kill(killer, victim, weapon, x, y, objectid)
	hook("kill", killer, victim, weapon, x, y, objectid)
end
_addhook("kill", "yates.hooks.kill")

function yates.hooks.leave(id)
	yates.players[id] = {}

	hook("leave", id)
end
_addhook("leave", "yates.hooks.leave")

function yates.hooks.log(text)
--     hook("log", text) -- @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX

--     return filter("log", text) or 0 -- @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX
end
_addhook("log", "yates.hooks.log")

function yates.hooks.mapchange(map)
	hook("mapchange", map)
end
_addhook("mapchange", "yates.hooks.mapchange")

function yates.hooks.menu(id, title, button)
	hook("menu", id, title, button)
end
_addhook("menu", "yates.hooks.menu")

function yates.hooks.minute()
	hook("minute")
end
_addhook("minute", "yates.hooks.minute")

function yates.hooks.move(id, x, y, mode)
	hook("move", id, x, y, mode)
end
_addhook("move", "yates.hooks.move")

function yates.hooks.movetile(id, tilex, tiley)
	hook("movetile", id, tilex, tiley)
end
_addhook("movetile", "yates.hooks.movetile")

function yates.hooks.ms100()
	hook("ms100")
end
_addhook("ms100", "yates.hooks.ms100")

function yates.hooks.name(id, oldname, newname, forced)
	hook("name", id, oldname, newname, forced)

    return filter("name", id, oldname, newname, forced) or 0
end
_addhook("name", "yates.hooks.name")

function yates.hooks.objectdamage(objectid, damage, id)
	hook("objectdamage", objectid, damage, id)

    return filter("objectdamage", objectid, damage, id) or 0
end
_addhook("objectdamage", "yates.hooks.objectdamage")

function yates.hooks.objectkill(objectid, id)
	hook("objectkill", objectid, id)
end
_addhook("objectkill", "yates.hooks.objectkill")

function yates.hooks.objectupgrade(objectid, id, progress, total)
	hook("objectupgrade", objectid, id, progress, total)

    return filter("objectupgrade", objectid, id, progress, total) or 0
end
_addhook("objectupgrade", "yates.hooks.objectupgrade")

function yates.hooks.parse(text)
	local tbl = string.toTable(text)
	if not tbl[1] then
		return 0
	end
	local command = tbl[1]

	hook("parse", text)
	if yates.funcs.checkCommand(command, "console") then
		return 2
	end

    return filter("parse", text) or 0
end
_addhook("parse", "yates.hooks.parse")

function yates.hooks.projectile(id, weapon, x, y)
	hook("projectile", id, weapon, x, y)
end
_addhook("projectile", "yates.hooks.projectile")

function yates.hooks.radio(id, message)
	hook("radio", id, message)

    return filter("radio", id, message) or 0
end
_addhook("radio", "yates.hooks.radio")

function yates.hooks.rcon(cmds, id, ip, port)
	local tbl = string.toTable(cmds)

	if not tbl[1] then
		return 1
	end
	local command = tbl[1]

	if yates.funcs.checkCommand(command, "console") then
		yates.funcs.executeCommand(false, command, cmds, "console")
	end
	hook("rcon", cmds, id, ip, port)

    return filter("rcon", cmds, id, ip, port) or 0
end
_addhook("rcon", "yates.hooks.rcon")

function yates.hooks.reload(id, mode)
	hook("reload", id, mode)
end
_addhook("reload", "yates.hooks.reload")

function yates.hooks.say(id, text, inner)
	local tbl = string.toTable(text)
	local usgn = player(id, "usgn")

	text = text:gsub("\166", "")
	text = text:gsub("|", "")

	if text:sub(1, #yates.settings.say_prefix) == yates.settings.say_prefix then
		local command = tbl[1]:sub(#yates.settings.say_prefix+1)

		if yates.funcs.checkCommand(command, "say") then
			if not yates.funcs.checkSayCommandUse(command) then
				msg2(id, lang("validation", 5, lang("global", 1)), "error")
				return 1
			end

			if inner then
				yates.funcs.executeCommand(id, command, text, "say", inner)
				return 1
			end

			for k, v in pairs(_GROUPS[(_PLAYERS[usgn] and _PLAYERS[usgn].group or yates.settings.group_default)].commands) do
				if command == v or v == "all" then
					yates.funcs.executeCommand(id, command, text, "say")
					return 1
				end
			end

			if _PLAYERS[usgn] and _PLAYERS[usgn].commands then
				for k, v in pairs(_PLAYERS[usgn].commands) do
					if command == v or v == "all" then
						yates.funcs.executeCommand(id, command, text, "say")
						return 1
					end
				end
			end
			msg2(id, lang("validation", 1, lang("global", 1)), "error")

		else
			msg2(id, lang("validation", 3, lang("global", 1)), "error")
			msg2(id, lang("help", 3, yates.settings.say_prefix), "info")
		end
	else
		if yates.settings.at_c == false then
			text = text:gsub("@C", yates.settings.at_c_replacement)
		end

		if yates.players[id].mute_time > 0 then
			msg2(id, lang("mute", 8, yates.players[id].mute_time), "error")
			msg2(id, lang("mute", 10, yates.players[id].mute_reason), "info")
		else
			yates.funcs.chat(id, text)
		end
    end
    hook("say", id, text)

    return filter("say", id, text) or 1
end
_addhook("say", "yates.hooks.say")

function yates.hooks.sayteam(id, message)
	hook("sayteam", id, message)

    return filter("sayteam", id, message) or 0
end
_addhook("sayteam", "yates.hooks.sayteam")

function yates.hooks.second()
	for _, id in pairs(player(0, "table")) do
		if yates.players[id] then
			if yates.players[id].mute_time > 0 then
				yates.players[id].mute_time = yates.players[id].mute_time - 1

				if _PLAYERS[player(id, "usgn")] and _PLAYERS[player(id, "usgn")].mute_time and _PLAYERS[player(id, "usgn")].mute_time > 0 then
					_PLAYERS[player(id, "usgn")].mute_time = _PLAYERS[player(id, "usgn")].mute_time - 1

					if _PLAYERS[player(id, "usgn")].mute_time == 0 then
						_PLAYERS[player(id, "usgn")].mute_time = nil
					end

					saveData(_PLAYERS, "data_player.lua")
				end

				if yates.players[id].mute_time == 0 then
					msg2(id, "You are no longer muted", "info")
				end
			end

			if yates.players[id].mute_time == 0 then
				yates.players[id].mute_reason = ""

				if _PLAYERS[player(id, "usgn")] and _PLAYERS[player(id, "usgn")].mute_reason then
					_PLAYERS[player(id, "usgn")].mute_reason = nil
					saveData(_PLAYERS, "data_player.lua")
				end
			end
		end
	end
	hook("second")
end
_addhook("second", "yates.hooks.second")

function yates.hooks.select(id, type, mode)
	hook("select", id, type, mode)
end
_addhook("select", "yates.hooks.select")

function yates.hooks.serveraction(id, mode)
	hook("serveraction", id, mode)
end
_addhook("serveraction", "yates.hooks.serveraction")

function yates.hooks.shieldhit(id, source, weapon, direction, objectid)
	hook("shieldhit", id, source, weapon, direction, objectid)
end
_addhook("shieldhit", "yates.hooks.shieldhit")

function yates.hooks.shutdown()
	hook("shutdown")
end
_addhook("shutdown", "yates.hooks.shutdown")

function yates.hooks.spawn(id)
	hook("spawn", id)

    return filter("spawn", id) or 0
end
_addhook("spawn", "yates.hooks.spawn")

function yates.hooks.specswitch(id, target)
	hook("specswitch", id, target)
end
_addhook("specswitch", "yates.hooks.specswitch")

function yates.hooks.spray(id)
	hook("spray", id)
end
_addhook("spray", "yates.hooks.spray")

function yates.hooks.startround(mode)
	hook("startround", mode)
end
_addhook("startround", "yates.hooks.startround")

function yates.hooks.startround_prespawn(mode)
	hook("startround_prespawn", mode)
end
_addhook("startround_prespawn", "yates.hooks.startround_prespawn")

function yates.hooks.suicide(id)
	hook("suicide", id)

    return filter("suicide", id) or 0
end
_addhook("suicide", "yates.hooks.suicide")

function yates.hooks.team(id, team, look)
	hook("team", id, team, look)

    return filter("team", id, team, look) or 0
end
_addhook("team", "yates.hooks.team")

function yates.hooks.trigger(trigger, source)
	hook("trigger", trigger, source)

    return filter("trigger", trigger, source) or 0
end
_addhook("trigger", "yates.hooks.trigger")

function yates.hooks.triggerentity(tilex, tiley)
	hook("triggerentity", tilex, tiley)

    return filter("triggerentity", tilex, tiley) or 0
end
_addhook("triggerentity", "yates.hooks.triggerentity")

function yates.hooks.use(id, event, data, tilex, tiley)
	hook("use", id, event, data, tilex, tiley)
end
_addhook("use", "yates.hooks.use")

function yates.hooks.usebutton(id, tilex, tiley)
	hook("usebutton", id, tilex, tiley)
end
_addhook("usebutton", "yates.hooks.usebutton")

function yates.hooks.vipescape(id, tilex, tiley)
	hook("vipescape", id, tilex, tiley)
end
_addhook("vipescape", "yates.hooks.vipescape")

function yates.hooks.vote(id, mode, param)
	hook("vote", id, mode, param)
end
_addhook("vote", "yates.hooks.vote")

function yates.hooks.walkover(id, iid, type, ain, a, mode)
	hook("walkover", id, iid, type, ain, a, mode)

    return filter("walkover", id, iid, type, ain, a, mode) or 0
end
_addhook("walkover", "yates.hooks.walkover")

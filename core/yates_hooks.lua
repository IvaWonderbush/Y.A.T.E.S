-- yates_hooks.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful hooks and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.hook.always()
	hook("always")
end
_addhook("always", "yates.hook.always")

function yates.hook.attack(id)
	hook("attack", id)
end
_addhook("attack", "yates.hook.attack")

function yates.hook.attack2(id, mode)
	hook("attack2", id, mode)
end
_addhook("attack2", "yates.hook.attack2")

function yates.hook.bombdefuse(id)
	hook("bombdefuse", id)

    return filter("bombdefuse", id) or 0
end
_addhook("bombdefuse", "yates.hook.bombdefuse")

function yates.hook.bombexplode(id, tilex, tiley)
	hook("bombexplode", id, tilex, tiley)

    return filter("bombexplode", id, tilex, tiley) or 0
end
_addhook("bombexplode", "yates.hook.bombexplode")

function yates.hook.bombplant(id, tilex, tiley)
	hook("bombplant", id, tilex, tiley)

    return filter("bombplant", id, tilex, tiley) or 0
end
_addhook("bombplant", "yates.hook.bombplant")

function yates.hook.destroy(tilex, tiley, id) -- yates.hook.break
	hook("destroy", tilex, tiley, id)
end
_addhook("break", "yates.hook.destroy")

function yates.hook.build(id, type, tilex, tiley, mode, objectid)
	hook("build", id, type, tilex, tiley, mode, objectid)

    return filter("build", id, type, tilex, tiley, mode, objectid) or 0
end
_addhook("build", "yates.hook.build")

function yates.hook.buildattempt(id, type, tilex, tiley, mode)
	hook("buildattempt", id, type, tilex, tiley, mode)

    return filter("buildattempt", id, type, tilex, tiley, mode) or 0
end
_addhook("buildattempt", "yates.hook.buildattempt")

function yates.hook.buy(id, weapon)
	hook("buy", id, weapon)

    return filter("buy", id, weapon) or 0
end
_addhook("buy", "yates.hook.buy")

function yates.hook.clientdata(id, mode, data1, data2)
	hook("clientdata", id, mode, data1, data2)
end
_addhook("clientdata", "yates.hook.clientdata")

function yates.hook.collect(id, iid, type, ain, a, mode)
	hook("collect", id, iid, type, ain, a, mode)
end
_addhook("collect", "yates.hook.collect")

function yates.hook.die(victim, killer, weapon, x, y, objectid)
	hook("die", victim, killer, weapon, x, y, objectid)

    return filter("die", victim, killer, weapon, x, y, objectid) or 0
end
_addhook("die", "yates.hook.die")

function yates.hook.dominate(id, team, tilex, tiley)
	hook("dominate", id, team, tilex, tiley)

    return filter("dominate", id, team, tilex, tiley) or 0
end
_addhook("dominate", "yates.hook.dominate")

function yates.hook.drop(id, iid, type, ain, a, mode, tilex, tiley)
	hook("drop", id, iid, type, ain, a, mode, tilex, tiley)

    return filter("drop", id, iid, type, ain, a, mode, tilex, tiley) or 0
end
_addhook("drop", "yates.hook.drop")

function yates.hook.endround(mode)
	hook("endround", mode)
end
_addhook("endround", "yates.hook.endround")

function yates.hook.flagcapture(id, team, tilex, tiley)
	hook("flagcapture", id, team, tilex, tiley)

    return filter("flagcapture", id, team, tilex, tiley) or 0
end
_addhook("flagcapture", "yates.hook.flagcapture")

function yates.hook.flagtake(id, team, tilex, tiley)
	hook("flagtake", id, team, tilex, tiley)

    return filter("flagtake", id, team, tilex, tiley) or 0
end
_addhook("flagtake", "yates.hook.flagtake")

function yates.hook.flashlight(id, mode)
	hook("flashlight", id, mode)
end
_addhook("flashlight", "yates.hook.flashlight")

function yates.hook.hit(id, source, weapon, hpdmg, apdmg, rawdmg, object)
	if yates.player[id].god then
		return filter("hitGod", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 1
	end

	hook("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object)

    return filter("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 0
end
_addhook("hit", "yates.hook.hit")

function yates.hook.hitzone(imageid, id, objectid, weapon, x, y, damage)
	hook("hitzone", imageid, id, objectid, weapon, x, y, damage)

    return filter("hitzone", imageid, id, objectid, weapon, x, y, damage) or 0
end
_addhook("hitzone", "yates.hook.hitzone")

function yates.hook.hostagerescue(id, tilex, tiley)
	hook("hostagerescue", id, tilex, tiley)
end
_addhook("hostagerescue", "yates.hook.hostagerescue")

function yates.hook.join(id)
	yates.player[id] = {}
	yates.player[id].hide = false
	yates.player[id].god = false
	yates.player[id].mute_time = 0
	yates.player[id].mute_reason = ""
	yates.player[id].tp = {}

	if _player[player(id, "usgn")] and _player[player(id, "usgn")].mute_time then
		yates.player[id].mute_time = _player[player(id, "usgn")].mute_time
		yates.player[id].mute_reason = _player[player(id, "usgn")].mute_reason

		msg2(id, "Welcome back! You are still muted for "..yates.player[id].mute_time.." seconds", "error")
		hook("joinMute", id)
	end

	hook("join", id)
end
_addhook("join", "yates.hook.join")

function yates.hook.kill(killer, victim, weapon, x, y, objectid)
	hook("kill", killer, victim, weapon, x, y, objectid)
end
_addhook("kill", "yates.hook.kill")

function yates.hook.leave(id)
	yates.player[id] = {}

	hook("leave", id)
end
_addhook("leave", "yates.hook.leave")

function yates.hook.log(text)
    -- hook("log", text) @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX

    -- return filter("log", text) or 0 @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX
end
_addhook("log", "yates.hook.log")

function yates.hook.mapchange(map)
	hook("mapchange", map)
end
_addhook("mapchange", "yates.hook.mapchange")

function yates.hook.menu(id, title, button)
	hook("menu", id, title, button)
end
_addhook("menu", "yates.hook.menu")

function yates.hook.minute()
	hook("minute")
end
_addhook("minute", "yates.hook.minute")

function yates.hook.move(id, x, y, mode)
	hook("move", id, x, y, mode)
end
_addhook("move", "yates.hook.move")

function yates.hook.movetile(id, tilex, tiley)
	hook("movetile", id, tilex, tiley)
end
_addhook("movetile", "yates.hook.movetile")

function yates.hook.ms100()
	hook("ms100")
end
_addhook("ms100", "yates.hook.ms100")

function yates.hook.name(id, oldname, newname, forced)
	hook("name", id, oldname, newname, forced)

    return filter("name", id, oldname, newname, forced) or 0
end
_addhook("name", "yates.hook.name")

function yates.hook.objectdamage(objectid, damage, id)
	hook("objectdamage", objectid, damage, id)

    return filter("objectdamage", objectid, damage, id) or 0
end
_addhook("objectdamage", "yates.hook.objectdamage")

function yates.hook.objectkill(objectid, id)
	hook("objectkill", objectid, id)
end
_addhook("objectkill", "yates.hook.objectkill")

function yates.hook.objectupgrade(objectid, id, progress, total)
	hook("objectupgrade", objectid, id, progress, total)

    return filter("objectupgrade", objectid, id, progress, total) or 0
end
_addhook("objectupgrade", "yates.hook.objectupgrade")

function yates.hook.parse(text)
	local tbl = string.toTable(text)
	if not tbl[1] then
		return 0
	end
	local command = tbl[1]

	hook("parse", text)
	if yates.func.checkCommand(command, "console") then
		return 2
	end

    return filter("parse", text) or 0
end
_addhook("parse", "yates.hook.parse")

function yates.hook.projectile(id, weapon, x, y)
	hook("projectile", id, weapon, x, y)
end
_addhook("projectile", "yates.hook.projectile")

function yates.hook.radio(id, message)
	hook("radio", id, message)

    return filter("radio", id, message) or 0
end
_addhook("radio", "yates.hook.radio")

function yates.hook.rcon(cmds, id, ip, port)
	local tbl = string.toTable(cmds)

	if not tbl[1] then
		return 1
	end
	local command = tbl[1]

	if yates.func.checkCommand(command, "console") then
		yates.func.executeCommand(false, command, cmds, "console")
	end
	hook("rcon", cmds, id, ip, port)

    return filter("rcon", cmds, id, ip, port) or 0
end
_addhook("rcon", "yates.hook.rcon")

function yates.hook.reload(id, mode)
	hook("reload", id, mode)
end
_addhook("reload", "yates.hook.reload")

function yates.hook.say(id, text)
	local tbl = string.toTable(text)
	local usgn = player(id, "usgn")

	text = text:gsub("\166", "")
	text = text:gsub("|", "")

	if text:sub(1, #yates.setting.say_prefix) == yates.setting.say_prefix then
		local command = tbl[1]:sub(#yates.setting.say_prefix+1)

		if yates.func.checkCommand(command, "say") then
			if not yates.func.checkSayCommandUse(command) then
				msg2(id, lang("validation", 5, lang("global", 1)), "error")
				return 1
			end

			for k, v in pairs(_group[(_player[usgn] and _player[usgn].group or yates.setting.group_default)].commands) do
				if command == v or v == "all" then
					yates.func.executeCommand(id, command, text, "say")
					return 1
				end
			end
			if _player[usgn] and _player[usgn].commands then
				for k, v in pairs(_player[usgn].commands) do
					if command == v or v == "all" then
						yates.func.executeCommand(id, command, text, "say")
						return 1
					end
				end
			end
			msg2(id, lang("validation", 1, lang("global", 1)), "error")

		else
			msg2(id, lang("validation", 3, lang("global", 1)), "error")
			msg2(id, lang("help", 3, yates.setting.say_prefix), "info")
		end
	else
		if yates.setting.at_c == false then
			text = text:gsub("@C", yates.setting.at_c_replacement)
		end

		if yates.player[id].mute_time > 0 then
			msg2(id, lang("mute", 8, yates.player[id].mute_time), "error")
			msg2(id, lang("mute", 10, yates.player[id].mute_reason), "info")
			return 1
		end

		chat(id, text)
    end
    hook("say", id, text)

    return filter("say", id, text) or 1
end
_addhook("say", "yates.hook.say")

function yates.hook.sayteam(id, message)
	hook("sayteam", id, message)

    return filter("sayteam", id, message) or 0
end
_addhook("sayteam", "yates.hook.sayteam")

function yates.hook.second()
	for _, id in pairs(player(0, "table")) do
		if yates.player[id].mute_time > 0 then
			yates.player[id].mute_time = yates.player[id].mute_time - 1

			if _player[player(id, "usgn")] and _player[player(id, "usgn")].mute_time and _player[player(id, "usgn")].mute_time > 0 then
				_player[player(id, "usgn")].mute_time = _player[player(id, "usgn")].mute_time - 1

				if _player[player(id, "usgn")].mute_time == 0 then
					_player[player(id, "usgn")].mute_time = nil
				end

				saveData(_player, "data_player.lua")
			end

			if yates.player[id].mute_time == 0 then
				yates.player[id].mute_reason = ""
				msg2(id, "You are no longer muted", "info")

				if _player[player(id, "usgn")] and _player[player(id, "usgn")].mute_reason then
					_player[player(id, "usgn")].mute_reason = nil
					saveData(_player, "data_player.lua")
				end
			end
		end
	end
	hook("second")
end
_addhook("second", "yates.hook.second")

function yates.hook.select(id, type, mode)
	hook("select", id, type, mode)
end
_addhook("select", "yates.hook.select")

function yates.hook.serveraction(id, mode)
	hook("serveraction", id, mode)
end
_addhook("serveraction", "yates.hook.serveraction")

function yates.hook.shieldhit(id, source, weapon, direction, objectid)
	hook("shieldhit", id, source, weapon, direction, objectid)
end
_addhook("shieldhit", "yates.hook.shieldhit")

function yates.hook.shutdown()
	hook("shutdown")
end
_addhook("shutdown", "yates.hook.shutdown")

function yates.hook.spawn(id)
	hook("spawn", id)

    return filter("spawn", id) or 0
end
_addhook("spawn", "yates.hook.spawn")

function yates.hook.specswitch(id, target)
	hook("specswitch", id, target)
end
_addhook("specswitch", "yates.hook.specswitch")

function yates.hook.spray(id)
	hook("spray", id)
end
_addhook("spray", "yates.hook.spray")

function yates.hook.startround(mode)
	hook("startround", mode)
end
_addhook("startround", "yates.hook.startround")

function yates.hook.startround_prespawn(mode)
	hook("startround_prespawn", mode)
end
_addhook("startround_prespawn", "yates.hook.startround_prespawn")

function yates.hook.suicide(id)
	hook("suicide", id)

    return filter("suicide", id) or 0
end
_addhook("suicide", "yates.hook.suicide")

function yates.hook.team(id, team, look)
	hook("team", id, team, look)

    return filter("team", id, team, look) or 0
end
_addhook("team", "yates.hook.team")

function yates.hook.trigger(trigger, source)
	hook("trigger", trigger, source)

    return filter("trigger", trigger, source) or 0
end
_addhook("trigger", "yates.hook.trigger")

function yates.hook.triggerentity(tilex, tiley)
	hook("triggerentity", tilex, tiley)

    return filter("triggerentity", tilex, tiley) or 0
end
_addhook("triggerentity", "yates.hook.triggerentity")

function yates.hook.use(id, event, data, tilex, tiley)
	hook("use", id, event, data, tilex, tiley)
end
_addhook("use", "yates.hook.use")

function yates.hook.usebutton(id, tilex, tiley)
	hook("usebutton", id, tilex, tiley)
end
_addhook("usebutton", "yates.hook.usebutton")

function yates.hook.vipescape(id, tilex, tiley)
	hook("vipescape", id, tilex, tiley)
end
_addhook("vipescape", "yates.hook.vipescape")

function yates.hook.vote(id, mode, param)
	hook("vote", id, mode, param)
end
_addhook("vote", "yates.hook.vote")

function yates.hook.walkover(id, iid, type, ain, a, mode)
	hook("walkover", id, iid, type, ain, a, mode)

    return filter("walkover", id, iid, type, ain, a, mode) or 0
end
_addhook("walkover", "yates.hook.walkover")

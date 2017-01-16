-- yates_hooks.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.hook.always()
	action("always")
end
addhook("always", "yates.hook.always")

function yates.hook.attack(id)
	action("attack", id)
end
addhook("attack", "yates.hook.attack")

function yates.hook.attack2(id, mode)
	action("attack2", id, mode)
end
addhook("attack2", "yates.hook.attack2")

function yates.hook.bombdefuse(id)
	action("bombdefuse", id)

    return filter("bombdefuse", id) or 0
end
addhook("bombdefuse", "yates.hook.bombdefuse")

function yates.hook.bombexplode(id, tilex, tiley)
	action("bombexplode", id, tilex, tiley)

    return filter("bombexplode", id, tilex, tiley) or 0
end
addhook("bombexplode", "yates.hook.bombexplode")

function yates.hook.bombplant(id, tilex, tiley)
	action("bombplant", id, tilex, tiley)

    return filter("bombplant", id, tilex, tiley) or 0
end
addhook("bombplant", "yates.hook.bombplant")

function yates.hook.destroy(tilex, tiley, id) -- yates.hook.break
	action("destroy", tilex, tiley, id)
end
addhook("break", "yates.hook.destroy")

function yates.hook.build(id, type, tilex, tiley, mode, objectid)
	action("build", id, type, tilex, tiley, mode, objectid)

    return filter("build", id, type, tilex, tiley, mode, objectid) or 0
end
addhook("build", "yates.hook.build")

function yates.hook.buildattempt(id, type, tilex, tiley, mode)
	action("buildattempt", id, type, tilex, tiley, mode)

    return filter("buildattempt", id, type, tilex, tiley, mode) or 0
end
addhook("buildattempt", "yates.hook.buildattempt")

function yates.hook.buy(id, weapon)
	action("buy", id, weapon)

    return filter("buy", id, weapon) or 0
end
addhook("buy", "yates.hook.buy")

function yates.hook.clientdata(id, mode, data1, data2)
	action("clientdata", id, mode, data1, data2)
end
addhook("clientdata", "yates.hook.clientdata")

function yates.hook.collect(id, iid, type, ain, a, mode)
	action("collect", id, iid, type, ain, a, mode)
end
addhook("collect", "yates.hook.collect")

function yates.hook.die(victim, killer, weapon, x, y, objectid)
	action("die", victim, killer, weapon, x, y, objectid)

    return filter("die", victim, killer, weapon, x, y, objectid) or 0
end
addhook("die", "yates.hook.die")

function yates.hook.dominate(id, team, tilex, tiley)
	action("dominate", id, team, tilex, tiley)

    return filter("dominate", id, team, tilex, tiley) or 0
end
addhook("dominate", "yates.hook.dominate")

function yates.hook.drop(id, iid, type, ain, a, mode, tilex, tiley)
	action("drop", id, iid, type, ain, a, mode, tilex, tiley)

    return filter("drop", id, iid, type, ain, a, mode, tilex, tiley) or 0
end
addhook("drop", "yates.hook.drop")

function yates.hook.endround(mode)
	action("endround", mode)
end
addhook("endround", "yates.hook.endround")

function yates.hook.flagcapture(id, team, tilex, tiley)
	action("flagcapture", id, team, tilex, tiley)

    return filter("flagcapture", id, team, tilex, tiley) or 0
end
addhook("flagcapture", "yates.hook.flagcapture")

function yates.hook.flagtake(id, team, tilex, tiley)
	action("flagtake", id, team, tilex, tiley)

    return filter("flagtake", id, team, tilex, tiley) or 0
end
addhook("flagtake", "yates.hook.flagtake")

function yates.hook.flashlight(id, mode)
	action("flashlight", id, mode)
end
addhook("flashlight", "yates.hook.flashlight")

function yates.hook.hit(id, source, weapon, hpdmg, apdmg, rawdmg, object)
	if yates.player[id].god then
		return filter("hitGod", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 1
	end

	action("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object)

    return filter("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 0
end
addhook("hit", "yates.hook.hit")

function yates.hook.hitzone(imageid, id, objectid, weapon, x, y, damage)
	action("hitzone", imageid, id, objectid, weapon, x, y, damage)

    return filter("hitzone", imageid, id, objectid, weapon, x, y, damage) or 0
end
addhook("hitzone", "yates.hook.hitzone")

function yates.hook.hostagerescue(id, tilex, tiley)
	action("hostagerescue", id, tilex, tiley)
end
addhook("hostagerescue", "yates.hook.hostagerescue")

function yates.hook.join(id)
	yates.player[id] = {}
	yates.player[id].say = true -- Currently not in use
	yates.player[id].prefix = true -- Currently not in use
	yates.player[id].god = false
	yates.player[id].mute_time = 0
	yates.player[id].mute_reason = ""
	yates.player[id].tp = {}

	if _PLAYER[player(id, "usgn")] and _PLAYER[player(id, "usgn")].mute_time then
		yates.player[id].mute_time = _PLAYER[player(id, "usgn")].mute_time
		yates.player[id].mute_reason = _PLAYER[player(id, "usgn")].mute_reason

		yatesMessage(id, "Welcome back! You are still muted for "..yates.player[id].mute_time.." seconds.", "warning")
		action("joinMute", id)
	end

	action("join", id)
end
addhook("join", "yates.hook.join")

function yates.hook.kill(killer, victim, weapon, x, y, objectid)
	action("kill", killer, victim, weapon, x, y, objectid)
end
addhook("kill", "yates.hook.kill")

function yates.hook.leave(id)
	yates.player[id] = {}

	action("leave", id)
end
addhook("leave", "yates.hook.leave")

function yates.hook.log(text)
    -- action("log", text) @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX

    -- return filter("log", text) or 0 @TODO CURRENTLY BREAKS CS2D FOR NO REASON, WORKING ON A FIX
end
addhook("log", "yates.hook.log")

function yates.hook.mapchange(map)
	action("mapchange", map)
end
addhook("mapchange", "yates.hook.mapchange")

function yates.hook.menu(id, title, button)
	action("menu", id, title, button)
end
addhook("menu", "yates.hook.menu")

function yates.hook.minute()
	action("minute")
end
addhook("minute", "yates.hook.minute")

function yates.hook.move(id, x, y, mode)
	action("move", id, x, y, mode)
end
addhook("move", "yates.hook.move")

function yates.hook.movetile(id, tilex, tiley)
	action("movetile", id, tilex, tiley)
end
addhook("movetile", "yates.hook.movetile")

function yates.hook.ms100()
	action("ms100")
end
addhook("ms100", "yates.hook.ms100")

function yates.hook.name(id, oldname, newname, forced)
	action("name", id, oldname, newname, forced)

    return filter("name", id, oldname, newname, forced) or 0
end
addhook("name", "yates.hook.name")

function yates.hook.objectdamage(objectid, damage, id)
	action("objectdamage", objectid, damage, id)

    return filter("objectdamage", objectid, damage, id) or 0
end
addhook("objectdamage", "yates.hook.objectdamage")

function yates.hook.objectkill(objectid, id)
	action("objectkill", objectid, id)
end
addhook("objectkill", "yates.hook.objectkill")

function yates.hook.objectupgrade(objectid, id, progress, total)
	action("objectupgrade", objectid, id, progress, total)

    return filter("objectupgrade", objectid, id, progress, total) or 0
end
addhook("objectupgrade", "yates.hook.objectupgrade")

function yates.hook.parse(text)
	local tbl = toTable(text)
	if not tbl[1] then
		return 0
	end
	local command = tbl[1]

	action("parse", text)
	if checkCommand(command, "console") then
		return 2
	end

    return filter("parse", text) or 0
end
addhook("parse", "yates.hook.parse")

function yates.hook.projectile(id, weapon, x, y)
	action("projectile", id, weapon, x, y)
end
addhook("projectile", "yates.hook.projectile")

function yates.hook.radio(id, message)
	action("radio", id, message)

    return filter("radio", id, message) or 0
end
addhook("radio", "yates.hook.radio")

function yates.hook.rcon(cmds, id, ip, port)
	local tbl = toTable(cmds)

	if not tbl[1] then
		return 1
	end
	local command = tbl[1]

	if checkCommand(command, "console") then
		executeCommand(false, command, cmds, "console")
	end
	action("rcon", cmds, id, ip, port)

    return filter("rcon", cmds, id, ip, port) or 0
end
addhook("rcon", "yates.hook.rcon")

function yates.hook.reload(id, mode)
	action("reload", id, mode)
end
addhook("reload", "yates.hook.reload")

function yates.hook.say(id, text)
	local tbl = toTable(text)
	local usgn = player(id, "usgn")

	text = text:gsub("\166", "")

	if text:sub(1, #yates.setting.say_prefix) == yates.setting.say_prefix then
		local command = tbl[1]:sub(#yates.setting.say_prefix+1)

		if checkCommand(command, "say") then
			if not checkSayCommandUse(command) then
				yatesMessage(id, "This command has been disabled and cannot be used!", "warning")
				return 1
			end
			for k, v in pairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates.setting.group_default)].commands) do
				if command == v or v == "all" then
					executeCommand(id, command, text, "say")
					return 1
				end
			end
			if _PLAYER[usgn] and _PLAYER[usgn].commands then
				for k, v in pairs(_PLAYER[usgn].commands) do
					if command == v or v == "all" then
						executeCommand(id, command, text, "say")
						return 1
					end
				end
			end
			yatesMessage(id, "You don't have the permissions to use this command!", "warning")
		else
			yatesMessage(id, "This command doesn't exist!", "warning")
			yatesMessage(id, "Say "..yates.setting.say_prefix.."help to see the available commands.", "info")
		end
	else
		if yates.setting.at_c == false then
			text = text:gsub("@C", yates.setting.at_c_replacement)
		end

		if yates.player[id].mute_time > 0 then
			yatesMessage(id, "You are still muted for "..yates.player[id].mute_time.." seconds.", "warning")
			yatesMessage(id, "Reason: "..yates.player[id].mute_reason, "info")
			return 1
		end

		chat(id, text)
    end
    action("say", id, text)

    return filter("say", id, text) or 1
end
addhook("say", "yates.hook.say")

function yates.hook.sayteam(id, message)
	action("sayteam", id, message)

    return filter("sayteam", id, message) or 0
end
addhook("sayteam", "yates.hook.sayteam")

function yates.hook.second()
	for _, id in pairs(player(0, "table")) do
		if yates.player[id].mute_time > 0 then
			yates.player[id].mute_time = yates.player[id].mute_time - 1

			if _PLAYER[player(id, "usgn")] and _PLAYER[player(id, "usgn")].mute_time and _PLAYER[player(id, "usgn")].mute_time > 0 then
				_PLAYER[player(id, "usgn")].mute_time = _PLAYER[player(id, "usgn")].mute_time - 1

				if _PLAYER[player(id, "usgn")].mute_time == 0 then
					_PLAYER[player(id, "usgn")].mute_time = nil
				end

				saveData(_PLAYER, "data_player.lua")
			end

			if yates.player[id].mute_time == 0 then
				yates.player[id].mute_reason = ""
				yatesMessage(id, "You are no longer muted.", "info")

				if _PLAYER[player(id, "usgn")] and _PLAYER[player(id, "usgn")].mute_reason then
					_PLAYER[player(id, "usgn")].mute_reason = nil
					saveData(_PLAYER, "data_player.lua")
				end
			end
		end
	end
	action("second")
end
addhook("second", "yates.hook.second")

function yates.hook.select(id, type, mode)
	action("select", id, type, mode)
end
addhook("select", "yates.hook.select")

function yates.hook.serveraction(id, mode)
	action("serveraction", id, mode)
end
addhook("serveraction", "yates.hook.serveraction")

function yates.hook.shieldhit(id, source, weapon, direction, objectid)
	action("shieldhit", id, source, weapon, direction, objectid)
end
addhook("shieldhit", "yates.hook.shieldhit")

function yates.hook.shutdown()
	action("shutdown")
end
addhook("shutdown", "yates.hook.shutdown")

function yates.hook.spawn(id)
	action("spawn", id)

    return filter("spawn", id) or 0
end
addhook("spawn", "yates.hook.spawn")

function yates.hook.specswitch(id, target)
	action("specswitch", id, target)
end
addhook("specswitch", "yates.hook.specswitch")

function yates.hook.spray(id)
	action("spray", id)
end
addhook("spray", "yates.hook.spray")

function yates.hook.startround(mode)
	action("startround", mode)
end
addhook("startround", "yates.hook.startround")

function yates.hook.startround_prespawn(mode)
	action("startround_prespawn", mode)
end
addhook("startround_prespawn", "yates.hook.startround_prespawn")

function yates.hook.suicide(id)
	action("suicide", id)

    return filter("suicide", id) or 0
end
addhook("suicide", "yates.hook.suicide")

function yates.hook.team(id, team, look)
	action("team", id, team, look)

    return filter("team", id, team, look) or 0
end
addhook("team", "yates.hook.team")

function yates.hook.trigger(trigger, source)
	action("trigger", trigger, source)

    return filter("trigger", trigger, source) or 0
end
addhook("trigger", "yates.hook.trigger")

function yates.hook.triggerentity(tilex, tiley)
	action("triggerentity", tilex, tiley)

    return filter("triggerentity", tilex, tiley) or 0
end
addhook("triggerentity", "yates.hook.triggerentity")

function yates.hook.use(id, event, data, tilex, tiley)
	action("use", id, event, data, tilex, tiley)
end
addhook("use", "yates.hook.use")

function yates.hook.usebutton(id, tilex, tiley)
	action("usebutton", id, tilex, tiley)
end
addhook("usebutton", "yates.hook.usebutton")

function yates.hook.vipescape(id, tilex, tiley)
	action("vipescape", id, tilex, tiley)
end
addhook("vipescape", "yates.hook.vipescape")

function yates.hook.vote(id, mode, param)
	action("vote", id, mode, param)
end
addhook("vote", "yates.hook.vote")

function yates.hook.walkover(id, iid, type, ain, a, mode)
	action("walkover", id, iid, type, ain, a, mode)

    return filter("walkover", id, iid, type, ain, a, mode) or 0
end
addhook("walkover", "yates.hook.walkover")

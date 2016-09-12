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
end
addhook("bombdefuse", "yates.hook.bombdefuse")

function yates.hook.bombexplode(id, tilex, tiley)
	action("bombexplode", id, tilex, tiley)
end
addhook("bombexplode", "yates.hook.bombexplode")

function yates.hook.bombplant(id, tilex, tiley)
	action("bombplant", id, tilex, tiley)
end
addhook("bombplant", "yates.hook.bombplant")

function yates.hook.break(tilex, tiley, id)
	action("break", tilex, tiley, id)
end
addhook("break", "yates.hook.break")

function yates.hook.build(id, type, tilex, tiley, mode, objectid)
	action("build", id, type, tilex, tiley, mode, objectid)
end
addhook("build", "yates.hook.build")

function yates.hook.buildattempt(id, type, tilex, tiley, mode)
	action("buildattempt", id, type, tilex, tiley, mode)
end
addhook("buildattempt", "yates.hook.buildattempt")

function yates.hook.buy(id, weapon)
	action("buy", id, weapon)
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
end
addhook("die", "yates.hook.die")

function yates.hook.dominate(id, team, tilex, tiley)
	action("dominate", id, team, tilex, tiley)
end
addhook("dominate", "yates.hook.dominate")

function yates.hook.drop(id, iid, type, ain, a, mode, tilex, tiley)
	action("drop", id, iid, type, ain, a, mode, tilex, tiley)
end
addhook("drop", "yates.hook.drop")

function yates.hook.endround(mode)
	action("endround", mode)
end
addhook("endround", "yates.hook.endround")

function yates.hook.flagcapture(id, team, tilex, tiley)
	action("flagcapture", id, team, tilex, tiley)
end
addhook("flagcapture", "yates.hook.flagcapture")

function yates.hook.flagtake(id, team, tilex, tiley)
	action("flagtake", id, team, tilex, tiley)
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
end
addhook("hit", "yates.hook.hit")

function yates.hook.hitzone(imageid, id, objectid, weapon, x, y, damage)
	action("hitzone", imageid, id, objectid, weapon, x, y, damage)
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
	action("log", text)
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
end
addhook("name", "yates.hook.name")

function yates.hook.objectdamage(objectid, damage, id)
	action("objectdamage", objectid, damage, id)
end
addhook("objectdamage", "yates.hook.objectdamage")

function yates.hook.objectkill(objectid, id)
	action("objectkill", objectid, id)
end
addhook("objectkill", "yates.hook.objectkill")

function yates.hook.objectupgrade(objectid, id, progress, total)
	action("objectupgrade", objectid, id, progress, total)
end
addhook("objectupgrade", "yates.hook.objectupgrade")

function yates.hook.parse(text)
	action("parse", text)
end
addhook("parse", "yates.hook.parse")

function yates.hook.projectile(id, weapon, x, y)
	action("projectile", id, weapon, x, y)
end
addhook("projectile", "yates.hook.projectile")

function yates.hook.radio(id, message)
	action("radio", id, message)
end
addhook("radio", "yates.hook.radio")

function yates.hook.rcon(cmds, id, ip, port)
	action("rcon", cmds, id, ip, port)
end
addhook("rcon", "yates.hook.rcon")

function yates.hook.reload(id, mode)
	action("reload", id, mode)
end
addhook("reload", "yates.hook.reload")

function yates.hook.say(id, text)
	local tbl = toTable(text)
	local usgn = player(id, "usgn")

	if text:sub(1, #yates.setting.say_prefix) == yates.setting.say_prefix then
		local command = tbl[1]:sub(#yates.setting.say_prefix+1)

		if checkSayCommand(command) then
			if not checkSayCommandUse(command) then
				yatesMessage(id, "This command has been disabled and cannot be used!", "warning")
				return 1
			end
			for k, v in pairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates.setting.group_default)].commands) do
				if command == v or v == "all" then
					executeSayCommand(id, command, text)
					return 1
				end
			end
			if _PLAYER[usgn] and _PLAYER[usgn].commands then
				for k, v in pairs(_PLAYER[usgn].commands) do
					if command == v or v == "all" then
						executeSayCommand(id, command, text)
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

		action("say", id, text)
		chat(id, text)
	end
	return 1
end
addhook("say", "yates.hook.say")

function yates.hook.sayteam(id, message)
	action("sayteam", id, message)
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
end
addhook("suicide", "yates.hook.suicide")

function yates.hook.trigger(trigger, source)
	action("trigger", trigger, source)
end
addhook("trigger", "yates.hook.trigger")

function yates.hook.triggerentity(tilex, tiley)
	action("triggerentity", tilex, tiley)
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
end
addhook("walkover", "yates.hook.walkover")

-- yates_hooks.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

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

function yates.hook.leave(id)
	yates.player[id] = {}

	action("leave", id)
end
addhook("leave", "yates.hook.leave")

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
					executeSayCommand(id, command)
					return 1
				end
			end
			if _PLAYER[usgn] and _PLAYER[usgn].commands then
				for k, v in pairs(_PLAYER[usgn].commands) do
					if command == v or v == "all" then
						executeSayCommand(id, command)
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

function yates.hook.hit(id, source, weapon, hpdmg, apdmg, rawdmg, object)
	if yates.player[id].god then
		return filter("hitGod", id, source, weapon, hpdmg, apdmg, rawdmg, object) or 1
	end

	action("hit", id, source, weapon, hpdmg, apdmg, rawdmg, object)
end
addhook("hit", "yates.hook.hit")

function yates.hook.ms100()
	action("ms100")
end
addhook("ms100", "yates.hook.ms100")

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

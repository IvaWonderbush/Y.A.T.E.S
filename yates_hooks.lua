-- yates_hooks.lua --

function yates.hook.join(id)
	yates.player[id] = {}
	yates.player[id].say = 1
	yates.player[id].pre = 1
	yates.player[id].tp = {}
end
addhook("join", "yates.hook.join")

function yates.hook.leave(id)
	yates.player[id] = {}
end
addhook("leave", "yates.hook.leave")

function yates.hook.say(id, text)
	local tbl = toTable(text)
	local usgn = player(id, "usgn")

	if text:sub(1, #yates.setting.say_prefix) == yates.setting.say_prefix then
		local command = tbl[1]:sub(#yates.setting.say_prefix+1)

		if checkSayCommand(command) then
			for k, v in pairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates.setting.group_default)].commands) do
				if command == v or v == "all" then
					executeSayCommand(id, text, tbl)
					return 1
				end
			end
			if _PLAYER[usgn] and _PLAYER[usgn].commands then
				for k, v in pairs(_PLAYER[usgn].commands) do
					if command == v or v == "all" then
						executeSayCommand(id, text, tbl)
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
		chat(id, text)
	end
	return 1
end
addhook("say", "yates.hook.say")
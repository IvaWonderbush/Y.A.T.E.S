-- yates_hooks.lua --

function yates.join(id)
	Player[id] = {}
	Player[id].say = 1
	Player[id].pre = 1
	Player[id].tp = {}
end
addhook("join", "yates.join")

function yates.leave(id)
	Player[id] = {}
end
addhook("leave", "yates.leave")

function yates.say(id, text)
	local tbl = toTable(text)
	local usgn = player(id, "usgn")

	if text:sub(1, #yates_say_prefix) == yates_say_prefix then
		if checkSayCommand(tbl[1]:sub(#yates_say_prefix+1)) then
			for k, v in pairs(_GROUP[(_PLAYER[usgn] and _PLAYER[usgn].group or yates_group_default)].commands) do
				if tbl[1]:sub(#yates_say_prefix+1) == v or v == "all" then
					executeSayCommand(id, text, tbl)
					return 1
				end
			end
			if _PLAYER[usgn] and _PLAYER[usgn].commands then
				for k, v in pairs(_PLAYER[usgn].commands) do
					if tbl[1]:sub(#yates_say_prefix+1) == v or v == "all" then
						executeSayCommand(id, text, tbl)
						return 1
					end
				end
			end
			yatesMessage(id, "You don't have the permissions to use this command!", "warning")	
		else
			yatesMessage(id, "This command doesn't exist!", "warning")
		end
	else
		if yates_at_c == 1 then
			text = text:gsub("@C", yates_at_c_replacement)
		end
		chat(id, text)
	end
	return 1
end
addhook("say", "yates.say")
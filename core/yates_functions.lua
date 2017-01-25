-- yates_functions.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

--[[
	Turns chat input into output
	@return void
]]
function chat(id, text)
	local usgn = player(id, "usgn")
	local c = ""
	local p = ""

	if _PLAYER[usgn] and not yates.player[id].hide then
		c = (_PLAYER[usgn].colour or _GROUP[(_PLAYER[usgn].group or yates.setting.group_default)].colour)
		p = ((_PLAYER[usgn].prefix or _GROUP[(_PLAYER[usgn].group or yates.setting.group_default)].prefix) or "")
	else
		c = (_GROUP[yates.setting.group_default].colour or "")
		p = (_GROUP[yates.setting.group_default].prefix or "")
	end

	c = c:gsub("©","")
	c = c:gsub("\169","")
	c = "\169"..c

	c = filter("chatColour", id, text, c, p, usgn) or c
	p = filter("chatPrefix", id, text, c, p, usgn) or p
	text = filter("chatText", id, text, c, p, usgn) or text

	if p ~= "" then
		p = p.." "
	end

	msg(c..p..player(id, "name")..": "..clr["yates"]["chat"]..text)
end

--[[
	Sets the help of a say command
	@return void	
]]
function setSayHelp(func, info)
	if not info then info = "" end
	yates.say.help[func] = func.." "..info
end

--[[
	Sets the description of a say command
	@return void	
]]
function setSayDesc(func, desc)
	if not desc then desc = "" end
	yates.say.desc[func] = desc
end

--[[
	Sets the help of a say command
	@return void
]]
function setConsoleHelp(func, info)
	if not info then info = "" end
	yates.console.help[func] = func.." "..info
end

--[[
	Sets the description of a say command
	@return void
]]
function setConsoleDesc(func, desc)
	if not desc then desc = "" end
	yates.console.desc[func] = desc
end

--[[
	Simplifies values into a msg or msg2
	@return void	
]]
function yatesMessage(id, text, type, prefix)
	if not type then type = "default" end
	if not text then return 1 end -- This is so things don't go batshitmad

	local colour = type
	local pre = ""

	if clr["yates"][type] then
		colour = clr["yates"][type]
	end

	colour = colour:gsub("©","")
	colour = colour:gsub("\169","")
	colour = "\169"..colour

	if prefix == nil then
		pre = (yates.setting.message_prefix or prefix)
	else
		if prefix ~= false then
			pre = prefix
		end
	end

	local message = colour..pre..clr["yates"]["default"]..text

	if pre == "" then
		message = colour..text
	end

	if not id then
		msg(message)
	else
		msg2(id, message)
	end
end

--[[
	Simplifies values into a print or print2
	@return void	
]]
function yatesPrint(text, type, prefix)
	if not type then type = "default" end
	if not text then return 1 end -- This is so things don't go batshitmad

	local colour = type
	local pre = ""

	if clr["yates"][type] then
		colour = clr["yates"][type]
	end

	colour = colour:gsub("©","")
	colour = colour:gsub("\169","")
	colour = "\169"..colour

	if prefix == nil then
		pre = (yates.setting.message_prefix or prefix)
	else
		if prefix ~= false then
			pre = prefix
		end
	end

	local message = colour..pre..clr["yates"]["default"]..text

	if pre == "" then
		message = colour..text
	end

	print(message)
end

--[[
	Logs data
	@return void	
]]
function yatesLog(log, type, file, extension, mode, date)
	if not type then
		type = "INFO"
	end

	if not file or file == "" then
		file = "yates"
		if date == true then
			file = yates.setting.date
		end
	else
		if date == true then
			file = file.." - "..yates.setting.date
		end
	end

	if not extension then
		extension = ".log"
	end

	if not mode then
		mode = "a"
	end

	local file = io.open(_DIR.."storage/logs/"..file..extension, mode) or io.tmpfile()

	file:write("["..yates.setting.date.." - "..yates.setting.time.."]: "..type..": "..log.."\n")
	file:close()
end

--[[
	Executes the string's matching function name
	@return void	
]]
function executeCommand(id, command, text, mode)
	_tbl = toTable(text)
	_id = id
	_txt = text

	func = loadstring("yates.func."..mode.."."..command.."()")
	func()

	if yates.setting.log_commands then
		if id then
			yatesLog("[ID: "..id.."] [USGN: "..player(id, "usgn").."] [IP: "..player(id, "ip").."] [Team: "..player(id, "team").."] [Name: "..player(id, "name").."]: "..text)
		end
	end

	_tbl = {}
	_id = nil
	_txt = nil
end

--[[
	Sets a player's undo command
	@return void
]]
function setUndo(id, command)
	if not checkUsgn(id, false) then
		yatesMessage(id, "An undo command cannot be set as you are not logged in to a U.S.G.N account.", "alert")
		return false
	end

	if not _PLAYER[player(id, "usgn")] then
		_PLAYER[player(id, "usgn")] = {}
	end

	_PLAYER[player(id, "usgn")].undo = command
	saveData(_PLAYER, "data_player.lua")
end

--[[
	Checks whether a player exists or not
	@return boolean
]]
function checkPlayer(id, message)
	if message == nil then
		message = true
	end

	if not id or tonumber(id) == nil then
		if message then
			yatesMessage(_id, "You have not supplied a player id!", "warning")
		end
		return false
	end

	if not player(id, "exists") then
		if message then
			yatesMessage(_id, "This player does not exist!", "warning")
		end
		return false
	end

	return true
end

--[[
	Checks whether a player has a U.S.G.N. ID or not
	@return boolean
]]
function checkUsgn(id, message)
	if message == nil then
		message = true
	end

	if not checkPlayer(id, message) then
		return false
	end

	if player(id, "usgn") == 0 then
		if message then
			yatesMessage(_id, "This player does not have a U.S.G.N. ID!", "warning")
		end
		return false
	end

	return true
end

--[[
	Checks whether a group with a certain name exists or not
	@return boolean
]]
function checkGroup(group, message)
	if not message then
		message = false
	end

	if not _GROUP[group] then
		yatesMessage(_id, "This group does not exist!", "warning")
		return false
	end

	return true
end

--[[
	Compares two player/group levels
	@return boolean	
]]
function compareLevel(id, id2)
	local usgn = player(id, "usgn")
	local usgn2 = player(id2, "usgn")

	local lvl = _GROUP[yates.setting.group_default].level or 0
	local lvl2 = _GROUP[yates.setting.group_default].level or 0
	
	if _PLAYER[usgn] and _PLAYER[usgn].group then
		lvl = _GROUP[(_PLAYER[usgn].group or yates.setting.group_default)].level or 0
		if _PLAYER[usgn].level then
			lvl = _PLAYER[usgn].level
		end
	end

	if _PLAYER[usgn2] and _PLAYER[usgn2].group then
		lvl2 = _GROUP[(_PLAYER[usgn2].group or yates.setting.group_default)].level or 0
		if _PLAYER[usgn2].level then
			lvl2 = _PLAYER[usgn2].level
		end
	end

	if lvl >= lvl2 then
		return true
	end
	return false
end

--[[
	Reloads the script by reloading the map
	@return void
]]
function hardReload()
	parse("map "..game("sv_map"))
end

--[[
	Get player info
	@return
]]
function getPlayerInfo(usgn, key)
	local case

	if usgn == 0 or not _PLAYER[usgn] then
		return false
	end

	if _PLAYER[usgn][key] then
		case = 1
	elseif _PLAYER[usgn].group then
		if _GROUP[_PLAYER[usgn].group][key] then
			case = 2
		end
	end

	if case == 1 then
		return _PLAYER[usgn][key]
	elseif case == 2 then
		return _GROUP[_PLAYER[usgn].group][key]
	end

	return false
end

--[[
	Add new group
	@return boolean
]]
function addGroup(name, lvl, clr, cmds)
	_GROUP[name] = {}
	_GROUP[name].level = lvl
	_GROUP[name].colour = ""..clr..""
	_GROUP[name].commands = {cmds}
	saveData(_GROUP, "data_group.lua")
end

--[[
	Deletes a group
	@return void	
]]
function deleteGroup(old, new)
	for tk, tv in pairs(_PLAYER) do
		for pk, pv in pairs(_PLAYER[tk]) do
			if type(pv) ~= "table" then
    			if pk == "group" then
    				if pv == old then
    					_PLAYER[tk].group = new
					end
					break
				end
			end
		end
	end

	_GROUP[old] = nil
	saveData(_GROUP, "data_group.lua")
	saveData(_PLAYER, "data_player.lua")
end

--[[
	Edits group data
	@return void	
]]
function editGroup(group, field)
	local t = type(_GROUP[group][field])
	local v = ""

	if _tbl[5]:sub(1, 1) == "/" then
		_GROUP[group][field] = yates.constant[_tbl[5]:sub(2)]
	else
	    if t == "table" then
	    	for i = 1, #_GROUP[group][field] do
	    		if _GROUP[group][field][i] ~= "," then
		    		if v == "" then
						v = _GROUP[group][field][i]
					else
						v = v.." ".._GROUP[group][field][i]
					end
				end
			end

	    	for i = 5, #_tbl do
	    		if _tbl[i]:sub(1,1) == "-" then
					v = v:gsub(_tbl[i]:sub(2), "")
				else
		    		if v == "" then
						v = _tbl[i]
					else
						v = v.." ".._tbl[i]
					end
				end
			end
			_GROUP[group][field] = toTable(v)
		else
			for i = 5, #_tbl do
	    		if v == "" then
					v = _tbl[i]
				else
					v = v.." ".._tbl[i]
				end
			end
			_GROUP[group][field] = v
		end
	end
	saveData(_GROUP, "data_group.lua")
end

--[[
	Edits player data
	@return void
]]
function editPlayer(player, field)
	local t = type(_PLAYER[player][field])
	local v = ""

	if _tbl[5]:sub(1, 1) == "/" then
		_PLAYER[player][field] = yates.constant[_tbl[5]:sub(2)]
	else
	    if t == "table" then
	    	for i = 1, #_PLAYER[player][field] do
	    		if _PLAYER[player][field][i] ~= "," then
		    		if v == "" then
						v = _PLAYER[player][field][i]
					else
						v = v.." ".._PLAYER[player][field][i]
					end
				end
			end

	    	for i = 5, #_tbl do
	    		if _tbl[i]:sub(1,1) == "-" then
					v = v:gsub(_tbl[i]:sub(2), "")
				else
		    		if v == "" then
						v = _tbl[i]
					else
						v = v.." ".._tbl[i]
					end
				end
			end
			_PLAYER[player][field] = toTable(v)
		else
			for i = 5, #_tbl do
	    		if v == "" then
					v = _tbl[i]
				else
					v = v.." ".._tbl[i]
				end
			end
			_PLAYER[player][field] = v
		end
	end
	saveData(_PLAYER, "data_player.lua")
end

--[[
	Saves (table) data to file output as Lua
	@return void
]]
function saveData(data, file, overwrite) -- @TODO: Add overwrite, add or merge (push) functionality
	local file = io.open(_DIR.."data/"..file, "w+") or io.tmpfile()

	local text = table.getName(data).." = " .. table.valueToString(data) .. ""
	file:write(text)
	file:close()
end

--[[
	Checks if say command exists
	@return boolean
]]
function checkCommand(command, mode)
	local tmp = {}
	for k, v in pairs(yates.func[mode]) do
		tmp[k] = k
	end

	for cmds = 1, countIterate(yates.func[mode]) do
		if tmp[command] then
			if command == tmp[command] then
				return true
			end
		end
	end
	return false
end

function checkSayCommandUse(command)
	if not _YATES.disabled_commands then _YATES.disabled_commands = {} end
	if not command then
		yatesPrint("No command was provided to check if the use of it is allowed!", "warning")
		return true
	end

	for k, v in pairs(_YATES.disabled_commands) do
		if command == v then
			return false
		end
	end
	return true
end

--[[
	Creates a filter to be called in a function
	@return void
]]
function addFilter(name, func, priority)
    if not yates.filter[name] then yates.filter[name] = {} end
    if priority then table.insert(yates.filter[name], priority, func)
    else table.insert(yates.filter[name], func) end
end

--[[
	Calls a filter during a function to change the outcome
	@return void
]]
function filter(name, ...)
	if yates.filter[name] then
	    local f, l = table.bounds(yates.filter[name])
	    for i = f, l do
	        local func = yates.filter[name][i]
	        if (func) then return func(...) end
	    end
    end
end

--[[
	Creates an action to be called in a function
	@return void
]]
function addAction(name, func, priority)
    if not yates.action[name] then yates.action[name] = {} end
    if priority then table.insert(yates.action[name], priority, func)
    else table.insert(yates.action[name], func) end
end

--[[
	Calls an action after a certain function is called
	@return void
]]
function action(name, ...)
	if yates.action[name] then
	    local f, l = table.bounds(yates.action[name])
	    for i = f, l do
	        local func = yates.action[name][i]
	        if (func) then func(...) end
        end
    end
end

function yates.func.autoload()
	for item in io.enumdir(_DIR.."core/autoload") do
		local name, extension = item:match("([^/]+)%.([^%.]+)$")

		if name and extension == "lua" then
			dofile(_DIR.."core/autoload/"..name.."."..extension)
		end
	end
end

--[[
	Iterate array and count
	@return numeric
]]
function countIterate(arr)
	local amount = 0
	for k, v in pairs(arr) do
		if #k > 0 then
			amount = amount + 1
		end
	end
	return amount
end

--[[
	Turns a string into a table
	@return table	
]]
function toTable(str, mch)
	local tmp = {}
	if not mch then mch = "[^%s]+" else mch = "[^"..mch.."]+" end
	for wrd in string.gmatch(str, mch) do
		table.insert(tmp, wrd)
	end	
	return tmp
end

-- @TODO: Rename all functions below and clean them up, rest are fine.

function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

--[[
	Gets all directories in a certain path
	@return table
]]
function getDirectories(path)
	local content = {}
	
	for name in io.enumdir(path) do
		if name ~= "." and name ~= ".." then
			content[ #content + 1 ] = name
		end
	end
	
	return content
end

--[[
	Gets a user's group level
	@return integer
]]
function getPlayerGroupLevel(usgn)
	if _PLAYER[usgn] then
		if _PLAYER[usgn].group then
			if checkGroup(_PLAYER[usgn].group) then
				return _GROUP[_PLAYER[usgn].group].level
			end
		end
	end

	return false
end

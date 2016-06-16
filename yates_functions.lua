-- yates_functions.lua --

--[[
	Turns chat input into output
	@return void
]]
function chat(id, text) -- @TODO: Recreate a dynamic (yet not buggy) chat function
	local usgn = player(id,"usgn")
	local c = ""
	local p = ""

	if _PLAYER[usgn] and yates.player[id].say ~= 0 then
		c = (_PLAYER[usgn].colour or _GROUP[(_PLAYER[usgn].group or yates.setting.group_default)].colour)
		p = ((_PLAYER[usgn].prefix or _GROUP[(_PLAYER[usgn].group or yates.setting.group_default)].prefix) or "")
	else
		c = (_GROUP[yates.setting.group_default].colour or "")
		p = (_GROUP[yates.setting.group_default].prefix or "")
	end

	if yates.player[id].pre == 0 then
		p = ""
	end

	c = c:gsub("©","")
	c = c:gsub("\169","")
	c = "\169"..c

	c = addFilter("chatColour", c, p, usgn) or c

	if p ~= "" then
		p = p.." "
	end

	msg(c..p..player(id, "name")..": "..clr["yates"]["default"]..text)
end

--[[
	Sets the help of a say command
	@return void	
]]
function setSayHelp(func, info)
	if not info then info = "" end
	yates.say.help[func] = func.." "..info
	print(yates.say.help[func])
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
function yatesLog(log, file, extension, type, date)
	if not file or file == "" then
		file = "log"
		if date == true then
			file = yates.setting.date
		end
	else
		if date == true then
			file = file.."-"..yates.setting.date
		end
	end

	if not extension then
		extension = ".txt"
	end

	local file = io.open(_DIR.."/logs/"..file..extension, type) or io.tmpfile()

	file:write(yates.setting.date.." - "..yates.setting.time.."\n")
	file:write(log.."\n")
	file:close()
end

--[[
	Executes the string's matching function name
	@return void	
]]
function executeSayCommand(id, txt, tbl)
	_tbl = tbl
	_id = id
	_txt = txt
	func = loadstring("yates.func.say."..tbl[1]:sub(#yates.setting.say_prefix+1).."()")
	func()
	yatesLog("[ID: "..id.."] [USGN: "..player(id, "usgn").."] [IP: "..player(id, "ip").."] [Team: "..player(id, "team").."] [Name: "..player(id, "name").."]: "..txt, yates.setting.date, ".txt", "a")
	_tbl = {}
	_id = nil
	_txt = ""
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
	saveData(_PLAYER, "data_player.lua", true)
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
	Checks whether a player has a U.S.G.N ID or not
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
			yatesMessage(_id, "This player does not have a U.S.G.N ID!", "warning")
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
	if message == nil then
		message = true
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
	Reloads the script with dofile
	@return void
]]
function softReload()
	dofile(_DIR.."yates_startup.lua")
end

--[[
	Reloads the script by reloading the map
	@return void
]]
function hardReload()
	parse("map "..game("sv_map"))
end

--[[
	Checks if first authentication has been complete
	@return boolean
]]
function checkInitialAuth()
	if (_YATES.auth_token ~= false and _YATES.auth_token == true) then
		print(clr["yates"]["default"].."[Y.A.T.E.S]: Initial authentication U.S.G.N: ".._YATES.auth_usgn)
		return true
	end
	_YATES.auth_token = createToken(5)
	print(clr["yates"]["warning"].."[Y.A.T.E.S]: Initial authentication has not been complete.")
	print(clr["yates"]["warning"].."[Y.A.T.E.S]: Please say !auth ".._YATES.auth_token)
	return false
end

--[[
	Creates an authentication token
	@return string
]]
function createToken(length)
    local s = ""
    for i = 1, length do
    	if (math.random(0, 1) == 0) then
        	s = s .. string.char(math.random(97, 120))
    	else
    		s = s .. math.random(0, 9)
		end
    end
    return s
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
	saveData(_GROUP, "data_group.lua", true)
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
	saveData(_GROUP, "data_group.lua", true)
	saveData(_PLAYER, "data_player.lua", true)
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
	saveData(_GROUP, "data_group.lua", true)
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
	saveData(_PLAYER, "data_player.lua", true)
end

--[[
	Saves (table) data to file output as Lua
	@return void
]]
function saveData(data, file, overwrite)
	local file = io.open(_DIR.."data/"..file, "w+") or io.tmpfile()

	local text = getTableName(data).." = " .. table.val_to_str(data) .. ""
	file:write(text)
	file:close()
end

--[[
	Checks if say command exists
	@return boolean
]]
function checkSayCommand(text)
	local tmp = {}
	for k, v in pairs(yates.func.say) do
		tmp[k] = k
	end

	for cmds = 1, countIterate(yates.func.say) do
		if tmp[text] then
			if text == tmp[text] then
				return true
			end
		end
	end
	return false
end

--[[
	Returns the filter function outcome if any
	@return void
]]
function addFilter(funcName, ...)
	local arg = {...}
	if yates.filter[funcName] then
		return yates.filter[funcName](unpack(arg))
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
	for wrd in string.gmatch(str,mch) do
		table.insert(tmp, wrd)
	end	
	return tmp
end

--[[
	Gets the name of a table (not the key)
	@return string
]]
function getTableName(tbl)
	for k, v in pairs(_G) do
		if v == tbl then
			return k
		end
	end
	return false
end

--[[
	Extends a function
	@return void	
]]
function extend(func1, func2)
    if (not _HOOKS[func1]) then _HOOKS[func1] = {} end
    _HOOKS[func1][#_HOOKS[func1]+1] = func2
end

debug.sethook(function()
    local s = debug.getinfo(2)
    for k, v in pairs(_HOOKS) do
        if (s.func == k) then
            for _, f in pairs( v ) do f() end
        end
    end
end, "r")

--[[
	Loads all plugins on initial start
	@return void
]]
function loadPlugins()
	local directories = getDirectories(_DIR.."plugins")
	_PLUGIN["on"] = {}
	_PLUGIN["off"] = {}
	for _, all in pairs(directories) do
		if all:sub(1, 1) ~= "." then
	  		if all:sub(1, 1) ~= "_" then
	  			_PLUGIN["on"][#_PLUGIN["on"]+1] = all
	  			yatesPrint("Loading plugin "..all.."..", "success", "[PLUGIN]: ")
	  			yates.plugin[all] = {}
	  			dofileLua(_DIR.."plugins/"..all.."/startup.lua")
	  			cachePluginData()
			elseif all:sub(1, 1) == "_" then
				_PLUGIN["off"][#_PLUGIN["off"]+1] = all:sub(2)
			end
		end
	end
	yates.force_reload = false
end

--[[
	Saves or caches all the provided plugin information
	@return void
]]
function cachePluginData()
	for k, v in pairs(yates.plugin) do
		_PLUGIN["info"][k] = {}
		checkPluginData(k, "author", "string")
		checkPluginData(k, "usgn", "string")
		checkPluginData(k, "version", "string")
		checkPluginData(k, "description", "string")
		saveData(_PLUGIN, "data_plugin.lua", true)
	end
end

--[[
	Checks whether a plugin has provided certain information and saves them if it exists
	@return void
]]
function checkPluginData(name, data, varType)
	if yates.plugin[name] then
		if yates.plugin[name][data] and type(yates.plugin[name][data]) == varType then
			_PLUGIN["info"][name][data] = yates.plugin[name][data]
		else
			yatesPrint("Plugin information for "..data.." not set or is not a "..varType.."!", "alert", "[PLUGIN]: ")
		end
	end
end

--[[
	Dofiles a Lua file if it could be found or if it should be created if not found
	@return void
]]
function dofileLua(path, create)
	if not fileExists(path) then
		if create == true then
			yatesPrint("Uh-oh! The file '"..path.."' could not be found or opened, creating one for you instead!", "alert")
			file = io.open(path, "w")
			io.close(file)
		else
			yatesPrint("Uh-oh! The file '"..path.."' could not be found or opened!", "warning")
			return false
		end
	end
	dofile(path)
end

--[[
	Checks whether a force restart should occur once a plugin has been enabled
	@return void
]]
function checkForceReload()
	print("test")
	if yates.force_reload == true then
		yatesMessage(false, "A plugin has been enabled which requires a server restart, please stay!", "success")
		timer(5000, "parse", "lua hardReload()")
		yates.force_reload = false
	end
end

--[[
	Checks if a file exists or not with the given path
	@return boolean
]]
function fileExists(path)
	local file = io.open(path, "r")
	if file ~= nil then 
		io.close(file)
		return true 
	else 
		return false
	end
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

function table.val_to_str ( v )
	if "string" == type( v ) then
		v = string.gsub( v, "\n", "\\n" )
		if string.match( string.gsub(v, "[^'\"]", ""), '^"+$' ) then
			return "'" .. v .. "'"
		end
		return '"' .. string.gsub(v, '"', '\\"' ) .. '"'
	else
		return "table" == type( v ) and table.tostring( v ) or
			tostring( v )
	end
end

function table.tostring( tbl )
	local result, done = {}, {}
	for k, v in ipairs( tbl ) do
		if k ~= 'tmp' then
			table.insert( result, table.val_to_str( v ) )
			done[ k ] = true
		end
	end
	for k, v in pairs( tbl ) do
		if not done[ k ] then
			table.insert( result, 
				table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
		end
	end
	return "{" .. table.concat( result, ", " ) .. "}"
end

function table.key_to_str ( k )
	if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
		return k
	else
		return "[" .. table.val_to_str( k ) .. "]"
	end
end

--[[
	Gets all directories in a certain path
	@return table
]]
function getDirectories(path)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..path..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end
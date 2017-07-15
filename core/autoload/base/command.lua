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
	Executes the matching string function name
	@return void
]]
function yates.func.executeCommand(id, command, text, mode)
    _id = id
    _usgn = player(id, "usgn")
    _tbl = string.toTable(text)
    _txt = text

    func = loadstring("yates.func."..mode.."."..command.."()")
    func()

    if yates.setting.log_commands then
        if id then
            log("[ID: "..id.."] [USGN: "..player(id, "usgn").."] [IP: "..player(id, "ip").."] [Team: "..player(id, "team").."] [Name: "..player(id, "name").."]: "..text, false, "chat")
        end
    end

    _id = nil
    _usgn = nil
    _tbl = {}
    _txt = nil
end

--[[
	Checks if say command exists
	@return boolean
]]
function yates.func.checkCommand(command, mode)
    local tmp = {}
    for k, v in pairs(yates.func[mode]) do
        tmp[k] = k
    end

    for cmds = 1, table.countValues(yates.func[mode]) do
        if tmp[command] then
            if command == tmp[command] then
                return true
            end
        end
    end
    return false
end

function yates.func.checkSayCommandUse(command)
    if not _YATES.disabled_commands then
        _YATES.disabled_commands = {}
    end

    for k, v in pairs(_YATES.disabled_commands) do
        if command == v then
            return false
        end
    end
    return true
end

--[[
	Sets a player's undo command
	@return void
]]
function setUndo(id, command)
    if player(id, "usgn") == 0 then
        msg2(id, lang("undo", 4), "notice")
        return false
    end

    if not _PLAYER[player(id, "usgn")] then
        _PLAYER[player(id, "usgn")] = {}
    end

    _PLAYER[player(id, "usgn")].undo = command
    saveData(_PLAYER, "data_player.lua")
end
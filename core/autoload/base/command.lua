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
function executeCommand(id, command, text, mode)
    _tbl = string.toTable(text)
    _id = id
    _txt = text

    func = loadstring("yates.func."..mode.."."..command.."()")
    func()

    if yates.setting.log_commands then
        if id then
            log("[ID: "..id.."] [USGN: "..player(id, "usgn").."] [IP: "..player(id, "ip").."] [Team: "..player(id, "team").."] [Name: "..player(id, "name").."]: "..text)
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
        msg2(id, "An undo command cannot be set as you are not logged in to a U.S.G.N. account.", "notice")
        return false
    end

    if not _PLAYER[player(id, "usgn")] then
        _PLAYER[player(id, "usgn")] = {}
    end

    _PLAYER[player(id, "usgn")].undo = command
    saveData(_PLAYER, "data_player.lua")
end
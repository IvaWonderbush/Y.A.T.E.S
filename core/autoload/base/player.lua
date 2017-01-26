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
            _PLAYER[player][field] = string.toTable(v)
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
	Checks whether a player exists or not
	@return boolean
]]
function checkPlayer(id, message)
    if message == nil then
        message = true
    end

    if not id or tonumber(id) == nil then
        if message then
            msg2(_id, "You have not supplied a player id!", "error")
        end
        return false
    end

    if not player(id, "exists") then
        if message then
            msg2(_id, "This player does not exist!", "error")
        end
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
            msg2(_id, "This player does not have a U.S.G.N. ID!", "error")
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
        msg2(_id, "This group does not exist!", "error")
        return false
    end

    return true
end
--[[
	Get player info
	@return
]]
function getPlayerInfo(usgn, key)
    local case

    if usgn == 0 or not _player[usgn] then
        return false
    end

    if _player[usgn][key] then
        case = 1
    elseif _player[usgn].group then
        if _group[_player[usgn].group][key] then
            case = 2
        end
    end

    if case == 1 then
        return _player[usgn][key]
    elseif case == 2 then
        return _group[_player[usgn].group][key]
    end

    return false
end

--[[
	Edits player data
	@return void
]]
function editPlayer(player, field)
    local t = type(_player[player][field])
    local v = ""

    if _tbl[5]:sub(1, 1) == "/" then
        _player[player][field] = yates.constant[_tbl[5]:sub(2)]
    else
        if t == "table" then
            for i = 1, #_player[player][field] do
                if _player[player][field][i] ~= "," then
                    if v == "" then
                        v = _player[player][field][i]
                    else
                        v = v.." ".._player[player][field][i]
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
            _player[player][field] = string.toTable(v)
        else
            for i = 5, #_tbl do
                if v == "" then
                    v = _tbl[i]
                else
                    v = v.." ".._tbl[i]
                end
            end
            _player[player][field] = v
        end
    end
    saveData(_player, "data_player.lua")
end

--[[
	Compares two player/group levels
	@return boolean
]]
function yates.func.compareLevel(id, id2)
    local usgn = player(id, "usgn")
    local usgn2 = player(id2, "usgn")

    local lvl = _group[yates.setting.group_default].level or 0
    local lvl2 = _group[yates.setting.group_default].level or 0

    if _player[usgn] and _player[usgn].group then
        lvl = _group[(_player[usgn].group or yates.setting.group_default)].level or 0
        if _player[usgn].level then
            lvl = _player[usgn].level
        end
    end

    if _player[usgn2] and _player[usgn2].group then
        lvl2 = _group[(_player[usgn2].group or yates.setting.group_default)].level or 0
        if _player[usgn2].level then
            lvl2 = _player[usgn2].level
        end
    end

    if lvl >= lvl2 then
        return true
    end

    return false
end

--[[
	Checks whether a player exists or not
	@return boolean
]]
function yates.func.checkPlayer(id)
    if not id or tonumber(id) == nil then
        msg2(_id, "You have not supplied a player id!", "error") -- @TODO: lang
        return false
    end

    if not player(id, "exists") then
        msg2(_id, "This player does not exist!", "error") -- @TODO: lang
        return false
    end

    return true
end

--[[
	Checks whether a player has a U.S.G.N. ID or not
	@return boolean
]]
function yates.func.checkUsgn(id)
    if player(id, "usgn") == 0 then
        msg2(_id, "This player does not have a U.S.G.N. ID!", "error")
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

    if not _group[group] then
        msg2(_id, "This group does not exist!", "error")
        return false
    end

    return true
end
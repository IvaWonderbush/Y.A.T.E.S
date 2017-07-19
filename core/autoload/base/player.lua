--[[
	Get player info
	@return
]]
function yates.funcs.getPlayerInfo(usgn, key)
    local case

    if usgn == 0 or not _PLAYERS[usgn] then
        return false
    end

    if _PLAYERS[usgn][key] then
        case = 1
    elseif _PLAYERS[usgn].group then
        if _GROUPS[_PLAYERS[usgn].group][key] then
            case = 2
        end
    end

    if case == 1 then
        return _PLAYERS[usgn][key]
    elseif case == 2 then
        return _GROUPS[_PLAYERS[usgn].group][key]
    end

    return false
end

--[[
	Edits player data
	@return void
]]
function yates.funcs.editPlayer(usgn, field)
    local t = type(_PLAYERS[usgn][field])
    local v = ""

    if _words[5]:sub(1, 1) == "/" then
        _PLAYERS[usgn][field] = yates.settings.constants[_words[5]:sub(2)]
    else
        if t == "table" then
            for i = 1, #_PLAYERS[usgn][field] do
                if _PLAYERS[usgn][field][i] ~= "," then
                    if v == "" then
                        v = _PLAYERS[usgn][field][i]
                    else
                        v = v.." ".._PLAYERS[usgn][field][i]
                    end
                end
            end

            for i = 5, #_words do
                if _words[i]:sub(1, 1) == "-" then
                    v = v:gsub(_words[i]:sub(2), "")
                else
                    if v == "" then
                        v = _words[i]
                    else
                        v = v.." ".._words[i]
                    end
                end
            end
            _PLAYERS[usgn][field] = string.toTable(v)
        else
            for i = 5, #_words do
                if v == "" then
                    v = _words[i]
                else
                    v = v.." ".._words[i]
                end
            end
            _PLAYERS[usgn][field] = v
        end
    end

    saveData(_PLAYERS, "data_player.lua")
end

--[[
	Compares two player/group levels
	@return boolean
]]
function yates.funcs.compareLevel(id, id2, message)
    id = tonumber(id)
    id2 = tonumber(id2)

    if not message then
        message = true
    end

    local usgn = player(id, "usgn")
    local usgn2 = player(id2, "usgn")

    local lvl = _GROUPS[yates.settings.group_default].level or 0
    local lvl2 = _GROUPS[yates.settings.group_default].level or 0

    if _PLAYERS[usgn] and _PLAYERS[usgn].group then
        lvl = _GROUPS[(_PLAYERS[usgn].group or yates.settings.group_default)].level or 0
        if _PLAYERS[usgn].level then
            lvl = _PLAYERS[usgn].level
        end
    end

    if _PLAYERS[usgn2] and _PLAYERS[usgn2].group then
        lvl2 = _GROUPS[(_PLAYERS[usgn2].group or yates.settings.group_default)].level or 0
        if _PLAYERS[usgn2].level then
            lvl2 = _PLAYERS[usgn2].level
        end
    end

    if lvl >= lvl2 then
        return true
    end

    if message then
        msg2(_id, lang("validation", 2, lang("global", 2)), "error")
    end

    return false
end

--[[checkPlayer
	Checks whether a player exists or not
	@return boolean
]]
function yates.funcs.checkPlayer(id)
    id = tonumber(id)

    if not id or tonumber(id) == nil then
        msg2(_id, lang("validation", 8, lang("global", 3)), "error")
        return false
    end

    if not player(id, "exists") then
        msg2(_id, lang("validation", 3, lang("global", 2)), "error")
        return false
    end

    return true
end

--[[
	Checks whether a player has a U.S.G.N. ID or not
	@return boolean
]]
function yates.funcs.checkUsgn(id, message)
    id = tonumber(id)

    if not message then
        message = true
    end

    if player(id, "usgn") == 0 then
        if message then
            msg2(_id, lang("player", 7), "error")
        end

        return false
    end

    return true
end

--[[
	Checks whether a group with a certain name exists or not
	@return boolean
]]
function yates.funcs.checkGroup(group, message)
    if not message then
        message = true
    end

    if not _GROUPS[group] then
        if message then
            msg2(_id, lang("validation", 3, lang("global", 4)), "error")
        end

        return false
    end

    return true
end
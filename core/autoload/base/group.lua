--[[
	Add new group
	@return boolean
]]
function addGroup(name, lvl, clr, cmds)
    _GROUPS[name] = {}
    _GROUPS[name].level = lvl
    _GROUPS[name].colour = ""..clr..""
    _GROUPS[name].commands = cmds
    saveData(_GROUPS, "data_group.lua")
end

--[[
	Deletes a group
	@return void
]]
function deleteGroup(old, new)
    for tk, tv in pairs(_PLAYERS) do
        for pk, pv in pairs(_PLAYERS[tk]) do
            if type(pv) ~= "table" then
                if pk == "group" then
                    if pv == old then
                        _PLAYERS[tk].group = new
                    end
                    break
                end
            end
        end
    end

    _GROUPS[old] = nil
    saveData(_GROUPS, "data_group.lua")
    saveData(_PLAYERS, "data_player.lua")
end

--[[
	Edits group data
	@return void
]]
function editGroup(group, field)
    local t = type(_GROUPS[group][field])
    local v = ""

    if _words[5]:sub(1, 1) == "/" then
        _GROUPS[group][field] = yates.settings.constants[_words[5]:sub(2)]
    else
        if t == "table" then
            for i = 1, #_GROUPS[group][field] do
                if _GROUPS[group][field][i] ~= "," then
                    if v == "" then
                        v = _GROUPS[group][field][i]
                    else
                        v = v.." ".._GROUPS[group][field][i]
                    end
                end
            end

            for i = 5, #_words do
                if _words[i]:sub(1,1) == "-" then
                    v = v:gsub(_words[i]:sub(2), "")
                else
                    if v == "" then
                        v = _words[i]
                    else
                        v = v.." ".._words[i]
                    end
                end
            end
            _GROUPS[group][field] = string.toTable(v)
        else
            for i = 5, #_words do
                if v == "" then
                    v = _words[i]
                else
                    v = v.." ".._words[i]
                end
            end
            _GROUPS[group][field] = v
        end
    end

    saveData(_GROUPS, "data_group.lua")
end

--[[
	Gets a user's group level
	@return integer
]]
function getPlayerGroupLevel(usgn)
    if _PLAYERS[usgn] then
        if _PLAYERS[usgn].group then
            if yates.funcs.checkGroup(_PLAYERS[usgn].group) then
                return _GROUPS[_PLAYERS[usgn].group].level
            end
        end
    end

    return false
end
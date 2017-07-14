--[[
	Add new group
	@return boolean
]]
function addGroup(name, lvl, clr, cmds)
    _group[name] = {}
    _group[name].level = lvl
    _group[name].colour = ""..clr..""
    _group[name].commands = {cmds}
    saveData(_group, "data_group.lua")
end

--[[
	Deletes a group
	@return void
]]
function deleteGroup(old, new)
    for tk, tv in pairs(_player) do
        for pk, pv in pairs(_player[tk]) do
            if type(pv) ~= "table" then
                if pk == "group" then
                    if pv == old then
                        _player[tk].group = new
                    end
                    break
                end
            end
        end
    end

    _group[old] = nil
    saveData(_group, "data_group.lua")
    saveData(_player, "data_player.lua")
end

--[[
	Edits group data
	@return void
]]
function editGroup(group, field)
    local t = type(_group[group][field])
    local v = ""

    if _tbl[5]:sub(1, 1) == "/" then
        _group[group][field] = yates.constant[_tbl[5]:sub(2)]
    else
        if t == "table" then
            for i = 1, #_group[group][field] do
                if _group[group][field][i] ~= "," then
                    if v == "" then
                        v = _group[group][field][i]
                    else
                        v = v.." ".._group[group][field][i]
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
            _group[group][field] = string.toTable(v)
        else
            for i = 5, #_tbl do
                if v == "" then
                    v = _tbl[i]
                else
                    v = v.." ".._tbl[i]
                end
            end
            _group[group][field] = v
        end
    end
    saveData(_group, "data_group.lua")
end

--[[
	Gets a user's group level
	@return integer
]]
function getPlayerGroupLevel(usgn)
    if _player[usgn] then
        if _player[usgn].group then
            if checkGroup(_player[usgn].group) then
                return _group[_player[usgn].group].level
            end
        end
    end

    return false
end
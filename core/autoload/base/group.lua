--[[
	Add new group
	@return boolean
]]
function addGroup(name, lvl, clr, cmds)
    _GROUP[name] = {}
    _GROUP[name].level = lvl
    _GROUP[name].colour = ""..clr..""
    _GROUP[name].commands = cmds
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

    if _words[5]:sub(1, 1) == "/" then
        _GROUP[group][field] = yates.constant[_words[5]:sub(2)]
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
            _GROUP[group][field] = string.toTable(v)
        else
            for i = 5, #_words do
                if v == "" then
                    v = _words[i]
                else
                    v = v.." ".._words[i]
                end
            end
            _GROUP[group][field] = v
        end
    end
    saveData(_GROUP, "data_group.lua")
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
--[[
	Turns a string into a table
	@return table
]]
function string.toTable(str, mch)
    local tmp = {}
    if not mch then mch = "[^%s]+" else mch = "[^"..mch.."]+" end
    for wrd in string.gmatch(str, mch) do
        table.insert(tmp, wrd)
    end
    return tmp
end
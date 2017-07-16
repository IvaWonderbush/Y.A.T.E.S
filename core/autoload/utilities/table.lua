function table.toString(tbl, start, finish, delimiter)
    local t = {}

    if not start or start < 1 then
        start = 1
    end

    if not finish or finish > #tbl then
        finish = #tbl
    end

    if not delimiter then
        delimiter = " "
    end

    if start > 1 and finish == #tbl then
        for i = start, finish do
            t[#t+1] = tostring(tbl[i])
        end

        return table.concat(t, delimiter)
    end

    return table.concat(tbl, delimiter)
end

function table.valueToString(v)
    if "string" == type(v) then
        v = string.gsub(v, "\n", "\\n")
        if string.match(string.gsub(v, "[^'\"]", ""), '^"+$') then
            return "'"..v.."'"
        end

        return '"'..string.gsub(v, '"', '\\"')..'"'
    else
        return "table" == type(v) and table.toLuaString(v) or tostring(v)
    end
end

function table.toLuaString(tbl)
    local result = {}
    local done = {}

    for k, v in ipairs(tbl) do
        if k ~= "tmp" then
            table.insert(result, table.valueToString(v))
            done[k] = true
        end
    end

    for k, v in pairs(tbl) do
        if not done[k] then
            table.insert(result, table.keyToString(k).."="..table.valueToString(v))
        end
    end

    return "{"..table.concat(result, ", ").."}"
end

function table.keyToString(k)
    if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$") then
        return k
    else
        return "["..table.valueToString(k).."]"
    end
end

function table.removeDuplicate(tbl)
    local hash = {}
    local t = {}

    for _, v in ipairs(tbl) do
        if (not hash[v]) then
            t[#t+1] = v
            hash[v] = true
        end
    end

    return t
end

function table.fileToTable(file, tbl)
    if not tbl then
        return
    end

    local file = io.open(file, "r");

    for line in file:lines() do
        table.insert(tbl, line);
    end
end

function table.bounds(tbl)
    local f
    local l

    for k, v in pairs(tbl) do
        if (not f) then f = k end
        if (not l) then l = k end
        if (k > l) then l = k end
        if (k < f) then f = k end
    end

    return f, l
end

--[[
	Turns all string-number occurrences in a table to a number
	@return table
]]
function table.valuesToNumber(tbl)
    local t = {}

    for k, v in pairs(tbl) do
        if tonumber(v) then
            v = tonumber(v)
        end
        t[k] = v
    end

    return t
end

--[[
	Gets the name of a table (not the key)
	@return string
]]
function table.getName(tbl)
    for k, v in pairs(_G) do
        if v == tbl then
            return k
        end
    end

    return false
end

--[[
	Iterate table and count
	@return numeric
]]
function table.countValues(tbl)
    local amount = 0

    for k, v in pairs(tbl) do
        if #k > 0 then
            amount = amount + 1
        end
    end

    return amount
end

function spairs(tbl, order)
    local keys = {}

    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end

    if order then
        table.sort(keys, function(a, b) return order(tbl, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0

    return function()
        i = i + 1
        if keys[i] then
            return keys[i], tbl[keys[i]]
        end
    end
end
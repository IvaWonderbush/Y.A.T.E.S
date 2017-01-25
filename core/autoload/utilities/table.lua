function table.valueToString(v)
    if "string" == type(v) then
        v = string.gsub(v, "\n", "\\n")
        if string.match(string.gsub(v, "[^'\"]", ""), '^"+$') then
            return "'"..v.."'"
        end
        return '"'..string.gsub(v, '"', '\\"')..'"'
    else
        return "table" == type(v) and table.toString(v) or tostring(v)
    end
end

function table.toString(tbl)
    local result, done = {}, {}
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
    local res = {}

    for _, v in ipairs(tbl) do
        if (not hash[v]) then
            res[#res+1] = v -- you could print here instead of saving to result table if you wanted
            hash[v] = true
        end
    end

    return res
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
    local f, l
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
    local vals = {}
    for k, v in pairs(tbl) do
        if tonumber(v) then
            v = tonumber(v)
        end
        vals[k] = v
    end
    return vals
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
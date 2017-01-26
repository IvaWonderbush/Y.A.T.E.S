--[[
	Dofiles a Lua file if it could be found or if it should be created if not found
	@return void
]]
_dofile = dofile
function dofile(path, create)
    if not io.exists(path) then
        if create == true then
            print("Uh-oh! The file '"..path.."' could not be found or opened, creating one for you instead!", "notice")
            file = io.open(path, "w")
            io.close(file)
        else
            print("Uh-oh! The file '"..path.."' could not be found or opened!", "error")
            return false
        end
    end
    _dofile(path)
end

--[[
	Checks if a file exists or not with the given path
	@return boolean
]]
function io.exists(path)
    local file = io.open(path, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

--[[
	Gets all directories in a certain path
	@return table
]]
function io.getDirectories(path)
    local content = {}

    for name in io.enumdir(path) do
        if name ~= "." and name ~= ".." then
            content[#content + 1] = name
        end
    end

    return content
end

--[[
	Saves (table) data to file output as Lua
	@return void
]]
function saveData(data, file, overwrite) -- @TODO: Add overwrite, add or merge (push) functionality
    local file = io.open(_DIR.."data/"..file, "w+") or io.tmpfile()

    local text = table.getName(data).." = " .. table.valueToString(data) .. ""
    file:write(text)
    file:close()
end
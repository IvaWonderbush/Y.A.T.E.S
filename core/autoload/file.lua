--[[
	Dofiles a Lua file if it could be found or if it should be created if not found
	@return void
]]
_dofile = dofile
function dofile(path, create)
    if not io.exists(path) then
        if create == true then
            yatesPrint("Uh-oh! The file '"..path.."' could not be found or opened, creating one for you instead!", "alert")
            file = io.open(path, "w")
            io.close(file)
        else
            yatesPrint("Uh-oh! The file '"..path.."' could not be found or opened!", "warning")
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
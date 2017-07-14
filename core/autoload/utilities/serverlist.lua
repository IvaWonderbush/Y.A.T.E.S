--[[
	Adds a file to the server transfer list table which will eventually be added to the file servertransfer.lst
	@return boolean
]]
function addTransferFile(file, path)
    if not file then
        print("No file name was defined to add to the server transfer list", "error")
        return false
    end

    if not path then
        print("No file path was defined to use to add a file to the server transfer list", "error")
        return false
    end

    local _, count = string.gsub(file, "%.", "")
    if count < 1 then
        print("The file '"..path..file.."' cannot be added to the server transfer list as it does not have an extension!", "error")
        return false
    end
    if count > 1 then
        print("The file '"..path..file.."' cannot be added to the server transfer list as it contains more than one dot!", "error")
        return false
    end

    if not io.exists(path..file) then
        print("The file '"..path..file.."' cannot be added to the server transfer list as it does not exist!", "error")
        return false
    end

    table.insert(yates.transferlist, path..file)
    return true
end

--[[
	Adds all the files in yates.transferlist to the server transfer list
	@return boolean
]]
function yates.func.setTransferList(response)
    table.fileToTable("sys/servertransfer.lst", yates.transferlist)

    local file = io.open("sys/servertransfer.lst", "w+") or io.tmpfile()
    local count = 0

    yates.transferlist = table.removeDuplicate(yates.transferlist)

    for k, v in pairs(yates.transferlist) do
        local text = v.."\n"
        file:write(text)
        count = count + 1
        if response then
            print("The file '"..v.."' has been added to the server transfer list", "success")
        end
    end
    file:close()

    if count > 0 then
        print("The server transfer list has been updated. Please restart your server if necessary", "info")
    end
end
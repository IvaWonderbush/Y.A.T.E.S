--[[
	Simplifies values into a neat msg
	@return void
]]
_msg = msg
function msg(text, type, prefix)
    message = getMessage(text, type, prefix)

    _msg(message)
end

--[[
	Simplifies values into a neat msg2
	@return void
]]
_msg2 = msg2
function msg2(id, text, type, prefix)
    message = getMessage(text, type, prefix)

    _msg2(id, message)
end

--[[
	Simplifies values into a print or print2
	@return void
]]
_print = print
function print(text, type, prefix)
    message = getMessage(text, type, prefix)

    _print(message)
end

--[[
	Logs data
	@return void
]]
function log(log, type, file, extension, mode, date)
    if not type then
        type = "INFO"
    end

    if not file or file == "" then
        file = "yates"
        if date == true then
            file = yates.setting.date
        end
    else
        if date == true then
            file = file.." - "..yates.setting.date
        end
    end

    if not extension then
        extension = ".log"
    end

    if not mode then
        mode = "a"
    end

    local file = io.open(_DIR.."storage/logs/"..file..extension, mode) or io.tmpfile()

    file:write("["..yates.setting.date.." - "..yates.setting.time.."]: "..string.upper(type)..": "..log.."\n")
    file:close()
end

function getMessage(text, type, prefix)
    if not type then type = "default" end
    if not text then return 1 end -- This is so things don't go batshitmad

    local colour = type
    local pre = ""

    if clr["yates"][type] then
        colour = clr["yates"][type]
    end

    colour = colour:gsub("©","")
    colour = colour:gsub("\169","")
    colour = "\169"..colour

    if prefix == nil then
        pre = (yates.setting.message_prefix or prefix)
    else
        if prefix ~= false then
            pre = prefix
        end
    end

    local message = colour..pre..clr["yates"]["default"]..text

    if pre == "" then
        message = colour..text
    end

    return message
end
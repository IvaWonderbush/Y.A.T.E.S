function yates.func.getLanguageData()
    for item in io.enumdir(_DIR.."storage/lang") do
        local name, extension = item:match("([^/]+)%.([^%.]+)$")

        if name and extension == "txt" then
            local file = io.open(_DIR.."storage/lang/"..name..".txt")

            local currentlanguage = {}
            local currentsection = "default"
            local currentline = 1

            for line in file:lines() do
                if not currentlanguage[currentsection] then
                    currentlanguage[currentsection] = {}
                end

                if line ~= "" then
                    if line:sub(1, 1) == ":" then
                        currentsection = line:sub(2)
                        currentline = 1
                    else
                        currentlanguage[currentsection][currentline] = line
                        currentline = currentline + 1
                    end
                end
            end

            file:close()

            yates.language[name] = currentlanguage

            print(lang("info", 3, name), "success")
        end
    end
end

function lang(section, line, ...)
    local str = yates.language[yates.setting.language] and yates.language[yates.setting.language][section] and yates.language[yates.setting.language][section][line] or nil

    if str then
        for index, arg in ipairs({...}) do
            str = str:gsub("$" .. index, arg)
        end
    else
        str = lang("error", 1, yates.setting.language, section, line)
        log(lang("error", 1, yates.setting.language, section, line), "error", "debug")
    end

    return str
end
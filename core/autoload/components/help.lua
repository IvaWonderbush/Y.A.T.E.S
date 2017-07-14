function yates.func.help(id, command)

    if command then
        yates.func.displayCommandHelp(id, command)
    else
        yates.func.displayHelpList(id)
    end
end

function yates.func.displayCommandHelp(id, command)
    if yates.say.help[command] then
        msg2(id, lang("help", 4), "info")
        msg2(id, yates.setting.say_prefix..yates.say.help[command], "default", false)
        if yates.say.desc[command] then
            msg2(id, yates.say.desc[command], "default", false)
        end
        msg2(id, "", false, false)
        msg2(id, lang("help", 5), "info")
        msg2(id, lang("help", 6), "info")
    else
        msg2(id, lang("help", 7), "notice")
    end
end

function yates.func.displayHelpList(id)
    local everything = false
    local usgn = player(id, "usgn")

    if _player[usgn] and _player[usgn].commands then
        for k, v in spairs(_player[usgn].commands) do
            if v == "all" then
                everything = true
                break
            end
            msg2(id, yates.setting.say_prefix..v, "default", false)
        end
    end
    if everything ~= true then
        for k, v in spairs(_group[(_player[usgn] and _player[usgn].group or yates.setting.group_default)].commands) do
            if v == "all" then
                everything = true
                break
            end
            msg2(id, yates.setting.say_prefix..v, "default", false)
        end
    end
    if everything == true then
        for k, v in spairs(yates.func.say) do
            if #k > 0 then
                msg2(id, yates.setting.say_prefix..k, "default", false)
            end
        end
    end
    msg2(id, lang("help", 8, yates.setting.say_prefix), "info")
    msg2(id, lang("help", 9), "info")
end
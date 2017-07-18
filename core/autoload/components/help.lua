function yates.funcs.help(id, command)

    if command then
        yates.funcs.displayCommandHelp(id, command)
    else
        yates.funcs.displayHelpList(id)
    end
end

function yates.funcs.displayCommandHelp(id, command)
    if yates.say.help[command] then
        msg2(id, lang("help", 4), "info")
        msg2(id, yates.settings.say_prefix..yates.say.help[command], "default", false)
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

function yates.funcs.displayHelpList(id)
    local everything = false
    local usgn = player(id, "usgn")

    if _PLAYERS[usgn] and _PLAYERS[usgn].commands then
        for k, v in spairs(_PLAYERS[usgn].commands) do
            if v == "all" then
                everything = true
                break
            end
            msg2(id, yates.settings.say_prefix..v, "default", false)
        end
    end

    if everything ~= true then
        for k, v in spairs(_GROUPS[(_PLAYERS[usgn] and _PLAYERS[usgn].group or yates.settings.group_default)].commands) do
            if v == "all" then
                everything = true
                break
            end
            msg2(id, yates.settings.say_prefix..v, "default", false)
        end
    end

    if everything == true then
        for k, v in spairs(yates.funcs.say) do
            if #k > 0 then
                msg2(id, yates.settings.say_prefix..k, "default", false)
            end
        end
    end

    msg2(id, lang("help", 8, yates.settings.say_prefix), "info")
    msg2(id, lang("help", 9), "info")
    return true
end
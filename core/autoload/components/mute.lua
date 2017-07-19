function yates.funcs.mute(id, target, time, reason)
    if not target then
        msg2(id, lang("validation", 8, lang("global", 3)), "error")
        return false
    end

    if not player(target, "exists") then
        msg2(id, lang("validation", 3, lang("global", 2)), "error")
        return false
    end
    target = tonumber(target)

    if not yates.funcs.compareLevel(id, target) then
        return false
    end

    if not time then
        msg2(id, lang("mute", 3, yates.settings.mute_time_default), "info")
        time = yates.settings.mute_time_default
    else
        time = tonumber(time)

        if type(time) ~= "number" then
            msg2(id, lang("validation", 6, lang("global", 19), lang("type", 2)), "error")
            return false
        end

        if time > yates.settings.mute_time_max then
            msg2(id, lang("mute", 4, yates.settings.mute_time_max), "error")
            return false
        end

        if time < 1 then
            msg2(id, lang("mute", 5), "error")
            return false
        end
    end

    if not reason or reason == "" then
        reason = lang("mute", 9)
    end

    setUndo(id, "!unmute "..target)

    yates.funcs.setMute(target, time, reason)

    msg2(id, lang("mute", 6, player(target, "name")), "success")
    msg2(target, lang("mute", 7, yates.players[target].mute_time), "error")
    msg2(target, lang("mute", 10, yates.players[target].mute_reason), "info")

    return true
end

function yates.funcs.unmute(id, target)
    if not target then
        msg2(id, lang("validation", 8, lang("global", 3)), "error")
        return false
    end

    if not player(target, "exists") then
        msg2(id, lang("validation", 3, lang("global", 2)), "error")
        return false
    end
    target = tonumber(target)

    if not yates.funcs.compareLevel(id, target) then
        return false
    end

    if yates.funcs.setMute(target, 0, "") then
        setUndo(id, "!mute "..target.." "..yates.players[target].mute_time.." "..yates.players[target].mute_reason)

        msg2(id, lang("unmute", 3, player(target, "name")), "success")
        msg2(target, lang("unmute", 4), "info")

        return true
    end

    return false
end

function yates.funcs.setMute(id, time, reason)
    local usgn = player(id, "usgn")

    yates.players[id].mute_time = time
    yates.players[id].mute_reason = reason

    if yates.settings.mute_save then
        if usgn > 0 then
            if not _PLAYERS[usgn] then
                _PLAYERS[usgn] = {}
            end

            _PLAYERS[usgn].mute_time = time
            _PLAYERS[usgn].mute_reason = reason

            saveData(_PLAYERS, "data_player.lua")
        end
    end

    return true
end

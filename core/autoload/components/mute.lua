function yates.func.mute(id, target, time, reason)
    if not target then
        msg2(id, lang("validation", 6, lang("global", 3)), "error")
        return
    end

    if not player(target, "exists") then
        msg2(id, lang("validation", 3, lang("global", 2)), "error")
        return
    end
    target = tonumber(target)

    if not yates.func.compareLevel(id, target) then
        msg2(id, lang("validation", 2, lang("global", 2)), "error")
        return
    end

    if not time then
        msg2(id, lang("mute", 3, yates.setting.mute_time_default), "info")
        time = yates.setting.mute_time_default
    else
        time = tonumber(time)

        if time > yates.setting.mute_time_max then
            msg2(id, lang("mute", 4, yates.setting.mute_time_max), "error")
            return
        end

        if time < 1 then
            msg2(id, lang("mute", 5), "error")
            return
        end
    end

    if not reason or reason == "" then
        reason = lang("mute", 9)
    end

    setUndo(id, "!unmute "..target)

    yates.func.setMute(target, time, reason)

    msg2(id, lang("mute", 6, player(target, "name")), "success")
    msg2(target, lang("mute", 7, yates.player[target].mute_time), "error")
    msg2(target, lang("mute", 10, yates.player[target].mute_reason), "info")
end

function yates.func.unmute(id, target)
    if not target then
        msg2(id, lang("validation", 6, lang("global", 3)), "error")
        return
    end

    if not player(target, "exists") then
        msg2(id, lang("validation", 3, lang("global", 2)), "error")
        return
    end
    target = tonumber(target)

    if not yates.func.compareLevel(id, target) then
        msg2(id, lang("validation", 2, lang("global", 2)), "error")
        return
    end

    setUndo(id, "!mute "..target.." "..yates.player[target].mute_time.." "..yates.player[target].mute_reason)

    yates.func.setMute(target, 0, "")

    msg2(id, lang("unmute", 3, player(target, "name")), "success")
    msg2(target, lang("unmute", 4), "info")
end

function yates.func.setMute(id, time, reason)
    local usgn = player(id, "usgn")

    print(yates.player[id].mute_reason)

    yates.player[id].mute_time = time
    yates.player[id].mute_reason = reason

    if yates.setting.mute_save then
        if usgn > 0 then
            if not _PLAYER[usgn] then
                _PLAYER[usgn] = {}
            end

            _PLAYER[usgn].mute_time = time
            _PLAYER[usgn].mute_reason = reason

            saveData(_PLAYER, "data_player.lua")
        end
    end
end
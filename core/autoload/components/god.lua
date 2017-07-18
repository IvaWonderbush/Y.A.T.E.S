function yates.funcs.toggleGod(id)
    if yates.players[id].god then
        yates.players[id].god = false
        msg2(id, lang("god", 2), "success")
    else
        yates.players[id].god = true
        msg2(id, lang("god", 3), "success")
    end
    return true
end
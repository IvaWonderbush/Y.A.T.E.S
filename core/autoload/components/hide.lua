function yates.funcs.toggleHide(id)
    if yates.players[id].hide then
        yates.players[id].hide = false
        msg2(id, lang("hide", 2), "success")
    else
        yates.players[id].hide = true
        msg2(id, lang("hide", 3), "success")
    end
end
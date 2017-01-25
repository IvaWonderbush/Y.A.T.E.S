function yates.func.toggleHide(id)
    if yates.player[id].hide then
        yates.player[id].hide = false
        msg2(id, lang("hide", 2), "success")
    else
        yates.player[id].hide = true
        msg2(id, lang("hide", 3), "success")
    end
end
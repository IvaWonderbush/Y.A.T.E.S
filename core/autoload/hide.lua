function yates.func.toggleHide(id)
    if yates.player[id].hide then
        yates.player[id].hide = false
        yatesMessage(id, lang("hide", 2), "success")
    else
        yates.player[id].hide = true
        yatesMessage(id, lang("hide", 3), "success")
    end
end
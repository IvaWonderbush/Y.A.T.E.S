function yates.func.toggleGod(id)
    if yates.player[id].god then
        yates.player[id].god = false
        msg2(id, lang("god", 2), "success")
    else
        yates.player[id].god = true
        msg2(id, lang("god", 3), "success")
    end
end
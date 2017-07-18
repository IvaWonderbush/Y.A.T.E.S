function yates.funcs.ls(id, command)
    if not command or command == "" then
        msg2(id, lang("validation", 8, lang("global", 18)), "error")
        return false
    end
    yates.funcs.executeLua(command)

    msg2(id, lang("ls", 3), "success")
    return true
end

function yates.funcs.executeLua(command)
    func = loadstring(command)
    func()
end
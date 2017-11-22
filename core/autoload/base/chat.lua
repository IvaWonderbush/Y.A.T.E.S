--[[
	Turns chat input into output
	@return void
]]
function yates.funcs.chat(id, text)
    local usgn = player(id, "usgn")
    local c = ""
    local p = ""
    local s = ""

    if _PLAYERS[usgn] and not yates.players[id].hide then
        c = (_PLAYERS[usgn].colour or _GROUPS[(_PLAYERS[usgn].group or yates.settings.group_default)].colour)
        p = ((_PLAYERS[usgn].prefix or _GROUPS[(_PLAYERS[usgn].group or yates.settings.group_default)].prefix) or "")
    else
        c = (_GROUPS[yates.settings.group_default].colour or "")
        p = (_GROUPS[yates.settings.group_default].prefix or "")
    end

    c = c:gsub("©", "")
    c = c:gsub("\169", "")
    c = "\169"..c

    c = filter("chatColour", id, text, c, p, s, usgn) or c
    p = filter("chatPrefix", id, text, c, p, s, usgn) or p
    s = filter("chatSuffix", id, text, c, p, s, usgn) or s
    text = filter("chatText", id, text, c, p, s, usgn) or text

    if p ~= "" then
        p = p.." "
    end

    if s ~= "" then
        s = " "..s
    end

    msg(c..p..player(id, "name")..s..": ".._COLOURS["yates"]["chat"]..text, false, false)
end
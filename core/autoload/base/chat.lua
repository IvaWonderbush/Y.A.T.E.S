--[[
	Turns chat input into output
	@return void
]]
function chat(id, text)
    local usgn = player(id, "usgn")
    local c = ""
    local p = ""

    if _player[usgn] and not yates.player[id].hide then
        c = (_player[usgn].colour or _group[(_player[usgn].group or yates.setting.group_default)].colour)
        p = ((_player[usgn].prefix or _group[(_player[usgn].group or yates.setting.group_default)].prefix) or "")
    else
        c = (_group[yates.setting.group_default].colour or "")
        p = (_group[yates.setting.group_default].prefix or "")
    end

    c = c:gsub("©","")
    c = c:gsub("\169","")
    c = "\169"..c

    c = filter("chatColour", id, text, c, p, usgn) or c
    p = filter("chatPrefix", id, text, c, p, usgn) or p
    text = filter("chatText", id, text, c, p, usgn) or text

    if p ~= "" then
        p = p.." "
    end

    msg(c..p..player(id, "name")..": "..clr["yates"]["chat"]..text, false, false)
end
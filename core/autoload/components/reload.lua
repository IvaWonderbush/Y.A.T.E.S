--[[
	Reloads the script by reloading the map
	@return void
]]
function yates.funcs.reload()
    if not _words[2] then
        _words[2] = 0
    end

    timer(tonumber(_words[2]*1000), "parse", "map "..game("sv_map"))
    msg(lang("reload", 3), "success")
end
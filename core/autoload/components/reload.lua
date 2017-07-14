--[[
	Reloads the script by reloading the map
	@return void
]]
function yates.func.reload()
    if not _tbl[2] then
        _tbl[2] = 0
    end

    timer(tonumber(_tbl[2]*1000), "parse", "map "..game("sv_map"))
    msg(lang("reload", 3), "success")
end
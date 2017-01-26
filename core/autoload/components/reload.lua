--[[
	Reloads the script by reloading the map
	@return void
]]
function hardReload()
    parse("map "..game("sv_map"))
end
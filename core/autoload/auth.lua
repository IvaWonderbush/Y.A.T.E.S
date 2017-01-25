--[[
	Checks if first authentication has been complete
	@return boolean
]]
function yates.func.checkFirstUse()
    if not yates.setting.auth_usgn or yates.setting.auth_usgn == 0 then
        yatesPrint("Initial authentication has not been complete.", "warning")
        yatesPrint("Please add your U.S.G.N. ID to the yates.setting.auth_usgn variable in the yates_config.lua file.", "warning")
        return false
    end

    _PLAYER[yates.setting.auth_usgn].commands = {"all"}
    saveData(_PLAYER, "data_player.lua")

    yatesPrint("Initial authentication complete.", "success")
    yatesPrint("The U.S.G.N. ID "..yates.setting.auth_usgn.." has been given access to all commands.", "success")
    return true
end
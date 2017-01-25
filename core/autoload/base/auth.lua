--[[
	Checks if first authentication has been complete
	@return boolean
]]
function yates.func.checkFirstUse()
    if not yates.setting.auth_usgn or yates.setting.auth_usgn == 0 then
        print("Initial authentication has not been complete.", "error")
        print("Please add your U.S.G.N. ID to the yates.setting.auth_usgn variable in the yates_config.lua file.", "error")
        return false
    end

    _PLAYER[yates.setting.auth_usgn].commands = {"all"}
    saveData(_PLAYER, "data_player.lua")

    print("Initial authentication complete.", "success")
    print("The U.S.G.N. ID "..yates.setting.auth_usgn.." has been given access to all commands.", "success")
    return true
end
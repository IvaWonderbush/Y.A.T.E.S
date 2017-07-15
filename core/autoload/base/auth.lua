--[[
	Checks if first authentication has been complete
	@return boolean
]]
function yates.func.checkFirstUse()
    if not yates.setting.auth_usgn or yates.setting.auth_usgn == 0 then
        print(lang("auth", 1), "error")
        print(lang("auth", 2), "error")
        return false
    end

    _PLAYER[yates.setting.auth_usgn].commands = {"all"}
    saveData(_PLAYER, "data_player.lua")

    print(lang("auth", 3), "success")
    print(lang("auth", 4, yates.setting.auth_usgn), "success")
    return true
end
--[[
	Checks if first authentication has been complete
	@return boolean
]]
function yates.funcs.checkFirstUse()
    if not yates.settings.auth_usgn or yates.settings.auth_usgn == 0 then
        print(lang("auth", 1), "error")
        print(lang("auth", 2), "error")
        return false
    end

    _PLAYERS[yates.settings.auth_usgn] = {}
    _PLAYERS[yates.settings.auth_usgn].commands = {"all"}
    saveData(_PLAYERS, "data_player.lua")

    print(lang("auth", 3), "success")
    print(lang("auth", 4, yates.settings.auth_usgn), "success")
    return true
end

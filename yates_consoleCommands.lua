-- yates_consoleCommands.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more

	Want to add console commands?
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.func.console.help()
    if _tbl[2] then
        if yates.console.help[_tbl[2]] then
            yatesPrint("Usage:", "info")
            yatesPrint(yates.console.help[_tbl[2]], "default", false)
            if yates.console.desc[_tbl[2]] then
                yatesPrint(yates.console.desc[_tbl[2]], "default", false)
            end
            yatesPrint("", false, false)
            yatesPrint("A parameter is wrapped with < >, a parameter that is optional is wrapped with [ ].", "info")
            yatesPrint("Additional parameter elaboration is displayed behind a parameter wrapped with ( ).", "info")
        else
            yatesPrint("There is no help for this command!", "alert")
        end
    else
        for k, v in spairs(yates.func.console) do
            if #k > 0 then
                yatesPrint(k, "default", false)
            end
        end
        yatesPrint("For more information about a command, use help <command> in the console.", "info")
    end
end
setConsoleHelp("help", "[<cmd>]")
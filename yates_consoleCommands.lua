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
    for k, v in spairs(yates.func.console) do
        if #k > 0 then
            yatesPrint(k, "default", false)
        end
    end
end
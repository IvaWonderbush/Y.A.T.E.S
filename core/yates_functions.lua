-- yates_functions.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.func.autoload()
	dofile(_DIR.."core/autoload/utilities/file.lua")

	local directories = io.getDirectories(_DIR.."core/autoload/")
	for _, all in pairs(directories) do
		for item in io.enumdir(_DIR.."core/autoload/"..all) do
			local name, extension = item:match("([^/]+)%.([^%.]+)$")

			if name and name ~= "file" and extension == "lua" then
				dofile(_DIR.."core/autoload/"..all.."/"..name.."."..extension)
			end
		end
	end
end

--[[
	Saves (table) data to file output as Lua
	@return void
]]
function saveData(data, file, overwrite) -- @TODO: Add overwrite, add or merge (push) functionality
	local file = io.open(_DIR.."data/"..file, "w+") or io.tmpfile()

	local text = table.getName(data).." = " .. table.valueToString(data) .. ""
	file:write(text)
	file:close()
end
_addhook = addhook

--[[
	Creates a hook to be called in a function
	@return void
]]
function addhook(name, func, priority)
    if not yates.action[name] then
        yates.action[name] = {}
    end

    if priority then
        table.insert(yates.action[name], priority, func)
    else
        table.insert(yates.action[name], func)
    end
end

--[[
	Calls a hook after a certain function is called
	@return void
]]
function hook(name, ...)
    if yates.action[name] then
        local f, l = table.bounds(yates.action[name])
        for i = f, l do
            local func = loadstring("return "..yates.action[name][i])()
            if (func) then
                func(...)
            end
        end
    end
end
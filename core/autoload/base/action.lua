_addhook = addhook

--[[
	Creates a hook to be called in a function
	@return void
]]
function addhook(name, func, priority)
    if not yates.actions[name] then
        yates.actions[name] = {}
    end

    if priority then
        table.insert(yates.actions[name], priority, func)
    else
        table.insert(yates.actions[name], func)
    end
end

--[[
	Calls a hook after a certain function is called
	@return void
]]
function hook(name, ...)
    if yates.actions[name] then
        local f, l = table.bounds(yates.actions[name])
        for i = f, l do
            if (yates.actions[name][i]) then
                local func = loadstring("return "..yates.actions[name][i])()
                if (func) then
                    func(...)
                end
            end
        end
    end
end
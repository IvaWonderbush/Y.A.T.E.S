--[[
	Creates a filter to be called in a function
	@return void
]]
function addFilter(name, func, priority)
    if not yates.filter[name] then
        yates.filter[name] = {}
    end

    if priority then
        table.insert(yates.filter[name], priority, func)
    else
        table.insert(yates.filter[name], func)
    end
end

--[[
	Calls a filter during a function to change the outcome
	@return void
]]
function filter(name, ...)
    if yates.filter[name] then
        local f, l = table.bounds(yates.filter[name])
        for i = f, l do
            local func = loadstring("return "..yates.filter[name][i])()
            if (func) then
                return func(...)
            end
        end
    end
end
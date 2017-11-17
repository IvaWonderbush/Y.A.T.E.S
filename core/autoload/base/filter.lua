--[[
	Creates a filter to be called in a function
	@return void
]]
function addfilter(name, func, priority)
    if not yates.filters[name] then
        yates.filters[name] = {}
    end

    if priority then
        table.insert(yates.filters[name], priority, func)
    else
        table.insert(yates.filters[name], func)
    end
end

--[[
	Calls a filter during a function to change the outcome
	@return void
]]
function filter(name, ...)
    if yates.filters[name] then
        local f, l = table.bounds(yates.filters[name])
        for i = f, l do
            local func = loadstring("return "..yates.filters[name][i])()
            if (func) then
                func(...)
            end
        end
    end
end
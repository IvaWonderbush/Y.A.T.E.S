--[[
	Loads all plugins on initial start
	@return void
]]
function yates.func.loadPlugins()
    local directories = getDirectories(_DIR.."plugins")
    _PLUGIN["on"] = {}
    _PLUGIN["off"] = {}
    for _, all in pairs(directories) do
        if all:sub(1, 1) ~= "." then
            if all:sub(1, 1) ~= "_" then
                _PLUGIN["on"][#_PLUGIN["on"]+1] = all
                yatesPrint(lang("info", 5, all), "success")
                yates.plugin[all] = {}
                yates.plugin[all]["dir"] = _DIR.."plugins/"..all.."/"
                dofile(yates.plugin[all]["dir"].."/startup.lua")
                yates.func.cachePluginData()
            elseif all:sub(1, 1) == "_" then
                _PLUGIN["off"][#_PLUGIN["off"]+1] = all:sub(2)
            end
        end
    end
    yates.force_reload = false
end

--[[
	Saves or caches all the provided plugin information
	@return void
]]
function yates.func.cachePluginData()
    for k, v in pairs(yates.plugin) do
        _PLUGIN["info"][k] = {}
        yates.func.checkPluginData(k, "title", "string")
        yates.func.checkPluginData(k, "author", "string")
        yates.func.checkPluginData(k, "usgn", "string")
        yates.func.checkPluginData(k, "version", "string")
        yates.func.checkPluginData(k, "description", "string")
        saveData(_PLUGIN, "data_plugin.lua")
    end
end

--[[
	Checks whether a plugin has provided certain information and saves them if it exists
	@return void
]]
function yates.func.checkPluginData(name, data, varType)
    if yates.plugin[name] then
        if yates.plugin[name][data] and type(yates.plugin[name][data]) == varType then
            _PLUGIN["info"][name][data] = yates.plugin[name][data]
        else
            yatesPrint("Plugin information for "..data.." not set or is not a "..varType.."!", "alert", "[PLUGIN]: ")
        end
    end
end

--[[
	Checks whether a force restart should occur once a plugin has been enabled
	@return void
]]
function yates.func.checkForceReload()
    if yates.force_reload == true then
        yatesMessage(false, "A plugin has been enabled which requires a server restart, please stay!", "success")
        timer(5000, "parse", "lua hardReload()")
        yates.force_reload = false
    end
end
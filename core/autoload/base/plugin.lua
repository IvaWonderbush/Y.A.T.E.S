--[[
	Loads all plugins on initial start
	@return void
]]
function yates.funcs.loadPlugins()
    local directories = io.getDirectories(_DIR.."plugins")

    _PLUGINS["on"] = {}
    _PLUGINS["off"] = {}

    for _, all in pairs(directories) do
        if all:sub(1, 1) ~= "." then
            if all:sub(1, 1) ~= "_" then
                _PLUGINS["on"][#_PLUGINS["on"]+1] = all
                print(lang("info", 5, all), "success")
                yates.plugins[all] = {}
                yates.plugins[all]["dir"] = _DIR.."plugins/"..all.."/"
                dofile(yates.plugins[all]["dir"].."/startup.lua")
                yates.funcs.cachePluginData()
            elseif all:sub(1, 1) == "_" then
                _PLUGINS["off"][#_PLUGINS["off"]+1] = all:sub(2)
            end
        end
    end

    yates.force_reload = false
end

--[[
	Saves or caches all the provided plugin information
	@return void
]]
function yates.funcs.cachePluginData()
    for k, v in pairs(yates.plugins) do
        _PLUGINS["info"][k] = {}
        yates.funcs.checkPluginData(k, "title", "string")
        yates.funcs.checkPluginData(k, "author", "string")
        yates.funcs.checkPluginData(k, "usgn", "string")
        yates.funcs.checkPluginData(k, "version", "string")
        yates.funcs.checkPluginData(k, "description", "string")
        saveData(_PLUGINS, "data_plugin.lua")
    end
end

--[[
	Checks whether a plugin has provided certain information and saves them if it exists
	@return void
]]
function yates.funcs.checkPluginData(name, data, varType)
    if yates.plugins[name] then
        if yates.plugins[name][data] and type(yates.plugins[name][data]) == varType then
            _PLUGINS["info"][name][data] = yates.plugins[name][data]
        else
            print(lang("plugin", 3, data, varType), "notice", "[PLUGIN]: ")
        end
    end
end

--[[
	Checks whether a force restart should occur once a plugin has been enabled
	@return void
]]
function yates.funcs.checkForceReload()
    if yates.force_reload == true then
        timer(3000, "parse", "lua yates.funcs.reload()")
        yates.force_reload = false

        msg(lang("plugin", 4), "success")
    end
end
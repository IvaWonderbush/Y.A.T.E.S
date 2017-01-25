function yates.func.checkStatus()
    local checkstatus = io.popen("curl -Is http://www.thomasyates.nl | head -1")
    local status = checkstatus:read("*a")
    if status:match("HTTP/1.1 200 OK") then
        return true;
    else
        return false;
    end
    status:close()
end

function yates.func.checkVersion()
    if not yates.setting.check_version then
        yatesPrint("Version check is disabled. Please enable this to stay up-to-date in yates_config.lua", "warning")
        return
    end
    if not yates.func.checkStatus() then
        yatesPrint("No connection status could be made with http://www.thomasyates.nl/", "warning")
        return
    end

    handle = io.popen("curl http://www.thomasyates.nl/docs/version.html")
    local git_version = tostring(handle:read("*a"))
    local local_version = tostring(yates.version)
    handle:close()

    git_version = git_version:gsub("%.", "")
    local_version = local_version:gsub("%.", "")

    if git_version > local_version then
        yatesPrint("You are not up-to-date with the current version!", "warning")
        yatesPrint("Please download the current version at http://www.thomasyates.nl/docs", "warning")
    elseif git_version < local_version then
        yatesPrint("You are running on a higher version of the current release. Huh? I don't even..", "alert")
    else
        yatesPrint("You are up-to-date with the current version!", "success")
    end
end
function yates.func.checkStatus()
    local checkstatus = io.popen("curl -Is "..yates.setting.domain.." | head -1")
    local status = checkstatus:read("*a")
    if status:match("HTTP/2 200") then
        return true;
    else
        return false;
    end
    status:close()
end

function yates.func.checkVersion()
    if not yates.setting.check_version then
        print(lang("version", 1), "error")
        return
    end
    if not yates.func.checkStatus() then
        print(lang("version", 2, yates.setting.domain), "error")
        return
    end

    handle = io.popen("curl "..yates.setting.domainVersion)
    local git_version = tostring(handle:read("*a"))
    local local_version = tostring(yates.version)
    handle:close()

    git_version = git_version:gsub("%.", "")
    local_version = local_version:gsub("%.", "")

    if git_version > local_version then
        print(lang("version", 3), "error")
        print(lang("version", 4, yates.setting.domainDownload), "error")
    elseif git_version < local_version then
        print(lang("version", 5), "notice")
    else
        print(lang("version", 6), "success")
    end
end
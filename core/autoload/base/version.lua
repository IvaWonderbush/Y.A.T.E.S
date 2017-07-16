function yates.funcs.checkStatus()
    local checkstatus = io.popen("curl -Is "..yates.settings.domain.." | head -1")
    local status = checkstatus:read("*a")

    if status:match("HTTP/2 200") then
        return true;
    else
        return false;
    end
    status:close()

    return false;
end

function yates.funcs.checkVersion()
    if not yates.settings.check_version then
        print(lang("version", 1), "error")
        return
    end

    if not yates.funcs.checkStatus() then
        print(lang("version", 2, yates.settings.domain), "error")
        return
    end

    handle = io.popen("curl "..yates.settings.domain_version)
    local git_version = tostring(handle:read("*a"))
    local local_version = tostring(yates.version)
    handle:close()

    git_version = git_version:gsub("%.", "")
    local_version = local_version:gsub("%.", "")

    if git_version > local_version then
        print(lang("version", 3), "error")
        print(lang("version", 4, yates.settings.domain_download), "error")
    elseif git_version < local_version then
        print(lang("version", 5), "notice")
    else
        print(lang("version", 6), "success")
    end
end
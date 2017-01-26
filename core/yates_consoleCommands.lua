-- yates_consoleCommands.lua --

--[[
	WARNING:
	Do not touch anything in this file. This file is part of the Y.A.T.E.S core.
	Anything you wish to change can be done using plugins! Many useful actions and filters have been added
	so you can even change function outcomes from outside of the core.
	Check (@TODO add url) to learn more

	Want to add console commands?
	Check (@TODO add url) to learn more
	BE WARNED.
]]--

function yates.func.console.help()
    if _tbl[2] then
        if yates.console.help[_tbl[2]] then
            print("Usage:", "info")
            print(yates.console.help[_tbl[2]], "default", false)
            if yates.console.desc[_tbl[2]] then
                print(yates.console.desc[_tbl[2]], "default", false)
            end
            print("", false, false)
            print("A parameter is wrapped with < >, a parameter that is optional is wrapped with [ ].", "info")
            print("Additional parameter elaboration is displayed behind a parameter wrapped with ( ).", "info")
        else
            print("There is no help for this command!", "notice")
        end
    else
        for k, v in spairs(yates.func.console) do
            if #k > 0 then
                print(k, "default", false)
            end
        end
        print("For more information about a command, use help <command> in the console.", "info")
    end
end
setConsoleHelp("help", "[<cmd>]")

function yates.func.console.reload()
    yates.func.reload()
end
setConsoleHelp("reload", lang("reload", 1))
setConsoleDesc("reload", lang("reload", 2))

function yates.func.console.player()
    if not _tbl[2] then
        print("You have not provided a sub-command, use help player for a list of sub-commands.", "error")
        return 1
    end

    if _tbl[2] == "list" then
        print("List of U.S.G.N.'s saved in data_player. Use player info <U.S.G.N.> for more info.", "info")
        for k, v in pairs(_PLAYER) do
            print(k, false, false)
        end
    elseif _tbl[2] == "info" then

        if not _tbl[3] then
            print("You need to supply a player (U.S.G.N.) ID you wish to view the information of!", "error")
            return 1
        end
        _tbl[3] = tonumber(_tbl[3])

        if _PLAYER[_tbl[3]] then
            if _tbl[4] then
                print("Developer player information.", "info")
                local info = table.valueToString(_PLAYER[_tbl[3]])
                info = info:gsub("©","")
                info = info:gsub("\169","")

                print("_PLAYER[\"".._tbl[3].."\"] = "..info, "default", false)
            else
                msg2(_id,"Player data information.","info")
                for k, v in pairs(_PLAYER[_tbl[3]]) do
                    if type(v) ~= "table" then
                        v = tostring(v)
                        v = v:gsub("©","")
                        v = v:gsub("\169","")
                    end
                    print(k.." = "..table.valueToString(v), "default", false)
                end
            end
            return 1
        end
        print("This player data does not exist!", "error")
        return 1

    elseif _tbl[2] == "edit" then
        if not _tbl[3] then
            print("You need to supply a U.S.G.N. ID for the player data you want to edit.", "error")
            return 1
        end
        _tbl[3] = tonumber(_tbl[3])

        if not _PLAYER[_tbl[3]] then
            _PLAYER[_tbl[3]] = {}
        end

        if _PLAYER[_tbl[3]] then
            if not _tbl[4] then
                print("You need to supply the field you want to edit.", "error")
                return 1
            end

            if not _tbl[5] then
                print("You need to supply a new variable for the field.", "error")
                return 1
            end

            editPlayer(_tbl[3], _tbl[4])
            print("The player ".._tbl[3].." has been edited!", "success")
            return 1
        end
        print("This player data does not exist!", "error")
    end
end
setConsoleHelp("player", "list / info <id> / edit <U.S.G.N.> <field> <new entry>")
setConsoleDesc("player", "A general command used to display information about players and edit their data.")

function yates.func.console.group()
    if not _tbl[2] then
        print("You have not provided a sub-command, say "..yates.setting.say_prefix.."help group for a list of sub-commands.", "error")
        return 1
    end

    if _tbl[2] == "list" then
        print("List of current groups, with their colour, prefix, name and level.", "info")
        for k, v in pairs(_GROUP) do
            print(k.." ".._GROUP[k].level.." "..(_GROUP[k].prefix or ""), _GROUP[k].colour, false)
        end
    elseif _tbl[2] == "info" then
        if not _tbl[3] then
            print("You need to supply a group name you wish to view the information of!", "error")
            return 1
        end

        if _GROUP[_tbl[3]] then
            if _tbl[4] then
                print("Developer group information.", "info")
                local info = table.valueToString(_GROUP[_tbl[3]])
                info = info:gsub("©", "")
                info = info:gsub("\169", "")

                print("_GROUP[\"".._tbl[3].."\"] = "..info, "default", false)
                return 1
            end

            print("List of group fields and their values.", "info")
            for k, v in pairs(_GROUP[_tbl[3]]) do
                if type(v) ~= "table" then
                    v = tostring(v)
                    v = v:gsub("©", "")
                    v = v:gsub("\169", "")
                end
                print(k.." = "..table.valueToString(v), "default", false)
            end
            return 1
        end
        print("This group does not exist!", "error")
    elseif _tbl[2] == "add" then
        if not _tbl[3] then
            print("You need to supply a name for the group!", "error")
            return 1
        end

        if not _GROUP[_tbl[3]] then
            local cmds = ""

            if not _tbl[4] then
                _tbl[4] = (yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)
                print("You did not enter a group level, the default level will be used instead: "..(yates.setting.group_default_level or _GROUP[yates.setting.group_default].level)..".", "notice")
            end
            if not _tbl[5] then
                _tbl[5] = (yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour)
                print("You did not enter a group colour, the default color will be used instead: "..(yates.setting.group_default_colour or _GROUP[yates.setting.group_default].colour).."Lorem Ipsum.", "notice")
            else
                _tbl[5] = "\169".._tbl[5]
            end
            if not _tbl[6] then
                _tbl[6] = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                print("You did not enter any group commands, the following default commands will be used instead:", "notice")
                local tbl = (yates.setting.group_default_commands or _GROUP[yates.setting.group_default].commands)
                for i = 1, #tbl do
                    if cmds == "" then
                        cmds = tbl[i]
                    else
                        cmds = cmds..", "..tbl[i]
                    end
                end
                print(cmds, "default", false)
            else
                for i = 6, #_tbl do
                    if cmds == "" then
                        cmds = _tbl[i]
                    else
                        cmds = cmds..", ".._tbl[i]
                    end
                end
            end
            setUndo(_id, "!group del ".._tbl[3])
            addGroup(_tbl[3], _tbl[4], _tbl[5], cmds)
            print("The group ".._tbl[3].." has been added!", "success")
            return 1
        end
        print("This group already exists!", "error")
    elseif _tbl[2] == "del" or _tbl[2] == "delete" then
        if not _tbl[3] then
            print("You need to supply the group name you want to delete.", "error")
            return 1
        end

        if _GROUP[_tbl[3]] then
            if not _tbl[4] then
                print("You did not enter a new group, the default group will be used instead: "..yates.setting.group_default..".", "notice")
                _tbl[4] = yates.setting.group_default
            end

            if not _GROUP[_tbl[4]] then
                print("The new group for the players in the old group does not exist!", "error")
                return 1
            end

            deleteGroup(_tbl[3], _tbl[4])
            print("The group ".._tbl[3].." has been deleted!", "success")
            return 1
        end
        print("This group does not exist!", "error")
    elseif _tbl[2] == "edit" then
        if not _tbl[3] then
            print("You need to supply a name for the group you are going to edit.", "error")
            return 1
        end

        if _GROUP[_tbl[3]] then
            if not _tbl[4] then
                print("You need to supply the field you want to edit.", "error")
                return 1
            end

            if not _tbl[5] then
                print("You need to supply a new variable for the field.", "error")
                return 1
            end

            editGroup(_tbl[3], _tbl[4])
            print("The group ".._tbl[3].." has been edited!", "success")
            return 1
        end
        print("This group does not exist!", "error")
    end
end
setConsoleHelp("group", "list / info <group> / add <group> [<level>] [<colour>] [<commands>] / del(ete) <group> [<new group>] / edit <group> <field> <new entry>")
setConsoleDesc("group", "A general command used to display information about groups and edit them.")
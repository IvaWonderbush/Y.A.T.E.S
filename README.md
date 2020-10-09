# Your Administration Tool for Every Server

[Y.A.T.E.S](http://www.thomasyates.nl/docs) is a Lua administration tool created for the game Counter-Strike 2D. It focuses mainly on the task to help server owners to administrate their server, it also provides every source to build upon without (hopefully) breaking it. The most important thing that makes Y.A.T.E.S stand out is the fact that every player or group data can be modified in-game and each player or group may also be given individual rights dynamically. Another important feature is the ability to create plugins and have them work together without changing anything. Simply drop them into the plugins folder and you're done!

# How to install:
1. Download one of the release .zip archives from the release page
2. Extract the contents of the .zip archive into your lua folder
3. Rename the release folder to `yates` as that will make things easier for you
4. Remove everything in the server.lua file and put in the following: `dofile("sys/lua/yates/core/yates_startup.lua")`
5. Optional: Extract the contents from `EXTRACTMEPLEASE.zip` into your `gfx` folder if you want the emoticons to work.

## Features:

- Plugins
- Dynamic group system
- Developer friendly hooks, actions and more!
- Built in commands
- Language files for translations
- Sturdy framework if I may say so myself

### Commands:
- `!help [<cmd>]`
- `!pm <id> <message>`
- `!ls <cmd>`
- `!plugin list / menu / <info/enable/disable> <plugin>`
- `!command list / <enable/disable> <command>`
- `!softreload [<delay>] (in seconds)`
- `!hardreload [<delay>] (in seconds)`
- `!god`
- `!mute <id> [<duration>] (default 60 seconds) [<reason>]`
- `!unmute <id>`
- `!kick <id> [<reason>]`
- `!ban <id> [<duration>] (0 for infinite, -1 for server setting) [<reason>]`
- `!banusgn <U.S.G.N.> [<duration>] (0 for infinite, -1 for server setting) [<reason>]`
- `!banip <ip> [<duration>] (0 for infinite, -1 for server setting) [<reason>]`
- `!unban <U.S.G.N./ip>`
- `!unbanall`
- `!spawn <id> [<tilex>] [<tiley>]`
- `!kill <id>`
- `!slap <id>`
- `!equip <id> <weapon id>`
- `!strip <id> <weapon id>`
- `!goto <id>`
- `!goback <id>`
- `!bring <id>`
- `!bringback <id>`
- `!make <id> <team> (id or abbreviation)`
- `!player list / info <id> / edit <U.S.G.N.> <field> <new entry>`
- `!playerinfo <id>`
- `!playerprefix <id> <prefix>`
- `!playercolour <id> <colour>`
- `!playergroup <id> <group>`
- `!playerlevel <id> <level>`
- `!group list / info <group> / add <group> [<level>] [<colour>] [<commands>] / del(ete) <group> [<new group>] / edit <group> <field> <new entry>`
- `!groupprefix <group> <prefix>`
- `!groupcolour <group> <colour>`
- `!grouplevel <group> <level>`
- `!undo`
  
## Built-in plugins:
- Bad words (no more naughty naughty)
- Emoticons (for when you're feeling good)


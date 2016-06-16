-- yates_settings.lua --

--[[
	WARNING:
	Do not touch anything in this file. All of this is used to keep everything working!
	If you do edit this file, and ask for help without knowing what you have done, I will simply ignore your request
	and encourage others to do so as well.
	BE WARNED.
]]--

_tbl = {}
_id = nil
_txt = ""

yates = {}
yates.filter = {}
yates.player = {}

yates.plugin = {}
yates.force_reload = false

yates.hook = {}
yates.func = {}
yates.func.say = {}

yates.say = {}
yates.say.help = {}
yates.say.desc = {}

yates.setting = {}

yates.version = "1.0.1"

_GROUP = {}
_PLAYER = {}
_PLUGIN = {["on"] = {}, ["off"] = {}, ["info"] = {}}

_HOOKS = {}

_YATES = {
	auth_token = false
}
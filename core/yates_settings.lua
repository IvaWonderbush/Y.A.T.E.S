-- yates_settings.lua --

--[[
	WARNING:
	Do not touch anything in this file. All of this is used to keep everything working!
	If you do edit this file, and ask for help without knowing what you have done, I will simply ignore your request
	and encourage others to do so as well.
	BE WARNED.
]]--

_id = nil
_usgn = nil
_words = {}
_text = nil

yates = {}
yates.action = {}
yates.filter = {}
yates.player = {}

yates.plugin = {}
yates.force_reload = false

yates.hook = {}
yates.func = {}
yates.func.say = {}
yates.func.console = {}

yates.say = {}
yates.say.help = {}
yates.say.desc = {}

yates.console = {}
yates.console.help = {}
yates.console.desc = {}

yates.language = {}

yates.setting = {}
yates.setting.domain = "https://www.thomasyates.nl/"
yates.setting.domainVersion = "https://www.thomasyates.nl/docs/version.html"
yates.setting.domainDownload = "https://www.thomasyates.nl/docs"

yates.transferlist = {}

yates.version = "3.0.0"

_GROUP = {}
_PLAYER = {}
_PLUGIN = {["on"] = {}, ["off"] = {}, ["info"] = {}}
_YATES = {disabled_commands = {}}

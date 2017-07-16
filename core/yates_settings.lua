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
yates.actions = {}
yates.filters = {}
yates.players = {}

yates.plugins = {}
yates.force_reload = false

yates.hooks = {}
yates.funcs = {}
yates.funcs.say = {}
yates.funcs.console = {}

yates.say = {}
yates.say.help = {}
yates.say.desc = {}

yates.console = {}
yates.console.help = {}
yates.console.desc = {}

yates.languages = {}

yates.settings = {}
yates.settings.domain = "https://www.thomasyates.nl/"
yates.settings.domain_version = "https://www.thomasyates.nl/docs/version.html"
yates.settings.domain_download = "https://www.thomasyates.nl/docs"

yates.transferlist = {}

yates.version = "3.0.0"

_GROUPS = {}
_PLAYERS = {}
_PLUGINS = {["on"] = {}, ["off"] = {}, ["info"] = {}}
_YATES = {disabled_commands = {}}

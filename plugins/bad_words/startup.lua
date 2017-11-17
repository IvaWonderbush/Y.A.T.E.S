--[[
	This replaces bad words and warns the player
	Example: fuck becomes f*uck or ****
]]

yates.plugins["bad_words"]["title"] = "Bad Words"
yates.plugins["bad_words"]["author"] = "Yates"
yates.plugins["bad_words"]["usgn"] = "21431"
yates.plugins["bad_words"]["version"] = "0.9.0"
yates.plugins["bad_words"]["description"] = "Replaces bad words and warns the player (will be updated soon with in-game commands)."

dofile(yates.plugins["bad_words"]["dir"].."config.lua")
dofile(yates.plugins["bad_words"]["dir"].."functions.lua")
dofile(yates.plugins["bad_words"]["dir"].."actions.lua")
dofile(yates.plugins["bad_words"]["dir"].."filters.lua")
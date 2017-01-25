--[[
	This replaces bad words and warns the player
	Example: fuck becomes f*uck or ****
]]

yates.plugin["bad_words"]["title"] = "Bad Words"
yates.plugin["bad_words"]["author"] = "Yates"
yates.plugin["bad_words"]["usgn"] = "21431"
yates.plugin["bad_words"]["version"] = "0.9.0"
yates.plugin["bad_words"]["description"] = "Replaces bad words and warns the player (will be updated soon with in-game commands)."

dofile(yates.plugin["bad_words"]["dir"].."config.lua")
dofile(yates.plugin["bad_words"]["dir"].."functions.lua")
dofile(yates.plugin["bad_words"]["dir"].."filters.lua")
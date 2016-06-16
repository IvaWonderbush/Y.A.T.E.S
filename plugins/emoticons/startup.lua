--[[
	When using a text emoticon abbreviation in the chat an image pops up next to the player with the corresponding image.
	Credits to Happy Camper (U.S.G.N. ID: 5248) for the list, images and partial code.
	The source of his code and images can be found here: http://unrealsoftware.de/files_show.php?file=4543
]]

-- @TODO: Add servertransfer list generator

yates.plugin["emoticons"]["title"] = "Bad Words"
yates.plugin["emoticons"]["author"] = "Yates, Happy Camper"
yates.plugin["emoticons"]["usgn"] = "21431, 5248"
yates.plugin["emoticons"]["version"] = "0.9.0"
yates.plugin["emoticons"]["description"] = "Displays the corresponding image when using a text emoticon abbreviation."

dofileLua(yates.plugin["emoticons"]["dir"].."config.lua")
dofileLua(yates.plugin["emoticons"]["dir"].."functions.lua")

yates.force_reload = true
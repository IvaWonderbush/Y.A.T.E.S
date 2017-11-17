--[[
	When using a text emoticon abbreviation in the chat an image pops up next to the player with the corresponding image.
	Credits to Happy Camper (U.S.G.N. ID: 5248) for the list, images and partial code.
	The source of his code and images can be found here: http://unrealsoftware.de/files_show.php?file=4543
]]

yates.plugins["emoticons"]["title"] = "Emoticons"
yates.plugins["emoticons"]["author"] = "Yates, Happy Camper"
yates.plugins["emoticons"]["usgn"] = "21431, 5248"
yates.plugins["emoticons"]["version"] = "0.9.0"
yates.plugins["emoticons"]["description"] = "Displays the corresponding image when using a text emoticon abbreviation."

dofile(yates.plugins["emoticons"]["dir"].."config.lua")
dofile(yates.plugins["emoticons"]["dir"].."functions.lua")
dofile(yates.plugins["emoticons"]["dir"].."actions.lua")

emoticons.addToTransfer()

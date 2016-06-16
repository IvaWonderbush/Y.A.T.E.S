--[[
	This "plugin" was made as an example to show you how plugins work and how they can influence not only Y.A.T.E.S
	but certain parts of the script which can run with or without. This merely changes the result of what Y.A.T.E.S
	shows you when submitting a chat message.
]]

yates.plugin["rainbow"]["title"] = "Rainbow Text"
yates.plugin["rainbow"]["author"] = "Yates"
yates.plugin["rainbow"]["usgn"] = "21431"
yates.plugin["rainbow"]["version"] = "1.0.0"
yates.plugin["rainbow"]["description"] = "Changes the chat of every message into a random colour. Filter example."

dofileLua(yates.plugin["rainbow"]["dir"].."functions.lua")
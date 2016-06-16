--[[
	This "plugin" was made as an example to show you how plugins work and how they can influence not only Y.A.T.E.S
	but certain parts of the script which can run with or without. This merely changes the result of what Y.A.T.E.S
	shows you when submitting a chat message.
]]

yates.plugin["rainbow"]["author"] = "Yates"
yates.plugin["rainbow"]["usgn"] = "21431"
yates.plugin["rainbow"]["version"] = "0.9"
yates.plugin["rainbow"]["description"] = "Changes the chat of every message into a random colour. Filter example."

function yates.filter.chatColour(colour, prefix, usgn) -- Note how none of these variables are used for an actual purpose yet could be as shown by print()
	print(colour:gsub("\169",""))
	print(prefix)
	print(usgn)
	local r = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	local g = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	local b = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	return "\169"..r..g..b
end
plugin["rainbow"]["author"] = "Yates"
plugin["rainbow"]["usgn"] = "21431"
plugin["rainbow"]["version"] = "0.9"
plugin["rainbow"]["description"] = "Turns the chat into My Little Pony."

function filter.chat_colour()
	local r = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	local g = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	local b = math.random(0, 2) .. math.random(0, 5) .. math.random(0, 5)
	return "\169"..r..g..b
end
-- Bad Words
-- functions.lua

bad_words.tmp = {}
for word in pairs(bad_words.list) do
	local newWord = ""
	for letter in word:gmatch"." do
    	newWord = newWord.."["..string.lower(letter)..string.upper(letter).."]"
	end
	bad_words.tmp[newWord] = bad_words.list[word]
end
bad_words.list = bad_words.tmp

function bad_words.geesub(text, find, replace)
	find = "%f[%a]"..find.."%f[%A]"
	return text:gsub(find, replace)
end
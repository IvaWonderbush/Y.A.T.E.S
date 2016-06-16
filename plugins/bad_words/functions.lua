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
bad_words.list =  bad_words.tmp

function yates.filter.chatText(id, text)
	local newText = text
	local count = 0

	if bad_words.setting.replace or bad_words.setting.punish then
	    for bad, good in pairs(bad_words.list) do
	    	if bad_words.setting.replace then
		    	if bad_words.setting.replace_everything then
		    		good = "****"
				end
	    		newText, replaced = bad_words.geesub(newText, bad, good)
	    		count = count + replaced
    		end
	    end
	    if bad_words.setting.punish then
	    	if count > 0 then
	    		parse("slap "..id)
    		end
		end
	end

    return newText
end

function bad_words.geesub(text, find, replace)
	find = "%f[%a]"..find.."%f[%A]"
	return text:gsub(find, replace)
end
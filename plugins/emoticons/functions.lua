-- Emoticons
-- functions.lua

function yates.action.join(id)
	emoticons.player[id] = {}
	emoticons.player[id].chat = false
end

function yates.action.leave(id)
	if emoticons.player[id].chat then
		freeimage(emoticons.player[id].emote)
		freeimage(emoticons.player[id].bubble)

		emoticons.player[id].emote = nil
		emoticons.player[id].bubble = nil
	end
end

function yates.action.say(id, text)
    for word in string.gmatch(text, "[^%s]+") do
        for smiley, emoticon in pairs(emoticons.list) do
            if word:match(smiley) then
                emoticons.displayEmoticon(id, emoticon)
                return
            end
        end
    end
end

function emoticons.displayEmoticon(id, emoticon)
	if emoticons.player[id].chat then
		freeimage(emoticons.player[id].emote)
		freeimage(emoticons.player[id].bubble)

		emoticons.player[id].emote = nil
		emoticons.player[id].bubble = nil
	end
	
	emoticons.player[id].bubble = image(emoticons.path.."speechbubble.png", 0, 0, 200 + id)
	emoticons.player[id].emote = image(emoticons.path..emoticon..".png", 0, 0, 200 + id)

	imagealpha(emoticons.player[id].bubble, emoticons.alpha)
	imagealpha(emoticons.player[id].emote, emoticons.alpha)

	emoticons.player[id].time = os.time()
	emoticons.player[id].alpha = emoticons.alpha

	emoticons.player[id].chat = true
end

function yates.action.ms100()
    for _, id in pairs(player(0, "table")) do
    	if emoticons.player[id].chat then
	    	local time = os.difftime(os.time(), emoticons.player[id].time)

		    if time > emoticons.duration then
		        emoticons.player[id].alpha = emoticons.player[id].alpha - emoticons.fadeout
		        if emoticons.player[id].alpha <= 0 then
		            if emoticons.player[id].alpha then
			            freeimage(emoticons.player[id].emote)
						freeimage(emoticons.player[id].bubble)

						emoticons.player[id].emote = nil
						emoticons.player[id].bubble = nil

						emoticons.player[id].chat = false
		            end
		        else
		            imagealpha(emoticons.player[id].emote, emoticons.player[id].alpha)
		            imagealpha(emoticons.player[id].bubble, emoticons.player[id].alpha)
		        end
		    end
	    end
    end
end
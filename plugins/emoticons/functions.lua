-- Emoticons
-- functions.lua

function yates.action.join(id)
	yates.player.emoticons[id] = {}
	yates.player.emoticons[id].chat = false
end

function yates.action.leave(id)
	if yates.player.emoticons[id].chat then
		freeimage(yates.player.emoticons[id].emote)
		freeimage(yates.player.emoticons[id].bubble)

		yates.player.emoticons[id].emote = nil
		yates.player.emoticons[id].bubble = nil
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
	if yates.player.emoticons[id].chat then
		freeimage(yates.player.emoticons[id].emote)
		freeimage(yates.player.emoticons[id].bubble)

		yates.player.emoticons[id].emote = nil
		yates.player.emoticons[id].bubble = nil
	end
	
	yates.player.emoticons[id].bubble = image(emoticons.path.."speechbubble.png", 0, 0, 200 + id)
	yates.player.emoticons[id].emote = image(emoticons.path..emoticon..".png", 0, 0, 200 + id)

	imagealpha(yates.player.emoticons[id].bubble, emoticons.alpha)
	imagealpha(yates.player.emoticons[id].emote, emoticons.alpha)

	yates.player.emoticons[id].time = os.time()
	yates.player.emoticons[id].alpha = emoticons.alpha

	yates.player.emoticons[id].chat = true
end

function yates.action.ms100()
    for _, id in pairs(player(0, "table")) do
    	if yates.player.emoticons[id].chat then
	    	local time = os.difftime(os.time(), yates.player.emoticons[id].time)

		    if time > emoticons.duration then
		        yates.player.emoticons[id].alpha = yates.player.emoticons[id].alpha - emoticons.fadeout
		        if yates.player.emoticons[id].alpha <= 0 then
		            if yates.player.emoticons[id].alpha then
			            freeimage(yates.player.emoticons[id].emote)
						freeimage(yates.player.emoticons[id].bubble)

						yates.player.emoticons[id].emote = nil
						yates.player.emoticons[id].bubble = nil

						yates.player.emoticons[id].chat = false
		            end
		        else
		            imagealpha(yates.player.emoticons[id].emote, yates.player.emoticons[id].alpha)
		            imagealpha(yates.player.emoticons[id].bubble, yates.player.emoticons[id].alpha)
		        end
		    end
	    end
    end
end
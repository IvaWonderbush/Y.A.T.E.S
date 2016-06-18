-- Emoticons
-- functions.lua

function emoticons.join(id)
	emoticons.player[id] = {}
	emoticons.player[id].chat = false
end
addAction("join", emoticons.join)

function emoticons.leave(id)
	if emoticons.player[id].chat then
		freeimage(emoticons.player[id].emote)
		freeimage(emoticons.player[id].bubble)

		emoticons.player[id].emote = nil
		emoticons.player[id].bubble = nil
	end
end
addAction("leave", emoticons.leave)

function emoticons.say(id, text)
    for word in string.gmatch(text, "[^%s]+") do
        for smiley, emoticon in pairs(emoticons.list) do
            if word:match(smiley) then
                emoticons.displayEmoticon(id, emoticon)
                return
            end
        end
    end
    if not emoticons.player.chat then
    	emoticons.displayEmoticon(id, "chat")
	end
end
addAction("say", emoticons.say)

function emoticons.displayEmoticon(id, emoticon)
	if emoticons.player[id].chat then
		freeimage(emoticons.player[id].emote)
		freeimage(emoticons.player[id].bubble)

		emoticons.player[id].emote = nil
		emoticons.player[id].bubble = nil
	end
	
	emoticons.player[id].bubble = image(emoticons.path.."speechbubble.png", 0, 0, 132 + id)
	emoticons.player[id].emote = image(emoticons.path..emoticon..".png", 0, 0, 132 + id)

	imagealpha(emoticons.player[id].bubble, emoticons.alpha)
	imagealpha(emoticons.player[id].emote, emoticons.alpha)

	emoticons.player[id].time = os.time()
	emoticons.player[id].alpha = emoticons.alpha

	emoticons.player[id].chat = true
end

function emoticons.ms100()
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
addAction("ms100", emoticons.ms100)

function emoticons.addToTransfer()
	for k, v in pairs(emoticons.list) do
    	addTransferFile(v..".png", emoticons.path)
	end
	addTransferFile("chat.png", emoticons.path)
	addTransferFile("cursing.png", emoticons.path)
	addTransferFile("speechbubble.png", emoticons.path)
end
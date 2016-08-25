-- Emoticons
-- functions.lua

function emoticons.displayEmoticon(id, emoticon)
	if player(id, "health") > 0 then
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
end

function emoticons.addToTransfer()
	for k, v in pairs(emoticons.list) do
    	addTransferFile(v..".png", emoticons.path)
	end
	addTransferFile("chat.png", emoticons.path)
	addTransferFile("cursing.png", emoticons.path)
	addTransferFile("speechbubble.png", emoticons.path)
end
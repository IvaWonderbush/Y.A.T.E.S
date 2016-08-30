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
		
		emoticons.player[id].bubble = image(emoticons.setting.path.."speechbubble.png", 0, 0, 132 + id)
		emoticons.player[id].emote = image(emoticons.setting.path..emoticon..".png", 0, 0, 132 + id)

		imagealpha(emoticons.player[id].bubble, emoticons.setting.alpha)
		imagealpha(emoticons.player[id].emote, emoticons.setting.alpha)

		emoticons.player[id].time = os.time()
		emoticons.player[id].alpha = emoticons.setting.alpha

		emoticons.player[id].chat = true
	end
end

function emoticons.addToTransfer()
	for k, v in pairs(emoticons.setting.list) do
    	addTransferFile(v..".png", emoticons.setting.path)
	end
	addTransferFile("chat.png", emoticons.setting.path)
	addTransferFile("cursing.png", emoticons.setting.path)
	addTransferFile("speechbubble.png", emoticons.setting.path)
end
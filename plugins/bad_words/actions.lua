-- Bad Words
-- actions.lua

function bad_words.join(id)
    bad_words.player[id] = {}
    bad_words.player[id].cuss = false
end
addhook("join", "bad_words.join")

function bad_words.say(id)
    if bad_words.player[id].cuss then
        if emoticons then
            emoticons.displayEmoticon(id, "cursing")
        else
            print("The emoticons plugin is not enabled! Cursing will NOT display an emoticon!", "warning")
        end
        bad_words.player[id].cuss = false
    end
end
addhook("say", "bad_words.say", 110)
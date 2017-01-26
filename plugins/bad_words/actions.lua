function bad_words.say()
    if bad_words.cursing_id then
        emoticons.displayEmoticon(bad_words.cursing_id, "cursing")
        bad_words.cursing_id = nil
    end
end
addAction("say", bad_words.say, 101)
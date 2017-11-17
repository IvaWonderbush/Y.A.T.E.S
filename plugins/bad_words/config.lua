-- Bad Words
-- config.lua

bad_words = {}
bad_words.setting = {}

-- Enables/disables the replacement of the bad word to the given string
bad_words.setting.replace = true

-- Enables/disables the punishment of the player by total slappage
bad_words.setting.punish = true

-- Enables/disables the replacement of the whole word. Example: fuck becomes ****
bad_words.setting.replace_everything = false

-- Enables/disables the swaer emoticon. NOTE: Emoticons plugin is required and must be ENABLED!
bad_words.setting.emoticon = true

-- Bad words list, the value of the table item is the replacement
bad_words.list = {
	["asshole"] = "*sshole",
	["bitch"] = "b*tch",
	["cunt"] = "c*nt",
	["fuck"] = "f*ck",
	["fucker"] = "f*cker",
	["fucking"] = "f*cking",
	["shit"] = "sh*t",
	["hitler"] = "h*tler",
	["gajos"] = "gayos*",
	["gay"] = "g*y",
	["motherfucker"] = "motherf*cker",
	["nigger"] = "n*gger",
	["nobhead"] = "n*bhead",
	["wanker"] = "w*nker",
}
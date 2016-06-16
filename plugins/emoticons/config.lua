-- Emoticons
-- config.lua

emoticons = {}
emoticons.player = {}

-- The alpha (transparency) of the image on creation. Lower the value to make the emoticon and bubble less visible (range 0 - 1)
emoticons.alpha = 0.6

-- The duration of how long the emoticon is visible until it starts to fade out
emoticons.duration = 2

-- The fadeout alpha. A value of 0.1 would fade the image out after the duration by 0.1 every 100 milliseconds
emoticons.fadeout = 0.1

-- Enables/disables the emoticon to fade over the duration of its visibility
emoticons.fade = false

-- Emoticon directory path
emoticons.path = "gfx/hc/emoticons/"

-- Emoticon list
emoticons.list = {
    ["^[:=8][-^o]?[)%]3>]$"] = "smiling", -- :)
    ["^%^[_]?%^$"] = "smiling", -- ^_^
    ["^[:=8][-^o]?[D]$"] = "smiling_big", -- :D
    ["^[:=8][-^o]?[(%[]$"] = "frowning", -- :(
    ["^[;][-^o]?[)%]D]$"] = "winking", -- ;)
    ["^[xX][-^o]?[D]+$"] = "laughing", -- xD
    ["^[lL1][oO��0]+[lL1]+[sSzZ]*%??$"] = "laughing", -- lol
    ["^[hH][aAeEoO��][hH][aAeEoO��]$"] = "laughing", -- hehe
    ["^[rR][oO��0]+[fF][lL1]+$"] = "laughing", -- rofl
    ["^[:=8xX][-^o]?[pPbq]$"] = "cheeky", -- :P
    ["^[:=8xX]['][-^o]?%($"] = "crying", -- :'(
    ["^[;][-]?%($"] = "crying", -- ;(
    ["^D[-^o]?[:=8xX]$"] = "crying", -- Dx
    ["^T[_.-]?T$"] = "crying", -- T_T
    ["^[:=8][-^o]?[oO0]$"] = "surprised", -- :O
    ["^[oO0][_.-]?[oO0]$"] = "surprised", -- O_o
    ["^[oO0][mM][gG]$"] = "surprised", -- omg
    ["^[:=8][-^o]?[/\\]$"] = "skeptical", -- :/
    ["^[:=8][-^o]?[sS]$"] = "uneasy", -- :S
    ["^>[:=8;][-^o]?[)%]D]$"] = "evil", -- >:D
    ["^>[_.-]<$"] = "angry", -- >_<
    ["^>[:=8;][-^o]?[(%[]$"] = "angry", -- >:(
    ["^<3$"] = "heart" -- <3
}
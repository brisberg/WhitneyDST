PrefabFiles = {
	"wtw_whitney",
}

Assets = {
  Asset( "IMAGE", "images/saveslot_portraits/wtw_whitney.tex" ),
  Asset( "ATLAS", "images/saveslot_portraits/wtw_whitney.xml" ),

  Asset( "IMAGE", "images/selectscreen_portraits/wtw_whitney.tex" ),
  Asset( "ATLAS", "images/selectscreen_portraits/wtw_whitney.xml" ),

  Asset( "IMAGE", "images/selectscreen_portraits/wtw_whitney_silho.tex" ),
  Asset( "ATLAS", "images/selectscreen_portraits/wtw_whitney_silho.xml" ),

  Asset( "IMAGE", "bigportraits/wtw_whitney.tex" ),
  Asset( "ATLAS", "bigportraits/wtw_whitney.xml" ),

	Asset( "IMAGE", "images/map_icons/wtw_whitney.tex" ),
	Asset( "ATLAS", "images/map_icons/wtw_whitney.xml" ),
}

local require = GLOBAL.require

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.wtw_whitney = "The Witch"
GLOBAL.STRINGS.CHARACTER_NAMES.wtw_whitney = "Esc"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.wtw_whitney = "*Light Staff\n*Grows Plants\n*Cool Hat"
GLOBAL.STRINGS.CHARACTER_QUOTES.wtw_whitney = "\"Of course I'm great with plants, it's in my nature.\""

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.WTW_WHITNEY = require "speech_wtw_whitney"

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "wtw_whitney")


AddMinimapAtlas("images/map_icons/wtw_whitney.xml")
AddModCharacter("wtw_whitney")

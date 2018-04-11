PrefabFiles = {
	"wtw_whitney",
	"wtw_whitney_none",
	"wtw_lightstaff",
	"wtw_lightstaff_fx"
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

	Asset( "IMAGE", "images/avatars/avatar_wtw_whitney.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_wtw_whitney.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_wtw_whitney.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_ghost_wtw_whitney.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_wtw_whitney.tex" ),
	Asset( "ATLAS", "images/avatars/self_inspect_wtw_whitney.xml" ),

	Asset("SOUNDPACKAGE", "sound/wtw_whitney_speech.fev"),
	Asset("SOUND", "sound/wtw_whitney_speech.fsb"),
}
if GLOBAL.TheSim:GetGameID() == "DS" then
	modimport "scripts/lib/polyfill-ds.lua"
elseif GLOBAL.TheSim:GetGameID() == "DST" then
	modimport "scripts/lib/polyfill-dst.lua"
end

local require = GLOBAL.require
local pf = GLOBAL.pf

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.wtw_whitney = "The Witch"
GLOBAL.STRINGS.CHARACTER_NAMES.wtw_whitney = "Whitney"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.wtw_whitney = "*Light Staff\n*Grows Plants\n*Cool Hat"
GLOBAL.STRINGS.CHARACTER_QUOTES.wtw_whitney = "\"Of course I'm great with plants, it's in my nature.\""

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.WTW_WHITNEY = require "speech_wtw_whitney"

-- Load the custom actions
modimport "scripts/actions/actions.lua"

-- Let the game know character is male, female, or robot
--table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "wtw_whitney")

RemapSoundEvent( "dontstarve/characters/wtw_whitney/death_voice", "wtw_whitney_speech/characters/wtw_whitney/death_voice" )
RemapSoundEvent( "dontstarve/characters/wtw_whitney/hurt", "wtw_whitney_speech/characters/wtw_whitney/hurt" )
RemapSoundEvent( "dontstarve/characters/wtw_whitney/talk_LP", "wtw_whitney_speech/characters/wtw_whitney/talk_LP" )
AddMinimapAtlas("images/map_icons/wtw_whitney.xml")
AddModCharacter("wtw_whitney", "FEMALE")

local Ingredient = GLOBAL.Ingredient
AddRecipe(
	"wtw_lightstaff",
	{
		Ingredient("lightbulb", 1),
		Ingredient("spear", 1)
	},
	GLOBAL.RECIPETABS.MAGIC,
	GLOBAL.TECH.NONE,
	nil, nil, nil, nil, "wtw_lightstaff_builder",
	"images/inventoryimages/wtw_lightstaff.xml",
	"wtw_lightstaff.tex")
GLOBAL.STRINGS.RECIPE_DESC.WTW_LIGHTSTAFF = "Assists in growing plants"

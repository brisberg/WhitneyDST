local assets =
{
	Asset( "ANIM", "anim/wtw_whitney.zip" ),
	Asset( "ANIM", "anim/ghost_wtw_whitney_build.zip" ),
}

local skins =
{
	normal_skin = "wtw_whitney",
	ghost_skin = "ghost_wtw_whitney_build",
}

local base_prefab = "wtw_whitney"

local tags = {"WTW_WHITNEY", "CHARACTER"} --字符

return CreatePrefabSkin("wtw_whitney_none",
{
	base_prefab = base_prefab,
	skins = skins, 
	assets = assets,
	tags = tags,

	skip_item_gen = true,
	skip_giftable_gen = true,
})

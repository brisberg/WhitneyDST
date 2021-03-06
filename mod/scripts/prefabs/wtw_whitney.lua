-- local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),

        -- custom hat sprites
        Asset( "ANIM", "anim/wtw_hat.zip" ),
}
local prefabs = {}
local start_inv = {
	-- Custom starting items
  "wtw_lightstaff",
}

local show_witch_hat = function(inst)
  inst.AnimState:OverrideSymbol("swap_hat", "wtw_hat", "swap_hat")
  inst.AnimState:Show("HAT")
  inst.AnimState:Show("HAIR_HAT")
  inst.AnimState:Show("HEAD_HAT")
  inst.AnimState:Hide("HAIR_NOHAT")
  inst.AnimState:Hide("HAIR")
  inst.AnimState:Hide("HEAD")
end

local common_fn = function(inst)
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "wtw_whitney.tex" )
end

local master_fn = function(inst)
  	-- choose which sounds this character will play
  	inst.soundsname = "wtw_whitney"

  	-- Stats
  	inst.components.health:SetMaxHealth(150)
  	inst.components.hunger:SetMax(150)
  	inst.components.sanity:SetMax(200)

  	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1

    show_witch_hat(inst)

    inst:AddTag("wtw_lightstaff_builder")

    inst:ListenForEvent("unequip", function(inst, data)
        if data.eslot == EQUIPSLOTS.HEAD then
          show_witch_hat(inst)
        end
    end)
end

return pf.MakePlayerCharacter("wtw_whitney", prefabs, assets, common_fn, master_fn, start_inv)

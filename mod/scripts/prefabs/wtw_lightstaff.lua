local name = "wtw_lightstaff"

local assets =
{
    Asset("ANIM", "anim/"..name..".zip"),
    Asset("ANIM", "anim/swap_"..name..".zip"),

    Asset( "IMAGE", "images/inventoryimages/"..name..".tex" ),
    Asset( "ATLAS", "images/inventoryimages/"..name..".xml" ),
}

local function onfinished(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    inst:Remove()
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn(colour, tags, hasskin)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild(name)
    inst.AnimState:SetBank(name.."_anim")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("nopunch")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"

    -- inst:AddComponent("tradable")

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(function(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_"..name, "swap_lightstaff")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end

STRINGS.NAMES.WTW_LIGHTSTAFF = "Lightstaff"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WTW_LIGHTSTAFF = "The result of nature and starlight"

return Prefab(name, fn, assets)

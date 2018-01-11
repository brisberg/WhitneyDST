local assets =
{
    Asset("ANIM", "anim/wtw_lightstaff.zip"),
    Asset("ANIM", "anim/swap_wtw_lightstaff.zip"),
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
    -- inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("wtw_lightstaff")
    inst.AnimState:SetBank("wtw_lightstaff_anim")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("nopunch")

    -- inst.entity:SetPristine()

    -- if not TheWorld.ismastersim then
    --     return inst
    -- end

    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    -- inst:AddComponent("tradable")

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(function(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_wtw_lightstaff", "swap_lightstaff")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end

return Prefab("wtw_lightstaff", fn, assets)

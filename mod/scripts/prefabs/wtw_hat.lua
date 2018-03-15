local name = "wtw_hat"
local fname = name
local symname = name
local prefabname = name
-- local fname = "hat_"..name
-- local symname = name.."hat"
-- local prefabname = symname

--If you want to use generic_perish to do more, it's still
--commented in all the relevant places below in this file.
--[[local function generic_perish(inst)
    inst:Remove()
end]]

local function onequip(inst, owner, symbol_override)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, symbol_override or "swap_hat", inst.GUID, fname)
    else
        owner.AnimState:OverrideSymbol("swap_hat", fname, symbol_override or "swap_hat")
    end
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")

    if owner:HasTag("player") then
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    end

    if inst.components.fueled ~= nil then
        inst.components.fueled:StartConsuming()
    end
end

local function onunequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end

    owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end

    if inst.components.fueled ~= nil then
        inst.components.fueled:StopConsuming()
    end
end

-- local function opentop_onequip(inst, owner)
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("equipskinneditem", inst:GetSkinName())
--         owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, fname)
--     else
--         owner.AnimState:OverrideSymbol("swap_hat", fname, "swap_hat")
--     end
--
--     owner.AnimState:Show("HAT")
--     owner.AnimState:Hide("HAIR_HAT")
--     owner.AnimState:Show("HAIR_NOHAT")
--     owner.AnimState:Show("HAIR")
--
--     owner.AnimState:Show("HEAD")
--     owner.AnimState:Hide("HEAD_HAT")
--
--     if inst.components.fueled ~= nil then
--         inst.components.fueled:StartConsuming()
--     end
-- end

local function simple(custom_init)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(symname)
    inst.AnimState:SetBuild(fname)
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("hat")

    if custom_init ~= nil then
        custom_init(inst)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"
    inst:AddComponent("inspectable")

    inst:AddComponent("tradable")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

local function fn()
    local inst = simple()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end
local assets = { Asset("ANIM", "anim/"..fname..".zip") ,
    Asset( "IMAGE", "images/inventoryimages/"..name..".tex" ),
    Asset( "ATLAS", "images/inventoryimages/"..name..".xml" ),}
local prefabs = nil

STRINGS.NAMES.WTW_HAT = "Temp WTW Hat"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WTW_LIGHTSTAFF = "It's a hat"


return Prefab(prefabname, fn or default, assets, prefabs)

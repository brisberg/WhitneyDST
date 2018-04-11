local Action = GLOBAL.Action
local ActionHandler = GLOBAL.ActionHandler
local TheSim = GLOBAL.TheSim
-- local languageStrings = require('lang/' .. GetModConfigData("LANGUAGE"))
-- local bpx = GLOBAL.bpx
local TUNING = GLOBAL.TUNING

--helper function for book_gardening
local function trygrowth(inst)
    if inst:IsInLimbo()
        or (inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()) then
        return
    end

    if inst.components.pickable ~= nil then
        if inst.components.pickable:CanBePicked() and inst.components.pickable.caninteractwith then
            return
        end
        inst.components.pickable:FinishGrowing()
    end

    if inst.components.crop ~= nil then
        inst.components.crop:DoGrow(TUNING.TOTAL_DAY_TIME * 3, true)
    end

    if inst.components.growable ~= nil and
        (inst:HasTag("tree") or inst:HasTag("winter_tree")) and
        not inst:HasTag("stump") then
        inst.components.growable:DoGrowth()
    end

    if inst.components.harvestable ~= nil and inst.components.harvestable:CanBeHarvested() and inst:HasTag("mushroom_farm") then
        inst.components.harvestable:Grow()
    end
end

-- Retreat Action
local WTW_CASTGROW = AddAction("WTW_CASTGROW", "Cast Grow", function(act)
  print("Running the WTW_CASTGROW act fn")
  -- act.doer.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

  local range = 5
  local ents = TheSim:FindEntities(act.pos.x, act.pos.y, act.pos.z, range, nil, { "pickable", "stump", "withered", "INLIMBO" })
  if #ents > 0 then
      trygrowth(table.remove(ents, math.random(#ents)))
      if #ents > 0 then
          local timevar = 1 - 1 / (#ents + 1)
          for i, v in ipairs(ents) do
              v:DoTaskInTime(timevar * math.random(), trygrowth)
          end
      end
  end
  if act.invobject and act.invobject.components.finiteuses then
    act.invobject.components.finiteuses:Use()
  end
  return true
end)
WTW_CASTGROW.priority = 2
--WTW_CASTGROW.instant = true
WTW_CASTGROW.distance = 30
WTW_CASTGROW.rmb = true

AddComponentAction("POINT", "wtw_spellcaster", function(inst, doer, pos, actions, right)
  -- print("Collect Point Actions for wtw_spellcaster")
  if right then
    -- if target.replica.pickable ~= nil and
    --    not target.replica.pickable:CanBePicked() and
    --    not target.replica.pickable.caninteractwith then
         table.insert(actions, GLOBAL.ACTIONS.WTW_CASTGROW)
    -- end
  end
end)


AddStategraphActionHandler("wilson",ActionHandler(WTW_CASTGROW, "castspell"))
AddStategraphActionHandler("wilson_client",ActionHandler(WTW_CASTGROW, "castspell"))

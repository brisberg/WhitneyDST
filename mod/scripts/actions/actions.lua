local Action = GLOBAL.Action
local ActionHandler = GLOBAL.ActionHandler
-- local languageStrings = require('lang/' .. GetModConfigData("LANGUAGE"))
-- local bpx = GLOBAL.bpx

-- Retreat Action
local WTW_CASTGROW = AddAction("WTW_CASTGROW", "Cast Grow", function(act)
  print("Running the WTW_CASTGROW act fn")
  if act.target and act.target.components.pickable then
      act.doer.components.talker:Say("Grow")
      if act.target.components.pickable:CanBePicked() and act.target.components.pickable.caninteractwith then
          return false
      end
      act.target.components.pickable:FinishGrowing()
  end
  return true
end)
WTW_CASTGROW.priority = 2
WTW_CASTGROW.instant = true
WTW_CASTGROW.rmb = true
-- WTW_CASTGROW.testfn = function(act)
--     print("wtw_castgrow test function")
--     local plant = act.target
--     -- check if combatant is in combat
--     if plant.components.pickable ~= nil then
--         if plant.components.pickable:CanBePicked() and plant.components.pickable.caninteractwith then
--             return false
--         end
--         return true
--     end
-- end

AddComponentAction("EQUIPPED", "wtw_spellcaster", function(inst, doer, target, actions, right)
  -- print("Collect Scene Actions for ttb_pet")
  if right then
    -- if target.replica.pickable ~= nil and
    --    not target.replica.pickable:CanBePicked() and
    --    not target.replica.pickable.caninteractwith then
         table.insert(actions, GLOBAL.ACTIONS.WTW_CASTGROW)
    -- end
  end
end)


AddStategraphActionHandler("wilson",ActionHandler(WTW_CASTGROW))
AddStategraphActionHandler("wilson_client",ActionHandler(WTW_CASTGROW))

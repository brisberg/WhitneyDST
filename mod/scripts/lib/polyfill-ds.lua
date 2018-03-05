-- DS polyfills

function loadfn(env)
  local pf = {}
  pf.AddModCharacter = function(name, gender)
    env.AddModCharacter(name)
  end
  pf.CreatePrefabSkin = function(name, info)
    return env.Prefab(name, nil, info.assets, info.prefabs)
  end
  pf.MakePlayerCharacter = function(name, customprefabs, customassets, common_postinit, master_postinit, starting_inventory)
      local function fn( ... )
          if common_postinit then
              common_postinit(...)
          end
          if master_postinit then
              master_postinit(...)
          end
      end
      return require("prefabs/player_common")(name, customprefabs, customassets, fn, starting_inventory)
  end
  pf.CreateEntity = function()
    local inst = GLOBAL.CreateEntity()
    function inst:AddNetwork(...) end
    function inst:SetPristine(...) end
    return inst
  end

  GLOBAL.global("TheWorld")
  GLOBAL.TheWorld = {
    ismastersim = true
  }

  GLOBAL.global("pf")
  GLOBAL.pf = pf
end

loadfn(env)

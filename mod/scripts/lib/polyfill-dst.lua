-- DST polyfills

function loadfn(env)
  local pf = {}
  pf.AddModCharacter = env.AddModCharacter
  pf.CreatePrefabSkin = GLOBAL.CreatePrefabSkin
  pf.MakePlayerCharacter = function(...)
      return GLOBAL.require("prefabs/player_common")(...)
  end
  pf.CreateEntity = GLOBAL.CreateEntity
  pf.MakeHauntableLaunch = GLOBAL.MakeHauntableLaunch

  GLOBAL.global("pf")
  GLOBAL.pf = pf
end

loadfn(env)

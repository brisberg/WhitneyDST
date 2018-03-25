-- Container component to attach spell casting actions
local WTW_Spellcaster = Class(function(self, inst)
    self.inst = inst
end)

function WTW_Spellcaster:GetDebugString()
    return "WTW_Spellcaster"
end

print("loaded wtw_spellcaster")

return WTW_Spellcaster

--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- Simple factory function for CheckButtons
--------------------------------------------------------------------------------
function B2H:Checkbox(type, parent, option, label, anchor, region, anchor_to, x, y, enabled, updateFunc, resetFunc, selectAllFunc, unselectAllFunc)
  if not option then return end
  local idx = B2H:FindIndex(self.db.toys, function(toy) return toy.id == option end)

  -- Create the CheckButton
  local cb = CreateFrame("CheckButton", _G[AddonName .. "CheckButton_" .. option], parent, "InterfaceOptionsCheckButtonTemplate")
  cb:SetPoint(anchor, region, anchor_to, x, y)

  if not enabled then
    cb:Disable()
    cb.Text:SetText(B2H:setTextColor(label, "grey"))
  else
    cb.Text:SetText(B2H:setTextColor(label, "white"))
  end
  
  if type == "toys" then
    if not idx then
      cb:SetChecked(enabled and self.db.fallback.active)
    else
      cb:SetChecked(enabled and self.db[type][idx].active)
    end
  elseif READI.Helper.table:Contains(type, READI.Helper.table:Keys(self.db.others)) then
    cb:SetChecked(self.db.others[type][option])
  end

  cb:HookScript("OnClick", function(_, btn, down)
    updateFunc()
  end)

  EventRegistry:RegisterCallback("B2H."..type..".OnReset", resetFunc)
  EventRegistry:RegisterCallback("B2H."..type..".OnUnselectAll", unselectAllFunc)
  EventRegistry:RegisterCallback("B2H."..type..".OnSelectAll", selectAllFunc)

  return cb
end
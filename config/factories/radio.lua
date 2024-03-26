--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- Simple factory function for RadioButtons
--------------------------------------------------------------------------------
function B2H:RadioButton(type, region, option, value, setCon, anchor, parent, parent_anchor, x, y, checkFunc, updateFunc, resetFunc)
  local rb = CreateFrame("CheckButton", nil, region, "UIRadioButtonTemplate ")
  rb.option = option
  rb.value = value
  rb.tooltip = CreateFrame("GameTooltip", AddonName .. "RadioButton_" .. option .. "_" .. value .. "ToolTip", UIParent, "GameTooltipTemplate")
  rb:SetPoint(anchor, parent, parent_anchor, x, y)
  rb:SetSize(32, 32)
  rb.texture = rb:CreateTexture(AddonName .. "RadioButtonBackground", "BACKGROUND")
  rb.texture:SetAllPoints(rb)
  rb.texture:SetTexture(B2H.T.b2h_radio_button_normal)

  local normalTexture = rb:GetNormalTexture()
  normalTexture:ClearAllPoints()

  local highlightTexture = rb:GetHighlightTexture()
  highlightTexture:ClearAllPoints()

  local checkedTexture = rb:GetCheckedTexture()
  checkedTexture:ClearAllPoints()

  if setCon then
    rb:SetChecked(true)
    rb.texture:SetTexture(B2H.T.b2h_radio_button_pushed)
  end

  local function UpdateDB(val)
    self.db.parent[option] = val
    B2H.HSButton:RePosition()
  end

  local function OnEnter(self)
    if not self.tooltip then
      return
    end
    self.tooltip:SetOwner(self, "ANCHOR_LEFT")
    self.tooltip:ClearLines()
    self.tooltip:AddLine(self.value, 1, 1, 1, true)
    self.tooltip:Show()

    if not self:GetChecked() then
      self.texture:SetTexture(B2H.T.b2h_radio_button_highlight)
    end
  end

  local function OnLeave(self)
    if not self.tooltip then
      return
    end
    self.tooltip:Hide()
    if not self:GetChecked() then
      self.texture:SetTexture(B2H.T.b2h_radio_button_normal)
    end
  end

  rb:SetScript("OnEnter", OnEnter)
  rb:SetScript("OnLeave", OnLeave)
  rb:HookScript("OnClick", function(self)
    for _, anchor in ipairs(b2h.anchors) do
      local btn = _G[AddonName .. "RadioButton_" .. option .. "_" .. anchor]
      if btn.value ~= self.value then
        btn:SetChecked(false)
        btn.texture:SetTexture(B2H.T.b2h_radio_button_normal)
      end
    end
    self:SetChecked(true)
    self.texture:SetTexture(B2H.T.b2h_radio_button_pushed)
    UpdateDB(self.value)
  end)
  checkFunc = checkFunc or function () return end
  updateFunc = updateFunc or function () return end
  resetFunc = resetFunc or function () return end
  EventRegistry:RegisterCallback("B2H."..type..".OnReset", function()
    local val = self.defaults.parent[option]
    if val == rb.value then rb:Click() end
  end)

  return rb
end

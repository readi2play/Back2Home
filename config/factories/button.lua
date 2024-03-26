--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- simple factory function for button creation,
--------------------------------------------------------------------------------
function B2H:Button(region, template, label, width, height, text, enabled, anchor, parent, p_anchor, x, y, clickCallback)
  template = template or "UIPanelButtonTemplate"
  local btn = CreateFrame("Button", nil, region, template)
  btn:SetPoint(anchor, parent, p_anchor, x, y)
  if label then
    btn:SetText(label)
  end
  btn:SetWidth(width or btn:GetTextWidth() + 30)
  btn:SetHeight(height or btn:GetTextHeight() + 10)
  btn:SetScript("OnClick", clickCallback)

  local parent = btn:GetParent()
  local additionalButtonText = parent:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  additionalButtonText:SetPoint("TOP", btn, "BOTTOM", 0, -5)
  additionalButtonText:SetText(text)
  additionalButtonText:Hide()

  if not enabled then
    btn:Disable()
    additionalButtonText:Show()
  end
  return btn
end
--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- simple factory function for slider creation
--------------------------------------------------------------------------------
function B2H:Slider(type, region, name, min, max, step, val, size, anchor, parent, p_anchor, x, y, updateFunc, resetFunc)
  local slider = CreateFrame("Slider", name, region, "OptionsSliderTemplate")
  slider.name = name
  slider:SetPoint(anchor, parent, p_anchor, x, y)
  slider:SetThumbTexture(B2H.T.b2h_radio_button_pushed)
  slider:SetOrientation(orientation or "HORIZONTAL")
  slider:SetWidth(size)
  slider:SetMinMaxValues(min or 16, max or 64)
  slider:SetObeyStepOnDrag(true)
  slider:SetValueStep(step or 8)
  slider:SetValue(val)
  _G[slider.name.."Low"]:SetText(min)
  _G[slider.name.."High"]:SetText(max)
  _G[slider.name.."Text"]:SetText(slider:GetValue())
  _G[slider.name.."Text"]:ClearAllPoints()
  _G[slider.name.."Text"]:SetPoint("TOP", slider, "BOTTOM", 0, -10)

  slider:SetScript("OnValueChanged", updateFunc)
  EventRegistry:RegisterCallback("B2H."..type..".OnReset", resetFunc)

  return slider
end
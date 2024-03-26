--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- Simple factory function for Icons
--------------------------------------------------------------------------------
function B2H:Icon(path, width, height, region)
  local f = CreateFrame("Frame", nil, region)
  f:SetSize(width, height)
  f.tex = f:CreateTexture()
  f.tex:SetAllPoints(f)
  f.tex:SetTexture(path)
  return f
end
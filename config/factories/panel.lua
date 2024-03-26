--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- Config Panel Factory
--------------------------------------------------------------------------------
function B2H:CreateConfigPanel(type, isMain, name, callback)
  -- create the panel frame and set its name
  local panel = CreateFrame("Frame")
  panel.name = name or AddonName

  -- if the panel is not meant to be the addon's main config panel set its parent to the AddonName
  if not isMain then panel.parent = AddonName end

  local container = CreateFrame("Frame", nil, panel)
  container.name = name.." Container"
  container:SetPoint("TOPLEFT", 5, -5)
  container:SetPoint("BOTTOMRIGHT", -5, 5)

  -- if the panel is not meant to be the main config panel for the addon set its name or title as headline
  if not isMain then
    local frameTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    frameTitle:SetPoint("TOP", container, 0, -20)
    frameTitle:SetText(B2H:setTextColor(name, "white"))
  end

  -- run the given callback
  if callback then callback(self, panel, container) end

  return panel
end
--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local configKeys = {"info", "items", "anchoring", "keybindings", "events", "reporting"}
local data = CopyTable(B2H.data)
data.keyword = "config"
B2H.config = B2H.config or {}


b2h.windowWidth = SettingsPanel.Container:GetWidth()
b2h.columns = 2
b2h.columnWidth = b2h.windowWidth / b2h.columns - 20
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:SetupConfig()
  local category = Settings.RegisterCanvasLayoutCategory(B2H.Info.panel, B2H:setTextColor(AddonName, "b2h"))
  category.ID = AddonName
  Settings.RegisterAddOnCategory(category)
end
--------------------------------------------------------------------------------
-- OPTIONS PANEL INITIALIZATION
--------------------------------------------------------------------------------
function B2H:InitializeOptions()
  for i,key in ipairs(configKeys) do
    local category = READI.Helper.string:Capitalize(key)
    if B2H[category] and B2H[category].Initialize then
      B2H[category].Initialize(self)
    end
  end
end
function B2H:UpdateOptions(shuffle)
  if shuffle == nil then shuffle = true end

  for i,key in ipairs(configKeys) do
    local category = READI.Helper.string:Capitalize(key)
    if B2H[category] and B2H[category].Update then
      B2H[category].Update()
    end
  end

  B2H.HSButton:ScaleButton()
  B2H.HSButton:SetPosition()
  B2H.HSButton:SetStrata()

  B2H.HSButton:Update(shuffle)
end
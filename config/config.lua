--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local configKeys = {"info", "toys", "anchoring", "keybindings", "reporting", "profiles"}
local data = CopyTable(B2H.data)
data.keyword = "config"
B2H.config = {}

b2h.windowWidth = SettingsPanel.Container:GetWidth()
b2h.columns = 2
b2h.columnWidth = b2h.windowWidth / b2h.columns - 20
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:SetupConfig()
  for i,key in ipairs(configKeys) do
    B2H.config[key] = B2H.config[key] or {}
    local panelName = READI:l10n(format("config.panels.%s.title", key), "B2H.L")
    local parentPanel = nil
    local titleText = READI:l10n(format("config.panels.%s.title", key), "B2H.L")

    if key == "info" then
      panelName = AddonName
      titleText = AddonName
    else
      parentPanel = AddonName
    end

    B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline = READI:OptionPanel(data, {
      name = panelName,
      parent = parentPanel,
      title = {
        text = titleText,
        color = "b2h"
      }
    })
    InterfaceOptions_AddCategory(B2H.config[key].panel)
  end
end
--------------------------------------------------------------------------------
-- OPTIONS PANEL INITIALIZATION
--------------------------------------------------------------------------------
function B2H:InitializeOptions()
  for i,key in ipairs(configKeys) do
    local callbackKey = format("Fill%sPanel", READI.Helper.string.Capitalize(key))
    if B2H[callbackKey] then
      B2H[callbackKey](self, B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline)
    end
  end
end
function B2H:UpdateOptions()
  B2H.Toys:Update()
  B2H.Keybindings:Update()
end
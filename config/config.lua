--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local configKeys = {"info", "toys", "fallbacks", "anchoring", "keybindings", "reporting", "profiles"}
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
    local FillPanelFunctionName = format("Fill%sPanel", READI.Helper.string:Capitalize(key))
    local panelExists = READI.Helper.functions:Exists("B2H."..FillPanelFunctionName)
    print(FillPanelFunctionName, panelExists)

    if panelExists then
      B2H.config[key] = B2H.config[key] or {}
      local panelName = READI:l10n(("config.panels.%s.title"):format(key), "B2H.L")
      local parentPanel = nil
      local titleText = READI:l10n(("config.panels.%s.title"):format(key), "B2H.L")
  
      if key == "info" then
        panelName = AddonName
        titleText = AddonName
      else
        parentPanel = AddonName
      end
  
      --------------------------------------------------------------------------------
      B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline = READI:OptionPanel(data, {
        name = panelName,
        parent = parentPanel,
        title = {
          text = titleText,
          color = "b2h"
        }
      })
      --------------------------------------------------------------------------------
  
      if Settings and Settings.RegisterCanvasLayoutCategory then
  
        if parentPanel then
          local category = Settings.GetCategory(parentPanel)
          local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, B2H.config[key].panel, panelName)
        else
          local category = Settings.RegisterCanvasLayoutCategory(B2H.config[key].panel, AddonName)
          category.ID = AddonName
          Settings.RegisterAddOnCategory(category)
        end
  
      else
        InterfaceOptions_AddCategory(B2H.config[key].panel)
      end
    end
  end
end
--------------------------------------------------------------------------------
-- OPTIONS PANEL INITIALIZATION
--------------------------------------------------------------------------------
function B2H:InitializeOptions()
  for i,key in ipairs(configKeys) do
    local FillPanelFunctionName = format("Fill%sPanel", READI.Helper.string:Capitalize(key))
    local panelExists = READI.Helper.functions:Exists("B2H."..FillPanelFunctionName)

    if panelExists then
      B2H[FillPanelFunctionName](self, B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline)
    end
  end
end
function B2H:UpdateOptions(shuffle)
  if shuffle == nil then
    shuffle = true
  end
  B2H.Toys:Update()
  B2H.Anchoring:Update()
  B2H.Keybindings:Update()

  B2H.HSButton:ScaleButton()
  B2H.HSButton:SetPosition()
  B2H.HSButton:SetStrata()

  B2H.HSButton:Update(shuffle)
end
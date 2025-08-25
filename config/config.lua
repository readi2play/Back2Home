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

  --[[
  for i,key in ipairs(configKeys) do
    local FillPanelFunctionName = format("Fill%sPanel", READI.Helper.string:Capitalize(key))
    local panelExists = READI.Helper.functions:Exists("B2H."..FillPanelFunctionName)

    if panelExists then
      B2H.config[key] = B2H.config[key] or {}
      local panelName = B2H.L[READI.Helper.string:Capitalize(key)]
      local parentPanel = nil
      local titleText = B2H.L[READI.Helper.string:Capitalize(key)]
  
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
          local subcategory = nil
          if key == "toys" or key == "fallbacks" then
            subcategory = Settings.RegisterVerticalLayoutSubcategory(category, B2H:setTextColor(panelName, "b2h_light"))
          else
            subcategory = Settings.RegisterCanvasLayoutSubcategory(category, B2H.config[key].panel, panelName)
          end
        else
          local category = Settings.RegisterCanvasLayoutCategory(B2H.config[key].panel, B2H:setTextColor(AddonName, "b2h"))
          category.ID = AddonName
          Settings.RegisterAddOnCategory(category)
        end
  
      else
        InterfaceOptions_AddCategory(B2H.config[key].panel)
      end
    end
  end
  ]]--
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
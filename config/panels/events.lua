--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "events"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
B2H.Events = B2H.Events or {
  fields = {},
  list = {"PLAYER_ENTERING_WORLD", "ZONE_CHANGED", "PLAYER_LEVEL_UP", "NEW_TOY_ADDED"}
}
--------------------------------------------------------------------------------
B2H.Events.panel, B2H.Events.container, B2H.Events.anchorline = READI:OptionPanel(data, {
  name = B2H.L["Events"],
  parent = AddonName,
  title = {
    text = B2H.L["Events"],
    color = "b2h"
  }
})
--------------------------------------------------------------------------------

function B2H.Events:Initialize()

  local category, layout = Settings.RegisterVerticalLayoutSubcategory(Settings.GetCategory(AddonName), B2H.L[READI.Helper.string:Capitalize(data.keyword)])
  Settings.RegisterAddOnCategory(category)

  layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(B2H:setTextColor(format(B2H.L["Select the events the %s Button shall refresh to."], B2H:setTextColor(AddonName, "b2h")), "b2h")))

  for i,event in ipairs(B2H.Events.list) do
    local name = B2H:setTextColor(B2H.L[event], "white")
    local variable = "B2H_RefreshOn"..event

    local variableKey = event
    local variableTbl = B2H.db.events
    local defaultValue = B2H.defaults.events[event]
    
    local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
    local tooltip = B2H:setTextColor(format(B2H.L["When activated %s will %s."], B2H:setTextColor(AddonName, "b2h"), READI.Helper.string:DecapitalizeFirst(B2H.L[event])), "white")
    table.insert(B2H.Events.fields, Settings.CreateCheckbox(category, setting, tooltip))
  end

end
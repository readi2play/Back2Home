--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "items"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
B2H.Items = B2H.Items or {
  list = {54452,64488,93672,162973,163045,165669,165670,165802,166746,166747,168907,172179,180290,182773,183716,184353,188952,190196,190237,193588,200630,208704,209035,212337,206195,228940,236687,235016,142542,245970,246565},
  fallbacks = {6948},
  fields = {},
  labels = {}
}

function B2H.Items:Initialize()
  sort(B2H.Items.list)

  local function OnSettingChanged(setting, value)
    -- This callback will be invoked whenever a setting is modified.
    B2H.HSButton:Update( b2h.id == setting.variableKey )
  end

  local category, layout = Settings.RegisterVerticalLayoutSubcategory(Settings.GetCategory(AddonName), B2H.L[READI.Helper.string:Capitalize(data.keyword)])
  Settings.RegisterAddOnCategory(category)

  layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(B2H:setTextColor(B2H.L["Included Hearthstone Toys"], "b2h")))

  for _,itemID in ipairs(B2H.Items.list) do
    local item = Item:CreateFromItemID(itemID)
    item:ContinueOnItemLoad(function()
      item.name = item:GetItemName() or "... loading"

      local owned = PlayerHasToy(itemID) or false
      local name = item.name
      local variable = "B2H_IncludeItem"..itemID
      if owned then
        name = B2H:setTextColor(name, "white")
      else
        name = B2H:setTextColor(name, "grey")
      end
      local variableKey = itemID
      local variableTbl = B2H.db.items
      local defaultValue = owned
      
      local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
      local tooltip = B2H:setTextColor(format(B2H.L[ [[When activated %s will include "%s" in the shuffle rotation.]] ], B2H:setTextColor(AddonName, "b2h"), name), "white")
      table.insert(B2H.Items.fields, Settings.CreateCheckbox(category, setting, tooltip))
  
      setting:SetValueChangedCallback(OnSettingChanged)
      if setting:GetValue() ~= defaultValue then
        setting:ApplyValue(defaultValue)
      end
      setting:SetLocked(not owned)
    end)
  end
end

function B2H.Items:Update()
  for i,cb in ipairs(B2H.Items.fields) do
    local setting = cb:GetSetting()
    local itemID = setting.variableKey
  end
end

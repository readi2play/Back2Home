--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "profiles"
local charName = GetUnitName("player")
--------------------------------------------------------------------------------
-- CREATE KEYBINDINGS PANEL CONTENT
--------------------------------------------------------------------------------
B2H.Profile = B2H.Profile or {}

function B2H:FillProfilesPanel(panel, container, anchorline)
  local activated = _G[AddonName.."DB"].use_profiles
  local profileList = READI.Helper.table:Keys(_G[AddonName.."DB"].chars)
  local deleteList = CopyTable(profileList)
  table.insert(profileList, 1, {txt = "Standard", val = "global"})

  local profiles_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  profiles_sectionTitle:SetPoint("TOPLEFT", anchorline, 0, -20)
  profiles_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.headline", "B2H.L"), "b2h"))

  local cbName = format("%s_%s_activate", AddonName, READI.Helper.string:Capitalize(data.keyword))
  local opts = {
    name = cbName,
    region = container,
    label = READI:l10n("config.panels.profiles.labels.activation", "B2H.L"),
    parent = profiles_sectionTitle,
    p_anchor = "BOTTOMLEFT",
    offsetX = 0,
    offsetY = -10,
    onClick = function(self)
      _G[AddonName.."DB"].use_profiles = self:GetChecked()
      activated = self:GetChecked()
      EventRegistry:TriggerEvent("B2H.PROFILE_ACTIVATION_CHANGED")
    end
  }
  local activationCB = READI:CheckBox(data, opts)
  activationCB:SetState(true)
  activationCB:SetChecked(activated)

  local wrapper = CreateFrame("Frame", nil, container)
  wrapper:SetPoint("TOPLEFT", activationCB, "BOTTOMLEFT", 0,0)
  wrapper:SetPoint("RIGHT", container, "RIGHT", 0,0)
  wrapper:SetHeight(0)

  if activated then
    wrapper:Show()
  else
    wrapper:Hide()
  end

  local selectProfileLabel = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
  selectProfileLabel:SetPoint("TOPLEFT", wrapper, "TOPLEFT", 0, -10)
  selectProfileLabel:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.select", "B2H.L"), "b2h_light"))
  selectProfileLabel:SetJustifyH("LEFT")
  selectProfileLabel:SetJustifyV("TOP")
  selectProfileLabel:SetWidth(b2h.columnWidth)
  selectProfileLabel:SetWordWrap(true)
  local selectDropdown = READI:DropDown(data, {
    values = profileList,
    storage = "B2H.db",
    option = "assigned_profile",
    condition = B2H.db ~= _G[AddonName.."DB"].global,
    name = AddonName.."Dropdown_selectedProfile",
    region = wrapper,
    parent = selectProfileLabel,
    offsetX = -15,
    offsetY = -10,
    onChange = B2H.Profile.Select
  })

  local copyList = CopyTable(profileList)

  local copyProfileLabel = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
  copyProfileLabel:SetPoint("TOPLEFT", wrapper, "TOPLEFT", b2h.columnWidth, -10)
  copyProfileLabel:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.copyProfile", "B2H.L"), "b2h_light"))
  copyProfileLabel:SetJustifyH("LEFT")
  copyProfileLabel:SetJustifyV("TOP")
  copyProfileLabel:SetWidth(b2h.columnWidth)
  copyProfileLabel:SetWordWrap(true)
  local copyDropdown = READI:DropDown(data, {
    values = copyList,
    option = nil,
    name = AddonName.."Dropdown_copyProfile",
    region = wrapper,
    parent = copyProfileLabel,
    offsetX = -15,
    offsetY = -10,
    onChange = B2H.Profile.SelectToCopy
  })

  local copyProfileBtn = READI:Button(data, {
    name = AddonName.."CopyProfileButton",
    label = READI:l10n("general.labels.buttons.submit"),
    region = wrapper,
    anchor = "LEFT",
    parent = copyDropdown,
    p_anchor = "RIGHT",
    onClick = B2H.Profile.Copy
  })

  local deleteProfileLabel = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
  deleteProfileLabel:SetPoint("TOPLEFT", copyDropdown, "TOPLEFT", 15, -128)
  deleteProfileLabel:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.deleteProfile", "B2H.L"), "b2h_light"))
  deleteProfileLabel:SetJustifyH("LEFT")
  deleteProfileLabel:SetJustifyV("TOP")
  deleteProfileLabel:SetWidth(b2h.columnWidth)
  deleteProfileLabel:SetWordWrap(true)
  local deleteDropdown = READI:DropDown(data, {
    values = deleteList,
    option = nil,
    name = AddonName.."Dropdown_deleteProfile",
    region = wrapper,
    parent = deleteProfileLabel,
    p_anchor = "BOTTOMLEFT",
    offsetX = -15,
    offsetY = -10,
    onChange = B2H.Profile.SelectToDelete
  })

  local deleteProfileBtn = READI:Button(data, {
    name = AddonName.."DeleteProfileButton",
    label = READI:l10n("general.labels.buttons.submit"),
    region = wrapper,
    anchor = "LEFT",
    parent = deleteDropdown,
    p_anchor = "RIGHT",
    onClick = B2H.Profile.Delete
  })

  if _G[AddonName.."DB"].chars[charName].assigned_profile == "global" then
    selectDropdown:SetValue("global", "Standard")
  end

  EventRegistry:RegisterCallback("B2H.PROFILE_ACTIVATION_CHANGED", function(evt)
    if activated then
      wrapper:Show()
      B2H.db = _G[AddonName.."DB"].chars[ _G[AddonName.."DB"].chars[charName].assigned_profile ]
    else
      wrapper:Hide()
      B2H.db = _G[AddonName.."DB"].global
    end
    B2H:UpdateOptions()    
  end)

  B2H.Profile:Init()
end

function B2H.Profile:Init()
  local dd = _G[AddonName.."Dropdown_selectedProfile"]
  B2H.Profile.selected = dd:GetValue() or _G[AddonName.."DB"].chars[charName].assigned_profile

  if B2H.Profile.selected == "global" and dd:GetText() == "global" then
    dd:SetText("Standard")
  end
end
function B2H.Profile:SelectToCopy()
  local dd = _G[AddonName.."Dropdown_copyProfile"]
  B2H.Profile.copyThis = dd:GetValue()
end
function B2H.Profile:Copy()
  local __p = B2H.Profile.copyThis
  local dst = _G[AddonName.."DB"].chars[B2H.Profile.selected]
  
  if B2H.Profile.selected ==  "global" then
    dst = _G[AddonName.."DB"].global
  end

  if __p then
    local src = _G[AddonName.."DB"].chars[__p]
    if __p ==  "global" then
      src = _G[AddonName.."DB"].global
    end  
    for k,v in pairs(src) do
      dst[k] = src[k]
    end
    B2H:UpdateOptions()    
  end
end
function B2H.Profile:SelectToDelete()
  local dd = _G[AddonName.."Dropdown_deleteProfile"]
  B2H.Profile.deleteThis = dd:GetValue()
end
function B2H.Profile:Delete()
  local __p = B2H.Profile.deleteThis
  local selection = _G[AddonName.."Dropdown_selectedProfile"]
  
  if __p ~= "global" then
    local src = _G[AddonName.."DB"].chars[__p]
    if __p == B2H.Profile.selected then
      if __p == charName then
        B2H.db = _G[AddonName.."DB"].global
        selection:SetValue("global", "Standard")
      else
        B2H.db = _G[AddonName.."DB"].chars[charName]
        selection:SetValue(charName)
      end
    end
    _G[AddonName.."DB"].chars[__p] = nil
    B2H:UpdateOptions()    
  end
end
function B2H.Profile:Select()
  local dd = _G[AddonName.."Dropdown_selectedProfile"]
  B2H.Profile.selected = dd:GetValue()
  _G[AddonName.."DB"].chars[charName].assigned_profile = B2H.Profile.selected

  if B2H.Profile.selected ==  "global" then
    B2H.db = _G[AddonName.."DB"].global
  else
    B2H.db = _G[AddonName.."DB"].chars[B2H.Profile.selected]
  end
  B2H:UpdateOptions()    
end
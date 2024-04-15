--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "profiles"
--------------------------------------------------------------------------------
-- CREATE KEYBINDINGS PANEL CONTENT
--------------------------------------------------------------------------------
B2H.Profile = B2H.Profile or {}

function B2H:FillProfilesPanel(panel, container, anchorline)
  local activated = _G[AddonName.."DB"].profiles.activated

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
      _G[AddonName.."DB"].profiles.activated = self:GetChecked()
      B2H.db.profiles.activated = self:GetChecked()
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

  local selectDropdown = READI:DropDown(data, {
    values = B2H.Profile.profileList,
    storage = "B2H",
    option = "db",
    name = AddonName.."Dropdown_selectedProfile",
    region = wrapper,
    parent = wrapper,
    offsetY = -10,
    onChange = B2H.Profile.Select
  })

  EventRegistry:RegisterCallback("B2H.PROFILE_ACTIVATION_CHANGED", function(evt)
    if activated then
      wrapper:Show()
    else
      wrapper:Hide()
    end
  end)  
end

function B2H.Profile:Init()
  B2H.Profile.Chars = B2H.Profile.Chars or {}
  B2H.Profile.ProfileList = B2H.Profile.ProfileList or {
    [0] = READI.l10n("config.panels.profiles.labels.default", "B2H.L")
  }

  local charName = GetUnitName("player")
  local charsNum = #B2H.Profile.Chars

  if not READI.Helper.table:Contains(B2H.Profile.Chars, charName) then
    B2H.Profile.Chars[charsNum + 1] = charName
  end
end

function B2H.Profile:Copy() end

function B2H.Profile:Select()
  print("Yeah!")
end
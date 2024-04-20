--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "profiles"
local charName = format("%s-%s", GetUnitName("player"), GetRealmName())
--------------------------------------------------------------------------------
-- CREATE PROFILES PANEL CONTENT
--------------------------------------------------------------------------------
B2H.Profile = B2H.Profile or {}
local Profiler = {
  defaultProfile = {txt = READI:l10n("general.commons.default"), val = "global"},
  activeProfile = {
    label = "",
    description = "",
    dropdown = nil,
    selection = nil,
  },
  copyProfile = {
    label = "",
    description = "",
    dropdown = nil,
  },
  deleteProfile = {
    label = "",
    description = "",
    dropdown = nil,
  },
}

function B2H:FillProfilesPanel(panel, container, anchorline)
  --[[---------------------------------------------------------------------------
  Toggle profile usage
  ---------------------------------------------------------------------------]]--
    local activated = _G[AddonName.."DB"].use_profiles
    -------------------------------------------------------------------------------
    local profiles_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    profiles_sectionTitle:SetPoint("TOPLEFT", anchorline, 0, -20)
    profiles_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.headline", "B2H.L"), "b2h"))
    -------------------------------------------------------------------------------
    local activationDescription = container:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
    activationDescription:SetPoint("TOPLEFT", profiles_sectionTitle, "BOTTOMLEFT", 0, -10)
    activationDescription:SetText(B2H:setTextColor(format(READI:l10n("config.panels.profiles.description.activation", "B2H.L"), B2H:setTextColor(AddonName, "b2h")), "white"))
    activationDescription:SetJustifyH("LEFT")
    activationDescription:SetJustifyV("TOP")
    activationDescription:SetWidth(b2h.windowWidth - 20)
    activationDescription:SetWordWrap(true)
    local cbName = format("%s_%s_activate", AddonName, READI.Helper.string:Capitalize(data.keyword))
    local opts = {
      name = cbName,
      region = container,
      label = READI:l10n("config.panels.profiles.labels.activation", "B2H.L"),
      parent = activationDescription,
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
    -------------------------------------------------------------------------------
    local wrapper = CreateFrame("Frame", nil, container)
    wrapper:SetPoint("TOPLEFT", activationCB, "BOTTOMLEFT", 0,0)
    wrapper:SetPoint("RIGHT", container, "RIGHT", 0,0)
    wrapper:SetHeight(0)
    -------------------------------------------------------------------------------
    if activated then
      wrapper:Show()
    else
      wrapper:Hide()
    end

  --[[----------------------------------------------------------------------------
  Active Profile section
  ----------------------------------------------------------------------------]]--
    Profiler.activeProfile.list = READI.Helper.table:Keys(_G[AddonName.."DB"].chars)
    table.insert(Profiler.activeProfile.list, 1, Profiler.defaultProfile)
    --------------------------------------------------------------------------------
    Profiler.activeProfile.label = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
    Profiler.activeProfile.label:SetPoint("TOPLEFT", wrapper, "TOPLEFT", 0, -10)
    Profiler.activeProfile.label:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.select", "B2H.L"), "b2h_light"))
    Profiler.activeProfile.label:SetJustifyH("LEFT")
    Profiler.activeProfile.label:SetJustifyV("TOP")
    Profiler.activeProfile.label:SetWidth(b2h.columnWidth)
    Profiler.activeProfile.label:SetWordWrap(true)
    -------------------------------------------------------------------------------
    Profiler.activeProfile.dropdown = READI:DropDown(data, {
      values = Profiler.activeProfile.list,
      storage = "B2H.db",
      option = "assigned_profile",
      condition = B2H.db ~= _G[AddonName.."DB"].global,
      name = AddonName.."Dropdown_activeProfile",
      region = wrapper,
      parent = Profiler.activeProfile.label,
      offsetX = -20,
      offsetY = -10,
      onChange = B2H.Profile.Select
    })

  --[[----------------------------------------------------------------------------
  Copy Profile section
  ----------------------------------------------------------------------------]]--
    Profiler.copyProfile.list = CopyTable(Profiler.activeProfile.list)
    --------------------------------------------------------------------------------
    Profiler.copyProfile.label = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
    Profiler.copyProfile.label:SetPoint("TOPLEFT", Profiler.activeProfile.dropdown, "BOTTOMLEFT", 20, -100)
    Profiler.copyProfile.label:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.copyProfile", "B2H.L"), "b2h_light"))
    Profiler.copyProfile.label:SetJustifyH("LEFT")
    Profiler.copyProfile.label:SetJustifyV("TOP")
    Profiler.copyProfile.label:SetWidth(b2h.columnWidth - 20)
    Profiler.copyProfile.label:SetWordWrap(true)
    -------------------------------------------------------------------------------
    Profiler.copyProfile.dropdown = READI:DropDown(data, {
      values = Profiler.copyProfile.list,
      option = nil,
      name = AddonName.."Dropdown_copyProfile",
      region = wrapper,
      parent = Profiler.copyProfile.label,
      offsetX = -20,
      offsetY = -10,
    })
    -------------------------------------------------------------------------------
    Profiler.copyProfile.description = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
    Profiler.copyProfile.description:SetPoint("TOPLEFT", Profiler.copyProfile.dropdown, "BOTTOMLEFT", 20, -5)
    Profiler.copyProfile.description:SetText(B2H:setTextColor(format(READI:l10n("config.panels.profiles.description.copyProfile", "B2H.L"), READI:l10n("general.labels.buttons.submit")), "white"))
    Profiler.copyProfile.description:SetJustifyH("LEFT")
    Profiler.copyProfile.description:SetJustifyV("TOP")
    Profiler.copyProfile.description:SetWidth(b2h.columnWidth - 20)
    Profiler.copyProfile.description:SetWordWrap(true)
    -------------------------------------------------------------------------------
    Profiler.copyProfile.button = READI:Button(data, {
      name = AddonName.."CopyProfileButton",
      label = READI:l10n("general.labels.buttons.submit"),
      region = wrapper,
      parent = Profiler.copyProfile.description,
      p_anchor = "BOTTOMLEFT",
      offsetY = -10,
      onClick = B2H.Profile.Copy
    })
  --[[----------------------------------------------------------------------------
  Delete Profile section
  ----------------------------------------------------------------------------]]--
    Profiler.deleteProfile.list = READI.Helper.table:Keys(_G[AddonName.."DB"].chars)
    --------------------------------------------------------------------------------
    Profiler.deleteProfile.label = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormal")
    Profiler.deleteProfile.label:SetPoint("TOPLEFT", Profiler.copyProfile.label, "TOPLEFT", b2h.columnWidth, 0)
    Profiler.deleteProfile.label:SetText(B2H:setTextColor(READI:l10n("config.panels.profiles.labels.deleteProfile", "B2H.L"), "b2h_light"))
    Profiler.deleteProfile.label:SetJustifyH("LEFT")
    Profiler.deleteProfile.label:SetJustifyV("TOP")
    Profiler.deleteProfile.label:SetWidth(b2h.columnWidth - 20)
    Profiler.deleteProfile.label:SetWordWrap(true)
    -------------------------------------------------------------------------------
    Profiler.deleteProfile.dropdown = READI:DropDown(data, {
      values = Profiler.deleteProfile.list,
      option = nil,
      name = AddonName.."Dropdown_deleteProfile",
      region = wrapper,
      parent = Profiler.deleteProfile.label,
      p_anchor = "BOTTOMLEFT",
      offsetX = -20,
      offsetY = -10,
    })
    -------------------------------------------------------------------------------
    Profiler.deleteProfile.description = wrapper:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
    Profiler.deleteProfile.description:SetPoint("TOPLEFT", Profiler.deleteProfile.dropdown, "BOTTOMLEFT", 20, -5)
    Profiler.deleteProfile.description:SetText(B2H:setTextColor(format(READI:l10n("config.panels.profiles.description.deleteProfile", "B2H.L"), READI:l10n("general.labels.buttons.submit")), "white"))
    Profiler.deleteProfile.description:SetJustifyH("LEFT")
    Profiler.deleteProfile.description:SetJustifyV("TOP")
    Profiler.deleteProfile.description:SetWidth(b2h.columnWidth - 20)
    Profiler.deleteProfile.description:SetWordWrap(true)
    -------------------------------------------------------------------------------
    Profiler.deleteProfile.button = READI:Button(data, {
      name = AddonName.."DeleteProfileButton",
      label = READI:l10n("general.labels.buttons.submit"),
      region = wrapper,
      parent = Profiler.deleteProfile.description,
      p_anchor = "BOTTOMLEFT",
      offsetY = -10,
      onClick = B2H.Profile.Delete
    })
  --[[----------------------------------------------------------------------------
  Handling of active profile 
  ----------------------------------------------------------------------------]]--
    if _G[AddonName.."DB"].chars[charName].assigned_profile == "global" then
      Profiler.activeProfile.dropdown:SetValue(Profiler.defaultProfile.val, Profiler.defaultProfile.txt)
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
  Profiler.activeProfile.selection = Profiler.activeProfile.dropdown:GetValue() or _G[AddonName.."DB"].chars[charName].assigned_profile

  if Profiler.activeProfile.selection == "global" and Profiler.activeProfile.dropdown:GetText() == "global" then
    Profiler.activeProfile.dropdown:SetText(Profiler.defaultProfile.txt)
  end
end
function B2H.Profile:Copy()
  local __selection = Profiler.copyProfile.dropdown:GetValue()
  local dst = _G[AddonName.."DB"].chars[Profiler.activeProfile.selection]
  
  if Profiler.activeProfile.selection ==  "global" then
    dst = _G[AddonName.."DB"].global
  end

  if __selection then
    local src = _G[AddonName.."DB"].chars[__selection]
    if __selection ==  "global" then
      src = _G[AddonName.."DB"].global
    end  
    for k,v in pairs(src) do
      dst[k] = src[k]
    end
    B2H:UpdateOptions()    
    Profiler.copyProfile.dropdown:SetValue(nil)
  end
end
function B2H.Profile:Delete()
  local __selection = Profiler.deleteProfile.dropdown:GetValue()
  local function FillPrompt(__p)
    __p.text = __p.text or __p:CreateFontString("ARTWORK", nil, "GameFontNormal")
    __p.text:SetText(
      B2H:setTextColor(format(
        READI:l10n("config.panels.profiles.dialogues.prompt.delete", "B2H.L"), B2H:setTextColor(__selection, "b2h_light")
      ), "white")
    )
    if __p.title then
      __p.text:SetPoint("TOPLEFT", __p.titleDivider, "BOTTOMLEFT", 20, -5)
    else
      __p.text:SetPoint("TOPLEFT", __p, "TOPLEFT", 20, -30)
    end
    __p.text:SetWidth(__p:GetWidth(-20))
    __p.text:SetJustifyH("LEFT")
    __p.text:SetJustifyV("TOP")
    __p.text:SetWordWrap(true)

    if __p.icon then
      __p.icon:SetPoint("CENTER", __p, "TOPLEFT", 10,-10)
      __p.icon:SetFrameStrata("DIALOG")
      __p.icon:SetFrameLevel(100)
    end
  end

  if not __selection then return end
  local promptName = "DeleteProfilePrompt"
  local prompt = _G[promptName] or READI:Dialog(data, {
    name = promptName,
    title = B2H:setTextColor(READI:l10n("config.panels.profiles.labels.deleteProfile", "B2H.L"), "b2h"),
    icon = {
      texture = GetAddOnMetadata(AddonName, "IconTexture"),
      height = 42,
      width = 42,
    },
    buttonSet = {
      confirm = READI:l10n("general.labels.buttons.yes"),
      cancel = READI:l10n("general.labels.buttons.no"),
    },
    closeOnEsc = true,
    createHidden = false,
    onOkay = function()
      local __selection = Profiler.deleteProfile.dropdown:GetValue()
      local src = _G[AddonName.."DB"].chars[__selection]
      if __selection == Profiler.activeProfile.selection then
        if __selection == charName then
          B2H.db = _G[AddonName.."DB"].global
          Profiler.activeProfile.dropdown:SetValue(Profiler.defaultProfile.val, Profiler.defaultProfile.txt)
        else
          B2H.db = _G[AddonName.."DB"].chars[charName]
          Profiler.activeProfile.dropdown:SetValue(charName)
        end
      end      
      local __actIdx = READI.Helper.table:Get(Profiler.activeProfile.dropdown.MenuList, function(k,v) return v == __selection end)
      table.remove(Profiler.activeProfile.dropdown.MenuList, __actIdx)

      local __copIdx = READI.Helper.table:Get(Profiler.copyProfile.dropdown.MenuList, function(k,v) return v == __selection end)
      table.remove(Profiler.copyProfile.dropdown.MenuList, __copIdx)

      local __delIdx = READI.Helper.table:Get(Profiler.deleteProfile.dropdown.MenuList, function(k,v) return v == __selection end)
      table.remove(Profiler.deleteProfile.dropdown.MenuList, __delIdx)

      _G[AddonName.."DB"].chars[__selection] = nil
      B2H:UpdateOptions()
    end,
    onCancel = function() end,
    onClose = function()
      Profiler.deleteProfile.dropdown:SetValue(nil)
    end
  })
  FillPrompt(prompt)
  if not prompt:IsVisible() then
    prompt:Show()
  end
end
function B2H.Profile:Select()
  Profiler.activeProfile.selection = Profiler.activeProfile.dropdown:GetValue()
  _G[AddonName.."DB"].chars[charName].assigned_profile = Profiler.activeProfile.selection

  if Profiler.activeProfile.selection ==  "global" then
    B2H.db = _G[AddonName.."DB"].global
  else
    B2H.db = _G[AddonName.."DB"].chars[Profiler.activeProfile.selection]
  end
  B2H:UpdateOptions()    
end
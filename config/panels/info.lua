--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "info"
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
B2H.Info = B2H.Info or {}

--------------------------------------------------------------------------------
B2H.Info.panel, B2H.Info.container, B2H.Info.anchorline = READI:OptionPanel(data, {
  name = AddonName,
  parent = nil,
  title = {
    text = AddonName,
    color = "b2h"
  }
})
--------------------------------------------------------------------------------

local addon = {
  ["icon"] = GetAddOnMetadata(AddonName, "IconTexture"),
  ["version"] = GetAddOnMetadata(AddonName, "Version"),
  ["author"] = GetAddOnMetadata(AddonName, "Author"),
}
local lib = {
  ["title"] = GetAddOnMetadata("readiLIB", "Title"), 
  ["icon"] = GetAddOnMetadata("readiLIB", "IconTexture"),
  ["version"] = GetAddOnMetadata("readiLIB", "Version"),
  ["author"] = GetAddOnMetadata("readiLIB", "Author"),
}
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H.Info:Initialize()
  local panel, container, anchorline = B2H.Info.panel, B2H.Info.container, B2H.Info.anchorline
  local logo = READI:Icon(data, {
    texture = addon.icon,
    name = format("%s Logo", AddonName),
    region = container,
    width = 80,
    height = 80,
  })
  logo:SetPoint("TOP", 0, -20)

  local headline_infos = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  headline_infos:SetPoint("TOP", logo, "BOTTOM", 0, -20)
  headline_infos:SetText(B2H:setTextColor(AddonName, "b2h"))

  local infos_text = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  infos_text:SetPoint("TOP", headline_infos, "BOTTOM", 0, -5)
  infos_text:SetText(
    B2H:setTextColor(B2H.L["Version"], "b2h") .. " " ..
    B2H:setTextColor(addon.version .. "\n", "white") ..
    B2H:setTextColor(B2H.L["Author"], "b2h") .. " " ..
    B2H:setTextColor(addon.author .. "\n", "readi")
  )

  local headline_commands = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  headline_commands:SetPoint("TOPLEFT", container, 0, -180)
  headline_commands:SetText(B2H:setTextColor(B2H.L["Slash Commands"], "b2h"))

  local text_commands = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  text_commands:SetPoint("TOPLEFT", headline_commands, "BOTTOMLEFT", 0, -10)
  text_commands:SetJustifyH("LEFT")
  text_commands:SetJustifyV("TOP")
  text_commands:SetWordWrap(true)
  text_commands:SetWidth(b2h.windowWidth - 18)
  text_commands:SetText(
    B2H:setTextColor(READI.Helper.string:Trim(format(
      B2H.L[ [=[
  Shuffle your Hearthstone Toys. Either via right clicking the %1$s Button or by using the following slash command
            
    %3$s


  Use the following slash command to open this config panel to adjust the Hearthstone Toys used by the %1$s Button, the Frame the Button is anchored to and if the default Hearthstone should be used as a fallback if no Hearthstone Toys are collected yet.
            
    %4$s




  Thanks for using %1$s and stay healthy
            

  yours sincerely

  %2$s
]=] ],
      B2H:setTextColor(AddonName, "b2h"),
      B2H:setTextColor(addon.author, "readi"),
      format("%s %s", B2H:setTextColor("/home", "b2h"), B2H:setTextColor("shuffle", "b2h_light")),
      format("%s %s", B2H:setTextColor("/home", "b2h"), B2H:setTextColor("config", "b2h_light"))
    )), "white")
  )

  local libLogo = READI:Icon(data, {
    texture = lib.icon,
    name = format("%s Logo", "readiLIB"),
    region = panel,
    width = 16,
    height = 16,
  })

  local libText = panel:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
  libText:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -5,5)
  libText:SetText(B2H:setTextColor(format("%s v%s", lib.title, lib.version), "white"))

  libLogo:SetPoint("RIGHT", libText, "LEFT", -5, 0)

  local powered_by = panel:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
  powered_by:SetPoint("RIGHT", libLogo, "LEFT", -5,0)
  powered_by:SetText(B2H:setTextColor("powered by:", "white"))
end

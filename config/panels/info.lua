--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "info"
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

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
function B2H:FillInfoPanel(panel, container, anchorline)
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
    B2H:setTextColor(READI:l10n("config.panels.info.version", "B2H.L"), "b2h") .. " " ..
    B2H:setTextColor(addon.version .. "\n", "white") ..
    B2H:setTextColor(READI:l10n("config.panels.info.author", "B2H.L", 1), "b2h") .. " " ..
    B2H:setTextColor(addon.author .. "\n", "readi")
  )

  local headline_commands = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  headline_commands:SetPoint("TOPLEFT", container, 0, -180)
  headline_commands:SetText(B2H:setTextColor(B2H:l10n("config.panels.info.commands", "B2H.L"), "b2h"))

  local text_commands = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  text_commands:SetPoint("TOPLEFT", headline_commands, "BOTTOMLEFT", 0, -10)
  text_commands:SetJustifyH("LEFT")
  text_commands:SetJustifyV("TOP")
  text_commands:SetWordWrap(true)
  text_commands:SetWidth(b2h.windowWidth - 18)
  text_commands:SetText(
    B2H:setTextColor(READI.Helper.string:Trim(format(
      READI:l10n("config.panels.info.text", "B2H.L"),
      B2H:setTextColor(AddonName, "b2h"),
      B2H:setTextColor(addon.author, "readi"),
      format("%s %s", B2H:setTextColor("/home|b2h", "b2h"), B2H:setTextColor("shuffle | random | update | mix", "white")),
      format("%s %s", B2H:setTextColor("/home|b2h", "b2h"), B2H:setTextColor("config | options | settings", "white"))
    )), "b2h_light")
  )

  local libLogo = READI:Icon(data, {
    texture = lib.icon,
    name = format("%s Logo", "readiLIB"),
    region = container,
    width = 16,
    height = 16,
  })

  local libText = container:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
  libText:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -5,5)
  libText:SetText(B2H:setTextColor(format("%s v%s", lib.title, lib.version), "white"))

  libLogo:SetPoint("RIGHT", libText, "LEFT", -5, 0)

  local powered_by = container:CreateFontString("ARTWORK", nil, "GameFontNormalSmall")
  powered_by:SetPoint("RIGHT", libLogo, "LEFT", -5,0)
  powered_by:SetText(B2H:setTextColor("powered by:", "white"))
end

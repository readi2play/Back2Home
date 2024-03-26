--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local addon = {
  ["icon"] = GetAddOnMetadata(AddonName, "IconTexture"),
  ["version"] = GetAddOnMetadata(AddonName, "Version"),
  ["author"] = GetAddOnMetadata(AddonName, "Author")
}
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillInfoPanel(panel, infoContainer)
  local logo = B2H:Icon(addon.icon, 80, 80, infoContainer)
  logo:SetPoint("TOP", 0, -20)

  local headline_infos = infoContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  headline_infos:SetPoint("TOP", logo, "BOTTOM", 0, -20)
  headline_infos:SetText(B2H:setTextColor(AddonName, "b2h"))

  local infos_text = infoContainer:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  infos_text:SetPoint("TOP", headline_infos, "BOTTOM", 0, -5)
  infos_text:SetText(
    B2H:setTextColor(B2H:l10n("infoAddonVersion"), "b2h") .. " " ..
    B2H:setTextColor(addon.version .. "\n", "white") ..
    B2H:setTextColor(B2H:l10n("infoAddonAuthor"), "b2h") .. " " ..
    B2H:setTextColor(addon.author .. "\n", "readi")
  )

  local headline_commands = infoContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  headline_commands:SetPoint("TOPLEFT", infoContainer, 0, -180)
  headline_commands:SetText(B2H:setTextColor(B2H:l10n("infoTextHeadline"), "b2h"))

  local text_commands = infoContainer:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  text_commands:SetPoint("TOPLEFT", headline_commands, "BOTTOMLEFT", 0, -10)
  text_commands:SetJustifyH("LEFT")
  text_commands:SetJustifyV("TOP")
  text_commands:SetWordWrap(true)
  text_commands:SetWidth(b2h.windowWidth - 18)
  text_commands:SetText(
    B2H:setTextColor(B2H:l10n("infoText1"), "b2h_light") .. " " ..
    B2H:setTextColor(AddonName, "b2h") .. " " ..
    B2H:setTextColor(B2H:l10n("infoText2"), "b2h_light") .. "\n\n" ..
    B2H:setTextColor("/home ", "b2h") ..
    B2H:setTextColor("shuffle | random | update | mix", "white") .. "\n\n" ..
    B2H:setTextColor(B2H:l10n("infoText3"), "white") .. "\n\n" ..
    B2H:setTextColor("/b2h ", "b2h") ..
    B2H:setTextColor("shuffle | random | update | mix", "white") .."\n\n\n\n" ..
    B2H:setTextColor(B2H:l10n("infoText4"), "b2h_light") .. " " ..
    B2H:setTextColor(AddonName, "b2h") .. " " ..
    B2H:setTextColor(B2H:l10n("infoText5"), "b2h_light") .. "\n\n" ..
    B2H:setTextColor("/home ", "b2h") ..
    B2H:setTextColor("config | options | settings", "white") .. "\n\n" ..
    B2H:setTextColor(B2H:l10n("infoText3"), "white") .. "\n\n" ..
    B2H:setTextColor("/b2h ", "b2h") ..
    B2H:setTextColor("config | options | settings".."\n\n\n\n\n", "white") ..
    B2H:setTextColor(B2H:l10n("infoText6"), "white") .. " " ..
    B2H:setTextColor(AddonName, "b2h") .. " " ..
    B2H:setTextColor(B2H:l10n("infoText7"), "white") .. "\n\n" ..
    B2H:setTextColor(B2H:l10n("infoText8"), "white") .. "\n\n" ..
    B2H:setTextColor(addon.author, "readi")
  )
end

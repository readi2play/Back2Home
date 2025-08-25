--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
b2h.anchors = {"TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT"}
local data = CopyTable(B2H.data)
data.keyword = "anchoring"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
B2H.Anchoring = B2H.Anchoring or {
  fields = {},
}
--------------------------------------------------------------------------------
B2H.Anchoring.panel, B2H.Anchoring.container, B2H.Anchoring.anchorline = READI:OptionPanel(data, {
  name = B2H.L["Anchoring"],
  parent = AddonName,
  title = {
    text = B2H.L["Anchoring"],
    color = "b2h"
  }
})
--------------------------------------------------------------------------------
local _posXname = format("%s_%sEditBox_parent_pos_x", data.prefix, "SettingsPanel")
local _posYname = format("%s_%sEditBox_parent_pos_y", data.prefix, "SettingsPanel")
local _parentName = format("%s_%sEditBox_parent_frame", data.prefix, "SettingsPanel" )
local _sizeName = format("%s_%sSlider_button_size", data.prefix, "SettingsPanel")
local _strataName = format("%s_%sDropdown_button_strata", data.prefix, "SettingsPanel")

function B2H.Anchoring:Initialize()
  local panel, container, anchorline = B2H.Anchoring.panel, B2H.Anchoring.container, B2H.Anchoring.anchorline
  local category = Settings.RegisterCanvasLayoutSubcategory(Settings.GetCategory(AddonName), B2H.Anchoring.panel, B2H.L[READI.Helper.string:Capitalize(data.keyword)])
  Settings.RegisterAddOnCategory(category)

  local function BuildAnchorGrid(wrapper, cols, option)
    for i,value in ipairs(b2h.anchors) do
      local parent = wrapper
      local p_anchor = "TOPLEFT"
      local x = 0
      local y = 0

      if i == 1 then
        x = 32
      elseif i == 2 then
        p_anchor = "TOP"
        x = -32
      elseif i == cols then
        p_anchor = "TOPRIGHT"
        x = -96
      else
        local btnName = format("%sRadioButton_%s_%s", AddonName, option ,b2h.anchors[i - cols]) 
        parent = B2H.Anchoring.fields[btnName]
        p_anchor = "BOTTOMLEFT"
      end
      local btnName = format("%sRadioButton_%s_%s", AddonName, option ,value)
      local textures = {
        normal = READI.T.rdl100001,
        highlight = READI.T.rdl100002,
        active = READI.T.rdl100003,
      }
      B2H.Anchoring.fields[btnName] = READI:RadioButton(data, {
        name = btnName,
        option = option,
        value = value,
        region = container,
        textures = textures,
        parent = parent,
        p_anchor = p_anchor,
        offsetX = x,
        offsetY = y,
        onClick = function()
          local rb = B2H.Anchoring.fields[btnName]
          for i, val in ipairs(b2h.anchors) do
            local btnName = format("%sRadioButton_%s_%s", AddonName, option, val)
            local btn = B2H.Anchoring.fields[btnName]
            if btn.value ~= rb.value then
              btn:SetChecked(false)
              btn.tex:SetTexture(textures.normal)
            end
          end
          rb:SetChecked(true)
          rb.tex:SetTexture(textures.active)
          B2H.db.anchoring[option] = rb.value
          B2H.HSButton:SetPosition()
        end,
        onReset = function()
          local rb = B2H.Anchoring.fields[btnName]
          if B2H.defaults.anchoring[option] == rb.value and not rb:GetChecked() then rb:Click() end
        end
      })

      if B2H.db.anchoring[option] == value then
        B2H.Anchoring.fields[btnName]:SetChecked()
        B2H.Anchoring.fields[btnName].tex:SetTexture(textures.active)
      end    
    end
  end

  local cols = 3
  for _,val in pairs({"button", "parent"}) do
    local offsetX = 0
    if val == "parent" then
      offsetX = b2h.columnWidth + 20
    end

    local title = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    title:SetPoint("TOPLEFT", anchorline, offsetX, -20)
    title:SetText(B2H:setTextColor(format(B2H.L[READI.Helper.string:Capitalize(val) .. " Anchor"], AddonName), "b2h"))

    local subTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
    subTitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
    subTitle:SetJustifyH("LEFT")
    subTitle:SetJustifyV("TOP")
    subTitle:SetWordWrap(true)
    subTitle:SetWidth(b2h.columnWidth)
    if val == "button" then
      local txt = format(B2H.L["Select the anchor point of the %s Button that should be aligned to its parent frame."],READI.Helper.color:Get("b2h", B2H.Colors, AddonName))
      subTitle:SetText(READI.Helper.color:Get("white", nil, txt))
    else
      subTitle:SetText(
        READI.Helper.color:Get("white", nil, format(B2H.L["Select the parent frame's anchor point the %s Button should be anchored to."], READI.Helper.color:Get("b2h", B2H.Colors, AddonName)))
      )
    end
  
    local wrapper = CreateFrame("Frame", format("%s_anchorWrapper", val))
    wrapper:SetPoint("TOPLEFT", subTitle, "BOTTOMLEFT", 0, -10)
    wrapper:SetPoint("BOTTOMRIGHT", subTitle, "BOTTOMRIGHT", 0, -80)

    -- create the anchor position radios
    BuildAnchorGrid(wrapper, cols, format("%s_anchor", val))
  end

  local position_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  position_sectionTitle:SetPoint("TOPLEFT", _G["button_anchorWrapper"], "BOTTOMLEFT", 0, -20)
  position_sectionTitle:SetText(B2H:setTextColor(B2H.L["Position Offset"], "b2h"))

  local position_cols = 2
  local posColWidth = b2h.columnWidth / position_cols - 20

  local positionX_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionX_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", 0, -5)
  positionX_sectionTitle:SetText(B2H:setTextColor(B2H.L["X-Offset"], "white"))

  B2H.Anchoring.fields[_posXname] = READI:EditBox(data, {
    name = _posXname,
    region = container,
    type = "number",
    step = 0.25,
    value = B2H.db.anchoring.position_x or B2H.defaults.anchoring.position_x,
    width = posColWidth,
    parent = positionX_sectionTitle,
    showButtons = true,
    okayForNumber = false,
    onChange = function()
      B2H.db.anchoring.position_x = B2H.Anchoring.fields[_posXname]:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      B2H.Anchoring.fields[_posXname]:SetText(B2H.defaults.anchoring.position_x)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })

  local positionY_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionY_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", posColWidth + 20, -5)
  positionY_sectionTitle:SetText(B2H:setTextColor(B2H.L["Y-Offset"], "white"))

  B2H.Anchoring.fields[_posYname] = READI:EditBox(data, {
    name = _posYname,
    region = container,
    type = "number",
    step = 0.25,
    value = B2H.db.anchoring.position_y or B2H.defaults.anchoring.position_y,
    width = posColWidth,
    parent = positionY_sectionTitle,
    showButtons = true,
    okayForNumber = false,
    onChange = function()
      B2H.db.anchoring.position_y = B2H.Anchoring.fields[_posYname]:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      B2H.Anchoring.fields[_posYname]:SetText(B2H.defaults.anchoring.position_y)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })

  -- define the parent related fields
  local parentFrame_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  parentFrame_sectionTitle:SetPoint("TOPLEFT", _G["parent_anchorWrapper"], "BOTTOMLEFT", 0, -20)
  parentFrame_sectionTitle:SetText(B2H:setTextColor(B2H.L["Parent Frame"], "b2h"))

  local parentFrame_nameTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  parentFrame_nameTitle:SetPoint("TOPLEFT", parentFrame_sectionTitle, "BOTTOMLEFT", 0, -5)
  parentFrame_nameTitle:SetText(B2H:setTextColor(B2H.L["Enter the name of the parent frame"], "white"))

  B2H.Anchoring.fields[_parentName] = READI:EditBox(data, {
    name = _parentName,
    region = container,
    type = "text",
    value = B2H.db.anchoring.frame or B2H.defaults.anchoring.frame,
    width = b2h.columnWidth,
    parent = parentFrame_nameTitle,
    showButtons = true,
    onChange = function()
      B2H.db.anchoring.frame = B2H.Anchoring.fields[_parentName]:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      B2H.Anchoring.fields[_parentName]:SetText(B2H.defaults.anchoring.frame)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })
  B2H.Anchoring.fields[_parentName.."FrameSelectorButton"] = READI:Button(data, {
    name = _parentName.."FrameSelectorButton",
    region = container,
    label = "",
    tooltip = READI:l10n("general.tooltips.buttons.frameSelector"),
    width = 22,
    height = 22,
    anchor = "LEFT",
    parent = B2H.Anchoring.fields[_parentName],
    p_anchor = "RIGHT",
    offsetX = 5,
    onClick = function(self)
      local field = B2H.Anchoring.fields[_parentName]
      data.frameName = field:GetText()
      READI:StartFrameSelector(data, B2H.db.anchoring.frame, field)
    end,
  })
  B2H.Anchoring.fields[_parentName.."FrameSelectorButton"].symbol = READI:Icon(data, {
    name = AddonName.."FrameSelectorButtonSymbol",
    region = B2H.Anchoring.fields[_parentName.."FrameSelectorButton"],
    texture = READI.T.rdl120001,
    width = 14,
    height = 14
  })
  B2H.Anchoring.fields[_parentName.."FrameSelectorButton"].symbol:SetPoint("CENTER", B2H.Anchoring.fields[_parentName.."FrameSelectorButton"], "CENTER", 0, 0)
  B2H.Anchoring.fields[_parentName]:SetWidth(b2h.columnWidth - B2H.Anchoring.fields[_parentName.."FrameSelectorButton"]:GetWidth() - 10)

  local buttonSizeTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonSizeTitle:SetPoint("TOPLEFT", B2H.Anchoring.fields[_posXname], "BOTTOMLEFT", 0, -20)
  buttonSizeTitle:SetText(B2H:setTextColor(B2H.L["Button Size"], "b2h"))

  B2H.Anchoring.fields[_sizeName] = READI:Slider(data, {
    region = container,
    name = _sizeName,
    min = 24,
    max = 64,
    step = 8,
    value = B2H.db.anchoring.button_size or B2H.defaults.anchoring.button_size,
    width = b2h.columnWidth - 20,
    anchor = "TOPLEFT",
    parent = buttonSizeTitle,
    p_anchor = "BOTTOMLEFT",
    offsetX = 0,
    offsetY = -20,
    onChange = function ()
      local slider = B2H.Anchoring.fields[_sizeName]
      B2H.db.anchoring.button_size = slider:GetValue()
      _G[slider.name.."Text"]:SetText(slider:GetValue())
        B2H.HSButton:ScaleButton()
    end,
    onReset = function ()
      B2H.Anchoring.fields[_sizeName]:SetValue(B2H.defaults.anchoring.button_size)
    end
  })

  local buttonStrataTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonStrataTitle:SetPoint("TOPLEFT", B2H.Anchoring.fields[_parentName], "BOTTOMLEFT", 0, -20)
  buttonStrataTitle:SetText(B2H:setTextColor(B2H.L["Button Strata"], "b2h"))

  B2H.Anchoring.fields[_strataName] = READI:DropDown(data, {
    values = {
      "PARENT",
      "BACKGROUND",
      "LOW",
      "MEDIUM",
      "HIGH",
      "DIALOG",
      "FULLSCREEN",
      "FULLSCREEN_DIALOG",
      "TOOLTIP",
    },
    storage = "B2H.db.anchoring",
    option = "button_strata",
    name = _strataName,
    region = container,
    width = b2h.columnWidth - 20,
    parent = buttonStrataTitle,
    offsetX = -20,
    offsetY = -15,
    onReset = function()
      B2H.db.anchoring.button_strata = B2H.defaults.anchoring.button_strata
      UIDropDownMenu_SetText(B2H.Anchoring.fields[_strataName], B2H.defaults.anchoring.button_strata)
      CloseDropDownMenus()    
    end,
    onChange = function () B2H.HSButton:SetStrata() end
  })

  local btn_Reset = READI:Button(data,
    {
      name = AddonName..READI.Helper.string:Capitalize(data.keyword).."ResetButton",
      region = panel,
      label = READI:l10n("general.labels.buttons.reset"),
      anchor = "BOTTOMLEFT",
      parent = panel,
      offsetY = 20,
      onClick = function()
        B2H.db[data.keyword] = CopyTable(B2H.defaults[data.keyword])
        EventRegistry:TriggerEvent(format("%s_%s_RESET", data.prefix, string.upper(data.keyword)))
        B2H[READI.Helper.string:Capitalize(data.keyword)]:Update()
    end
    }
  )
end
function B2H.Anchoring:Update()
  B2H.Anchoring.fields[_posXname]:SetText( B2H.db.anchoring.position_x)
  B2H.Anchoring.fields[_posYname]:SetText( B2H.db.anchoring.position_y)
  B2H.Anchoring.fields[_parentName]:SetText( B2H.db.anchoring.frame)
  B2H.Anchoring.fields[_sizeName]:SetValue( B2H.db.anchoring.button_size)
  B2H.Anchoring.fields[_strataName]:SetValue( B2H.db.anchoring.button_strata)

  for _,val in pairs({"button", "parent"}) do
    for i, anchor in pairs(b2h.anchors) do
      local rb = B2H.Anchoring.fields[format("%sRadioButton_%s_%s", AddonName, format("%s_anchor", val), anchor)]
      if rb.value == B2H.db.anchoring[format("%s_anchor", val)] then
        rb:Click()
        break;
      end
    end
  end
end

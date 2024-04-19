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
function B2H:FillAnchoringPanel(panel, container, anchorline)
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
        parent = _G[btnName]
        p_anchor = "BOTTOMLEFT"
      end
      local btnName = format("%sRadioButton_%s_%s", AddonName, option ,value)
      local textures = {
        normal = B2H.T.rdl100001,
        highlight = B2H.T.rdl100002,
        active = B2H.T.rdl100003,
      }
      _G[btnName] = READI:RadioButton(data, {
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
          local rb = _G[btnName]
          for i, val in ipairs(b2h.anchors) do
            local btnName = format("%sRadioButton_%s_%s", AddonName, option, val)
            local btn = _G[btnName]
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
          local rb = _G[btnName]
          if B2H.defaults.anchoring[option] == rb.value and not rb:GetChecked() then rb:Click() end
        end
      })

      if B2H.db.anchoring[option] == value then
        _G[btnName]:SetChecked()
        _G[btnName].tex:SetTexture(textures.active)
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
    title:SetText(B2H:setTextColor(format(READI:l10n("config.panels.anchoring.anchors."..val..".headline", "B2H.L"), AddonName), "b2h"))

    local subTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
    subTitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
    subTitle:SetJustifyH("LEFT")
    subTitle:SetJustifyV("TOP")
    subTitle:SetWordWrap(true)
    subTitle:SetWidth(b2h.columnWidth)
    subTitle:SetText(
      B2H:setTextColor(format(READI:l10n("config.panels.anchoring.anchors."..val..".subline", "B2H.L"), AddonName), "b2h_light")
    )
  
    local wrapper = CreateFrame("Frame", format("%s_anchorWrapper", val))
    wrapper:SetPoint("TOPLEFT", subTitle, "BOTTOMLEFT", 0, -10)
    wrapper:SetPoint("BOTTOMRIGHT", subTitle, "BOTTOMRIGHT", 0, -80)

    -- create the anchor position radios
    BuildAnchorGrid(wrapper, cols, format("%s_anchor", val))
  end

  local position_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  position_sectionTitle:SetPoint("TOPLEFT", _G["button_anchorWrapper"], "BOTTOMLEFT", 0, -20)
  position_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.offset.headline", "B2H.L"), "b2h"))

  local position_cols = 2
  local posColWidth = b2h.columnWidth / position_cols - 20

  local positionX_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionX_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", 0, -5)
  positionX_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.offset.x", "B2H.L"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_pos_x"] = READI:EditBox(data, {
    region = container,
    type = "number",
    step = 0.25,
    value = B2H.db.anchoring.position_x or B2H.defaults.anchoring.position_x,
    width = posColWidth,
    parent = positionX_sectionTitle,
    showButtons = true,
    okayForNumber = false,
    onChange = function()
      local eb = _G[AddonName .. "EditBox_parent_pos_x"]
      B2H.db.anchoring.position_x = eb:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      local eb = _G[AddonName .. "EditBox_parent_pos_x"]
      eb:SetText(B2H.defaults.anchoring.position_x)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })

  local positionY_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionY_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", posColWidth + 20, -5)
  positionY_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.offset.y", "B2H.L"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_pos_y"] = READI:EditBox(data, {
    region = container,
    type = "number",
    step = 0.25,
    value = B2H.db.anchoring.position_y or B2H.defaults.anchoring.position_y,
    width = posColWidth,
    parent = positionY_sectionTitle,
    showButtons = true,
    okayForNumber = false,
    onChange = function()
      local eb = _G[AddonName .. "EditBox_parent_pos_y"]
      B2H.db.anchoring.position_y = eb:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      local eb = _G[AddonName .. "EditBox_parent_pos_y"]
      eb:SetText(B2H.defaults.anchoring.position_y)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })

  -- define the parent related fields
  local parentFrame_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  parentFrame_sectionTitle:SetPoint("TOPLEFT", _G["parent_anchorWrapper"], "BOTTOMLEFT", 0, -20)
  parentFrame_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.parent.headline", "B2H.L"), "b2h"))

  local parentFrame_nameTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  parentFrame_nameTitle:SetPoint("TOPLEFT", parentFrame_sectionTitle, "BOTTOMLEFT", 0, -5)
  parentFrame_nameTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.parent.subline", "B2H.L"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_frame"] = READI:EditBox(data, {
    region = container,
    type = "text",
    value = B2H.db.anchoring.frame or B2H.defaults.anchoring.frame,
    width = b2h.columnWidth,
    parent = parentFrame_nameTitle,
    showButtons = true,
    onChange = function()
      local eb = _G[AddonName .. "EditBox_parent_frame"]
      B2H.db.anchoring.frame = eb:GetText()
      B2H.HSButton:SetPosition()
    end,
    onReset = function()
      local eb = _G[AddonName .. "EditBox_parent_frame"]
      eb:SetText(B2H.defaults.anchoring.frame)
      EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnChange"))
    end
  })
  _G[AddonName.."FrameSelectorButton"] = READI:Button(data, {
    name = AddonName.."FrameSelectorButton",
    region = container,
    label = "",
    tooltip = READI:l10n("general.tooltips.buttons.frameSelector"),
    width = 22,
    height = 22,
    anchor = "LEFT",
    parent = _G[AddonName.."EditBox_parent_frame"],
    p_anchor = "RIGHT",
    offsetX = 5,
    onClick = function(self)
      local field = _G[AddonName .. "EditBox_parent_frame"]
      data.frameName = field:GetText()
      READI:StartFrameSelector(data, B2H.db.anchoring.frame, field)
    end,
  })
  _G[AddonName.."FrameSelectorButton"].symbol = READI:Icon(data, {
    name = AddonName.."FrameSelectorButtonSymbol",
    region = _G[AddonName.."FrameSelectorButton"],
    texture = B2H.T.rdl120001,
    width = 14,
    height = 14
  })
  _G[AddonName.."FrameSelectorButton"].symbol:SetPoint("CENTER", _G[AddonName.."FrameSelectorButton"], "CENTER", 0, 0)
  _G[AddonName .. "EditBox_parent_frame"]:SetWidth(b2h.columnWidth - _G[AddonName.."FrameSelectorButton"]:GetWidth() - 10)

  local buttonSizeTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonSizeTitle:SetPoint("TOPLEFT", _G[AddonName .. "EditBox_parent_pos_x"], "BOTTOMLEFT", 0, -20)
  buttonSizeTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.button.size.headline", "B2H.L"), "b2h"))

  _G[AddonName.."Slider_button_size"] = READI:Slider(data, {
    region = container,
    name = "button_size",
    min = 16,
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
      local slider = _G[AddonName.."Slider_button_size"]
      B2H.db.anchoring.button_size = slider:GetValue()
      _G[slider.name.."Text"]:SetText(slider:GetValue())
        B2H.HSButton:ScaleButton()
    end,
    onReset = function ()
      _G[AddonName.."Slider_button_size"]:SetValue(B2H.defaults.anchoring.button_size)
    end
  })

  local buttonStrataTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonStrataTitle:SetPoint("TOPLEFT", _G[AddonName .. "EditBox_parent_frame"], "BOTTOMLEFT", 0, -20)
  buttonStrataTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.anchoring.button.strata.headline", "B2H.L"), "b2h"))

  _G[AddonName.."Dropdown_button_strata"] = READI:DropDown(data, {
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
    name = AddonName.."Dropdown_button_strata",
    region = container,
    width = b2h.columnWidth - 20,
    parent = buttonStrataTitle,
    offsetX = -20,
    offsetY = -15,
    onReset = function()
      B2H.db.anchoring.button_strata = B2H.defaults.anchoring.button_strata
      UIDropDownMenu_SetText(_G[AddonName.."Dropdown_button_strata"], B2H.defaults.anchoring.button_strata)
      CloseDropDownMenus()    
    end,
    onChange = function() B2H.HSButton:SetStrata() end
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
        EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnReset"))
        B2H.HSButton:SetPosition()
      end
    }
  )
end

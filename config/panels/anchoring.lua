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
function B2H:FillAnchoringPanel(panel, container)
  local button_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  button_sectionTitle:SetPoint("TOPLEFT", container, "TOPLEFT", 0, -60)
  button_sectionTitle:SetText(B2H:setTextColor(AddonName .. " "..B2H:l10n("button"), "b2h"))

  local button_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  button_sectionSubTitle:SetPoint("TOPLEFT", button_sectionTitle, "BOTTOMLEFT", 0, -5)
  button_sectionSubTitle:SetJustifyH("LEFT")
  button_sectionSubTitle:SetJustifyV("TOP")
  button_sectionSubTitle:SetWordWrap(true)
  button_sectionSubTitle:SetWidth(b2h.columnWidth)
  button_sectionSubTitle:SetText(
    B2H:setTextColor(B2H:l10n("btnAnchor1"), "b2h_light") .. " " ..
    B2H:setTextColor(AddonName, "b2h") .. " " ..
    B2H:setTextColor(B2H:l10n("btnAnchor2"), "b2h_light")
  )

  local parent_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  parent_sectionTitle:SetPoint("TOPLEFT", button_sectionTitle, "TOPLEFT", b2h.columnWidth + 20, 0)
  parent_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("parentAnchorHeadline"), "b2h"))

  local parent_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  parent_sectionSubTitle:SetPoint("TOPLEFT", parent_sectionTitle, "BOTTOMLEFT", 0, -5)
  parent_sectionSubTitle:SetJustifyH("LEFT")
  parent_sectionSubTitle:SetJustifyV("TOP")
  parent_sectionSubTitle:SetWordWrap(true)
  parent_sectionSubTitle:SetWidth(b2h.columnWidth)
  parent_sectionSubTitle:SetText(
    B2H:setTextColor(B2H:l10n("parentAnchor1"), "b2h_light") .. " " ..
    B2H:setTextColor(AddonName, "b2h") .. " " ..
    B2H:setTextColor(B2H:l10n("parentAnchor2"), "b2h_light")
  )

  -- radio button callback functions
  local function ResetRadio(btn, option)
    local val = B2H.defaults.parent[option]
    if val == btn.value then btn:Click() end
  end

  local anchor_cols = 3
  local button_anchorWrapper = CreateFrame("Frame", nil)
  --  button_anchorWrapper.texture = button_anchorWrapper:CreateTexture()
  --  button_anchorWrapper.texture:SetAllPoints(button_anchorWrapper)
  --  button_anchorWrapper.texture:SetColorTexture(1,0,0,.5)
  button_anchorWrapper:SetPoint("TOPLEFT", button_sectionSubTitle, "BOTTOMLEFT", 0, -10)
  button_anchorWrapper:SetPoint("BOTTOMRIGHT", button_sectionSubTitle, "BOTTOMRIGHT", 0, -80)
  -- create the anchor position radios for the Back2Home Button
  for i, value in ipairs(b2h.anchors) do
    local parent = button_anchorWrapper
    local parent_anchor = "TOPLEFT"
    local x = 0
    local y = 0

    if i == 1 then
      x = 32
    elseif i == 2 then
      parent_anchor = "TOP"
      x = -32
    elseif i == anchor_cols then
      parent_anchor = "TOPRIGHT"
      x = -96
    else
      parent = _G[AddonName .. "RadioButton_button_anchor_" .. b2h.anchors[i - anchor_cols]]
      parent_anchor = "BOTTOMLEFT"
    end
    _G[AddonName .. "RadioButton_button_anchor_" .. value] =
      self:RadioButton(data.keyword, container, "button_anchor", value, self.db.parent.button_anchor == value, "TOPLEFT", parent, parent_anchor, x, y)
  end

  local parent_anchorWrapper = CreateFrame("Frame", nil)
  --  parent_anchorWrapper.texture = parent_anchorWrapper:CreateTexture()
  --  parent_anchorWrapper.texture:SetAllPoints(parent_anchorWrapper)
  --  parent_anchorWrapper.texture:SetColorTexture(0,1,0,.5)
  parent_anchorWrapper:SetPoint("TOPLEFT", parent_sectionSubTitle, "BOTTOMLEFT", 0, -10)
  parent_anchorWrapper:SetPoint("BOTTOMRIGHT", parent_sectionSubTitle, "BOTTOMRIGHT", 0, -80)
  -- create the anchor position radios for the Back2Home Button's parent frame
  for i, value in ipairs(b2h.anchors) do
    parent = parent_anchorWrapper
    x = 0
    y = 0

    if i == 1 then
      parent_anchor = "TOPLEFT"
      x = 32
    elseif i == 2 then
      parent_anchor = "TOP"
      x = -32
    elseif i == anchor_cols then
      parent_anchor = "TOPRIGHT"
      x = -96
    else
      parent = _G[AddonName .. "RadioButton_parent_anchor_" .. b2h.anchors[i - anchor_cols]]
      parent_anchor = "BOTTOMLEFT"
    end
    _G[AddonName .. "RadioButton_parent_anchor_" .. value] =
      self:RadioButton(data.keyword, container, "parent_anchor", value, self.db.parent.parent_anchor == value, "TOPLEFT", parent, parent_anchor, x, y)
  end

  -- define the position fields
  local position_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  position_sectionTitle:SetPoint("TOPLEFT", button_anchorWrapper, "BOTTOMLEFT", 0, -20)
  position_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("offsetHeadline"), "b2h"))

  local position_cols = 2
  local posColWidth = b2h.columnWidth / position_cols - 20

  local positionX_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionX_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", 0, -5)
  positionX_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("offsetX"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_pos_x"] = self:EditBox(data.keyword, "position_x", self.db.parent.position_x or self.defaults.parent.position_x, container, posColWidth, 32, positionX_sectionTitle, 0, 0)

  local positionY_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  positionY_sectionTitle:SetPoint("TOPLEFT", position_sectionTitle, "BOTTOMLEFT", posColWidth + 20, -5)
  positionY_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("offsetY"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_pos_y"] = self:EditBox(data.keyword, "position_y", self.db.parent.position_y or self.defaults.parent.position_y, container, posColWidth, 32, positionY_sectionTitle, 0, 0)

  -- define the parent related fields
  local parentFrame_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  parentFrame_sectionTitle:SetPoint("TOPLEFT", parent_anchorWrapper, "BOTTOMLEFT", 0, -20)
  parentFrame_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("parentFrameHeadline"), "b2h"))

  local parentFrame_nameTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  parentFrame_nameTitle:SetPoint("TOPLEFT", parentFrame_sectionTitle, "BOTTOMLEFT", 0, -5)
  parentFrame_nameTitle:SetText(B2H:setTextColor(B2H:l10n("parentFrameName"), "b2h_light"))

  _G[AddonName .. "EditBox_parent_frame"] = self:EditBox(data.keyword, "frame", self.db.parent.frame or self.defaults.parent.frame, container, b2h.columnWidth, 32, parentFrame_nameTitle, 0, 0)

  local buttonSizeTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonSizeTitle:SetPoint("TOPLEFT", _G[AddonName .. "EditBox_parent_pos_x"], "BOTTOMLEFT", 0, -20)
  buttonSizeTitle:SetText(B2H:setTextColor(B2H:l10n("buttonSizeSliderHeadline"), "b2h"))

  _G[AddonName.."Slider_button_size"] = B2H:Slider(data.keyword, container, "button_size", 16, 64, 8, self.db.parent.button_size or self.defaults.parent.button_size, b2h.columnWidth - 20, "TOPLEFT", buttonSizeTitle, "BOTTOMLEFT", 0, -20, function (self)
    B2H.db.parent.button_size = self:GetValue()
    _G[self.name.."Text"]:SetText(self:GetValue())
      B2H.HSButton:ScaleButton()
  end, function ()
    _G[AddonName.."Slider_button_size"]:SetValue(B2H.defaults.parent.button_size)
  end)

  local buttonStrataTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  buttonStrataTitle:SetPoint("TOPLEFT", _G[AddonName .. "EditBox_parent_frame"], "BOTTOMLEFT", 0, -20)
  buttonStrataTitle:SetText(B2H:setTextColor(B2H:l10n("buttonStrataDropdownHeadline"), "b2h"))

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
    storage = B2H.db.parent,
    option = "button_strata",
    name = AddonName.."Dropdown_button_strata",
    region = container,
    width = b2h.columnWidth - 20,
    parent = buttonStrataTitle,
    offsetX = -20,
    offsetY = -20,
    onReset = function()
      B2H.db.parent.button_strata = B2H.defaults.parent.button_strata
      UIDropDownMenu_SetText(_G[AddonName.."Dropdown_button_strata"], B2H.defaults.parent.button_strata)
      CloseDropDownMenus()    
    end,
    onChange = function() B2H.HSButton:SetStrata() end
  })

  local btn_Reset = READI:Button(data,
    {
      name = AddonName..READI.Helper.string.Capitalize(data.keyword).."ResetButton",
      region = panel,
      label = B2H:l10n("resetBtnLbl"),
      anchor = "BOTTOMLEFT",
      parent = container,
      offsetY = 20,
      onClick = function()
        B2H.HSButton:SetPosition()
        EventRegistry:TriggerEvent(data.addon.."."..data.keyword..".OnReset")
      end
    }
  )
end

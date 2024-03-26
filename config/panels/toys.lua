--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillToysPanel(panel, toysContainer)
  local toys_sectionTitle = toysContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  toys_sectionTitle:SetPoint("TOPLEFT", toysContainer, 0, -60)
  toys_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("toysHeadline"), "b2h"))

  local toys_sectionSubTitle = toysContainer:CreateFontString("ARTWORK", nil, "GameFontNormal")
  toys_sectionSubTitle:SetPoint("TOPLEFT", toys_sectionTitle, 0, -20)
  toys_sectionSubTitle:SetText(B2H:setTextColor(B2H:l10n("toysSubHeadline"), "b2h_light"))

  local numRows = #self.db.toys / b2h.columns
  local lastToy = self.db.toys[#self.db.toys]

  for i = 1, #self.db.toys do
    local current = self.db.toys[i]
    local owned = PlayerHasToy(current.id)
    local label = select(2, C_ToyBox.GetToyInfo(current.id))  
    local anchor_to_element = toys_sectionSubTitle
    local anchor_to = "BOTTOMLEFT"
    local y = 0
    local x = 0
    if i == 1 then
      y = -10
    elseif i > 1 and i <= b2h.columns then
      anchor_to = "TOPLEFT"
      anchor_to_element = _G[AddonName .. "CheckButton_" .. self.db.toys[i - 1].id]
      x = b2h.columnWidth + 20
    else
      anchor_to_element = _G[AddonName .. "CheckButton_" .. self.db.toys[i - b2h.columns].id]
    end
    _G[AddonName .. "CheckButton_" .. current.id] = self:Checkbox("toys", toysContainer, current.id, label, "TOPLEFT", anchor_to_element, anchor_to, x, y, (current.active and owned),
    -- UPDATE DATABASE - calllback function
    function ()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      B2H.db.toys[i].active = cb:GetChecked()
      B2H.HSButton:Shuffle()
    end,
    -- RESET TO DEFAULT - calllback function
      function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      cb:SetChecked(B2H.defaults.toys[i].active)
      B2H.HSButton:Shuffle()
    end,
    -- SELECT ALL - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      cb:SetChecked(true)
      B2H.HSButton:Shuffle()
    end,
    -- UNSELECT ALL - calllback function
      function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      cb:SetChecked(false)
      B2H.HSButton:Shuffle()
    end)
  end

  local fallback_sectionSubTitle = toysContainer:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  fallback_sectionSubTitle:SetPoint("TOPLEFT", _G[AddonName .. "CheckButton_" .. lastToy.id], "BOTTOMLEFT", 0, -20)
  fallback_sectionSubTitle:SetJustifyH("LEFT")
  fallback_sectionSubTitle:SetJustifyV("TOP")
  fallback_sectionSubTitle:SetWordWrap(true)
  fallback_sectionSubTitle:SetWidth(b2h.windowWidth - 20)
  fallback_sectionSubTitle:SetText(B2H:setTextColor(B2H:l10n("fallbackText"), "b2h_light"))

  _G[AddonName .. "CheckButton_" .. self.db.fallback.id] = self:Checkbox("toys", toysContainer, self.db.fallback.id, GetItemInfo(self.db.fallback.id), "TOPLEFT", fallback_sectionSubTitle, "BOTTOMLEFT", 0, -10, true,
  -- UPDATE DATABASE - calllback function
  function()
    local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
    B2H.db.fallback.active = cb:GetChecked()
  end,
  -- RESET TO DEFAULT - calllback function
  function()
    local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
    cb:SetChecked(B2H.defaults.fallback.active)
  end,
  -- SELECT ALL - calllback function
  function()
    local cb = _G[AddonName .. "CheckButton_" .. current.id]
    cb:SetChecked(true)
    B2H.HSButton:Shuffle()
  end,
  -- UNSELECT ALL - calllback function
  function()
    local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
    cb:SetChecked(false)
    B2H.HSButton:Shuffle()
  end)

  local btn_Reset = B2H:Button(panel, "UIPanelButtonTemplate", B2H:l10n("resetBtnLbl"), nil, nil, nil, true, "BOTTOMLEFT", toysContainer, "BOTTOMLEFT", 0, 20, function()
    _G[AddonName .. "DB"].toys = CopyTable(self.defaults.toys)
    self.db = _G[AddonName .. "DB"]
    EventRegistry:TriggerEvent("B2H.OnReset")
  end)

  local btn_UnselectAll = B2H:Button(panel, "UIPanelButtonTemplate", B2H:l10n("unselectAllBtnLbl"), nil, nil, nil, true, "TOPLEFT", btn_Reset, "TOPRIGHT", 20, 0, function()
    EventRegistry:TriggerEvent("B2H.OnUnselectAll")
  end)
end

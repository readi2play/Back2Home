--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "toys"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillToysPanel(panel, container)

  local toys_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  toys_sectionTitle:SetPoint("TOPLEFT", container, 0, -60)
  toys_sectionTitle:SetText(B2H:setTextColor(B2H:l10n("toysHeadline"), "b2h"))

  local toys_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontNormal")
  toys_sectionSubTitle:SetPoint("TOPLEFT", toys_sectionTitle, 0, -20)
  toys_sectionSubTitle:SetText(B2H:setTextColor(B2H:l10n("toysSubHeadline"), "b2h_light"))

  local numRows = #self.db.toys / b2h.columns
  local lastToy = self.db.toys[#self.db.toys]

  for i = 1, #self.db.toys do
    local current = self.db.toys[i]
    local owned = PlayerHasToy(current.id)
    local label = select(2, C_ToyBox.GetToyInfo(current.id))
    local link = C_ToyBox.GetToyLink(current.id)
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
    _G[AddonName .. "CheckButton_" .. current.id] = self:Checkbox(data.keyword, container, current.id, label, "TOPLEFT", anchor_to_element, anchor_to, x, y, owned,
    -- UPDATE DATABASE - calllback function
    function ()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      B2H.db.toys[i].active = cb:GetChecked()
      B2H.HSButton:Update(true)
    end,
    -- RESET TO DEFAULT - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      if B2H.defaults.toys[i].active and not cb:GetChecked() then
        cb:Click()
      end
    end,
    -- SELECT ALL - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      if not cb:GetChecked() then
        cb:Click()
      end
    end,
    -- UNSELECT ALL - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      if cb:GetChecked() then
        cb:Click()
      end
    end)
    
    _G[AddonName .. "CheckButton_" .. current.id].Update = function(evt)
      local owned = PlayerHasToy(current.id) or B2H.IsTesting
      local cb = _G[AddonName .. "CheckButton_" .. current.id]
      if owned and not cb:IsEnabled() then
        cb:Enable()
        cb:Click()
        READI.Debug:Notify(B2H:setTextColor(AddonName, "b2h"), B2H.db.others.notifications[data.keyword], link, B2H:l10n("toyAddedNotification"))
      end
    end

    EventRegistry:RegisterCallback("B2H.TOYS_UPDATED", _G[AddonName .. "CheckButton_" .. current.id].Update)
    
  end

  local fallback_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlight")
  fallback_sectionSubTitle:SetPoint("TOPLEFT", _G[AddonName .. "CheckButton_" .. lastToy.id], "BOTTOMLEFT", 0, -20)
  fallback_sectionSubTitle:SetJustifyH("LEFT")
  fallback_sectionSubTitle:SetJustifyV("TOP")
  fallback_sectionSubTitle:SetWordWrap(true)
  fallback_sectionSubTitle:SetWidth(b2h.windowWidth - 20)
  fallback_sectionSubTitle:SetText(B2H:setTextColor(B2H:l10n("fallbackText"), "b2h_light"))

  _G[AddonName .. "CheckButton_" .. self.db.fallback.id] = self:Checkbox(data.keyword, container, self.db.fallback.id, GetItemInfo(self.db.fallback.id), "TOPLEFT", fallback_sectionSubTitle, "BOTTOMLEFT", 0, -10, true,
    -- UPDATE DATABASE - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
      B2H.db.fallback.active = cb:GetChecked()
      B2H.HSButton:Update(true)
    end,
    -- RESET TO DEFAULT - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
      if (B2H.defaults.fallback.active and not cb:GetChecked()) then
        cb:Click()
      end
    end,
    -- SELECT ALL - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
      if not cb:GetChecked() then cb:Click() end
    end,
    -- UNSELECT ALL - calllback function
    function()
      local cb = _G[AddonName .. "CheckButton_" .. B2H.db.fallback.id]
      if cb:GetChecked() then cb:Click() end
    end
  )

  local btn_Reset = READI:Button(data,
    {
      name = AddonName..READI.Helper.string.Capitalize(data.keyword).."ResetButton",
      region = panel,
      label = B2H:l10n("resetBtnLbl"),
      anchor = "BOTTOMLEFT",
      parent = container,
      offsetY = 20,
      onClick = function()
        EventRegistry:TriggerEvent(data.addon.."."..data.keyword..".OnReset")
      end
    }
  )

  local btn_UnselectAll = READI:Button(data,
    {
      name = AddonName..READI.Helper.string.Capitalize(data.keyword).."UnselectAllButton",
      region = panel,
      label = B2H:l10n("unselectAllBtnLbl"),
      parent = btn_Reset,
      p_anchor = "TOPRIGHT",
      offsetX = 20,
      onClick = function()
        EventRegistry:TriggerEvent(data.addon.."."..data.keyword..".OnUnselectAll")
      end
    }
  )
end

--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "toys"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
B2H.Toys = B2H.Toys or {}
function B2H:FillToysPanel(panel, container, anchorline)
  local toys_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  toys_sectionTitle:SetPoint("TOPLEFT", anchorline, 0, -20)
  toys_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.toys.headline", "B2H.L"), "b2h"))

  local toys_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontNormal")
  toys_sectionSubTitle:SetPoint("TOPLEFT", toys_sectionTitle, "BOTTOMLEFT", 0, -5)
  toys_sectionSubTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.toys.subline", "B2H.L"), "b2h_light"))

  local numRows = #B2H.db.toys / b2h.columns
  local lastToy = B2H.db.toys[#B2H.db.toys]

  for i,toy in ipairs(B2H.db.toys) do
    local link = C_ToyBox.GetToyLink(toy.id)
    local opts = {
      name = AddonName .. "CheckButton_" .. toy.id,
      region = container,
      label = toy.label[B2H.Locale],
      parent = toys_sectionSubTitle,
      p_anchor = "BOTTOMLEFT",
      offsetY = 0,
      offsetX = 0,
    }

    if i == 1 then
      opts.offsetY = -10
    elseif i > 1 and i <= b2h.columns then
      opts.p_anchor = "TOPLEFT"
      opts.parent = _G[AddonName .. "CheckButton_" .. B2H.db.toys[i - 1].id]
      opts.offsetX = b2h.columnWidth + 20
    else
      opts.parent = _G[AddonName .. "CheckButton_" .. B2H.db.toys[i - b2h.columns].id]
    end
    opts.onClick = function()
      local cb = _G[opts.name]
      B2H.db.toys[i].active = cb:GetChecked()
      B2H.HSButton:Update(true)
    end
    opts.onReset = function()
      local cb = _G[opts.name]
      if toy.owned and not cb:GetChecked() then cb:Click() end
    end
    opts.onClear = function()
      local cb = _G[opts.name]
      if cb:GetChecked() then cb:Click() end
    end
    opts.onSelectAll = function()
      local cb = _G[opts.name]
      if not cb:GetChecked() then cb:Click() end
    end

    _G[opts.name] = READI:CheckBox(data, opts)
    _G[opts.name]:SetState(toy.owned)
    _G[opts.name]:SetChecked(toy.owned and toy.active)

    _G[opts.name].onNewToy = function(evt)
      local owned = PlayerHasToy(toy.id)
      local cb = _G[opts.name]
      if B2H.IsTesting or (owned and not cb:IsEnabled()) then
        if owned and not cb:IsEnabled() then
          cb:Enable()
          cb:Click()
        end
        READI.Debug:Notify(
          B2H:setTextColor(AddonName, "b2h"),
          B2H.db.reporting.notifications[data.keyword],
          link,
          B2H:setTextColor(format(READI:l10n("reporting.notifications.toys.new", "B2H.L"), B2H:setTextColor("/home", "b2h"), B2H:setTextColor("config", "white")), "b2h_light"))
      end
    end

    EventRegistry:RegisterCallback("B2H.TOYS_UPDATED", _G[opts.name].onNewToy)
    
  end

  local fallback_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  fallback_sectionTitle:SetPoint("TOP", _G[AddonName .. "CheckButton_" .. lastToy.id], "BOTTOM", 0, -20)
  fallback_sectionTitle:SetPoint("LEFT", anchorline, "LEFT", 0, 0)
  fallback_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.fallbacks.headline", "B2H.L"), "b2h"))

  local fallback_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontNormal")
  fallback_sectionSubTitle:SetPoint("TOPLEFT", fallback_sectionTitle, "BOTTOMLEFT", 0, -5)
  fallback_sectionSubTitle:SetJustifyH("LEFT")
  fallback_sectionSubTitle:SetJustifyV("TOP")
  fallback_sectionSubTitle:SetWordWrap(true)
  fallback_sectionSubTitle:SetWidth(b2h.windowWidth - 20)
  fallback_sectionSubTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.fallbacks.subline", "B2H.L"), "b2h_light"))

  for i,item in ipairs(B2H.db.fallbacks.items) do
    _G[AddonName .. "CheckButton_" .. item.id] = READI:CheckBox(data, {
      name = AddonName .. "CheckButton_" .. item.id,
      region = container,
      label = item.label[B2H.Locale],
      parent = fallback_sectionSubTitle,
      offsetY = -10,
      onClick = function()
        local cb = _G[AddonName .. "CheckButton_" .. item.id]
        B2H.db.fallbacks.items[i].active = cb:GetChecked()
        B2H.HSButton:Update(true)
      end,
      onReset = function()
        local cb = _G[AddonName .. "CheckButton_" .. item.id]
        if B2H.defaults.fallbacks.items[i].active and not cb:GetChecked() then
          cb:Click()
        end
      end,
      onClear = function()
        local cb = _G[AddonName .. "CheckButton_" .. item.id]
        if cb:GetChecked() then cb:Click() end
      end,
      onSelectAll = function()
        local cb = _G[AddonName .. "CheckButton_" .. item.id]
        if not cb:GetChecked() then cb:Click() end
      end
    })
    _G[AddonName .. "CheckButton_" .. item.id]:SetState()
    _G[AddonName .. "CheckButton_" .. item.id]:SetChecked(item.active)
  end

  
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
      end
    }
  )

  local btn_UnselectAll = READI:Button(data,
    {
      name = AddonName..READI.Helper.string:Capitalize(data.keyword).."UnselectAllButton",
      region = panel,
      label = READI:l10n("general.labels.buttons.unselectAll"),
      parent = btn_Reset,
      p_anchor = "TOPRIGHT",
      offsetX = 20,
      onClick = function()
        EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnClear"))
      end
    }
  )
  end
function B2H.Toys:Update()
  for i,toy in ipairs(B2H.db.toys) do
    if not toy.owned then
      local cb =_G[AddonName .. "CheckButton_" .. toy.id]
      toy.owned = PlayerHasToy(toy.id)
      B2H.defaults.toys[i].owned = PlayerHasToy(toy.id)
      
      B2H.db.toys[i].active = toy.owned
      B2H.defaults.toys[i].active = toy.owned

      cb:SetState(toy.owned)
      cb:SetChecked(toy.owned and toy.active)
    end
  end
end 
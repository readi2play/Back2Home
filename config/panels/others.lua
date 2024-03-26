--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillOthersSettingsPanel(panel, othersContainer)
  local categories = {}

  for category, tbl in pairs(self.db.others) do
    table.insert(categories, category)
    local c_idx = B2H:FindIndex(categories, function(kw) return kw == category end)
    local c_anchor = "TOPLEFT"
    local c_region = othersContainer
    local c_anchor_to = "BOTTOMLEFT"
    local c_x = 0
    local c_y = 0

    if c_idx == 1 then
      c_anchor_to = "TOPLEFT"
      c_y = -40
    elseif c_idx > 1 and c_idx <= b2h.columns then
      c_anchor_to = "TOPLEFT"
      c_region = _G[categories[c_idx - 1].."Section"]
      c_x = b2h.columnWidth + 20
    else
      c_region = _G[categories[c_idx - 2].."Section"]
    end

    _G[category.."Section"] = CreateFrame("Frame", nil, othersContainer)
    _G[category.."Section"]:SetPoint(c_anchor, c_region, c_anchor_to, c_x, c_y)
    _G[category.."Section"]:SetWidth(b2h.columnWidth - 20)
    _G[category.."Section"]:SetHeight(1)
    -- _G[category.."Section"].texture = _G[category.."Section"]:CreateTexture()
    -- _G[category.."Section"].texture:SetAllPoints(_G[category.."Section"])
    -- _G[category.."Section"].texture:SetColorTexture(0,0.98,0.83,.5)

    _G[category.."SectionTitle"] = _G[category.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    _G[category.."SectionTitle"]:SetPoint("TOPLEFT", _G[category.."Section"], "TOPLEFT", 0, -20)
    _G[category.."SectionTitle"]:SetText(B2H:setTextColor(B2H:l10n(category), "b2h"))

    local options = {}
    for option, active in pairs(tbl) do
      table.insert(options, option)
      local idx = B2H:FindIndex(options, function(o) return o == option end)
      local anchor = "TOPLEFT"
      local region = _G[category.."SectionTitle"]
      local anchor_to = "BOTTOMLEFT"
      local x = 0
      local y = 0

      if idx == 1 then
        y = -10
      elseif idx > 1 and idx <= b2h.columns then
        region = _G[category.."Option_"..options[idx - 1]]
        anchor_to = "TOPLEFT"
        x = b2h.columnWidth + 20
      else
        region = _G[category.."Option_"..options[idx - b2h.columns]]
      end

      _G[category.."Option_"..option] = B2H:Checkbox(category, othersContainer, option, B2H:l10n(option..B2H:CapitalizeString(category)), anchor, region, anchor_to, x, y, true,
      -- UPDATE DATABASE - calllback function
      function()
        local cb = _G[category.."Option_"..option]
        B2H.db.others[category][option] = cb:GetChecked()
      end,
      -- RESET TO DEFAULT - calllback function
      function()
        local cb = _G[category.."Option_"..option]
        cb:SetChecked(B2H.defaults.others[category][option])
      end,
      -- SELECT ALL - calllback function
      function()
        local cb = _G[category.."Option_"..option]
        if not cb:GetChecked() then cb:Click() end
      end,
      -- UNSELECT ALL - calllback function
      function()
        local cb = _G[category.."Option_"..option]
        if cb:GetChecked() then cb:Click() end
      end)

    end

    local btn_Reset = B2H:Button(panel, "UIPanelButtonTemplate", B2H:l10n("resetBtnLbl"), nil, nil, nil, true, "BOTTOMLEFT", othersContainer, "BOTTOMLEFT", 0, 20, function()
      _G[AddonName .. "DB"].others = CopyTable(self.defaults.others)
      self.db = _G[AddonName .. "DB"]
      EventRegistry:TriggerEvent("B2H.Debug.OnReset")
    end)
  
    local btn_UnselectAll = B2H:Button(panel, "UIPanelButtonTemplate", B2H:l10n("selectAllBtnLbl"), nil, nil, nil, true, "TOPLEFT", btn_Reset, "TOPRIGHT", 20, 0, function()
      EventRegistry:TriggerEvent("B2H.Debug.OnSelectAll")
    end)  
  end
end
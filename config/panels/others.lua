--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "others"

--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillOthersSettingsPanel(panel, container)
  local categories = READI.Helper.table:Keys(self.db.others)

  for category, tbl in pairs(self.db.others) do
    local c_idx = B2H:FindIndex(categories, function(kw) return kw == category end)
    local c_name = READI.Helper.string:Capitalize(category)
    local c_anchor = "TOPLEFT"
    local c_region = container
    local c_anchor_to = "BOTTOMLEFT"
    local c_x = 0
    local c_y = 0

    if c_idx == 1 then
      c_anchor_to = "TOPLEFT"
      c_y = -40
    else
      c_region = _G[categories[c_idx - 1] .. "Section"]
    end

    _G[category.."Section"] = CreateFrame("Frame", nil, container)
    _G[category.."Section"]:SetPoint(c_anchor, c_region, c_anchor_to, c_x, c_y)
    _G[category.."Section"]:SetWidth(b2h.windowWidth - 20)
    -- _G[category.."Section"].texture = _G[category.."Section"]:CreateTexture()
    -- _G[category.."Section"].texture:SetAllPoints(_G[category.."Section"])
    -- _G[category.."Section"].texture:SetColorTexture(0,0.98,0.83,.5)
    
    _G[category.."SectionTitle"] = _G[category.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    _G[category.."SectionTitle"]:SetPoint("TOPLEFT", _G[category.."Section"], "TOPLEFT", 0, -20)
    _G[category.."SectionTitle"]:SetText(B2H:setTextColor(B2H:l10n(category), "b2h"))
    
    local options = READI.Helper.table:Keys(tbl)
    local rows = #options / b2h.columns
    if rows < 1 then rows = 1 end

    _G[category.."Section"]:SetHeight(26 * rows + 30 + _G[category.."SectionTitle"]:GetHeight())
    
    for option, active in pairs(tbl) do
      local idx = B2H:FindIndex(options, function(o) return o == option end)
      local anchor = "TOPLEFT"
      local parent = _G[category.."SectionTitle"]
      local p_anchor = "BOTTOMLEFT"
      local x = 0
      local y = 0

      if idx == 1 then
        y = -10
      elseif idx > 1 and idx <= b2h.columns then
        parent = _G[category.."Option_"..options[idx - 1]]
        p_anchor = "TOPLEFT"
        x = b2h.columnWidth + 20
      else
        parent = _G[category.."Option_"..options[idx - b2h.columns]]
      end

      print(category, READI.Helper.string:Capitalize(category))
      local opts = {
        ["name"] = AddonName.."CheckBox"..c_name.."_"..option,
        ["region"] = container,
        ["label"] = B2H:l10n(option..c_name),
        ["anchor"] = anchor,
        ["parent"] = parent,
        ["p_anchor"] = p_anchor,
        ["offsetX"] = x,
        ["offsetY"] = y,
        ["onClick"] = function()
          local cb = _G[category.."Option_"..option]
          B2H.db.others[category][option] = cb:GetChecked()
        end,
        ["onReset"] = function()
          local cb = _G[category.."Option_"..option]
          if (B2H.defaults.others[category][option] and not cb:GetChecked()) or
             (not B2H.defaults.others[category][option] and cb:GetChecked()) then
            cb:Click("LeftButton", 1)
          end
        end,
        ["onClear"] = function()
          local cb = _G[category.."Option_"..option]
          if cb:GetChecked() then cb:Click("LeftButton", 1) end
        end,
        ["onSelectAll"] = function()
          local cb = _G[category.."Option_"..option]
          if not cb:GetChecked() then cb:Click("LeftButton", 1) end
        end,
      }
      _G[category.."Option_"..option] = READI:CheckBox(data, opts)
      _G[category.."Option_"..option]:SetState()
      _G[category.."Option_"..option]:SetChecked(B2H.db.others[category][option])
    end

    local btn_Reset = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."ResetButton",
        region = panel,
        label = B2H:l10n("resetBtnLbl"),
        anchor = "BOTTOMLEFT",
        parent = container,
        offsetY = 20,
        onClick = function()
          EventRegistry:TriggerEvent(format("%s.%s.%s", data.addon, data.keyword, "OnReset"))
        end
      }
    )
    print(btn_Reset:GetName())
    local btn_UnselectAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."UnselectAllButton",
        region = panel,
        label = B2H:l10n("unselectAllBtnLbl"),
        parent = btn_Reset,
        p_anchor = "TOPRIGHT",
        offsetX = 20,
        onClick = function()
          EventRegistry:TriggerEvent(format("%s.%s.%s", data.addon, data.keyword, "OnClear"))
        end
      }
    )
    local btn_SelectAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."SelectAllButton",
        region = panel,
        label = B2H:l10n("selectAllBtnLbl"),
        parent = btn_UnselectAll,
        p_anchor = "TOPRIGHT",
        offsetX = 20,
        onClick = function()
          EventRegistry:TriggerEvent(format("%s.%s.%s", data.addon, data.keyword, "OnSelectAll"))
        end
      }
    )
    
    -- local btn_Test = B2H:Button("debugging", panel, "UIPanelButtonTemplate", "Test", nil, nil, nil, true, "TOPLEFT", btn_UnselectAll, "TOPRIGHT", 20, 0, function()
    --   B2H.IsTesting = true
    --   EventRegistry:TriggerEvent("B2H.TOYS_UPDATED")
    -- end)
  end
end
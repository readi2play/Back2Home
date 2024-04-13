--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "reporting"

--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:FillReportingPanel(panel, container, anchorline)
  local categories = READI.Helper.table:Keys(B2H.db.reporting)

  for category, tbl in pairs(B2H.db.reporting) do
    local c_idx = READI.Helper.table:Get(categories, function(k,v) return v == category end)
    local c_name = READI.Helper.string:Capitalize(category)
    local c_anchor = "TOPLEFT"
    local c_region = anchorline
    local c_anchor_to = "BOTTOMLEFT"
    local c_x = 0
    local c_y = 0

      if c_idx == 1 then
      c_anchor_to = "TOPLEFT"
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
    _G[category.."SectionTitle"]:SetText(B2H:setTextColor(READI:l10n(format("config.panels.reporting.sections.%s", category), "B2H.L"), "b2h"))
    
    local options = READI.Helper.table:Keys(tbl)
    local rows = ceil(#options / b2h.columns)
    if rows < 1 then rows = 1 end

    _G[category.."Section"]:SetHeight(26 * rows + 30 + _G[category.."SectionTitle"]:GetHeight())
    
    for option, active in pairs(tbl) do
      local idx = READI.Helper.table:Get(options, function(k,v) return v == option end)
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

      local opts = {
        ["name"] = AddonName.."CheckBox"..c_name.."_"..option,
        ["region"] = container,
        ["label"] = READI:l10n(format("config.panels.reporting.%s.%s", category, option), "B2H.L"),
        ["anchor"] = anchor,
        ["parent"] = parent,
        ["p_anchor"] = p_anchor,
        ["offsetX"] = x,
        ["offsetY"] = y,
        ["onClick"] = function()
          local cb = _G[category.."Option_"..option]
          B2H.db.reporting[category][option] = cb:GetChecked()
        end,
        ["onReset"] = function()
          local cb = _G[category.."Option_"..option]
          if (B2H.defaults.reporting[category][option] and not cb:GetChecked()) or
             (not B2H.defaults.reporting[category][option] and cb:GetChecked()) then
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
      _G[category.."Option_"..option]:SetChecked(B2H.db.reporting[category][option])
    end

    local btn_Reset = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."ResetButton",
        region = panel,
        label = READI:l10n("general.labels.buttons.reset"),
        anchor = "BOTTOMLEFT",
        parent = container,
        offsetY = 20,
        onClick = function()
          EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnReset"))
        end
      }
    )
    local btn_UnselectAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."UnselectAllButton",
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
    local btn_SelectAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."SelectAllButton",
        region = panel,
        label = READI:l10n("general.labels.buttons.selectAll"),
        parent = btn_UnselectAll,
        p_anchor = "TOPRIGHT",
        offsetX = 20,
        onClick = function()
          EventRegistry:TriggerEvent(format("%s.%s.%s", data.prefix, data.keyword, "OnSelectAll"))
        end
      }
    )
    -- local btn_Test = READI:Button(data,
    --   {
    --     name = AddonName..READI.Helper.string.Capitalize(data.keyword).."TestButton",
    --     region = panel,
    --     label = "Test",
    --     parent = btn_SelectAll,
    --     p_anchor = "TOPRIGHT",
    --     offsetX = 20,
    --     onClick = function()
    --       B2H.IsTesting = true
    --       EventRegistry:TriggerEvent("B2H.TOYS_UPDATED")
    --     end
    --   }
    -- )
  end
end
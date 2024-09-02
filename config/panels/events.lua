--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "events"
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
B2H.Events = B2H.Events or {
  fields = {}
}

function B2H:FillEventsPanel(panel, container, anchorline)
  local events_sectionTitle = container:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
  events_sectionTitle:SetPoint("TOPLEFT", anchorline, 0, -20)
  events_sectionTitle:SetText(B2H:setTextColor(READI:l10n("config.panels.events.headline", "B2H.L"), "b2h"))

  local events_sectionSubTitle = container:CreateFontString("ARTWORK", nil, "GameFontNormal")
  events_sectionSubTitle:SetPoint("TOPLEFT", events_sectionTitle, "BOTTOMLEFT", 0, -5)
  events_sectionSubTitle:SetText(B2H:setTextColor(format(READI:l10n("config.panels.events.section", "B2H.L"), AddonName), "b2h_light"))

  local numRows = #B2H.db.events / b2h.columns
  local lastEvent = B2H.db.events[#B2H.db.events]

  for i,event in ipairs(B2H.db.events) do
    local fieldName = AddonName .. "CheckButton_" .. event.name
    local opts = {
      name = fieldName,
      region = container,
      enabled = true,
      label = event.label[B2H.Locale],
      parent = events_sectionSubTitle,
      p_anchor = "BOTTOMLEFT",
      offsetY = 0,
      offsetX = 0,
      width = b2h.columnWidth - 18
    }

    if i == 1 then
      opts.offsetY = -10
    elseif i > 1 and i <= b2h.columns then
      opts.p_anchor = "TOPLEFT"
      opts.parent = _G[AddonName .. "CheckButton_" .. B2H.db.events[i - 1].name]
      opts.offsetX = b2h.columnWidth + 20
    else
      opts.parent = _G[AddonName .. "CheckButton_" .. B2H.db.events[i - b2h.columns].name]
    end
    opts.onClick = function()
      local cb = _G[opts.name]
      B2H.db.events[i].active = cb:GetChecked()
    end
    opts.onReset = function()
      local cb = _G[opts.name]
      if B2H.defaults.events[i].active and not cb:GetChecked() then
        cb:Click()
      end
    end
    opts.onClear = function()
      local cb = _G[opts.name]
      if cb:GetChecked() then cb:Click() end
    end
    opts.onSelectAll = function()
      local cb = _G[opts.name]
      if not cb:GetChecked() then cb:Click() end
    end

    B2H.Events.fields[fieldName] = READI:CheckBox(data, opts)
    B2H.Events.fields[fieldName]:SetChecked(event.active)
  end

end
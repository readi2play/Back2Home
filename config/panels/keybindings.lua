--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "keybindings"
--------------------------------------------------------------------------------
-- CREATE KEYBINDINGS PANEL CONTENT
--------------------------------------------------------------------------------
B2H.Keybindings = B2H.Keybindings or {}

function B2H:FillKeybindingsPanel(panel, container, anchorline)
  local itemKeys = READI.Helper.table:Keys(B2H.db[data.keyword].items)

  for itmKey, item in pairs(B2H.db[data.keyword].items) do
    local idx = READI.Helper.table:Get(itemKeys, function(kw) return kw == itmKey end)
    local name = item.label[B2H.Locale]
    local label = B2H:setTextColor(NOT_BOUND, "grey")
    local enable = true
    local additionalText = READI:l10n("reporting.information.toys.notCollected", "B2H.L")  
    local anchor = "TOPLEFT"
    local region = anchorline
    local anchor_to = "BOTTOMLEFT"
    local x = 0
    local y = 0

    if item.key ~= "" then label = item.key end

    if idx == 1 then
      anchor_to = "TOPLEFT"
    elseif idx > 1 and idx <= b2h.columns then
      anchor_to = "TOPLEFT"
      region = _G[itemKeys[idx - 1].."Section"]
      x = b2h.columnWidth + 20
    else
      region = _G[itemKeys[idx - 2].."Section"]
    end

    _G[itmKey.."Section"] = CreateFrame("Frame", nil, container)
    _G[itmKey.."Section"]:SetPoint(anchor, region, anchor_to, x,y)
    _G[itmKey.."Section"]:SetWidth(b2h.columnWidth - 20)
    _G[itmKey.."Section"]:SetHeight(1)
    -- _G[itmKey.."Section"].texture = _G[itmKey.."Section"]:CreateTexture()
    -- _G[itmKey.."Section"].texture:SetAllPoints(_G[itmKey.."Section"])
    -- _G[itmKey.."Section"].texture:SetColorTexture(0,0.98,0.83,.5)
    -- section headline
    _G[itmKey.."SectionTitle"] = _G[itmKey.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    _G[itmKey.."SectionTitle"]:SetPoint("TOPLEFT", _G[itmKey.."Section"], "TOPLEFT", 0, -20)
    _G[itmKey.."SectionTitle"]:SetText(B2H:setTextColor(name, "b2h"))
    -- section subtext
    _G[itmKey.."SectionSubtext"] = _G[itmKey.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlight")
    _G[itmKey.."SectionSubtext"]:SetPoint("TOPLEFT", _G[itmKey.."SectionTitle"], "TOPLEFT", 0, -20)
    _G[itmKey.."SectionSubtext"]:SetJustifyH("LEFT")
    _G[itmKey.."SectionSubtext"]:SetJustifyV("TOP")
    _G[itmKey.."SectionSubtext"]:SetWidth(b2h.columnWidth)
    _G[itmKey.."SectionSubtext"]:SetWordWrap(true)
    _G[itmKey.."SectionSubtext"]:SetText(
      B2H:setTextColor(
        format(
          READI:l10n("config.panels.keybindings.section", "B2H.L"),
          B2H:setTextColor(name, "white"),
          B2H:setTextColor(AddonName, "b2h")
        ),
        "b2h_light"
      )
    )
    -- Button
    local opts = {
      ["name"] = AddonName..READI.Helper.string.Capitalize(data.keyword)..READI.Helper.string.Capitalize(itmKey).."Button",
      ["region"] = _G[itmKey.."Section"],
      ["template"] = "UIMenuButtonStretchTemplate",
      ["anchor"] =  "TOPLEFT",
      ["parent"] =  _G[itmKey.."SectionSubtext"],
      ["offsetX"] = 0,      
      ["offsetY"] = -20,
      ["label"] = label,
      ["text"] = B2H:setTextColor(additionalText, "error"),
      ["condition"] = not enable,
      ["enabled"] = enable,
      ["width"] = b2h.columnWidth,
      ["height"] = 24,
      ["onClick"] = function(self)
        function self:OnEvent(evt, ...)
          self[evt](self, evt, ...)
        end
        
        self:SetScript("OnEvent", self.OnEvent)
  
        self:RegisterEvent("MODIFIER_STATE_CHANGED")
        self:SetHighlightLocked(true)
        -- check if the button is already waiting for a user input and remove that script if present
        function self:MODIFIER_STATE_CHANGED(evt, key, down)
          B2H:Debug(B2H.db.reporting.debugging[data.keyword], "Event: ", evt, "Key: ", key, "Down: ", down)
          -- return early to prevent non-modifier keys to be used as keybindings for the Back2Home button
          -- this will leave the user being able to try another key
          if down == 0 then
            if not READI.Helper.table:Contains(key, B2H.KeysToBind) then return end
            self:Update(key, true)
          end
        end
      end,
      ["onReset"] = function() _G[itmKey.."SectionButton"]:Update(B2H.defaults[data.keyword].items[itmKey].key, true) end,
      ["onClear"] = function() _G[itmKey.."SectionButton"]:Update("", true) end
    }
    _G[itmKey.."SectionButton"] = READI:Button(data, opts)
    _G[itmKey.."SectionButton"].Update = function(self, key, check)
      B2H:Debug(B2H.db.reporting.debugging[data.keyword], "key: ",key, "check: ",check)
      if check then self:CheckForDuplicateBinding(key) end
      -- update the button label and write to the SavedVariables
      if key == "" then
        self:SetText(B2H:setTextColor(NOT_BOUND, "grey"))
      else
        self:SetText(key)
      end
      B2H.db[data.keyword].items[itmKey].key = key
      B2H:InitializeKeyBindings()

      self:SetHighlightLocked(false)

      if self:GetScript("OnEvent") then
        self:SetScript("OnEvent", nil)
      end
    end
    _G[itmKey.."SectionButton"].CheckForDuplicateBinding = function(self, key)
      B2H:Debug(B2H.db.reporting.debugging[data.keyword], "key: ",key)
      for kword, item in pairs(B2H.db[data.keyword].items) do
        B2H:Debug(B2H.db.reporting.debugging[data.keyword], "item.key: ",item.key, "kword: ",kword, "keyword: ",itmKey)
        if item.key == key and kword ~= itmKey then
          _G[kword.."SectionButton"]:Update("", false)
        end
      end
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
    local btn_ClearAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string.Capitalize(data.keyword).."ClearAllButton",
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
  return 
end

function B2H.Keybindings:Update()
  for i,toy in ipairs(B2H.db.keybindings.items) do
    local btn = _G[AddonName..READI.Helper.string.Capitalize(data.keyword)..READI.Helper.string.Capitalize(toy.key).."Button"]
    if not toy.owned then
      toy.owned = PlayerHasToy(toy.id)
      B2H.defaults.keybindings.items[i].owned = PlayerHasToy(toy.id)
      
      B2H.db.toys[i].active = toy.owned
      B2H.defaults.toys[i].active = toy.owned

      if toy.owned then
        btn:Enable()
      else
        btn:Disable()
      end
    end
  end
end
--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = {
  ["addon"] = B2H.AddonAbbr,
  ["keyword"] = "keybindings",
}
--------------------------------------------------------------------------------
-- CREATE KEYBINDINGS PANEL CONTENT
--------------------------------------------------------------------------------
function B2H:FillKeybindingsPanel(panel, container)
  local keywords = {}

  for keyword, item in pairs(self.db[data.keyword].items) do
    table.insert(keywords, keyword)
    local idx = B2H:FindIndex(self.db[data.keyword].items, function(k) return k == keyword end)
    local name = select(2,C_ToyBox.GetToyInfo(item.id))
    local label = B2H:setTextColor(NOT_BOUND, "disabled")
    local enable = PlayerHasToy(item.id)
    local additionalText = B2H:l10n("toyNotCollected")  
    local anchor = "TOPLEFT"
    local region = container
    local anchor_to = "BOTTOMLEFT"
    local x = 0
    local y = 0

    if item.key ~= "" then label = item.key end

    if idx == 1 then
      anchor_to = "TOPLEFT"
      y = -40
    elseif idx > 1 and idx <= b2h.columns then
      anchor_to = "TOPLEFT"
      region = _G[keywords[idx - 1].."Section"]
      x = b2h.columnWidth + 20
    else
      region = _G[keywords[idx - 2].."Section"]
    end

    _G[keyword.."Section"] = CreateFrame("Frame", nil, container)
    _G[keyword.."Section"]:SetPoint(anchor, region, anchor_to, x,y)
    _G[keyword.."Section"]:SetWidth(b2h.columnWidth - 20)
    _G[keyword.."Section"]:SetHeight(1)
    -- _G[keyword.."Section"].texture = _G[keyword.."Section"]:CreateTexture()
    -- _G[keyword.."Section"].texture:SetAllPoints(_G[keyword.."Section"])
    -- _G[keyword.."Section"].texture:SetColorTexture(0,0.98,0.83,.5)

    -- section headline
    _G[keyword.."SectionTitle"] = _G[keyword.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    _G[keyword.."SectionTitle"]:SetPoint("TOPLEFT", _G[keyword.."Section"], "TOPLEFT", 0, -20)
    _G[keyword.."SectionTitle"]:SetText(B2H:setTextColor(name, "b2h"))

    -- section subtext
    _G[keyword.."SectionSubtext"] = _G[keyword.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlight")
    _G[keyword.."SectionSubtext"]:SetPoint("TOPLEFT", _G[keyword.."SectionTitle"], "TOPLEFT", 0, -20)
    _G[keyword.."SectionSubtext"]:SetJustifyH("LEFT")
    _G[keyword.."SectionSubtext"]:SetJustifyV("TOP")
    _G[keyword.."SectionSubtext"]:SetWidth(b2h.columnWidth)
    _G[keyword.."SectionSubtext"]:SetWordWrap(true)
    _G[keyword.."SectionSubtext"]:SetText(
      B2H:setTextColor(B2H:l10n(data.keyword.."SectionSubtext1"), "b2h_light").." "..
      B2H:setTextColor(name).." "..
      B2H:setTextColor(B2H:l10n(data.keyword.."SectionSubtext2"), "b2h_light").." "..
      B2H:setTextColor(AddonName, "b2h").."."
    )

    -- Button
    local opts = {
      ["name"] = AddonName..READI.Helper.string:Capizalize(data.keyword)..READI.Helper.string:Capizalize(keyword).."Button",
      ["region"] = _G[keyword.."Section"],
      ["template"] = "UIMenuButtonStretchTemplate",
      ["anchor"] =  "TOPLEFT",
      ["parent"] =  _G[keyword.."SectionSubtext"],
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
          B2H:Debug(B2H.db.others.debugging[data.keyword], "Event: ", evt, "Key: ", key, "Down: ", down)
          -- return early to prevent non-modifier keys to be used as keybindings for the Back2Home button
          -- this will leave the user being able to try another key
          if down == 0 then
            if not B2H:IsInList(key, B2H.KeysToBind) then return end
            self:Update(key, true)
          end
        end
      end,
      ["onReset"] = function() _G[keyword.."SectionButton"]:Update(B2H.defaults[data.keyword].items[keyword].key, true) end,
      ["onClear"] = function() _G[keyword.."SectionButton"]:Update("", true) end
    }

    _G[keyword.."SectionButton"] = READI:Button(data, opts)
    _G[keyword.."SectionButton"].Update = function(self, key, check)
      B2H:Debug(B2H.db.others.debugging[data.keyword], "key: ",key, "check: ",check)
      if check then self:CheckForDuplicateBinding(key) end
      -- update the button label and write to the SavedVariables
      if key == "" then
        self:SetText(B2H:setTextColor(NOT_BOUND, "disabled"))
      else
        self:SetText(key)
      end
      B2H.db[data.keyword].items[keyword].key = key
      B2H:InitializeKeyBindings()

      self:SetHighlightLocked(false)

      if self:GetScript("OnEvent") then
        self:SetScript("OnEvent", nil)
      end
    end
    _G[keyword.."SectionButton"].CheckForDuplicateBinding = function(self, key)
      B2H:Debug(B2H.db.others.debugging[data.keyword], "key: ",key)
      for kword, item in pairs(B2H.db[data.keyword].items) do
        B2H:Debug(B2H.db.others.debugging[data.keyword], "item.key: ",item.key, "kword: ",kword, "keyword: ",keyword)
        if item.key == key and kword ~= keyword then
          _G[kword.."SectionButton"]:Update("", false)
        end
      end
    end
    local btn_Reset = READI:Button(data,
      {
        name = AddonName..READI.Helper.string:Capizalize(data.keyword).."ResetButton",
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
    local btn_ClearAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string:Capizalize(data.keyword).."ClearAllButton",
        region = panel,
        label = B2H:l10n("clearAllBtnLbl"),
        parent = btn_Reset,
        p_anchor = "TOPRIGHT",
        offsetX = 20,
        onClick = function()
          EventRegistry:TriggerEvent(data.addon.."."..data.keyword..".OnClear")
        end
      }
    )
  end
  return 
end
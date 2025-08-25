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
--------------------------------------------------------------------------------
B2H.Keybindings.panel, B2H.Keybindings.container, B2H.Keybindings.anchorline = READI:OptionPanel(data, {
  name = B2H.L["Keybindings"],
  parent = AddonName,
  title = {
    text = B2H.L["Keybindings"],
    color = "b2h"
  }
})
--------------------------------------------------------------------------------

function B2H.Keybindings:Initialize(panel, container, anchorline)
  local panel, container, anchorline = B2H.Keybindings.panel, B2H.Keybindings.container, B2H.Keybindings.anchorline
  local category = Settings.RegisterCanvasLayoutSubcategory(Settings.GetCategory(AddonName), B2H.Keybindings.panel, B2H.L[READI.Helper.string:Capitalize(data.keyword)])
  Settings.RegisterAddOnCategory(category)

  local itemKeys = {}
  for _,itm in pairs(B2H.db[data.keyword].items) do itemKeys[#itemKeys+1] = itm.name end

  for idx, item in pairs(B2H.db[data.keyword].items) do
    local itmKey = item.name
    local name = ""
    local label = B2H:setTextColor(NOT_BOUND, "grey")
    local enable = true
    local additionalText = B2H.L["You don't have this toy collected yet."]
    local anchor = "TOPLEFT"
    local region = anchorline
    local anchor_to = "BOTTOMLEFT"
    local x = 0
    local y = 0
    local initialHeight = 0
    if item[B2H.faction] then
      name = item[B2H.faction].label[B2H.Locale]
    else
      name = item.label[B2H.Locale]
    end

    if item.key ~= "" then label = item.key end

    if idx == 1 then
      y = -10
    elseif idx > 1 and idx <= b2h.columns then
      initialHeight = _G[itemKeys[1].."Section"]:GetHeight()
      anchor_to = "TOPLEFT"
      region = _G[itemKeys[idx - 1].."Section"]
      x = b2h.columnWidth + 20
    else
      y = -30
      initialHeight = _G[itemKeys[1].."Section"]:GetHeight()
      region = _G[itemKeys[idx - 2].."Section"]
    end

    _G[itmKey.."Section"] = CreateFrame("Frame", itmKey.."Section", container)
    _G[itmKey.."Section"]:SetPoint(anchor, region, anchor_to, x,y)
    _G[itmKey.."Section"]:SetWidth(b2h.columnWidth)
    _G[itmKey.."Section"]:SetHeight(initialHeight)
    -- _G[itmKey.."Section"].texture = _G[itmKey.."Section"]:CreateTexture()
    -- _G[itmKey.."Section"].texture:SetAllPoints(_G[itmKey.."Section"])
    -- _G[itmKey.."Section"].texture:SetColorTexture(0,0.98,0.83,.5)
    -- section headline
    _G[itmKey.."SectionTitle"] = _G[itmKey.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    _G[itmKey.."SectionTitle"]:SetPoint("TOPLEFT", _G[itmKey.."Section"], "TOPLEFT", 0, 0)
    _G[itmKey.."SectionTitle"]:SetText(B2H:setTextColor(name, "b2h"))
    if idx == 1 then
      _G[itmKey.."Section"]:SetHeight(_G[itmKey.."Section"]:GetHeight() + _G[itmKey.."SectionTitle"]:GetHeight())
    end
    -- section subtext
    _G[itmKey.."SectionSubtext"] = _G[itmKey.."Section"]:CreateFontString("ARTWORK", nil, "GameFontHighlight")
    _G[itmKey.."SectionSubtext"]:SetPoint("TOPLEFT", _G[itmKey.."SectionTitle"], "TOPLEFT", 0, -20)
    _G[itmKey.."SectionSubtext"]:SetJustifyH("LEFT")
    _G[itmKey.."SectionSubtext"]:SetJustifyV("TOP")
    _G[itmKey.."SectionSubtext"]:SetWidth(b2h.columnWidth)
    _G[itmKey.."SectionSubtext"]:SetWordWrap(true)
    local subText = B2H.L["Select a modifier key to easily use %s via %s."]

    _G[itmKey.."SectionSubtext"]:SetText(
      B2H:setTextColor(
        format(
          subText,
          B2H:setTextColor(name, "b2h_light"),
          B2H:setTextColor(AddonName, "b2h")
        ),
        "white"
      )
    )
    if idx == 1 then
      _G[itmKey.."Section"]:SetHeight(_G[itmKey.."Section"]:GetHeight() + 20 + _G[itmKey.."SectionSubtext"]:GetHeight())
    end
    -- Button
    local opts = {
      name = AddonName..READI.Helper.string:Capitalize(data.keyword)..READI.Helper.string:Capitalize(itmKey).."Button",
      region = _G[itmKey.."Section"],
      template = "UIMenuButtonStretchTemplate",
      anchor =  "TOPLEFT",
      parent =  _G[itmKey.."SectionSubtext"],
      offsetX = 0,      
      offsetY = -20,
      label = label,
      text = B2H:setTextColor(additionalText, "error"),
      condition = not enable,
      enabled = enable,
      width = b2h.columnWidth,
      height = 24,
      onClick = function(self)
        function self:OnEvent(evt, ...)
          self[evt](self, evt, ...)
        end
        
        self:SetScript("OnEvent", self.OnEvent)
  
        self:RegisterEvent("MODIFIER_STATE_CHANGED")
        self:SetHighlightLocked(true)
        -- check if the button is already waiting for a user input and remove that script if present
        function self:MODIFIER_STATE_CHANGED(evt, key, down)
          READI.Debug:Debug(data.addon, B2H.db.reporting.debugging[data.keyword], "Event: ", evt, "Key: ", key, "Down: ", down)
          -- return early to prevent non-modifier keys to be used as keybindings for the Back2Home button
          -- this will leave the user being able to try another key
          if down == 0 then
            if not READI.Helper.table:Contains(key, B2H.KeysToBind) then return end
            self:Update(key, true)
          end
        end
      end,
      onReset = function() _G[itmKey.."SectionButton"]:Update(B2H.defaults[data.keyword].items[itmKey].key, true) end,
      onClear = function() _G[itmKey.."SectionButton"]:Update("", true) end
    }
    if initialHeight > 0 then
      opts.anchor = "BOTTOMLEFT"
      opts.parent =  _G[itmKey.."Section"]
      opts.offsetX = 0
      opts.offsetY = 0
    end
    _G[itmKey.."SectionButton"] = READI:Button(data, opts)
    if idx == 1 then
      _G[itmKey.."Section"]:SetHeight(_G[itmKey.."Section"]:GetHeight() + 4 + _G[itmKey.."SectionButton"]:GetHeight())
    end
    _G[itmKey.."SectionButton"].Update = function(self, key, check)
      READI.Debug:Debug(data.addon, B2H.db.reporting.debugging[data.keyword], "key: ",key, "check: ",check)
      if check then self:CheckForDuplicateBinding(key) end
      -- update the button label and write to the SavedVariables
      if key == "" then
        self:SetText(B2H:setTextColor(NOT_BOUND, "grey"))
      else
        self:SetText(key)
      end
      B2H.db[data.keyword].items[idx].key = key
      B2H:InitializeKeyBindings()

      self:SetHighlightLocked(false)

      if self:GetScript("OnEvent") then
        self:SetScript("OnEvent", nil)
      end
    end
    _G[itmKey.."SectionButton"].CheckForDuplicateBinding = function(self, key)
      READI.Debug:Debug(data.addon, B2H.db.reporting.debugging[data.keyword], "key: ",key)
      for i, item in pairs(B2H.db[data.keyword].items) do
        local kword = item.name
        READI.Debug:Debug(data.addon, B2H.db.reporting.debugging[data.keyword], "item.key: ",item.key, "kword: ",kword, "keyword: ",itmKey)
        if item.key == key and kword ~= itmKey then
          _G[kword.."SectionButton"]:Update("", false)
        end
      end
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
          B2H.db[data.keyword] = CopyTable(B2H.defaults[data.keyword])
          EventRegistry:TriggerEvent(format("%s_%s_RESET", data.prefix, string.upper(data.keyword)))
          B2H[READI.Helper.string:Capitalize(data.keyword)]:Update()
        end
      }
    )
    local btn_ClearAll = READI:Button(data,
      {
        name = AddonName..READI.Helper.string:Capitalize(data.keyword).."ClearAllButton",
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
    local btn = _G[AddonName..READI.Helper.string:Capitalize(data.keyword)..READI.Helper.string:Capitalize(toy.name).."Button"]
    if toy[B2H.faction] then
      toy.owned = (B2H:ItemIsToy(toy[B2H.faction].id) and PlayerHasToy(toy[B2H.faction].id) and B2H:IsUsable(toy[B2H.faction])) or (not B2H:ItemIsToy(toy[B2H.faction].id) and B2H:GetItemBagSlot(toy[B2H.faction].id))
      B2H.defaults.keybindings.items[i].owned = toy.owned
    else
      toy.owned = (B2H:ItemIsToy(toy.id) and PlayerHasToy(toy.id) and B2H:IsUsable(toy)) or (not B2H:ItemIsToy(toy.id) and B2H:GetItemBagSlot(toy.id))
      B2H.defaults.keybindings.items[i].owned = toy.owned
    end  

    btn:SetText(B2H.db.keybindings.items[i].key)

    -- B2H.db.items[i] = toy.owned
    -- B2H.defaults.items[i] = toy.owned

    if toy.owned then
      btn:Enable()
    else
      btn:Disable()
    end
  end
end
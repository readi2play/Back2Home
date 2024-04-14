local AddonName, b2h = ...

--------------------------------------------------------------------------------
-- CREATE BACK2HOME BUTTON
--------------------------------------------------------------------------------
local function CreateButton()
  -- button creation
  B2H.HSButton = B2H.HSButton or CreateFrame("Button", AddonName .. "Button", UIParent, "SecureActionButtonTemplate")
  B2H.HSButton:SetFrameLevel(100)
  B2H.HSButton:SetHighlightTexture(B2H.T.b2h100000, "ADD")
  B2H.HSButton:EnableKeyboard()
  
  -- create children
  B2H.HSButton.cooldown = B2H.HSButton.cooldown or CreateFrame("Cooldown", AddonName .. "Cooldown", B2H.HSButton, "CooldownFrameTemplate")
  B2H.HSButton.tooltip = B2H.HSButton.tooltip or CreateFrame("GameTooltip", AddonName .. "Tooltip", UIParent, "GameTooltipTemplate")
  B2H.HSButton.background = B2H.HSButton.background or B2H.HSButton:CreateTexture(AddonName .. "Background", "BACKGROUND")
  B2H.HSButton.icon = B2H.HSButton.icon or B2H.HSButton:CreateTexture(AddonName .. "Icon", "ARTWORK")
  B2H.HSButton.mask = B2H.HSButton.mask or B2H.HSButton:CreateMaskTexture()

  -- METHODS ---
  --[[ This function updates the button's icon, tooltip and cooldown ]] --
  function B2H.HSButton:Update(shuffle, condition)
    condition = condition or true
    -- if the character is infight, just return early to prevent the addon throwing a bunch of errors
    -- secure buttons are not allowed to change in fight therefore we have to prevent this by all meaning  
    if InCombatLockdown() then return end
    local activeFallbacks = READI.Helper.table:Filter(B2H.db.fallbacks.items, function(item) return item.active end)
    local activeToys = READI.Helper.table:Filter(B2H.db.toys, function(toy) return toy.active end )
    local fbActive = READI.Helper.table:Filter(activeFallbacks, function(item) return item.id == b2h.id end)

    if shuffle then
      if not b2h.id or (#fbActive >= 1 and #activeToys < 1) then
        b2h.id, b2h.name, b2h.icon = B2H.HSButton:Shuffle(activeFallbacks)
      else
        local owned = READI.Helper.table:Filter(activeToys, function(toy) return toy.owned end);
        b2h.id, b2h.name, b2h.icon = B2H.HSButton:Shuffle(owned)
      end
    end

    if not b2h.id then
      B2H.HSButton.icon:SetTexture(nil)
      -- B2H.HSButton:Disable()
      return
    end
    B2H.HSButton:Enable()

    local function GetFallbackItemBagSlot(item)
      for i = 0, NUM_BAG_SLOTS do
        for j = 1, C_Container.GetContainerNumSlots(i) do
          if C_Container.GetContainerItemID(i, j) == item.id then
            return i, j
          end
        end
      end
      return 0, 0
    end

    -- set the button's tooltip
    local activeFallback = READI.Helper.table:Filter(B2H.db.fallbacks.items, function(item) return item.id == b2h.id end)[1]
    if not b2h.id then
      b2h.name = activeFallback.label[B2H.Locale]
      b2h.icon = activeFallback.icon
      B2H.HSButton.tooltip:SetBagItem(GetFallbackItemBagSlot(activeFallback))
    else
      B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
    end

    B2H.HSButton.icon:SetTexture(b2h.icon)

    B2H.HSButton:SetAttribute("macrotext", "/use item:" .. b2h.id)

    local start, duration = GetItemCooldown(b2h.id)
    B2H.HSButton.cooldown:SetCooldown(start, duration)
  end
  --[[ Retrieve a new random toy itemID ]] --
  function B2H.HSButton:Shuffle(src)
    local rndIdx = #src
    -- retrieve random id
    if rndIdx and rndIdx > 0 then
      local __idx = math.random(rndIdx)
      return src[__idx].id, src[__idx].label[B2H.Locale], src[__idx].icon
    end
    return nil
  end

  function B2H.HSButton:SetPosition()
    B2H.HSButton:ClearAllPoints()
    B2H.HSButton:SetPoint(B2H.db.anchoring.button_anchor, _G[B2H.db.anchoring.frame], B2H.db.anchoring.parent_anchor,
      B2H.db.anchoring.position_x, B2H.db.anchoring.position_y)
  end

  function B2H.HSButton:ScaleButton()
    local btnSize = B2H.db.anchoring.button_size
    B2H.HSButton:SetSize(btnSize, btnSize)
    B2H.HSButton.mask:SetSize(btnSize * 0.8, btnSize * 0.8)
  end

  function B2H.HSButton:SetStrata()
    local btnStrata = B2H.db.anchoring.button_strata
    if btnStrata == "PARENT" then
      local parent = B2H.HSButton:GetParent() 
      B2H.HSButton:SetFrameStrata(parent:GetFrameStrata())
    else
      B2H.HSButton:SetFrameStrata(btnStrata)
    end
  end
  --------------------------------------------------------------------------------
  -- KEY BINDINGS
  --------------------------------------------------------------------------------
  for k,v in pairs(B2H.db.keybindings.items) do
    SetBindingMacro(v.key, B2H.HSButton:GetName())
  end
  
  -- button action configuration
  B2H.HSButton:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp")
  B2H.HSButton:SetAttribute("type", "macro")
  if b2h.id then
    B2H.HSButton:SetAttribute("macrotext", "/use item:" .. b2h.id)
  end
  B2H.HSButton:SetAttribute("macrotext2", "/run Back2HomeButton:Update(true)")

  -- cooldown positioning
  B2H.HSButton.cooldown:SetAllPoints(B2H.HSButton.icon)
  B2H.HSButton.cooldown:SetDrawSwipe(false)
  B2H.HSButton.cooldown:SetDrawEdge(false)

  -- button background positioning
  B2H.HSButton.background:SetAllPoints(B2H.HSButton)
  B2H.HSButton.background:SetTexture(B2H.T.b2h100001)

  -- icon texture positioning
  B2H.HSButton.icon:SetAllPoints(B2H.HSButton)

  -- mask texture positioning
  B2H.HSButton.mask:SetPoint("CENTER", B2H.HSButton.icon, "CENTER", -0.2, -0.2)
  -- use the texture id of the "TempPortraitAlphaMask" (130924)
  B2H.HSButton.mask:SetTexture(130924, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  B2H.HSButton.icon:AddMaskTexture(B2H.HSButton.mask)

  b2h.isLogin = false
  return B2H.HSButton
end

function B2H:InitializeButton()
  --------------------------------------------------------------------------------
  -- BUTTON CREATION
  --------------------------------------------------------------------------------
  B2H.HSButton = B2H.HSButton or CreateButton()
  B2H.HSButton:ScaleButton()
  B2H.HSButton:SetPosition()
  B2H.HSButton:SetStrata()
  B2H.HSButton:Update(true)

  --------------------------------------------------------------------------------
  -- EVENT HANDLERS
  --------------------------------------------------------------------------------
  -- register events for event handling
  B2H.HSButton:RegisterEvent("ZONE_CHANGED")
  B2H.HSButton:RegisterEvent("PLAYER_LEVEL_UP")
  B2H.HSButton:RegisterEvent("NEW_TOY_ADDED")


  local function OnEvent(evt, ...)
    if self[evt] then
      self[evt](self, evt, ...)
    end
    B2H.HSButton:Update(true)
  end  
  -- user moves cursor over the button
  local function OnEnter(self)
    if B2H.HSButton.tooltip then
      B2H.HSButton.tooltip:SetOwner(self, "ANCHOR_LEFT")
      B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
      B2H.HSButton.tooltip:Show()
    end
  end
  -- user moves cursor off the button
  local function OnLeave(self)
    if B2H.HSButton.tooltip then
      B2H.HSButton.tooltip:Hide()
    end
  end
  -- user clicks the button, either with left or right mouse button
  local function OnClick(self, clicked, down, ...)
    local start, duration = GetItemCooldown(b2h.id)
    B2H.HSButton.cooldown:SetCooldown(start, duration)
  end
  -- shuffle and update the button due to several events
  B2H:RegisterEvent("NEW_TOY_ADDED")
  function B2H:NEW_TOY_ADDED(evt)
    EventRegistry:TriggerEvent("B2H.TOYS_UPDATED")      
    B2H.HSButton:Update(true)
  end

  -- set event scripts
  B2H.HSButton:SetScript("OnEvent", OnEvent)
  B2H.HSButton:SetScript("OnEnter", OnEnter)
  B2H.HSButton:SetScript("OnLeave", OnLeave)

end
local AddonName, b2h = ...

--------------------------------------------------------------------------------
-- CREATE BACK2HOME BUTTON
--------------------------------------------------------------------------------
local function CreateButton()
  local btnSize = B2H.db.parent.button_size or B2H.defaults.parent.button_size
  -- button creation
  B2H.HSButton = B2H.HSButton or CreateFrame("Button", AddonName .. "Button", UIParent, "SecureActionButtonTemplate")
  B2H.HSButton:SetSize(btnSize, btnSize)
  B2H.HSButton:SetFrameStrata("TOOLTIP")
  B2H.HSButton:SetFrameLevel(100)
  B2H.HSButton:SetPoint(B2H.db.parent.button_anchor, _G[B2H.db.parent.frame], B2H.db.parent.parent_anchor,
    B2H.db.parent.position_x, B2H.db.parent.position_y)
  B2H.HSButton:SetHighlightTexture("common-roundhighlight", "ADD")
  B2H.HSButton:EnableKeyboard()
  
  -- create children
  B2H.HSButton.cooldown = B2H.HSButton.cooldown or CreateFrame("Cooldown", AddonName .. "Cooldown", B2H.HSButton, "CooldownFrameTemplate")
  B2H.HSButton.tooltip = B2H.HSButton.tooltip or CreateFrame("GameTooltip", AddonName .. "Tooltip", UIParent, "GameTooltipTemplate")
  B2H.HSButton.background = B2H.HSButton.background or B2H.HSButton:CreateTexture(AddonName .. "Background", "BACKGROUND")
  B2H.HSButton.icon = B2H.HSButton.icon or B2H.HSButton:CreateTexture(AddonName .. "Icon", "ARTWORK")
  B2H.HSButton.mask = B2H.HSButton.mask or B2H.HSButton:CreateMaskTexture()

  -- METHODS ---
  --[[ This function updates the button's icon, tooltip and cooldown ]] --
  function B2H.HSButton:Update()
    if not b2h.id then
      B2H.HSButton.icon:SetTexture(nil)
      B2H.HSButton:Disable()
      return
    end
    _, b2h.name, b2h.icon = C_ToyBox.GetToyInfo(b2h.id)
    B2H.HSButton:Enable()
    local function GetFallbackItemBagSlot()
      for i = 0, NUM_BAG_SLOTS do
        for j = 1, C_Container.GetContainerNumSlots(i) do
          if C_Container.GetContainerItemID(i, j) == B2H.db.fallback.id then
            return i, j
          end
        end
      end
      return 0, 0
    end

    -- set the button's icon to the information returned by the GetToyInfo function
    if b2h.id == B2H.db.fallback.id then
      B2H.HSButton.tooltip:SetBagItem(GetFallbackItemBagSlot())
    else
      B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
    end

    B2H.HSButton.icon:SetTexture(b2h.icon)

    B2H.HSButton:SetAttribute("macrotext", "/use item:" .. b2h.id)

    local start, duration = GetItemCooldown(b2h.id)
    B2H.HSButton.cooldown:SetCooldown(start, duration)
  end
  --[[ Retrieve a new random toy itemID ]] --
  function B2H.HSButton:Shuffle()
    -- if the character is infight, just return early to prevent the addon throwing a bunch of errors
    -- secure buttons are not allowed to change in fight therefore we have to prevent this by all meaning  
    if InCombatLockdown() then return end
    local owned = B2H:FilterTable(B2H.db.toys, function(toy)
      return toy.active
    end);
    -- retrieve random id or fall back to default hearthstone's itemId if no hearthstone toy is collected yet 
    local rndIdx = #owned
    if rndIdx > 0 then
      b2h.id = owned[math.random(rndIdx)].id
    elseif B2H.db.fallback.active then
      b2h.id = B2H.db.fallback.id
    else
      b2h.id = nil
      B2H.HSButton:Update()
      return
    end
    if b2h.id == B2H.db.fallback.id then
      b2h.name = GetItemInfo(b2h.id)
      b2h.icon = select(10, GetItemInfo(b2h.id))
    else
      _, b2h.name, b2h.icon = C_ToyBox.GetToyInfo(b2h.id)
    end

    B2H.HSButton:Update()
  end

  function B2H.HSButton:RePosition()
    B2H.HSButton:ClearAllPoints()
    B2H.HSButton:SetPoint(B2H.db.parent.button_anchor, _G[B2H.db.parent.frame], B2H.db.parent.parent_anchor,
      B2H.db.parent.position_x, B2H.db.parent.position_y)
  end

  function B2H.HSButton:Resize()
    local btnSize = B2H.db.parent.button_size or B2H.defaults.parent.button_size
    B2H.HSButton:SetSize(btnSize, btnSize)
    B2H.HSButton.mask:SetSize(btnSize * 0.8, btnSize * 0.8)
  end

  B2H.HSButton:Shuffle()
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
  B2H.HSButton:SetAttribute("macrotext2", "/run Back2HomeButton:Shuffle()")

  -- cooldown positioning
  B2H.HSButton.cooldown:SetAllPoints(B2H.HSButton.icon)
  B2H.HSButton.cooldown:SetDrawSwipe(false)
  B2H.HSButton.cooldown:SetDrawEdge(false)

  -- button background positioning
  B2H.HSButton.background:SetAllPoints(B2H.HSButton)
  B2H.HSButton.background:SetTexture(B2H.T.b2h_hearthstone_button_inactive)

  -- icon texture positioning
  B2H.HSButton.icon:SetAllPoints(B2H.HSButton)

  -- mask texture positioning
  B2H.HSButton.mask:SetPoint("CENTER", B2H.HSButton.icon, "CENTER", -0.2, -0.2)
  B2H.HSButton.mask:SetTexture(B2H.T.BLZ_TempPortraitAlphaMask, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  B2H.HSButton.mask:SetSize(btnSize * 0.8, btnSize * 0.8)
  B2H.HSButton.icon:AddMaskTexture(B2H.HSButton.mask)

  b2h.isLogin = false
  return B2H.HSButton
end

function B2H:InitializeButton()
  --------------------------------------------------------------------------------
  -- BUTTON CREATION
  --------------------------------------------------------------------------------
  B2H.HSButton = B2H.HSButton or CreateButton()
  B2H.HSButton:Shuffle()

  --------------------------------------------------------------------------------
  -- EVENT HANDLERS
  --------------------------------------------------------------------------------
  -- register events for event handling
  B2H.HSButton:RegisterEvent("ZONE_CHANGED")
  B2H.HSButton:RegisterEvent("PLAYER_LEVEL_UP")
  B2H.HSButton:RegisterEvent("NEW_TOY_ADDED")

  -- user moves cursor over the button
  function BtnOnEnter(self)
    if B2H.HSButton.tooltip then
      B2H.HSButton.tooltip:SetOwner(self, "ANCHOR_LEFT")
      B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
      B2H.HSButton.tooltip:Show()
    end
  end
  -- user moves cursor off the button
  function BtnOnLeave(self)
    if B2H.HSButton.tooltip then
      B2H.HSButton.tooltip:Hide()
    end
  end
  -- user clicks the button, either with left or right mouse button
  function BtnOnClick(self, clicked, down, ...)
    local start, duration = GetItemCooldown(b2h.id)
    B2H.HSButton.cooldown:SetCooldown(start, duration)
  end
  -- shuffle and update the button due to several events
  function BtnOnEvent(evt, addon)
    -- if B2H.HSButton.tooltip:IsShown() then
    --   B2H.HSButton.tooltip:Hide()
    -- end
    B2H.HSButton:Shuffle()
  end

  -- set event scripts
  B2H.HSButton:SetScript("OnEvent", BtnOnEvent)
  B2H.HSButton:SetScript("OnEnter", BtnOnEnter)
  B2H.HSButton:SetScript("OnLeave", BtnOnLeave)

end
b2h.isLogin = isLogin

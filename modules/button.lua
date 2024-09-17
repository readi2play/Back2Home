local AddonName, b2h = ...
--[[----------------------------------------------------------------------------
Button factory for the Back2Home button
----------------------------------------------------------------------------]]--
  local function CreateButton()
    if InCombatLockdown() then return end
    --[[------------------------------------------------------------------------
    button creation
    ------------------------------------------------------------------------]]--
    B2H.HSButton = B2H.HSButton or CreateFrame("Button", AddonName .. "Button", _G[B2H.db.anchoring.frame], "SecureActionButtonTemplate")
    B2H.HSButton:SetFrameLevel(100)
    B2H.HSButton:SetHighlightTexture(READI.T.rdl110004, "ADD")
    B2H.HSButton:EnableKeyboard()

    --[[------------------------------------------------------------------------
    Drag & Drop functionality
    ------------------------------------------------------------------------]]--
    B2H.HSButton:SetMovable(true)
    --[[------------------------------------------------------------------------
    create children
    ------------------------------------------------------------------------]]--
    B2H.HSButton.cooldown = B2H.HSButton.cooldown or CreateFrame("Cooldown", AddonName .. "Cooldown", B2H.HSButton, "CooldownFrameTemplate")
    B2H.HSButton.tooltip = B2H.HSButton.tooltip or CreateFrame("GameTooltip", AddonName .. "Tooltip", UIParent, "GameTooltipTemplate")
    B2H.HSButton.background = B2H.HSButton.background or B2H.HSButton:CreateTexture(AddonName .. "Background", "BACKGROUND")
    B2H.HSButton.border = B2H.HSButton.border or B2H.HSButton:CreateTexture(AddonName .. "Border", "BORDER")
    B2H.HSButton.icon = B2H.HSButton.icon or B2H.HSButton:CreateTexture(AddonName .. "Icon", "ARTWORK")
    B2H.HSButton.mask = B2H.HSButton.mask or B2H.HSButton:CreateMaskTexture()
    --[[------------------------------------------------------------------------
    METHODS ---
    This function updates the button's icon, tooltip and cooldown
    ------------------------------------------------------------------------]]--
    function B2H.HSButton:Update(shuffle, condition)
      condition = condition or true
      --[[----------------------------------------------------------------------
      if the character is infight, just return early to prevent the addon throwing a bunch of errors
      secure buttons are not allowed to change in fight therefore we have to prevent this by all meaning  
      ----------------------------------------------------------------------]]--
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
        B2H.HSButton.icon:SetTexture(B2H.T.b2h200001)
        B2H.HSButton:Disable()
        return
      end
      B2H.HSButton:Enable()

      --[[----------------------------------------------------------------------
      set the button's tooltip
      ----------------------------------------------------------------------]]--
      local activeFallback = READI.Helper.table:Filter(B2H.db.fallbacks.items, function(item) return item.id == b2h.id end)[1]
      if not b2h.id then
        b2h.name = activeFallback.label[B2H.Locale]
        b2h.icon = activeFallback.icon
        B2H.HSButton.tooltip:SetBagItem(B2H:GetItemBagSlot(activeFallback.id))
      else
        B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
      end

      B2H.HSButton.icon:SetTexture(b2h.icon)

      B2H.HSButton:SetAttribute("macrotext", "/use item:" .. b2h.id)

      local start, duration = GetItemCooldown(b2h.id)
      B2H.HSButton.cooldown:SetCooldown(start, duration)
    end
    --[[------------------------------------------------------------------------
    Retrieve a new random toy itemID
    ------------------------------------------------------------------------]]--
    function B2H.HSButton:Shuffle(src)
      if InCombatLockdown() then return end
      local rndIdx = #src
      --[[----------------------------------------------------------------------
      retrieve random id
      ----------------------------------------------------------------------]]--
      if rndIdx and rndIdx > 0 then
        local __idx = math.random(rndIdx)
        return src[__idx].id, src[__idx].label[B2H.Locale], src[__idx].icon
      end
      return nil
    end

    function B2H.HSButton:SetPosition()
      if InCombatLockdown() then return end
      B2H.HSButton:ClearAllPoints()
      B2H.HSButton:SetParent(_G[B2H.db.anchoring.frame])
      B2H.HSButton:SetPoint(B2H.db.anchoring.button_anchor, _G[B2H.db.anchoring.frame], B2H.db.anchoring.parent_anchor,
      B2H.db.anchoring.position_x, B2H.db.anchoring.position_y)
    end

    function B2H.HSButton:ScaleButton()
      if InCombatLockdown() then return end
      local btnSize = B2H.db.anchoring.button_size
      B2H.HSButton:SetSize(btnSize, btnSize)
      B2H.HSButton.mask:SetSize(btnSize, btnSize)
    end

    function B2H.HSButton:SetStrata()
      if InCombatLockdown() then return end
      local btnStrata = B2H.db.anchoring.button_strata
      if btnStrata == "PARENT" then
        local parent = B2H.HSButton:GetParent() 
        B2H.HSButton:SetFrameStrata(parent:GetFrameStrata())
      else
        B2H.HSButton:SetFrameStrata(btnStrata)
      end
    end
    --[[------------------------------------------------------------------------
    KEY BINDINGS
    ------------------------------------------------------------------------]]--
    for k,v in pairs(B2H.db.keybindings.items) do
      SetBindingMacro(v.key, B2H.HSButton:GetName())
    end
    --[[------------------------------------------------------------------------
    button action configuration
    ------------------------------------------------------------------------]]--
    B2H.HSButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
    B2H.HSButton:SetAttribute("type", "macro")
    if b2h.id then
      B2H.HSButton:SetAttribute("macrotext", "/use item:" .. b2h.id)
    end
    B2H.HSButton:SetAttribute("macrotext2", "/run Back2HomeButton:Update(true)")
    --[[------------------------------------------------------------------------
    cooldown positioning
    ------------------------------------------------------------------------]]--
    B2H.HSButton.cooldown:SetAllPoints(B2H.HSButton.icon)
    B2H.HSButton.cooldown:SetDrawSwipe(false)
    B2H.HSButton.cooldown:SetDrawEdge(false)

    --[[------------------------------------------------------------------------
    button background positioning
    ------------------------------------------------------------------------]]--
    B2H.HSButton.background:SetAllPoints(B2H.HSButton)
    B2H.HSButton.background:SetTexture(READI.T.rdl110005)
    --[[------------------------------------------------------------------------
    icon texture positioning
    ------------------------------------------------------------------------]]--
    B2H.HSButton.icon:SetAllPoints(B2H.HSButton)

    --[[------------------------------------------------------------------------
    mask texture positioning
    ------------------------------------------------------------------------]]--
    B2H.HSButton.mask:SetPoint("CENTER", B2H.HSButton.icon, "CENTER", 0, 0)
    --[[------------------------------------------------------------------------
    use the texture id of the "TempPortraitAlphaMask" (130924)
    ------------------------------------------------------------------------]]--
    B2H.HSButton.mask:SetTexture(READI.T.rdl110003, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    B2H.HSButton.icon:AddMaskTexture(B2H.HSButton.mask)
    --[[------------------------------------------------------------------------
    button border positioning
    ------------------------------------------------------------------------]]--
    B2H.HSButton.border:SetAllPoints(B2H.HSButton)
    B2H.HSButton.border:SetTexture(READI.T.rdl110001)

    b2h.isLogin = false
    return B2H.HSButton
  end

--[[----------------------------------------------------------------------------
Inititialize the Back2Home button
----------------------------------------------------------------------------]]--
  function B2H:InitializeButton()
    if InCombatLockdown() then return end
    --[[------------------------------------------------------------------------
    Create the Button and initially set scale, position and strate
    ------------------------------------------------------------------------]]--
      B2H.HSButton = B2H.HSButton or CreateButton()
      B2H.HSButton:ScaleButton()
      B2H.HSButton:SetPosition()
      B2H.HSButton:SetStrata()
      B2H.HSButton:Update(true)

      local ButtonPosition = {}

    --[[------------------------------------------------------------------------
    EVENT HANDLERS
    ----------------------------------------------------------------------------
    register all events that should trigger a shuffle of the button
    ------------------------------------------------------------------------]]--
      for i,event in ipairs(B2H.db.events) do
        B2H.HSButton:RegisterEvent(event.name)
      end
    --[[------------------------------------------------------------------------
    generic event handler so we can implement dedicated methods for each event
    the button should listen on
    ------------------------------------------------------------------------]]--
      local function OnEvent(self, evt, ...)
        if InCombatLockdown() then return end
        if self[evt] then self[evt](self, evt, ...) end
        for i,_e in ipairs(B2H.db.events) do
          if _e.name == evt and _e.active then
            B2H.HSButton:Update(true)
          end
        end
      end  
    --[[------------------------------------------------------------------------
    handling the mouseover event to show the tooltip of the currently selected
    hearthstone toy or fallback item
    ------------------------------------------------------------------------]]--
      local function OnEnter(self)
        if B2H.HSButton.tooltip then
          B2H.HSButton.tooltip:SetOwner(self, "ANCHOR_LEFT")
          B2H.HSButton.tooltip:SetToyByItemID(b2h.id)
          B2H.HSButton.tooltip:Show()
        end
      end
    --[[------------------------------------------------------------------------
    handling the mouseout event to hide the tooltip
    ------------------------------------------------------------------------]]--
      local function OnLeave(self)
        if B2H.HSButton.tooltip then
          B2H.HSButton.tooltip:Hide()
        end
      end
    --[[------------------------------------------------------------------------
    handling the click event to either shuffle the button (right click) or use
    the currently selected hearthstone toy or fallback item (left click)
    ------------------------------------------------------------------------]]--
      local function OnClick(self, clicked, down, ...)
        local start, duration = GetItemCooldown(b2h.id)
        B2H.HSButton.cooldown:SetCooldown(start, duration)
      end
    --[[------------------------------------------------------------------------
    shuffle the button when a new toy is learned
    ------------------------------------------------------------------------]]--
      function B2H.HSButton:NEW_TOY_ADDED(evt)
        EventRegistry:TriggerEvent("B2H.TOYS_UPDATED")      
        B2H.HSButton:Update(true)
      end
    --[[------------------------------------------------------------------------
    set event scripts
    ------------------------------------------------------------------------]]--
      B2H.HSButton:SetScript("OnEvent", OnEvent)
      B2H.HSButton:SetScript("OnEnter", OnEnter)
      B2H.HSButton:SetScript("OnLeave", OnLeave)
      B2H.HSButton:SetScript("OnMouseDown", function(self, button)
        if InCombatLockdown() then return end
        if button ~= "MiddleButton" then return end
        ButtonPosition.origin = {B2H.HSButton:GetPoint(1)}
        self:StartMoving()
        ButtonPosition.dragInit = {B2H.HSButton:GetPoint(1)}
      end)
      B2H.HSButton:SetScript("OnMouseUp", function(self, button)
        if InCombatLockdown() then return end
        if button ~= "MiddleButton" then return end

        ButtonPosition.dragOut = {B2H.HSButton:GetPoint(1)}
        self:StopMovingOrSizing()
        local delta = {
          x = ButtonPosition.dragOut[4] - ButtonPosition.dragInit[4],
          y = ButtonPosition.dragOut[5] - ButtonPosition.dragInit[5],
        }
        B2H.db.anchoring.position_x = format("%.2f", B2H.db.anchoring.position_x + delta.x)
        B2H.db.anchoring.position_y = format("%.2f", B2H.db.anchoring.position_y + delta.y)

        B2H:UpdateOptions(false)
      end)
  end
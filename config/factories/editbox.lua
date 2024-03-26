--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- Simple factory function for EditBoxes
--------------------------------------------------------------------------------
function B2H:EditBox(option, value, region, width, height, parent, x, y, updateFunc, ...)
  local eb = CreateFrame("EditBox", AddonName .. "EditBox_parent_" .. option, region, "InputBoxTemplate")
  eb:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x, y)
  eb:SetFrameStrata("DIALOG")
  eb:SetSize(width, height)
  eb:SetAutoFocus(false)
  eb:SetFontObject("GameFontNormal")
  eb:SetTextColor(1, 1, 1, 1)
  eb:SetJustifyH("LEFT")
  eb:SetJustifyV("TOP")
  eb:SetText(value)
  eb:SetCursorPosition(0)

  local ebBtn = CreateFrame("Button", nil, eb, "UIPanelButtonTemplate")
  ebBtn.parent = eb
  ebBtn:SetPoint("RIGHT", eb, "RIGHT", 1, 1)
  ebBtn:SetWidth(ebBtn:GetHeight() + 10)
  ebBtn:SetText("OK")
  ebBtn:Hide()

  eb:SetTextInsets(3, ebBtn:GetWidth() + 3, 0, 0)

  local function UpdateDB(value)
    if not value then return end

    self.db.parent[option] = value
    B2H.HSButton:RePosition()

    if updateFunc then
      updateFunc(value)
    end
  end

  eb:SetScript("OnEditFocusGained", function(self)
    ebBtn:Show()
  end)
  eb:SetScript("OnEditFocusLost", function(self)
    ebBtn:Hide()
  end)
  eb:HookScript("OnEnterPressed", function(self)
    ebBtn:Click()
  end)

  ebBtn:SetScript("OnClick", function()
    UpdateDB(eb:GetText())
    eb:SetCursorPosition(0)
    eb:ClearFocus()
  end)
  EventRegistry:RegisterCallback("B2H.OnResetFrames", function()
    local val = self.defaults.parent[option]
    self.db.parent[option] = val
    eb:SetText(val)
    eb:SetCursorPosition(0)
    UpdateDB(val)
  end)
  return eb
end
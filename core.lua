local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- ADDON MAIN FRAME AND LOCALIZATION TABLE
--------------------------------------------------------------------------------
B2H = CreateFrame("Frame")
B2H.data = {
  ["addon"] = "B2H",
}
B2H.Locale = GetLocale()
B2H.KeysToBind = {"LALT", "LCTRL", "LSHIFT", "RALT", "RCTRL", "RSHIFT"}
B2H.BoundKeys = {}
b2h.L = b2h.L
--[[
  Create a simple texture mapping table
  ATTENTION: to avoid errors resulting in not displaying the texture make sure you didn't
  use a normal forward slash (/) as path separator but two backslashes (\) instead
]]--
B2H.T = {
  ["BLZ_TempPortraitAlphaMask"] = "Interface\\CharacterFrame\\TempPortraitAlphaMask",
  ["b2h_hearthstone_button_inactive"] = "Interface\\Addons\\Back2Home\\media\\b2h_disabled.tga",
  ["b2h_radio_button_normal"] = "Interface\\Addons\\Back2Home\\media\\b2h_anchor_button_normal.tga",
  ["b2h_radio_button_highlight"] = "Interface\\Addons\\Back2Home\\media\\b2h_anchor_button_highlight.tga",
  ["b2h_radio_button_pushed"] = "Interface\\Addons\\Back2Home\\media\\b2h_anchor_button_pushed.tga",
}
--------------------------------------------------------------------------------
-- EVENT HANDLERS
--------------------------------------------------------------------------------
-- Custom Events
EventRegistry:RegisterCallback("B2H.PLAYABLE", function(evt, isLogin, isReload)
  if not isLogin and not isReload then return end
  B2H:GenerateDefaultSettings()
  _G[AddonName .. "DB"] = (_G[AddonName .. "DB"] or CopyTable(B2H.defaults))
  B2H.db = _G[AddonName .. "DB"]
  B2H:InitializeOptions()
  B2H:InitializeButton()
  B2H:InitializeKeyBindings()
end)

-- Native Events
function B2H:OnEvent(evt, ...)
  self[evt](self, evt, ...)
end

B2H:SetScript("OnEvent", B2H.OnEvent)
B2H:RegisterEvent("ADDON_LOADED")
B2H:RegisterEvent("PLAYER_ENTERING_WORLD")
B2H:RegisterEvent("MODIFIER_STATE_CHANGED")

function B2H:ADDON_LOADED(evt, addonName)
  if addonName == AddonName then
    self:UnregisterEvent(evt)
  end
end
function B2H:PLAYER_ENTERING_WORLD(evt, isLogin, isReload)
  -- this is a simple yield functionality to get the hearthstone toy information via the C_ToyBox API class
  C_Timer.After(0, function()
    C_Timer.After(0, function()
      EventRegistry:TriggerEvent("B2H.PLAYABLE", isLogin, isReload)
    end)
  end)
end

function B2H:MODIFIER_STATE_CHANGED(evt, key, down)
  if not B2H:IsInList(key, B2H.BoundKeys) then return end

  if down > 0 then
    local isNotBoundItem = B2H:Find(B2H.db.keybindings.items, function(k,v) return v.id == b2h.id end) == nil
    local boundItem = B2H:Find(B2H.db.keybindings.items, function(k,v) return v.key == key end)
    if isNotBoundItem then
      b2h.restore = b2h.id
    end
    b2h.id = boundItem.id
  else
    b2h.id = b2h.restore
  end
  B2H.HSButton:Update(false)
end

--------------------------------------------------------------------------------
-- COLOR SCHEME
--------------------------------------------------------------------------------
B2H.Colors = CopyTable(READI.Colors)
B2H.Colors.b2h = "00FAD4"
B2H.Colors.b2h_light = "9DFFF1"

function B2H:setTextColor(str, color)
  return READI.Helper.color:Get(color, B2H.Colors, str)
end
--------------------------------------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------------------------------------
-- simple debugging print function
--------------------------------------------------------------------------------
function B2H:Debug(con, ...)
  if not con then return end
  print("------------------------------------------")
  print(date("%H:%M:%S"), AddonName, ...)
  print("------------------------------------------")
end
--------------------------------------------------------------------------------
-- simple capitalizing function to convert the first character of a given string
-- to uppercase
--------------------------------------------------------------------------------
function B2H:CapitalizeString(str)
  return (str:gsub("^%l", string.upper))
end
--------------------------------------------------------------------------------
-- simple localization function
--------------------------------------------------------------------------------
function B2H:l10n(key)
  if b2h.L[B2H.Locale] and b2h.L[B2H.Locale][key] then
    return b2h.L[B2H.Locale][key]
  else
    return b2h.L.enUS[key] or ""
  end
end
--------------------------------------------------------------------------------
-- simple function to search for an item within a list via a boolean callback
--------------------------------------------------------------------------------
function B2H:Find(table, callback)
  if #table > 0 then
    for i, item in ipairs(table) do
      if callback(item) then
        return item
      end
    end
  else
    local i = 0
    for k,v in pairs(table) do
      i = i + 1
      if callback(k,v) then
        return v
      end
    end
  end
  return nil
end
--------------------------------------------------------------------------------
-- simple function to search for an item within a list via a boolean callback
--------------------------------------------------------------------------------
function B2H:FindIndex(table, callback)
  if #table > 0 then
    for i, item in ipairs(table) do
      if callback(item) then
        return i
      end
    end
  else
    local i = 0
    for k,v in pairs(table) do
      i = i + 1
      if callback(k) then
        return i
      end
    end
  end
  return nil
end
--------------------------------------------------------------------------------
-- simple function check if a given item is part of a list
--------------------------------------------------------------------------------
function B2H:IsInList(needle, haystack)
  for i = 1, #haystack do
    if haystack[i] == needle then
      return true
    end
  end
  return false
end
--------------------------------------------------------------------------------
-- simple function to split tables in chunks of given size
--------------------------------------------------------------------------------
function B2H:ChunkTable(tbl, size)
  local i = 1
  local count = 0
  return function()
    if i > #tbl then
      return
    end
    local chunk = table.move(tbl, i, i + size - 1, 1, {})
    i = i + size
    count = count + 1
    return count, chunk
  end
end
--------------------------------------------------------------------------------
-- simple filter function for tables using a boolean callback
--------------------------------------------------------------------------------
function B2H:FilterTable(t, callback)
  local out = {}
  for k, v in ipairs(t) do
    if callback(v) then
      table.insert(out, v)
    end
  end
  return out
end
--------------------------------------------------------------------------------
-- Initialize key bindings from database
--------------------------------------------------------------------------------
function B2H:InitializeKeyBindings()
  if #B2H.BoundKeys > 0 then B2H.BoundKeys = {} end
  for k,v in pairs(B2H.db.keybindings.items) do
    table.insert(B2H.BoundKeys, v.key)
  end
end
--------------------------------------------------------------------------------
_G[AddonName .. '_Options'] = function()
  Settings.OpenToCategory(AddonName)
end
-- enable the addon, this is defined in classic/modern
if type(b2h.Enable) == "function" then B2H:Enable() end

--------------------------------------------------------------------------------
-- SLASH COMMANDS
--------------------------------------------------------------------------------
SLASH_B2HB1 = "/home"
SLASH_B2HB2 = "/b2h"

local function InfoCommandHandler()
  print("------------------------------------------")
  print("|cFF00FAD4Back2Home|r knows two different slash commands: /home and /b2h")
  print("Use one of the keywords 'shuffle', 'random', 'update' or 'mix' to get another random hearthstone toy")
  print("|cFF00FAD4Example:|r /home shuffle")
  print("|cFF00FAD4Hint:|r The same functionality can be used via right clicking the button itself")
  print("")
  print("Use one of the keywords 'config', 'options' or 'settings' open up the configuration panel")
  print("|cFF00FAD4Example:|r /home config")
  print("|cFF00FAD4Hint:|r The same panel can be accessed via ESC > Options > Addons")
  print("")
  print(
    "Run one of the slash commands alongside with the keyword 'info' or an empty string to show this info text again.")
  print("")
  print("Thanks for using |cFF00FAD4Back2Home|r and stay healthy")
  print("yours sincerely |cFF78B064readi2play|r")
  print("------------------------------------------")
end
-- define the corresponding slash command handlers
SlashCmdList.B2HB = function(msg, editBox)
  msg = string.lower(msg)
  local infoKeywords = {"", "info"}
  local shuffleKeywords = {"shuffle", "random", "update", "mix"}
  local configKeywords = {"config", "options", "settings"}
  if B2H:IsInList(msg, shuffleKeywords) then
    B2H.HSButton:Update(true)
  elseif B2H:IsInList(msg, configKeywords) then
    _G[AddonName .. '_Options']()
  else
    InfoCommandHandler()
  end
end

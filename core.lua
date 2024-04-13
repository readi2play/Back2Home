local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- ADDON MAIN FRAME AND LOCALIZATION TABLE
--------------------------------------------------------------------------------
B2H = CreateFrame("Frame")

B2H.Colors = CopyTable(READI.Colors)
B2H.Colors.b2h = "00FAD4"
B2H.Colors.b2h_light = "9DFFF1"

B2H.data = {
  ["addon"] = "Back2Home",
  ["prefix"] = "B2H",
  ["colors"] = B2H.Colors
}
B2H.Locale = GAME_LOCALE or GetLocale()
B2H.KeysToBind = {"LALT", "LCTRL", "LSHIFT", "RALT", "RCTRL", "RSHIFT"}
B2H.BoundKeys = {}

B2H.L = B2H.L
--------------------------------------------------------------------------------
-- EVENT HANDLERS
--------------------------------------------------------------------------------

-- Custom Events

EventRegistry:RegisterCallback("B2H.PLAYABLE", function(evt, isLogin, isReload)
  B2H:InitializeDefaultSettings()
  B2H:InitializeDB()
  B2H:InitializeOptions()
  B2H:InitializeButton()
  B2H:InitializeKeyBindings()
end)

-- Native Events

function B2H:OnEvent(evt, ...)
  if self[evt] then
    self[evt](self, evt, ...)
  end
end

B2H:SetScript("OnEvent", B2H.OnEvent)
B2H:RegisterEvent("ADDON_LOADED")
B2H:RegisterEvent("CHAT_MSG_ADDON")
B2H:RegisterEvent("PLAYER_ENTERING_WORLD")
B2H:RegisterEvent("MODIFIER_STATE_CHANGED")
B2H:RegisterEvent("FIRST_FRAME_RENDERED")

function B2H:ADDON_LOADED(evt, addonName)
  if addonName == AddonName then
    B2H:SetupConfig()
    self:UnregisterEvent(evt)
  end

  B2H:InitializeDefaultSettings()
  B2H:InitializeDB()
  B2H:InitializeOptions()
  B2H:InitializeButton()
  B2H:InitializeKeyBindings()
end
function B2H:PLAYER_ENTERING_WORLD(evt, isLogin, isReload)
  B2H.registered = C_ChatInfo.RegisterAddonMessagePrefix(B2H.data.prefix)
  if not B2H.HSButton then return end
  B2H.HSButton:Update(true)
end

function B2H:FIRST_FRAME_RENDERED(evt)
  B2H:UpdateOptions()
end

function B2H:MODIFIER_STATE_CHANGED(evt, key, down)
  if not READI.Helper.table:Contains(key, B2H.BoundKeys) then return end

  if down > 0 then
    local _,isNotBoundItem = READI.Helper.table:Get(B2H.db.keybindings.items, function(_,v) return v.id == b2h.id end)
    local _,boundItem = READI.Helper.table:Get(B2H.db.keybindings.items, function(_,v) return v.key == key end)
    if not PlayerHasToy(boundItem.id) then return end
    if isNotBoundItem == nil then
      b2h.restore = {
        id = b2h.id,
        icon = b2h.icon
      }
    end
    b2h.id = boundItem.id
    b2h.icon = boundItem.icon
  else
    b2h.id = b2h.restore.id
    b2h.icon = b2h.restore.icon
  end
  B2H.HSButton:Update(false)
end

--------------------------------------------------------------------------------
-- COLOR SCHEME
--------------------------------------------------------------------------------

function B2H:setTextColor(str, color)
  return READI.Helper.color:Get(color, B2H.Colors, str)
end
--------------------------------------------------------------------------------
-- Create the config DB
function B2H:InitializeDB ()
  if not _G[AddonName .. "DB"] or _G[AddonName .. "DB"] == {} then
    _G[AddonName .. "DB"] = CopyTable(B2H.defaults)
  else
    _G[AddonName .. "DB"] = READI.Helper.table:Merge(CopyTable(B2H.defaults), _G[AddonName .. "DB"])
  end
  B2H.db = _G[AddonName .. "DB"]
end
--------------------------------------------------------------------------------
-- Initialize key bindings from database
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
  if READI.Helper.table:Contains(msg, shuffleKeywords) then
    B2H.HSButton:Update(true)
  elseif READI.Helper.table:Contains(msg, configKeywords) then
    _G[AddonName .. '_Options']()
  else
    InfoCommandHandler()
  end
end

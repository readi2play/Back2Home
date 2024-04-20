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
B2H:RegisterEvent("PLAYER_LEAVING_WORLD")
B2H:RegisterEvent("MODIFIER_STATE_CHANGED")
B2H:RegisterEvent("FIRST_FRAME_RENDERED")

function B2H:ADDON_LOADED(evt, addonName)
  if addonName ~= AddonName then return end
  self:UnregisterEvent(evt)  
  
  B2H:InitializeDefaultSettings()
  B2H:InitializeDB()
  B2H:SetupConfig()
  B2H:InitializeOptions()
  B2H:InitializeButton()
  B2H:InitializeKeyBindings()
end

function B2H:PLAYER_ENTERING_WORLD(evt, isLogin, isReload)
  B2H.registered = C_ChatInfo.RegisterAddonMessagePrefix(B2H.data.prefix)
  if not B2H.HSButton then return end
  B2H.HSButton:Update(true)
end
function B2H:PLAYER_LEAVING_WORLD(evt, isLogout, isReload)
  local dbName = AddonName .. "DB"
  local charName = format("%s-%s", GetUnitName("player"), GetRealmName())
  _G[dbName.."Chr"] = CopyTable(_G[dbName].chars[charName])
end

function B2H:FIRST_FRAME_RENDERED(evt)
  B2H:UpdateOptions()
end

function B2H:MODIFIER_STATE_CHANGED(evt, key, down)
  if InCombatLockdown() then return end
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
  local dbName = AddonName .. "DB"
  local charName = format("%s-%s", GetUnitName("player"), GetRealmName())
  -- get or create the overall SavedVariables
  _G[dbName] = _G[dbName] or {}

  -- get or create the global table
  _G[dbName].global = _G[dbName].global or {}
  READI.Helper.table:Move(B2H.defaults, _G[dbName], _G[dbName].global)
  if not next(_G[dbName].global) then
    _G[dbName].global = CopyTable(B2H.defaults)
  else
    _G[dbName].global = READI.Helper.table:Merge({}, CopyTable(B2H.defaults), _G[dbName].global)
  end

  B2H.db = _G[dbName].global

  -- get or create the character specific table
  _G[dbName].chars = _G[dbName].chars or {}
  if _G[dbName].use_profiles then
    _G[dbName].chars[charName] = _G[dbName].chars[charName] or CopyTable(B2H.defaults)
    
    _G[dbName].chars[charName].assigned_profile = _G[dbName].chars[charName].assigned_profile or charName
    local _ap = _G[dbName].chars[charName].assigned_profile

    if _ap ~= "global" then
      B2H.db = _G[dbName].chars[_ap]
    end
  end

  -- perform a cleanup to remove no longer used keys
  READI.Helper.table:CleanUp(B2H.defaults, B2H.db, "assigned_profile")
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
  print([=[ 
    |cFF00FAD4Shuffle:|r
      |cFF9DFFF1/home | /b2h|r shuffle | random | update | mix
    |cFF00FAD4Config:|r
      |cFF9DFFF1/home | /b2h|r config | options | settings
    |cFF00FAD4Help:|r
      |cFF9DFFF1/home | /b2h|r help
  ]=])
end
-- define the corresponding slash command handlers
SlashCmdList.B2HB = function(msg, editBox)
  msg = string.lower(msg)
  local infoKeywords = {"", "help"}
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

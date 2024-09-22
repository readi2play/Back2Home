local AddonName, b2h = ...
--[[----------------------------------------------------------------------------
ADDON MAIN FRAME AND LOCALIZATION TABLE
----------------------------------------------------------------------------]]--
B2H = CreateFrame("Frame")

B2H.Colors = READI.Helper.table:Merge(
  CopyTable(READI.Colors), {
    b2h = "00FAD4",
    b2h_light = "9DFFF1"
  }
)

B2H.data = {
  ["addon"] = "Back2Home",
  ["prefix"] = "B2H",
  ["colors"] = B2H.Colors
}
B2H.Locale = GAME_LOCALE or GetLocale()
B2H.KeysToBind = {"LALT", "LCTRL", "LSHIFT", "RCTRL", "RSHIFT"}
B2H.BoundKeys = {}
B2H.ActiveKeys = {}

B2H.L = B2H.L

--[[----------------------------------------------------------------------------
EVENT HANDLERS
----------------------------------------------------------------------------]]--
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
  B2H:InitializeButton()
  B2H:InitializeKeyBindings()
end

function B2H:PLAYER_ENTERING_WORLD(evt, isLogin, isReload)
  B2H.faction, _ = string.lower(UnitFactionGroup("player"))
  B2H:InitializeOptions()
  B2H.registered = C_ChatInfo.RegisterAddonMessagePrefix(B2H.data.prefix)
  if not B2H.HSButton then return end
  B2H.HSButton:Update(true)
end
function B2H:PLAYER_LEAVING_WORLD(evt, isLogout, isReload)
  local dbName = AddonName .. "DB"
  if not _G[dbName].use_profiles then return end 

  local charName = format("%s-%s", GetUnitName("player"), GetRealmName())

  _G[dbName.."Chr"] = CopyTable(_G[dbName].chars[charName] or B2H.defaults)
end

function B2H:FIRST_FRAME_RENDERED(evt)
  B2H:UpdateOptions()
end

function B2H:ItemIsToy(id)
  return C_ToyBox.GetToyInfo(id) ~= nil
end

function B2H:GetItemBagSlot(id)
  for i = 0, NUM_BAG_SLOTS do
    for j = 1, C_Container.GetContainerNumSlots(i) do
      if C_Container.GetContainerItemID(i, j) == id then
        return i, j
      end
    end
  end
  return nil
end

function B2H:MODIFIER_STATE_CHANGED(evt, key, down)
  if InCombatLockdown() then return end
  if not READI.Helper.table:Contains(key, B2H.BoundKeys) then return end
  if #B2H.ActiveKeys > 0 and key ~= B2H.ActiveKeys[1] then return end

  if down > 0 then
    table.insert(B2H.ActiveKeys, key)
    b2h.restore = {
      id = b2h.id,
      icon = b2h.icon
    }

    local _,boundItem = READI.Helper.table:Get(B2H.db.keybindings.items, function(_,v) return v.key == key end)
    if boundItem[B2H.faction] then
      if (not B2H:ItemIsToy(boundItem[B2H.faction].id) and not B2H:GetItemBagSlot(boundItem[B2H.faction].id)) and not
      (B2H:ItemIsToy(boundItem[B2H.faction].id) and PlayerHasToy(boundItem[B2H.faction].id) and B2H:IsUsable(boundItem[B2H.faction])) then return end
    else
      if (not B2H:ItemIsToy(boundItem.id) and not B2H:GetItemBagSlot(boundItem.id)) and not
      (B2H:ItemIsToy(boundItem.id) and PlayerHasToy(boundItem.id) and B2H:IsUsable(boundItem)) then return end
    end

    if boundItem[B2H.faction] then
      b2h.id = boundItem[B2H.faction].id
      b2h.icon = boundItem[B2H.faction].icon
    else
      b2h.id = boundItem.id
      b2h.icon = boundItem.icon
    end
  else
    b2h.id = b2h.restore.id
    b2h.icon = b2h.restore.icon
    B2H.ActiveKeys = {}
  end
  B2H.HSButton:Update(false)
end

--[[----------------------------------------------------------------------------
COLOR SCHEME
----------------------------------------------------------------------------]]--
function B2H:setTextColor(str, color)
  return READI.Helper.color:Get(color, B2H.Colors, str)
end
--[[----------------------------------------------------------------------------
HELPER
----------------------------------------------------------------------------]]--
function B2H:IsUsable(item)
  if not item.condition then return true end
  for key, conditions in pairs(item.condition) do
    if key == "quests" then
      return #READI.Helper.table:Filter(conditions, function(v) return C_QuestLog.IsQuestFlaggedCompleted(v) end) > 0
    end
  end

  return true
end
--[[----------------------------------------------------------------------------
Create the config DB
----------------------------------------------------------------------------]]--
function B2H:InitializeDB ()
  local dbName = AddonName .. "DB"
  local charName = format("%s-%s", GetUnitName("player"), GetRealmName())
  -- get or create the overall SavedVariables
  _G[dbName] = _G[dbName] or {
    use_profiles = false
  }

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
      _G[dbName].chars[_ap] = READI.Helper.table:Merge({}, CopyTable(B2H.defaults), _G[dbName].chars[_ap])
    else
      _G[dbName].chars[_ap] = _G[dbName].global
    end

    B2H.db = _G[dbName].chars[_ap]
  end

  -- perform a cleanup to remove no longer used keys
  READI.Helper.table:CleanUp(B2H.defaults, B2H.db, "assigned_profile")
end
--[[----------------------------------------------------------------------------
Initialize key bindings from database
----------------------------------------------------------------------------]]--
function B2H:InitializeKeyBindings()
  if #B2H.BoundKeys > 0 then B2H.BoundKeys = {} end
  for k,v in pairs(B2H.db.keybindings.items) do
    table.insert(B2H.BoundKeys, v.key)
  end
end
--[[------------------------------------------------------------------------]]--
_G[AddonName .. '_Options'] = function()
  Settings.OpenToCategory(AddonName)
end
-- enable the addon, this is defined in classic/modern
if type(b2h.Enable) == "function" then B2H:Enable() end

--[[----------------------------------------------------------------------------
SLASH COMMANDS
----------------------------------------------------------------------------]]--
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

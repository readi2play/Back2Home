--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local configKeys = {"info", "toys", "anchoring", "keybindings", "reporting"}
local data = CopyTable(B2H.data)
data.keyword = "config"
B2H.config = {}

b2h.windowWidth = SettingsPanel.Container:GetWidth()
b2h.columns = 2
b2h.columnWidth = b2h.windowWidth / b2h.columns - 20
--------------------------------------------------------------------------------
-- DEFAULT SETTINGS
--------------------------------------------------------------------------------
function B2H:InitializeDefaultSettings()
  B2H.defaults = {
    ["toys"] = {
      {
        ["active"] = PlayerHasToy(54452),
        ["id"] = 54452
      }, {
        ["active"] = PlayerHasToy(64488),
        ["id"] = 64488
      }, {
        ["active"] = PlayerHasToy(162973),
        ["id"] = 162973
      }, {
        ["active"] = PlayerHasToy(163045),
        ["id"] = 163045
      }, {
        ["active"] = PlayerHasToy(165669),
        ["id"] = 165669
      }, {
        ["active"] = PlayerHasToy(165670),
        ["id"] = 165670
      }, {
        ["active"] = PlayerHasToy(165802),
        ["id"] = 165802
      }, {
        ["active"] = PlayerHasToy(166746),
        ["id"] = 166746
      }, {
        ["active"] = PlayerHasToy(166747),
        ["id"] = 166747
      }, {
        ["active"] = PlayerHasToy(168907),
        ["id"] = 168907
      }, {
        ["active"] = PlayerHasToy(172179),
        ["id"] = 172179
      }, {
        ["active"] = PlayerHasToy(180290),
        ["id"] = 180290
      }, {
        ["active"] = PlayerHasToy(182773),
        ["id"] = 182773
      }, {
        ["active"] = PlayerHasToy(183716),
        ["id"] = 183716
      }, {
        ["active"] = PlayerHasToy(184353),
        ["id"] = 184353
      }, {
        ["active"] = PlayerHasToy(188952),
        ["id"] = 188952
      }, {
        ["active"] = PlayerHasToy(190196),
        ["id"] = 190196
      }, {
        ["active"] = PlayerHasToy(190237),
        ["id"] = 190237
      }, {
        ["active"] = PlayerHasToy(193588),
        ["id"] = 193588
      }, {
        ["active"] = PlayerHasToy(200630),
        ["id"] = 200630
      }, {
        ["active"] = PlayerHasToy(208704),
        ["id"] = 208704
      }, {
        ["active"] = PlayerHasToy(209035),
        ["id"] = 209035
      }, {
        ["active"] = PlayerHasToy(212337),
        ["id"] = 212337
      }
    },
    ["fallback"] = {
      ["id"] = 6948,
      ["active"] = true
    },
    ["parent"] = {
      ["frame"] = "MainMenuBarBackpackButton",
      ["button_anchor"] = "TOPLEFT",
      ["parent_anchor"] = "TOPRIGHT",
      ["position_x"] = -20,
      ["position_y"] = 10,
      ["button_size"] = 32,
      ["button_strata"] = "PARENT",
    },
    ["keybindings"] = {
      ["items"] = {
        ["garrison"] = {
          ["id"] = 110560,
          ["key"] = "LSHIFT"
        },
        ["dalaran"] = {
          ["id"] = 140192,
          ["key"] = "RSHIFT"
        },
      }
    },
    ["reporting"] = {
      ["debugging"] = {
        ["toys"] = false,
        ["positioning"] = false,
        ["keybindings"] = false,
        ["profiles"] = false,
      },
      ["notifications"] = {
        ["toys"] = true,
      },
    },
  }  
end
--------------------------------------------------------------------------------
-- OPTIONS PANEL CREATION
--------------------------------------------------------------------------------
function B2H:SetupConfig()
  for i,key in ipairs(configKeys) do
    B2H.config[key] = B2H.config[key] or {}
    local panelName = READI:l10n(format("config.panels.%s.title", key), "B2H.L")
    local parentPanel = nil
    local titleText = READI:l10n(format("config.panels.%s.title", key), "B2H.L")

    if key == "info" then
      panelName = AddonName
      titleText = AddonName
    else
      parentPanel = AddonName
    end

    B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline = READI:OptionPanel(data, {
      name = panelName,
      parent = parentPanel,
      title = {
        text = titleText,
        color = "b2h"
      }
    })
    InterfaceOptions_AddCategory(B2H.config[key].panel)
  end
end
--------------------------------------------------------------------------------
-- OPTIONS PANEL INITIALIZATION
--------------------------------------------------------------------------------
function B2H:InitializeOptions()
  for i,key in ipairs(configKeys) do
    local callbackKey = format("Fill%sPanel", READI.Helper.string.Capitalize(key))
    if B2H[callbackKey] then
      B2H[callbackKey](self, B2H.config[key].panel, B2H.config[key].container, B2H.config[key].anchorline)
    end
  end
end
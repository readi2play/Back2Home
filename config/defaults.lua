local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- DEFAULT SETTINGS
--------------------------------------------------------------------------------
function B2H:InitializeDefaultSettings()
  B2H.defaults = {
    items = {
      [54452] = false,
      [93672] = false,
      [64488] = false,
      [162973] = false,
      [163045] = false,
      [165669] = false,
      [165670] = false,
      [165802] = false,
      [166746] = false,
      [166747] = false,
      [168907] = false,
      [172179] = false,
      [180290] = false,
      [182773] = false,
      [183716] = false,
      [184353] = false,
      [188952] = false,
      [190196] = false,
      [190237] = false,
      [193588] = false,
      [200630] = false,
      [208704] = false,
      [209035] = false,
      [212337] = false,
      [206195] = false,
      [228940] = false,
      [236687] = false,
      [235016] = false,
      [142542] = false,
      [245970] = false,
      [246565] = false
    },
    fallbacks = {
      [6948] = true
    },
    anchoring = {
      frame = "MainMenuBarBackpackButton",
      button_anchor = "TOPLEFT",
      parent_anchor = "TOPRIGHT",
      position_x = -20,
      position_y = 10,
      button_size = 32,
      button_strata = "PARENT",
    },
    keybindings = {
      items = {
        {
          id = 110560,
          icon = 1041860,
          name = "garrison",
          condition = {
            quests = {
              34378,
              34586
            }
          },
          label = {
            deDE = "Garnisonsruhestein",
            enUS = "Garrison Hearthstone",
            esES = "Piedra de hogar de la ciudadela",
            esMX = "Piedra de hogar de la ciudadela",
            frFR = "Pierre de foyer de fief",
            itIT = "Pietra del Ritorno alla Guarnigione",
            ptBR = "Pedra de Regresso da Guarnição",
            ruRU = "Камень возвращения в гарнизон",
            koKR = "주둔지 귀환석",
            zhCN = "要塞炉石",
          },
          key = "LSHIFT"
        },
        {
          id = 140192,
          icon = 1444943,
          name = "dalaran",
          condition = {
            quests = {
              44184,
              44663
            }
          },
          label = {
            deDE = "Dalaranruhestein",
            enUS = "Dalaran Hearthstone",
            esES = "Piedra de hogar de Dalaran",
            esMX = "Piedra de hogar de Dalaran",
            frFR = "Pierre de foyer de Dalaran",
            itIT = "Pietra del Ritorno di Dalaran",
            ptBR = "Pedra de Regresso de Dalaran",
            ruRU = "Камень возвращения в Даларан",
            koKR = "달라란 귀환석",
            zhCN = "达拉然炉石",
          },
          key = "RSHIFT"
        },
        {
          id = 128353,
          icon = 134234,
          name = "dockyard",
          label = {
            deDE = "Kompass des Admirals",
            enUS = "Admiral's Compass",
            esES = "Brújula del Almirante",
            esMX = "Brújula del Almirante",
            frFR = "Boussole d'amiral",
            itIT = "Bussola dell'Ammiraglio",
            ptBR = "Bússola do Almirante",
            ruRU = "Адмиральский компас",
            koKR = "제독의 나침반",
            zhCN = "海军上将的罗盘",
          },
          key = "LCTRL"
        },
        {
          name = "relic",
          horde = {
            id = 118662,
            icon = 133283,
            label = {
              deDE = "Relikt der Speerspießer",
              enUS = "Bladespire Relic",
              esES = "Reliquia Aguja del Filo",
              esMX = "Reliquia Aguja del Filo",
              frFR = "Relique de Flèchelame",
              itIT = "Reliquia dei Lamacurva",
              ptBR = "Relíquia Giralança",
              ruRU = "Реликвия Камнерогов",
              koKR = "칼날첨탑 성물",
              zhCN = "刀塔圣物",
            },
          },
          alliance = {
            id = 118663,
            icon = 133316,
            label = {
              deDE = "Relikt von Karabor",
              enUS = "Relic of Karabor",
              esES = "Reliquia de Karabor",
              esMX = "Reliquia de Karabor",
              frFR = "Relique de Karabor",
              itIT = "Reliquia di Karabor",
              ptBR = "Relíquia de Karabor",
              ruRU = "Реликвия Карабора",
              koKR = "카라보르의 성물",
              zhCN = "卡拉波圣物",
            },
          },
          key = "RCTRL",
        },
        {
          id = 64457,
          icon = 458240,
          name = "argus",
          label = {
            deDE = "Die Letzte Reliquie von Argus",
            enUS = "The Last Relic of Argus",
            esES = "La última reliquia de Argus",
            esMX = "La última reliquia de Argus",
            frFR = "La dernière relique d'Argus",
            itIT = "Ultima Reliquia di Argus",
            ptBR = "A Última Relíquia de Argus",
            ruRU = "Последняя реликвия Аргуса",
            koKR = "마지막 아르거스 유물",
            zhCN = "阿古斯的最后一件圣物",
          },
          key = "LALT"
        }
      }
    },
    events = {
      PLAYER_ENTERING_WORLD = true,
      ZONE_CHANGED = true,
      PLAYER_LEVEL_UP = false,
      NEW_TOY_ADDED = true,
    },
    reporting = {
      debugging = {
        toys = false,
        positioning = false,
        keybindings = false,
        profiles = false,
      },
      notifications = {
        toys = true,
      },
    },
  }  
end

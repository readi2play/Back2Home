local AddonName, b2h = ...
--------------------------------------------------------------------------------
-- DEFAULT SETTINGS
--------------------------------------------------------------------------------
function B2H:InitializeDefaultSettings()
  B2H.defaults = {
    toys = {
      {
        active = false,
        owned = false,
        id = 54452,
        icon = 236222,
        label = {
          deDE = "Durchscheinendes Portal",
          enUS = "Ethereal Portal",
          esES = "Portal etéreo",
          frFR = "Portail éthérien",
          itIT = "Portale Etereo",
          ptBR = "Portal Etéreo",
          ruRU = "Эфириальный портал",
          koKR = "에테리얼 차원문",
          zhCN = "虚灵之门",
        }
      }, {
        active = false,
        owned = false,
        id = 64488,
        icon = 458254,
        label = {
          deDE = "Die Tochter des Gastwirts",
          enUS = "The Innkeeper's Daughter",
          esES = "La hija del tabernero",
          frFR = "La fille de l'aubergiste",
          itIT = "Figlia del Locandiere",
          ptBR = "A Filha do Estalajadeiro",
          ruRU = "Дочь трактирщика",
          koKR = "여관주인의 딸",
          zhCN = "旅店老板的女儿",
        }
      }, {
        active = false,
        owned = false,
        id = 162973,
        icon = 2124576,
        label = {
          deDE = "Altvater Winters Ruhestein",
          enUS = "Greatfather Winter's Hearthstone",
          esES = "Piedra de hogar del Gran Padre Invierno",
          frFR = "Pierre de foyer de Grandpère Hiver",
          itIT = "Pietra del Ritorno di Babbo Inverno",
          ptBR = "Pedra de Regresso do Papai Inverno",
          ruRU = "Камень возвращения Дедушки Зимы",
          koKR = "겨울 할아버지의 귀환석",
          zhCN = "冬天爷爷的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 163045,
        icon = 2124575,
        label = {
          deDE = "Ruhestein des kopflosen Reiters",
          enUS = "Headless Horseman's Hearthstone",
          esES = "Piedra de hogar del Jinete decapitado",
          frFR = "Pierre de foyer du Cavalier sans tête",
          itIT = "Pietra del Ritorno del Cavaliere Senza Testa",
          ptBR = "Pedra de Regresso do Cavaleiro Sem Cabeça",
          ruRU = "Камень возвращения Всадника без головы",
          koKR = "저주받은 기사의 귀환석",
          zhCN = "无头骑士的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 165669,
        icon = 2491049,
        label = {
          deDE = "Ruhestein des Mondältesten",
          enUS = "Lunar Elder's Hearthstone",
          esES = "Piedra de hogar de anciano lunar",
          frFR = "Pierre de foyer d’ancien lunaire",
          itIT = "Pietra del Ritorno dell'Anziano della Luna",
          ptBR = "Pedra de Regresso do Ancião Lunar",
          ruRU = "Камень возвращения Лунного предка",
          koKR = "달 장로의 귀환석",
          zhCN = "春节长者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 165670,
        icon = 2491048,
        label = {
          deDE = "Q. Pidos herziger Ruhestein",
          enUS = "Peddlefeet's Lovely Hearthstone",
          esES = "Piedra de hogar adorable de Pies Rápidos",
          frFR = "Pierre de foyer ravissante de Colportecœur",
          itIT = "Pietra del Ritorno Amorosa di Stupìdo",
          ptBR = "Pedra de Regresso Adorável de Ligeirinho Coração",
          ruRU = "Камушек возвращения Мелкошустра",
          koKR = "덜렁발의 사랑스러운 귀환석",
          zhCN = "小匹德菲特的可爱炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 165802,
        icon = 2491065,
        label = {
          deDE = "Ruhestein des Nobelgärtners",
          enUS = "Noble Gardener's Hearthstone",
          esES = "Piedra de hogar de jardinero noble",
          frFR = "Pierre de foyer du noble jardinier",
          itIT = "Pietra del Ritorno del Vero Gentiluovo",
          ptBR = "Pedra de Regresso do Jardineiro Nobr",
          ruRU = "Камень возвращения чудесного садовника",
          koKR = "귀족 정원사의 귀환석",
          zhCN = "复活节的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 166746,
        icon = 2491064,
        label = {
          deDE = "Ruhestein des Feuerschluckers",
          enUS = "Fire Eater's Hearthstone",
          esES = "Piedra de hogar de tragafuegos",
          frFR = "Pierre de foyer du cracheur de feu",
          itIT = "Pietra del Ritorno del Mangiatore di Fuoco",
          ptBR = "Pedra de Regresso do Engolidor de Fogo",
          ruRU = "Камень возвращения огнеглотателя",
          koKR = "불꽃 마술사의 귀환석",
          zhCN = "吞火者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 166747,
        icon = 2491063,
        label = {
          deDE = "Ruhestein des Braufestfeiernden",
          enUS = "Brewfest Reveler's Hearthstone",
          esES = "Piedra de hogar de juerguista de la Fiesta de la Cerveza",
          frFR = "Pierre de foyer de fêtard de la fête des Brasseurs",
          itIT = "Pietra del Ritorno del Festaiolo della Festa della Birra",
          ptBR = "Pedra de Regresso do Folião da CervaFest",
          ruRU = "Камень возвращения гуляки Хмельного фестиваля",
          koKR = "가을 축제 구경꾼의 귀환석",
          zhCN = "美酒节狂欢者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 168907,
        icon = 2491049,
        label = {
          deDE = "Holografischer Digitalisierungsruhestein ",
          enUS = "Holographic Digitalization Hearthstone",
          esES = "Digitalización holográfica de piedra de hogar",
          frFR = "Pierre de foyer à numérisation holographique",
          itIT = "Pietra del Ritorno Digitale Olografica",
          ptBR = "Pedra de Regresso de Digitalização Holográfica",
          ruRU = "Голографизирующий камень возвращения",
          koKR = "디지털화 홀로그램 귀환석",
          zhCN = "全息数字化炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 172179,
        icon = 3084684,
        label = {
          deDE = "Ruhestein des Ewigen Reisenden",
          enUS = "Eternal Traveler's Hearthstone",
          esES = "Piedra de hogar de viajero eterno",
          frFR = "Pierre de foyer du voyageur éternel",
          itIT = "Pietra del Ritorno del Viandante Eterno",
          ptBR = "Pedra de Regresso do Viajante Eterno",
          ruRU = "Камень возвращения вечного путника",
          koKR = "영원한 여행자의 귀환석",
          zhCN = "永恒旅者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 180290,
        icon = 3489827,
        label = {
          deDE = "Ruhestein der Nachtfae",
          enUS = "Night Fae Hearthstone",
          esES = "Piedra de hogar de sílfide nocturna",
          frFR = "Pierre de foyer des Faë nocturnes",
          itIT = "Pietra del Ritorno dei Silfi della Notte",
          ptBR = "Pedra de Regresso de Feério Noturno",
          ruRU = "Арденвельдский камень возвращения",
          koKR = "나이트 페이 귀환석",
          zhCN = "法夜炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 182773,
        icon = 3716927,
        label = {
          deDE = "Nekrolordruhestein",
          enUS = "Necrolord Hearthstone",
          esES = "Piedra de hogar de necroseñor",
          frFR = "Pierre de foyer de Nécro-seigneur",
          itIT = "Pietra del Ritorno dei Necrosignori",
          ptBR = "Pedra de Regresso dos Necrolordes",
          ruRU = "Камень возвращения некролордов",
          koKR = "강령군주 귀환석",
          zhCN = "通灵领主炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 183716,
        icon = 3514225,
        label = {
          deDE = "Venthyrsündenstein",
          enUS = "Venthyr Sinstone",
          esES = "Piedra del pecado venthyr",
          frFR = "Stèle du vice venthyr",
          itIT = "Pietra del Peccato dei Venthyr",
          ptBR = "Pedra de Pecado Venthyr",
          ruRU = "Вентирский камень грехов",
          koKR = "벤티르 죄악석",
          zhCN = "温西尔罪碑",
        }
      }, {
        active = false,
        owned = false,
        id = 184353,
        icon = 3257748,
        label = {
          deDE = "Kyrianischer Ruhestein",
          enUS = "Kyrian Hearthstone",
          esES = "Piedra de hogar kyriana",
          frFR = "Pierre de foyer kyriane",
          itIT = "Pietra del Ritorno dei Kyrian",
          ptBR = "Pedra de Regresso Kyriana",
          ruRU = "Кирийский камень возвращения",
          koKR = "키리안 귀환석",
          zhCN = "格里恩炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 188952,
        icon = 3528303,
        label = {
          deDE = "Beherrschter Ruhestein",
          enUS = "Dominated Hearthstone",
          esES = "Piedra de hogar dominada",
          frFR = "Pierre de foyer dominée",
          itIT = "Pietra del Ritorno Dominata",
          ptBR = "Pedra de Regresso Dominada",
          ruRU = "Подчиненный камень возвращения",
          koKR = "지배의 귀환석",
          zhCN = "被统御的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 190196,
        icon = 3950360,
        label = {
          deDE = "Erleuchteter Ruhestein",
          enUS = "Enlighted Hearthstone",
          esES = "Piedra de hogar de los Iluminados",
          frFR = "Pierre de foyer des Éclairés",
          itIT = "Pietra del Ritorno degli Illuminati",
          ptBR = "Pedra de Regresso Iluminada",
          ruRU = "Камень возвращения Просветленных",
          koKR = "깨달음의 귀환석",
          zhCN = "开悟者炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 190237,
        icon = 3954409,
        label = {
          deDE = "Translokationsmatrix der Mittler",
          enUS = "Broker Translocation Matrix",
          esES = "Matriz de traslado de los Especuladores",
          frFR = "Matrice de transposition de négociant",
          itIT = "Matrice di Traslocazione degli Alienatori",
          ptBR = "Matriz de Deslocamento dos Corretores",
          ruRU = "Брокерская матрица транслокации",
          koKR = "중개자 위치변환 행렬",
          zhCN = "掮灵传送矩阵",
        }
      }, {
        active = false,
        owned = false,
        id = 193588,
        icon = 4571434,
        label = {
          deDE = "Ruhestein des Zeitwanderers",
          enUS = "Timewalker's Hearthstone",
          esES = "Piedra de hogar de Caminante del Tiempo",
          frFR = "Pierre de foyer de marcheur du temps",
          itIT = "Pietra del Ritorno dei Viaggiatori nel Tempo",
          ptBR = "Pedra de Regresso do Andarilho do Tempo",
          ruRU = "Камень возвращения Дозорного Времени",
          koKR = "시간여행단의 귀환석",
          zhCN = "时光旅行者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 200630,
        icon = 4080564,
        label = {
          deDE = "Ruhestein des Windweisen der Ohn'ir",
          enUS = "Ohn'ir Windsage's Hearthstone",
          esES = "Piedra de hogar de sabio del viento Ohn'ir",
          frFR = "Pierre de foyer de sage-du-vent ohn’ir",
          itIT = "Pietra del Ritorno del Saggio delle Nubi Ohn'ir",
          ptBR = "Pedra de Regresso do Sábio dos Ventos Ohn'ir",
          ruRU = "Камень возвращения он'ирского жреца ветра",
          koKR = "온이르 바람현자의 귀환석",
          zhCN = "欧恩伊尔轻风贤者的炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 208704,
        icon = 5333528,
        label = {
          deDE = "Irdener Ruhestein des Tiefenbewohners",
          enUS = "Deepdweller's Earthen Hearthstone",
          esES = "Piedra de hogar terránea de habitante las profundidades",
          frFR = "Pierre de foyer en terre de rôdeur des profondeurs",
          itIT = "Pietra del Ritorno Terrigena dell'Abitante del Profondo",
          ptBR = "Pedra de Regresso Terrana das Profundezas",
          ruRU = "Камень возвращения земных недр",
          koKR = "심연살이의 대지 귀환석",
          zhCN = "幽邃住民的土灵炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 209035,
        icon = 2491064,
        label = {
          deDE = "Ruhestein der Flamme",
          enUS = "Hearthstone of the Flame",
          esES = "Piedra de hogar de la Llama",
          frFR = "Pierre de foyer de la Flamme",
          itIT = "Pietra del Ritorno delle Fiamme",
          ptBR = "Pedra de Regresso da Chama",
          ruRU = "Огненный камень возвращени",
          koKR = "화염의 귀환석",
          zhCN = "烈焰炉石",
        }
      }, {
        active = false,
        owned = false,
        id = 212337,
        icon = 5524923,
        label = {
          deDE = "Herdstein",
          enUS = "Stone of the Hearth",
          esES = "Piedra del hogar",
          frFR = "Pierre du foyer",
          itIT = "Pietra del Focolare",
          ptBR = "Pedra do Lar",
          ruRU = "Возвращающий камень",
          koKR = "하스의 돌",
          zhCN = "炉之石",
        }
      }, {
        active = false,
        owned = false,
        id = 206195,
        icon = 1708140,
        label = {
          deDE = "Pfad der Naaru",
          enUS = "Path of the Naaru",
          esES = "Senda de los naaru",
          frFR = "Voie des Naaru",
          itIT = "Sentiero dei Naaru",
          ptBR = "Caminho dos Naarus",
          ruRU = "Путь наару",
          koKR = "나루의 길",
          zhCN = "纳鲁之路",
        }
      }
    },
    fallbacks = {
      items = {
        {
          active = true,
          id = 6948,
          icon = 134414,
          label = {
            deDE = "Ruhestein",
            enUS = "Hearthstone",
            esES = "Piedra de hogar",
            frFR = "Pierre de foyer",
            itIT = "Pietra del Ritorno",
            ptBR = "Pedra de Regresso",
            ruRU = "Камень возвращения",
            koKR = "귀환석",
            zhCN = "炉石",
          }
        }
      }
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
        garrison = {
          id = 110560,
          icon = 1041860,
          label = {
            deDE = "Garnisonsruhestein",
            enUS = "Garrison Hearthstone",
            esES = "Piedra de hogar de la ciudadela",
            frFR = "Pierre de foyer de fief",
            itIT = "Pietra del Ritorno alla Guarnigione",
            ptBR = "Pedra de Regresso da Guarnição",
            ruRU = "Камень возвращения в гарнизон",
            koKR = "주둔지 귀환석",
            zhCN = "要塞炉石",
          },
          key = "LSHIFT"
        },
        dalaran = {
          id = 140192,
          icon = 1444943,
          label = {
            deDE = "Dalaranruhestein",
            enUS = "Dalaran Hearthstone",
            esES = "Piedra de hogar de Dalaran",
            frFR = "Pierre de foyer de Dalaran",
            itIT = "Pietra del Ritorno di Dalaran",
            ptBR = "Pedra de Regresso de Dalaran",
            ruRU = "Камень возвращения в Даларан",
            koKR = "달라란 귀환석",
            zhCN = "达拉然炉石",
          },
          key = "RSHIFT"
        },
      }
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

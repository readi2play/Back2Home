-- closure to make sure only the relevant language is uses
if (GAME_LOCALE or GetLocale()) ~= "ruRU" then return end
-- Translator ZamestoTV
local L = B2H.L
--[[General]]--
L["Version"] = "Версия"
L["Author"] = "Автор"
L["Authors"] = "Авторы"
L["Slash Commands"] = "Слеш-команды"
L[ [=[
  Перемешивайте свои игрушки для возвращения домой. Либо с помощью правого клика по кнопке %1$s, либо с использованием следующей слеш-команды
            
    %3$s


  Используйте следующую слеш-команду, чтобы открыть панель настроек для регулировки игрушек для возвращения домой, используемых кнопкой %1$s, рамкой, к которой привязана кнопка, и для выбора, использовать ли стандартный Камень возвращения в качестве запасного варианта, если игрушки для возвращения еще не собраны.
            
    %4$s

  Спасибо за использование %1$s и будьте здоровы
            

  с наилучшими пожеланиями

  %2$s
]=] ] = [=[
  Перемешивайте свои игрушки для возвращения домой. Либо с помощью правого клика по кнопке %1$s, либо с использованием следующей слеш-команды
            
    %3$s


  Используйте следующую слеш-команду, чтобы открыть панель настроек для регулировки игрушек для возвращения домой, используемых кнопкой %1$s, рамкой, к которой привязана кнопка, и для выбора, использовать ли стандартный Камень возвращения в качестве запасного варианта, если игрушки для возвращения еще не собраны.
            
    %4$s

  Спасибо за использование %1$s и будьте здоровы
            

  с наилучшими пожеланиями

  %2$s
]=]

L["Items"] = "Ротация предметов"
L["Anchoring"] = "Настройки рамки"
L["Keybindings"] = "Горячие клавиши"
L["Events"] = "Обработка событий"
L["Reporting"] = "Отладка и отчеты"

L["Included Hearthstone Toys"] = "Включенные игрушки для возвращения"
L["(The Checkboxes for not yet collected toys are disabled)"] = "(Флажки для еще не собранных игрушек отключены)"
L["Available Fallback items"] = "Доступные запасные предметы"
L["Use one of those items as a fallback if no hearthstone toys are collected or selected."] = "Используйте один из этих предметов в качестве запасного, если игрушки для возвращения не собраны или не выбраны."

L[ [[When activated %s will include "%s" in the shuffle rotation.]] ] = [[Когда активировано, %s будет включать "%s" в ротацию перемешивания.]]

L["Button Anchor"] = "Якорь кнопки"
L["Select the anchor point of the %s Button that should be aligned to its parent frame."] = "Выберите точку привязки кнопки %s, которая должна быть выровнена относительно родительской рамки."
L["Parent Anchor"] = "Родительский якорь"
L["Select the parent frame's anchor point the %s Button should be anchored to."] = "Выберите точку привязки родительской рамки, к которой должна быть привязана кнопка %s."
L["Position Offset"] = "Смещение позиции"
L["X-Offset"] = "Смещение по X"
L["Y-Offset"] = "Смещение по Y"
L["Parent Frame"] = "Родительская рамка"
L["Enter the name of the parent frame"] = "Введите имя родительской рамки"
L["Button Size"] = "Размер кнопки"
L["Button Strata"] = "Слой кнопки"
L["Select a modifier key to easily use %s via %s."] = "Выберите модификатор клавиши для удобного использования %s через %s."

L["Select the events the %s Button shall refresh to."] = "Выберите события, на которые должна обновляться кнопка %s."
L["PLAYER_ENTERING_WORLD"] = "Обновление при входе в игру и при входе или выходе из инстанса"
L["ZONE_CHANGED"] = "Обновление при смене зоны"
L["PLAYER_LEVEL_UP"] = "Обновление при повышении уровня"
L["NEW_TOY_ADDED"] = "Обновление при получении новой игрушки для возвращения"
L["When activated %s will %s."] = "Когда активировано, %s будет %s."

L["Debugging"] = "Отладка"
L["Notifications"] = "Уведомления"
L["Enable all debugging reports"] = "Включить все отладочные отчеты"
L["Enable general debugging reports"] = "Включить общие отладочные отчеты"
L["Enable debugging for toys"] = "Включить отладочные отчеты для игрушек"
L["Enable debugging for positioning"] = "Включить отладочные отчеты для позиционирования"
L["Enable debugging for keybindings"] = "Включить отладочные отчеты для горячих клавиш"
L["Enable debugging for profiles"] = "Включить отладочные отчеты для профилей"
L["Enable notifications for toys"] = "Включить уведомления в чате для новых полученных игрушек"
L["Initialize Button ..."] = "Инициализация кнопки ..."
L["Writing tooltips ..."] = "Создание всплывающих подсказок ..."
L["Painting icons ..."] = "Отрисовка иконок ..."
L["Updating button action ..."] = "Обновление действия кнопки ..."
L["Gathering data ..."] = "Сбор данных ..."
L["You don't have this toy collected yet."] = "Вы еще не собрали эту игрушку."
L["has been added to your ToyBox and activated in the config. See %s %s if you want to deactivate this toy."] = "была добавлена в вашу коллекцию игрушек и активирована в настройках. См. %s %s, если вы хотите деактивировать эту игрушку."

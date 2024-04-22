local _, b2h = ...

B2H.L = B2H.L or {}
B2H.L.deDE = {
  config = {
    panels = {
      info = {
        version = "Version",
        author = {
          none = "Autoren",
          one = "Autor",
          some = "Autoren",
        },
        commands = "Chat-Befehle",
        text = [=[
          Mische deine Hearthstone-Spielzeuge. Entweder durch einen Rechtsklick auf den %1$s-Button oder durch Verwendung des folgenden Chat-Befehls
                    
            %3$s


          Verwende den folgenden Chat-Befehl, um dieses Konfigurationsfenster zu öffnen, um die vom %1$s-Button verwendeten Hearthstone-Spielzeuge anzupassen, den Rahmen, in dem der Button verankert ist, und ob der standardmäßige Hearthstone als Fallback verwendet werden soll, wenn noch keine Hearthstone-Spielzeuge gesammelt wurden.
                    
            %4$s




          Danke, dass Du %1$s verwendest und bleib gesund
                  

          Mit freundlichem Gruß

          %2$s
        ]=]
      },
      toys = {
        title = "Toys & Fallback",
        headline = "Enthaltene Hearthstone-Spielzeuge",
        subline = "(Checkboxen für noch nicht gesammelte Spielzeuge sind deaktiviert)",
      },
      fallbacks = {
        title = "Fallbacks",
        headline = "Alternative Items",
        subline = "Verwende eines der folgend aufgelisteten Items, falls (noch) keine Ruhestein-Spielzeuge gesammelt oder ausgewählt wurden.",
      },
      anchoring = {
        title = "Frame-Einstellungen",
        headline = "",
        anchors = {
          button ={
            headline = "%s-Button",
            subline = "Wähle den Ankerpunkt des %s-Buttons aus, der an seinem Parent Frame ausgerichtet werden soll."
          },
          parent = {
            headline = "Anker des Parent Frames",
            subline = "Wählen Sie den Ankerpunkt des Parent Frames aus, an dem der %s-Button verankert werden soll."
          }
        },
        offset = {
          headline = "Versatz",
          x = "X-Achse",
          y = "Y-Achse",
        },
        parent = {
          headline = "Parent Frame",
          subline = "Gib den Namen des Parent Frames ein",
        },
        button = {
          size = {
            headline = "Größe des Buttons"
          },
          strata = {
            headline = "UI-Layer des Buttons"
          },
        },
      },
      keybindings = {
        title = "Tastenbelegungen",
        headline = "Tastenbelegungen",
        section = "Wähle eine Modifier Taste aus, um deinen %s einfach über %s zu verwenden.",
        section_relic = "Wähle eine Modifier Taste aus, um dein %s einfach über %s zu verwenden.",
      },
      reporting = {
        title = "Debugging & Reporting",
        headline = "",
        sections = {
          debugging = "Debugging",
          notifications = "Benachrichtigungen",
        },
        debugging = {
          all = "Alle Debugging-Berichte aktivieren",
          general = "Allgemeine Debugging-Berichte aktivieren",
          toys = "Debugging-Berichte für Spielzeug aktivieren",
          positioning = "Debugging-Berichte für die Positionierung aktivieren",
          keybindings = "Debugging-Berichte für Tastenbelegungen aktivieren",
          profiles = "Debugging-Berichte für Profile aktivieren"
        },
        notifications = {
          toys = "Chat-Benachrichtigungen für neu erhaltene Spielzeuge aktivieren"
        }
      },
      profiles = {
        title = "Profile",
        headline = "Charakter-Profile",
        subline = "Wähle das aktive Speicher-Profil aus. Auf diese Weise kannst du individuelle Einstellungen für verschiedene Charaktere vornehmen, was eine wesentlich flexiblere Konfiguration ermöglicht.",
        labels = {
          activation = "Charakterspezifische Profile aktivieren",
          select = "Wähle das Profil aus, das für diesen Charakter verwendet werden soll.",
          copyProfile = "Kopiere von ...",
          deleteProfile = "Profil löschen",
        },
        description = {
          activation = "Mit dieser Checkbox kannst du die Verwendung charakterspezifischer Profile aktivieren oder deaktivieren. So kannst du %s für jeden deiner Charaktere individuell konfigurieren.",
          copyProfile = "Kopiere Einstellungen aus einem anderen Profil in das aktive, wenn Du auf „%s“ klickst.",
          deleteProfile = "Klick auf „%s“, um ein nicht verwendetes oder nicht mehr benötigtes Profil zu löschen.",
        },
        dialogues = {
          prompt = {
            delete = "Möchtest du das Profil %s wirklich löschen?"
          }
        }
      }
    }

  },
  reporting = {
    general = {
      init = "Button initialisieren ...",
      tooltip = "Tooltips schreiben ...",
      icon = "Icons malen ...",
      action = "Buttonfunktionalität aktualisieren ...",
      shuffle = "Sammle Daten zusammen ..."
    },
    debugging = {},
    information = {
      toys = {
        notCollected = "Du hast dieses Spielzeug noch nicht gesammelt."
      }
    },
    notifications = {
      toys = {
        new = "wurde zu Deiner ToyBox hinzugefügt und in der Konfiguration aktiviert. Gib %s %s ein, wenn du dieses Spielzeug deaktivieren möchtest."
      }
    },
  },
}
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
          Mische deine Hearthstone-Spielzeuge. Entweder durch einen Rechtsklick auf die %1$s-Schaltfläche oder durch Verwendung des folgenden Schrägstrichbefehls
                    
            %3$s


          Verwenden Sie den folgenden Schrägstrichbefehl, um dieses Konfigurationsfenster zu öffnen, um die vom %1$s-Button verwendeten Hearthstone-Spielzeuge anzupassen, den Rahmen, in dem der Button verankert ist, und ob der standardmäßige Hearthstone als Fallback verwendet werden soll, wenn noch keine Hearthstone-Spielzeuge gesammelt wurden.
                    
            %4$s




          Vielen Dank, dass Sie %1$s nutzen und bleiben Sie gesund
                  

          Mit freundlichem Gruß

          %2$s
        ]=]
      },
      toys = {
        title = "Toys & Fallback",
        headline = "Enthaltene Hearthstone-Spielzeuge",
        subline = "(Die Checkboxen für noch nicht gesammelte Spielzeuge sind deaktiviert)",
        fallback = {
          headline = "Fallback",
          label = "Standard-Ruhestein verwenden, wenn noch keine Ruhestein-Spielzeuge gesammelt oder oben ausgewählt wurden",
        },
      },
      anchoring = {
        title = "Frame-Einstellungen",
        headline = "",
        anchors = {
          button ={
            headline = "%s-Button",
            subline = "Wähle den Ankerpunkt des %s-Buttons aus, der an seinem übergeordneten Frame ausgerichtet werden soll."
          },
          parent = {
            headline = "Anker des übergeordneten Frames",
            subline = "Wählen Sie den Ankerpunkt des übergeordneten Frames aus, an dem der %s-Button verankert werden soll."
          }
        },
        offset = {
          headline = "Versatz",
          x = "X-Achse",
          y = "Y-Achse",
        },
        parent = {
          headline = "Übergeordneter Frame",
          subline = "Gib den Namen des übergeordneten Frames ein",
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
        section = "Wähle eine Modifier Taste aus, um deinen %s einfach über %s zu verwenden."
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
        headline = "Profile",
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
        notCollected = "Sie haben dieses Spielzeug noch nicht gesammelt."
      }
    },
    notifications = {
      toys = {
        new = "%s wurde zu Ihrer ToyBox hinzugefügt und in der Konfiguration aktiviert. Sehen Sie sich die /home-Konfiguration an, wenn Sie dieses Spielzeug deaktivieren möchten."
      }
    },
  },
}
-- closure to make sure only the relevant language is uses
if (GAME_LOCALE or GetLocale()) ~= "deDE" then return end

local L = B2H.L

L["Version"] = "Version"
L["Author"] = "Autoren"
L["Authors"] = "Autor"
L["Slash Commands"] = "Chat-Befehle"
L[ [=[
  Shuffle your Hearthstone Toys. Either via right clicking the %1$s Button or by using the following slash command
            
    %3$s


  Use the following slash command to open this config panel to adjust the Hearthstone Toys used by the %1$s Button, the Frame the Button is anchored to and if the default Hearthstone should be used as a fallback if no Hearthstone Toys are collected yet.
            
    %4$s




  Thanks for using %1$s and stay healthy
            

  yours sincerely

  %2$s
]=] ] = [=[
  Mische deine Hearthstone-Spielzeuge. Entweder durch einen Rechtsklick auf den %1$s-Button oder durch Verwendung des folgenden Chat-Befehls
            
    %3$s


  Verwende den folgenden Chat-Befehl, um dieses Konfigurationsfenster zu öffnen, um die vom %1$s-Button verwendeten Hearthstone-Spielzeuge anzupassen, den Rahmen, in dem der Button verankert ist, und ob der standardmäßige Hearthstone als Fallback verwendet werden soll, wenn noch keine Hearthstone-Spielzeuge gesammelt wurden.
            
    %4$s




  Danke, dass Du %1$s verwendest und bleib gesund
          

  Mit freundlichem Gruß

  %2$s
]=]

L["Items"] = "Items in der Rotation"
L["Fallbacks"] = "Fallbacks"
L["Anchoring"] = "Frame-Einstellungen"
L["Keybindings"] = "Tastenbelegungen"
L["Events"] = "Event-Handling"
L["Reporting"] = "Debugging & Benachrichtigungen"

L["Included Hearthstone Toys"] = "Enthaltene Ruhestein-Spielzeuge"
L["(The Checkboxes for not yet collected toys are disabled)"] = "(Checkboxen für noch nicht gesammelte Spielzeuge sind deaktiviert)"
L["Available Fallback items"] = "Verfügbare Alternativen"
L["Use one of those items as a fallback if no hearthstone toys are collected or selected."] = "Verwende eines der folgend aufgelisteten Items, falls (noch) keine Ruhestein-Spielzeuge gesammelt oder ausgewählt wurden."

L[ [[When activated %s will include "%s" in the shuffle rotation.]] ] = [[Wenn dies aktiviert wird, wird %s "%s" in der Shuffle Rotation berücksichtigen.]]

L["Button Anchor"] = "%s-Button"
L["Select the anchor point of the %s Button that should be aligned to its parent frame."] = "Wähle den Ankerpunkt des %s-Buttons aus, der an seinem Parent Frame ausgerichtet werden soll."
L["Parent Anchor"] = "Anker des Parent Frames"
L["Select the parent frame's anchor point the %s Button should be anchored to."] = "Wählen Sie den Ankerpunkt des Parent Frames aus, an dem der %s-Button verankert werden soll."
L["Position Offset"] = "Versatz"
L["X-Offset"] = "X-Achse"
L["Y-Offset"] = "Y-Achse"
L["Parent Frame"] = "Parent Frame"
L["Enter the name of the parent frame"] = "Gib den Namen des Parent Frames ein"
L["Button Size"] = "Größe des Buttons"
L["Button Strata"] = "UI-Layer des Buttons"
L["Select a modifier key to easily use %s via %s."] = "Wähle eine Modifier Taste aus, um %s einfach über %s zu verwenden."

L["Select the events the %s Button shall refresh to."] = "Wähle die Ereignisse aus, bei denen der %s Button aktualisiert werden soll."
L["PLAYER_ENTERING_WORLD"] = "Bei Login und beim betreten oder verlassen von instanzierten Bereichen updaten"
L["ZONE_CHANGED"] = "Wenn das Gebiet gewechselt wird updaten"
L["PLAYER_LEVEL_UP"] = "Bei Stufenaufstieg updaten"
L["NEW_TOY_ADDED"] = "Wenn ein neues Ruhestein-Spielzeug erhalten wird updaten"
L["When activated %s will %s."] = "Wenn dies aktiviert wird, wird %s %s."

L["Debugging"] = "Debugging"
L["Notifications"] = "Benachrichtigungen"
L["Enable all debugging reports"] = "Alle Debugging-Berichte aktivieren"
L["Enable general debugging reports"] = "Allgemeine Debugging-Berichte aktivieren"
L["Enable debugging for toys"] = "Debugging-Berichte für Spielzeug aktivieren"
L["Enable debugging for positioning"] = "Debugging-Berichte für die Positionierung aktivieren"
L["Enable debugging for keybindings"] = "Debugging-Berichte für Tastenbelegungen aktivieren"
L["Enable debugging for profiles"] = "Debugging-Berichte für Profile aktivieren"
L["Enable notifications for toys"] = "Chat-Benachrichtigungen für neu erhaltene Spielzeuge aktivieren"
L["Initialize Button ..."] = "Button initialisieren ..."
L["Writing tooltips ..."] = "Tooltips schreiben ..."
L["Painting icons ..."] = "Icons malen ..."
L["Updating button action ..."] = "Buttonfunktionalität aktualisieren ..."
L["Gathering data ..."] = "Sammle Daten zusammen ..."
L["You don't have this toy collected yet."] = "Du hast dieses Spielzeug noch nicht gesammelt."
L["has been added to your ToyBox and activated in the config. See %s %s if you want to deactivate this toy."] = "wurde zu Deiner ToyBox hinzugefügt und in der Konfiguration aktiviert. Gib %s %s ein, wenn du dieses Spielzeug deaktivieren möchtest."
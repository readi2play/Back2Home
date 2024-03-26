local _, b2h = ...

b2h.L = b2h.L or {}
b2h.L.deDE = {
  -- generic strings
  ["resetBtnLbl"] = "Zurücksetzen",
  ["clearAllBtnLbl"] = "Alle entfernen",
  ["unselectAllBtnLbl"] = "Nichts auswählen",
  ["selectAllBtnLbl"] = "Alles auswählen",
  ["button"] = "Button",
  ["toyNotCollected"] = "Du hast dieses Spielzeug noch nicht gesammelt.",
  ["debugging"] = "Debugging",
  -- config panel titles
  ["toysAndFallbackPanelTitle"] = "Toys & Fallback",
  ["frameSettingsPanelTitle"] = "Frame-Einstellungen",
  ["keybindingSettingsPanelTitle"] = "Tastenbelegung",
  ["otherSettingsPanelTitle"] = "Sonstige Einstelllungen",
  -- reporting strings
  ["reportInit"] = "Button wird initialisiert ...",
  ["reportTooltip"] = "Tooltips werden geschrieben ...",
  ["reportIcon"] = "Icon wird gemalt ...",
  ["reportButton"] = "Button-Action wird aktualisiert ...",
  ["reportShuffle"] = "Sammle Daten ...",
  -- info panel strings
  ["infoAddonVersion"] = "Version:",
  ["infoAddonAuthor"] = "Autor:",
  ["infoTextHeadline"] = "Chatkommandos",
  ["infoText1"] = "Mische deine Ruhestein-Spielzeuge. Entweder durch Rechtsklick auf den",
  ["infoText2"] = "Button oder, indem du eines der folgenden Chatkommandos verwendest:",
  ["infoText3"] = "oder",
  ["infoText4"] = "Öffne das Options-Fenster, um festzulegen, welche Ruhestein-Spielzeuge vom",
  ["infoText5"] = "Button verwendet werden sollen, an welchem Frame der Button angehängt werden und ob das normale Ruhestein Item als Fallback verwendet werden soll, wenn noch keine Ruhestein-Spielzeuge gesammelt wurden.",
  ["infoText6"] = "Danke dass du",
  ["infoText7"] = "verwendest und bleib gesund",
  ["infoText8"] = "Mit freundlichem Gruß",
  -- toys & fallback panel strings
  ["toysHeadline"] = "Verwendete Ruhestein-Spielzeuge",
  ["toysSubHeadline"] = "(Die Checkboxen für noch nicht gesammelte Spielzeuge sind automatisch deaktiviert.)",
  ["fallbackText"] = "Dieses Item wird als Fallback verwendet, wenn keine Ruhestein-Spielzeuge gesammelt (oder in der Liste oben ausgewählt) wurden.",
  -- frame anchoring panel strings
  ["btnAnchor1"] = "Wähle den Ankerpunkt des",
  ["btnAnchor2"] = "Buttons zur Positionierung am unten stehenden Frame.",
  ["parentAnchorHeadline"] = "Ankerpunkt Parent Frame",
  ["parentAnchor1"] = "Wähle den Ankerpunkt des Frames an dem der",
  ["parentAnchor2"] = "Button ausgerichtet werden soll.",
  ["offsetHeadline"] = "Versatz",
  ["offsetX"] = "X-Achse",
  ["offsetY"] = "Y-Achse",
  ["parentFrameHeadline"] = "Parent Frame",
  ["parentFrameName"] = "Gib den Namen des Parent Frames an",
  ["buttonSizeSliderHeadline"] = "Button-Größe",
  -- keybinding panel strings
  ["keybindingSectionSubtext1"] = "Wähle eine Modifier-Taste und nutze deinen",
  ["keybindingSectionSubtext2"] = "einfach mit",
  -- debugging
  ["allDebugging"] = "Alle Debugging-Reports aktivieren",
  ["generalDebugging"] = "Allgemeine Debugging-Reports aktivieren",
  ["toysDebugging"] = "Debugging-Reports für Spielzeuge aktivieren",
  ["positioningDebugging"] = "Debugging-Reports für Positionierung aktivieren",
  ["keybindingsDebugging"] = "Debugging-Reports für Keybindings aktivieren",
}
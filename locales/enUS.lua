local _, b2h = ...

b2h.L = b2h.L or {}
b2h.L.enUS = {
  -- generic strings
  ["resetBtnLbl"] = "Reset",
  ["clearAllBtnLbl"] = "Clear all",
  ["unselectAllBtnLbl"] = "Unselect all",
  ["selectAllBtnLbl"] = "Select all",
  ["button"] = "Button",
  ["toyNotCollected"] = "You don't have this toy collected yet.",
  ["debugging"] = "Debugging",
  ["notifications"] = "Notifications",
  -- config panel titles
  ["toysAndFallbackPanelTitle"] = "Toys & Fallback",
  ["frameSettingsPanelTitle"] = "Frame Settings",
  ["keybindingSettingsPanelTitle"] = "Keybindings",
  ["otherSettingsPanelTitle"] = "Other Settings",
  -- reporting strings
  ["reportInit"] = "Initialize Button ...",
  ["reportTooltip"] = "Writing tooltip ...",
  ["reportIcon"] = "Painting the icon ...",
  ["reportButton"] = "Updating Button-Action ...",
  ["reportShuffle"] = "Gathering Data ...",
  -- info panel strings
  ["infoAddonVersion"] = "Version:",
  ["infoAddonAuthor"] = "Author:",
  ["infoTextHeadline"] = "Slash Commands",
  ["infoText1"] = "Shuffle your Hearthstone Toys. Either via right clicking the",
  ["infoText2"] = "Button or by using one of the following slash commands",
  ["infoText3"] = "or",
  ["infoText4"] = "Open this config panel, to adjust the Hearthstone Toys to be used by the",
  ["infoText5"] = "Button, the Frame the Button is anchored to and if standard Hearthstone item should be used as a fallback if there are no Hearthstone Toys collected yet.",
  ["infoText6"] = "Thanks for using",
  ["infoText7"] = "and stay healthy",
  ["infoText8"] = "yours sincerely",
  -- toys & fallback panel strings
  ["toysHeadline"] = "Included Hearthstone Toys",
  ["toysSubHeadline"] = "(The Checkboxes for not yet collected toys are disabled)",
  ["fallbackText"] = "This item will be used as a fallback if no Hearthstone Toys are collected or selected",
  -- frame anchoring panel strings
  ["btnAnchor1"] = "Select the anchor point of the",
  ["btnAnchor2"] = "Button that should be aligned to its parent frame.",
  ["parentAnchorHeadline"] = "Parent Frame Anchor",
  ["parentAnchor1"] = "Select the parent frame's anchor point the",
  ["parentAnchor2"] = "Button should be anchored to.",
  ["offsetHeadline"] = "Position Offset",
  ["offsetX"] = "X-Offset",
  ["offsetY"] = "Y-Offset",
  ["parentFrameHeadline"] = "Parent frame",
  ["parentFrameName"] = "Enter the name of the parent frame",
  ["buttonSizeSliderHeadline"] = "Button Size",
  -- keybinding panel strings
  ["keybindingSectionSubtext1"] = "Select a modifier key to easily use your",
  ["keybindingSectionSubtext2"] = "via",
  -- debugging
  ["allDebugging"] = "Enable all debugging reports",
  ["generalDebugging"] = "Enable general debugging reports",
  ["toysDebugging"] = "Enable debugging reports for toys",
  ["positioningDebugging"] = "Enable debugging reports for positioning",
  ["keybindingsDebugging"] = "Enable debugging reports for keybindings",
  -- notification
  ["toysNotifications"] = "Enable chat notifications for new earned toys",
  ["toyAddedNotification"] = "has been added to your ToyBox and activated in the config. See /home config if you want to deactivate this toy.",
}
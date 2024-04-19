local _, b2h = ...

B2H.L = B2H.L or {}
B2H.L.enUS = {
  config = {
    panels = {
      info = {
        version = "Version",
        author = {
          none = "Authors",
          one = "Author",
          some = "Authors",
        },
        commands = "Slash Commands",
        text = [=[
          Shuffle your Hearthstone Toys. Either via right clicking the %1$s Button or by using the following slash command
                    
            %3$s


          Use the following slash command to open this config panel to adjust the Hearthstone Toys used by the %1$s Button, the Frame the Button is anchored to and if the default Hearthstone should be used as a fallback if no Hearthstone Toys are collected yet.
                    
            %4$s




          Thanks for using %1$s and stay healthy
                    

          yours sincerely

          %2$s
        ]=]
      },
      toys = {
        title = "Toybox Items",
        headline = "Included Hearthstone Toys",
        subline = "(The Checkboxes for not yet collected toys are disabled)",
      },
      fallbacks = {
        title = "Fallback Items",
        headline = "Available Fallback items",
        subline = "Use one of those items as a fallback if no hearthstone toys are collected or selected.",
      },
      anchoring = {
        title = "Frame Settings",
        headline = "",
        anchors = {
          button ={
            headline = "%s Button",
            subline = "Select the anchor point of the %s Button that should be aligned to its parent frame."
          },
          parent = {
            headline = "Parent Frame Anchor",
            subline = "Select the parent frame's anchor point the %s Button should be anchored to."
          }
        },
        offset = {
          headline = "Position Offset",
          x = "X-Offset",
          y = "Y-Offset",
        },
        parent = {
          headline = "Parent Frame",
          subline = "Enter the name of the parent frame",
        },
        button = {
          size = {
            headline = "Button Size"
          },
          strata = {
            headline = "Button Strata"
          },
        },
      },
      keybindings = {
        title = "Keybindings",
        headline = "Keybindings",
        section = "Select a modifier key to easily use your %s via %s."
      },
      reporting = {
        title = "Debugging & Reporting",
        headline = "",
        sections = {
          debugging = "Debugging",
          notifications = "Notifications",
        },
        debugging = {
          all = "Enable all debugging reports",
          general = "Enable general debugging reports",
          toys = "Enable debugging reports for toys",
          positioning = "Enable debugging reports for positioning",
          keybindings = "Enable debugging reports for keybindings",
          profiles = "Enable debugging reports for profiles"
        },
        notifications = {
          toys = "Enable chat notifications for new earned toys"
        }
      },
      profiles = {
        title = "Profiles",
        headline = "Character Profiles",
        labels = {
          activation = "Activate character specific profiles",
          select = "Select the profile to be used for this Character",
          copyProfile = "Copy Settings from another profile",
          deleteProfile = "Delete a profile",
        },
      },
    },
  },
  reporting = {
    general = {
      init = "Initialize Button ...",
      tooltip = "Writing tooltips ...",
      icon = "Painting icons ...",
      action = "Updating button action ...",
      shuffle = "Gathering data ..."
    },
    debugging = {},
    information = {
      toys = {
        notCollected = "You don't have this toy collected yet."
      }
    },
    notifications = {
      toys = {
        new = "has been added to your ToyBox and activated in the config. See %s %s if you want to deactivate this toy."
      }
    },
  },
}
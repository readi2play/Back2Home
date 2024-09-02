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
        section = "Select a modifier key to easily use your %s via %s.",
        section_relic = "Select a modifier key to easily use your %s via %s.",
      },
      events = {
        title = "Event Listener Settings",
        headline = "",
        section = "Select the events the %s Button shall refresh to.",
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
        subline = "This section allows you to select the currently active storage profile so you can define different settings for different characters which leads to much more flexible configurations.",
        labels = {
          activation = "Activate character specific profiles",
          select = "Select the profile to be used for this Character",
          copyProfile = "Copy from ...",
          deleteProfile = "Delete profile",
        },
        description = {
          activation = "This checkbox allows you to activate or deactivate character specific storage profiles allowing you to individually configure %s for each of your characters.",
          copyProfile = "This will copy settings from another profile into the active one when hitting the \"%s\" button.",
          deleteProfile = "Hit the \"%s\" button to remove an unused or no longer required profile.",
        },
        dialogues = {
          prompt = {
            delete = "Are you sure you want to delete the profile %s?"
          }
        }
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
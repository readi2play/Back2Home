# Another Random Hearthstone Toy Addon?

This addon was created as _my first step into addon development_. I already had this functionality in style of a macro and wanted to get rid off the character limitations of user macros. The reason is simple: we're collecting more and more Hearthstone toys and it's high likely that it will become even more in the future. So the character limit of user macros (even if using macro addons to extend this limit far beyond) is a clear barrier.

I knew there were plenty of addons for random hearthstone toys but none of 'em seemed to fulfill what I wanted to achieve, so I took _my first steps into addon development_ and now proudly present the result to the community.

## **Features**

- use the normal Hearthstone item as a fallback if no respective toy was collected yet
- tooltips keep preserved
- button fits neat into default blizzard UI
- re-shuffle in one of the following ways
  - right click the button
  - use one of the following slash commands
    - `/home shuffle|random|update|mix`
    - `/b2h shuffle|random|update|mix`
- button is addressable via user macro with the following syntax:
  - `/click Back2HomeButton LeftButton 1`
- configurability for the button and its parent frame (the frame the button is anchored to)
- localized settings to serve users in their native language
- support for modifier keys for additional Hearthstone toys
  - Dalaran Hearthstone (keybinding defaults to `LSHIFT`)
  - Garrison Hearthstone (keybinding defaults to `RSHIFT`)

## Quick peek into the future

I don't want this to be a one time project. Therefore I will keep developing this further and am open to feature requests. If you find a bug, don't hesitate and let me know please. I will fix it as soon as possible.

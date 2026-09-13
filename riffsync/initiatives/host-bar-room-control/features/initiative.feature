Feature: Host Bar Room Control
  As a signed-in host in a watch party
  I want room settings in one Watch Party Settings screen on the host theater bar
  So that I can rename, copy the party URL, set visibility, and pick share quality without the Room sidebar panel

  # Out of this initiative:
  # - Host Header Layout Fix (separate initiative)
  # - Finish the Host Chrome Extension (separate Next item)
  # - Playlist / Next Up (removed now; later initiative — no playlist ticket)
  # - New Leave Party control (do not invent; see OQ leave-party-remaining-surface)
  # - Board tickets (created later in LLD grooming)
  # - HostTheaterButtonBar Load Media, Broadcast, Cast, AV, room-mode, Play/Pause
  # - Host help popup (Hide/Show chat)

  Background:
    Given I am on a watch-party room route /room/:roomId

  Scenario: Settings replaces Share on the host theater bar
    Given I am the signed-in host of the room
    When the host theater control bar renders
    Then a Settings control is present on the bar
    And the Share watch party control is not present on the bar
    And the Share Watch Party popup is not present
    And activating Settings opens Watch Party Settings

  Scenario: Watch Party Settings shows the consolidated host fields
    Given I am the signed-in host of the room
    When I open Watch Party Settings
    Then the screen is titled Watch Party Settings
    And I see a Party Name field with a Save action
    And I see a Party URL field with a Copy action
    And I see a visibility control with Private and Public options
    And I see a Share Quality control
    And I see a Close action that dismisses the screen

  Scenario: Saving the party name shows a toast-like confirmation
    Given I am the signed-in host of the room
    And Watch Party Settings is open
    When I change the party name and save
    Then the party name is updated for the room
    And a toast-like confirmation is shown

  Scenario: Changing room visibility shows a toast-like confirmation
    Given I am the signed-in host of the room
    And Watch Party Settings is open
    When I change room visibility between Private and Public
    Then the room visibility is updated
    And a toast-like confirmation is shown

  Scenario: Host copies the party URL
    Given I am the signed-in host of the room
    And Watch Party Settings is open
    When I activate Copy on the Party URL field
    Then the party URL for /room/:roomId is placed on the clipboard

  Scenario: Host can change share quality from Settings
    Given I am the signed-in host of the room
    And Watch Party Settings is open
    When I choose a Share Quality option
    Then the selected quality is stored for the host theater share
    And the change applies the next time I start Share Source Tab

  Scenario: Guests do not see Watch Party Settings
    Given I am a guest in the room and not the host
    When the room page renders
    Then the host theater control bar is not shown
    And I do not see a Settings control that opens Watch Party Settings
    And I cannot change party name, visibility, or share quality

  Scenario: Room panel playlist and host-help actions are removed
    When the room sidebar renders
    Then there is no Room button at the top of the chat section
    And the Room panel is not present
    And Next Up playlist and catalog-queue controls are not present
    And Install Host Extension is not present
    And Hosting Guide is not present
    And Leave Party is not present in the sidebar or Room panel

  Scenario: Chat People and Friends remain
    When the room sidebar renders
    Then Chat and People tabs remain
    And Friends remains available for signed-in fans

  Scenario: Watch Party Settings is accessible
    Given I am the signed-in host of the room
    When I activate Settings
    Then Watch Party Settings is exposed as a dialog with an accessible name
    And Settings exposes aria-expanded while the screen is open
    And Close and Escape dismiss the screen and return focus to Settings
    And toast-like confirmations are announced to assistive technology

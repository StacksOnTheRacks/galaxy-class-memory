Feature: Replace host-bar Share with Watch Party Settings dialog
  As a signed-in host in a watch party
  I want room settings in one Watch Party Settings screen on the host theater bar
  So that I can rename, copy the party URL, set visibility, and pick share quality without the Room sidebar panel

  # Out of this ticket: Room sidebar panel removal (#473); Load Media, Broadcast,
  # Cast, AV, Play/Pause; Host help popup; new Leave Party control.

  Background:
    Given I am on a watch-party room route /room/:roomId
    And I am the signed-in host of the room

  Scenario: Settings replaces Share on the host theater bar
    When the host theater control bar renders
    Then a Settings control is present on the bar
    And the Share watch party control is not present on the bar
    And the Share Watch Party popup is not present
    And activating Settings opens Watch Party Settings

  Scenario: Watch Party Settings shows the consolidated host fields
    When I open Watch Party Settings
    Then the screen is titled Watch Party Settings
    And I see a Party Name field with a Save action
    And I see a Party URL field with a Copy action
    And I see a visibility control with Private and Public options
    And I see a Share Quality control
    And I see a Close action that dismisses the screen

  Scenario: Saving the party name shows a toast-like confirmation
    Given Watch Party Settings is open
    When I change the party name and save
    Then the party name is updated for the room
    And a toast-like confirmation is shown

  Scenario: Changing room visibility shows a toast-like confirmation
    Given Watch Party Settings is open
    When I change room visibility between Private and Public
    Then the room visibility is updated
    And a toast-like confirmation is shown

  Scenario: Host copies the party URL
    Given Watch Party Settings is open
    When I activate Copy on the Party URL field
    Then the party URL for /room/:roomId is placed on the clipboard

  Scenario: Host can change share quality from Settings
    Given Watch Party Settings is open
    When I choose a Share Quality option
    Then the selected quality is stored for the host theater share
    And the change applies the next time I start Share Source Tab

  Scenario: Guests do not see Watch Party Settings
    Given I am a guest in the room and not the host
    When the room page renders
    Then the host theater control bar is not shown
    And I do not see a Settings control that opens Watch Party Settings
    And I cannot change party name, visibility, or share quality

  Scenario: Watch Party Settings is accessible
    When I activate Settings
    Then Watch Party Settings is exposed as a dialog with an accessible name
    And Settings exposes aria-expanded while the screen is open
    And Close and Escape dismiss the screen and return focus to Settings
    And toast-like confirmations are announced to assistive technology

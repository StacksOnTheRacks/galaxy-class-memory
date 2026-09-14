Feature: Host Header Layout Fix
  As a fan or guest in a watch party
  I want the room header to match the standard watch-party layout
  So that branding and account controls are consistent with Figma

  # Out of this initiative:
  # - Host Bar Room Control (separate initiative)
  # - Board tickets (created later in LLD grooming)
  # - Live channel shell header
  # - Friends person-icon on room header (presentation.md contract)
  # - HostTheaterButtonBar behavior changes

  Background:
    Given I am on a watch-party room route /room/:roomId
    And the Figma-aligned slim header is visible at the top of the room shell
    And the room header does not show a friends person-icon control

  Scenario: Logo on the left navigates home
    When the room page renders
    Then the RiffSync logo or brand link is on the left side of the slim header
    And activating the logo navigates to /

  Scenario: Signed-in fan sees profile menu on the right
    Given I am signed in as a fan
    When the room page renders
    Then a profile or avatar control is on the right side of the slim header
    And activating it opens an account menu with Account and Sign out
    And Sign out uses the existing first-party fan auth flow
    And returnTo for auth handoffs preserves the current room path

  Scenario: Signed-out visitor sees Sign in on the right
    Given I am not signed in
    When the room page renders
    Then a Sign in affordance is on the right side of the slim header
    And no friends person-icon appears on the header

  Scenario: Host and guest share the same header layout
    Given the room has a signed-in host and anonymous guests
    When each participant views the room
    Then the slim header shows logo left and menu right for both host and guest
    And host authority is unchanged and not exposed via header friends controls

  Scenario: Header controls are accessible
    When the slim header renders
    Then the logo control has an accessible name for home navigation
    And the profile or Sign in control exposes aria-expanded when its menu is open
    And the room document has a primary heading for the episode or room title that is sr-only
    And the slim header strip does not show a visible episode or room title
    And the slim header strip does not show a visible Host subtitle

  Scenario: Episode title stays out of other chrome
    When the room page renders
    Then the episode or room title is not shown in stage chrome
    And the episode or room title is not shown on HostTheaterButtonBar
    And no secondary header row is added for the title

  Scenario: Leave party is retired from the header
    When the slim header renders
    Then NavigationSlim does not show a Leave party link or leave control
    And the profile menu does not include Leave party

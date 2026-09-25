Feature: Render dashboard table shell for Desktop, Tablet, and Phone
  As a player
  I want the dashboard play layout from Figma
  So that game surfaces mount in the correct regions

  Scenario: Dashboard regions exist at Desktop
    Given the play surface is Table / Your Turn Desktop 4132:45
    Then regions exist for Top Bar, Player Row, My Hand, Board, and Actions
    And the composition is dashboard layout not a felt table

  Scenario: Dashboard regions exist at Tablet
    Given the play surface is Table / Your Turn Tablet 4132:795
    Then the Top Bar has identity and controls on the first row and hand meta on the second
    And regions exist for Player Row, Board, My Hand, and Actions in stacked Play Area order

  Scenario: Dashboard regions exist at Phone
    Given the play surface is Table / Your Turn Phone 4132:796
    Then regions exist for Header, Opponents as the player-row region, Board, My Hand, and Action Sheet as the Actions region

  Scenario: Desktop and Tablet top bar show public hand meta including Players
    Given public table meta with table name, hand number, blinds, Players, and street
    When the shell renders at Desktop or Tablet
    Then the top bar shows table name, hand number, blinds, Players, and street

  Scenario: Phone Header omits separate Players count
    Given public table meta including a Players count
    When the shell renders at Phone
    Then the Header shows table name and Hand number, blinds, and street
    And the Header does not show a separate Players count

  Scenario: Shell mount points stay empty of sibling surfaces
    Given the dashboard table shell is rendered
    Then the player-row, My Hand, Board, and Actions regions are mount points only
    And they do not show player tiles, My Hand contents, board or pot contents, or Fold Check Call Raise controls

  Scenario: Mic and Camera controls are omitted
    Given the dashboard table shell is rendered at any breakpoint
    Then Mic and Camera controls are not present

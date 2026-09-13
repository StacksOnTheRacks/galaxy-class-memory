Feature: Anonymous player can change in-game display name
  As an anonymous player at a Riffle table
  I want to change my in-game display name
  So that other seated players can recognize me without creating an account

  # Out of this ticket: identity sign-up/sign-in, MatchStore creation,
  # shared play URL, Sit at Table, WS notify, betting, hole/board views,
  # hand complete, display-name moderation policy (ship edit first).

  Background:
    Given a player is seated with an anonymous Riffle session
    And display name is seat-visible metadata, not identity or seat authority

  Scenario: Anonymous player changes display name
    When they change their in-game display name
    Then seated players see the new display name for that seat

  Scenario: Display name change does not require an account
    When an anonymous player saves a new display name
    Then they are not required to create a Riffle account

  Scenario: Display name change does not rebind the seat
    When an anonymous player changes their display name
    Then playerSubject and seat binding remain unchanged

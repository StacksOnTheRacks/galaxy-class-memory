Feature: Anonymous player can change in-game display name
  As an anonymous player at a Riffle table
  I want to change my in-game display name
  So that other seated players can recognize me without creating an account

  # Out of this ticket: identity sign-up/sign-in, MatchStore creation,
  # shared play URL, Sit at Table, WS notify, betting, hole/board views,
  # hand complete, uniqueness, moderation, cross-match persistence,
  # account-profile name (ship a working edit; do not block on policy).

  Background:
    Given a player is seated with an anonymous Riffle session
    And display name is seat-visible metadata, not identity or seat authority
    And sit left displayName null on this seat

  Scenario: Seated player opens Edit display name from own seat
    When they activate Edit display name on their seated felt
    Then the Edit display name overlay opens on the dimmed felt
    And the field is labeled Display name
    And helper copy is Shown to other players at the table

  Scenario: Anonymous player saves a valid display name
    When they enter a trimmed name of 3 to 24 characters
    And they save
    Then the overlay closes
    And that seat's public label shows the new name

  Scenario: Display name change does not require an account
    When an anonymous player saves a new display name
    Then they are not required to create a Riffle account

  Scenario: Display name change does not rebind the seat
    When an anonymous player changes their display name
    Then playerSubject and seat binding remain unchanged

  Scenario: Other clients see the name on the public table
    When an anonymous player saves a new display name
    Then a second client GET of the public table shows that displayName
    And live WebSocket push is not required

  Scenario: Empty or out-of-range name is rejected
    When they try to save a name that is empty, shorter than 3, or longer than 24 after trim
    Then the overlay shows Name must be 3–24 characters.
    And displayName is unchanged

  Scenario: Saving announces Saving
    When the save is in progress
    Then the Save control is replaced by Saving…
    And that status is a polite live region

  Scenario: Two seats may share a display name
    When two seated players save the same valid display name
    Then both saves succeed

  Scenario: Unseated player cannot change a display name
    Given a player is not seated
    When they try to change a seat display name
    Then no seat displayName changes

  Scenario: Other-seat bearer cannot change this seat's name
    Given another bearer is bound to a different seat
    When that bearer tries to change this seat's display name
    Then this seat's displayName is unchanged

  Scenario: Host identity cannot set a display name
    When a caller presents only host JWT, shared play URL, postMessage, cookie, host-key, or seat capability
    Then no seat displayName changes

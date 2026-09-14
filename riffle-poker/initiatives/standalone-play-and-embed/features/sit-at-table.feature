Feature: Sit at Table binds a Riffle session to a seat
  As a player at a Riffle table
  I want to click Sit at Table
  So that my Riffle bearer session binds to a seat without host identity as authority

  # Out of this ticket: account sign-up/sign-in UI, MatchStore module creation,
  # shared URL routing, display name edit, WS notify, betting actions,
  # hole/board views, hand complete, anonymous-to-account upgrade.

  Background:
    Given a match is reachable via the shared play URL
    And seat authority is a Riffle bearer session (account or anonymous)
    And host identity, room membership, and postMessage are not seat authority

  Scenario: Signed-in account sits at the table
    Given a player is signed in with a Riffle account
    When they click Sit at Table
    Then they are seated as that Riffle account
    And no anonymous session is issued

  Scenario: Anonymous player sits without an account
    When a player with no Riffle account and no existing session clicks Sit at Table
    Then they receive an anonymous session that binds that seat
    And they are not required to create a Riffle account

  Scenario: Existing anonymous session is reused on sit
    Given a player already holds an anonymous Riffle bearer
    When they click Sit at Table
    Then that same anonymous session binds the seat
    And a second anonymous session is not issued

  Scenario: Account and anonymous occupy the same table without finishing a hand
    Given one seated player is signed in with a Riffle account
    And another seated player is bound by an anonymous session
    Then both seats show occupancy of different kinds on the same match
    And no hand is opened or completed

  Scenario: Unauthenticated host guest sits in embed iframe
    Given a host has loaded the play surface via the shared play URL
    And a guest has no Riffle account and no host account
    When that guest clicks Sit at Table
    Then they are seated with an anonymous Riffle session
    And there is no Riffle login chrome in the iframe

  Scenario: Host identity is not sufficient to sit or fetch holes
    When a caller presents only host JWT, room membership, postMessage, or the shared play URL
    Then they cannot sit
    And they cannot fetch hole cards
    And occupancy is unchanged

  Scenario: Sit and later seat-scoped HTTP use the same bearer
    Given a player has sat successfully
    Then later seat-scoped HTTP uses that same Authorization bearer
    And no ambient cookie is set or required

  Scenario: Sit at Table auto-assigns the next empty seat
    Given the unseated surface shows a single Sit at Table control
    When the player clicks Sit at Table
    Then the server binds the next empty MatchStore seat
    And the player does not pick a seat id in the UI

  Scenario: Full table rejects sit without overwriting occupants
    Given every MatchStore seat already has a playerSubject
    When another player clicks Sit at Table
    Then they are not seated
    And existing occupants are unchanged

  Scenario: Same bearer already seated stays on that seat
    Given a player is already bound to a seat on this match
    When they click Sit at Table again
    Then they remain on that same seat
    And they do not occupy a second seat

  Scenario: Unseated flows into waiting-for-deal
    Given a player has clicked Sit at Table successfully
    Then the UI progresses from unseated to sit-submitting to waiting-for-deal
    And waiting-for-deal reuses the existing seated frames

  Scenario: Sit-submitting announces Taking your seat
    When Sit at Table is submitting
    Then the surface shows Taking your seat…
    And that status is a polite live region

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

  Scenario: Anonymous player sits without an account
    When a player with no Riffle account clicks Sit at Table
    Then they receive an anonymous session that binds that seat
    And they are not required to create a Riffle account

  Scenario: Account and anonymous players share a table
    Given one seated player is signed in with a Riffle account
    And another seated player is bound by an anonymous session
    When they play at the same table
    Then both seats participate in the same hand

  Scenario: Unauthenticated host guest sits in embed iframe
    Given a host has loaded the play surface via the shared play URL
    And a guest has no Riffle account and no host account
    When that guest clicks Sit at Table
    Then they are seated with an anonymous Riffle session
    And there is no Riffle login chrome in the iframe

  Scenario: Host identity is not sufficient to sit or fetch holes
    When a caller presents only host JWT, room membership, postMessage, or the shared play URL
    Then they cannot sit or fetch hole cards without a Riffle bearer bound to the seat

  Scenario: Unseated flows into waiting-for-deal
    Given a player has clicked Sit at Table successfully
    Then the UI progresses from unseated to sit-submitting to waiting-for-deal

Feature: Seat-scoped hidden views
  As a game pack developer authenticated with an SDK key
  I want to write and read a hidden view for one seat
  So that private state does not leak to another seat or to shared match reads

  # Out of this ticket: GET /moves isolation, atomic move+views,
  # SDK methods, integrator docs, signed result, player/host auth,
  # a game-rule engine, a delete/clear-view route.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: Game writes a hidden view for one seat
    Given the authenticated game has created two seats on the match
    When the authenticated game writes a hidden view for the first seat
    Then Turnur stores that payload as the first seat's hidden view

  Scenario: Reading an unset view returns null
    Given the authenticated game has created two seats on the match
    And no hidden view has been written for the first seat
    When the authenticated game reads the hidden view for the first seat
    Then the response includes the first seat
    And the view is null

  Scenario: Hidden view does not leak to another seat
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    And the second seat has a different hidden view
    When the authenticated game reads the hidden view for the first seat
    Then the response includes the first seat's hidden view
    And the response does not include the second seat's hidden view

  Scenario: Writing one seat's view does not change another seat's view
    Given the authenticated game has created two seats on the match
    And the second seat has a hidden view
    When the authenticated game writes a hidden view for the first seat
    Then the second seat's hidden view is unchanged

  Scenario: A later write replaces that seat's hidden view
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    When the authenticated game writes a different hidden view for the first seat
    Then Turnur stores the new payload as the first seat's hidden view
    And the previous payload is no longer returned

  Scenario: Shared match reads omit hidden views
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    When the authenticated game reads the match seats, current turn, or match probe
    Then those reads do not include any seat's hidden view

  Scenario: Writing without a view is rejected as an invalid request
    Given the authenticated game has created two seats on the match
    When the authenticated game writes a hidden view without a view payload
    Then Turnur rejects the request as invalid
    And no hidden view is stored for that seat

  Scenario: Unknown seat is rejected
    Given the authenticated game has created two seats on the match
    When the authenticated game writes or reads a hidden view for a seat that does not exist on the match
    Then Turnur rejects the request as seat not found

  Scenario: Missing or invalid SDK key is rejected
    When a caller writes or reads a hidden view without a valid SDK key
    Then Turnur rejects the request

  Scenario: A game cannot read or write views on another game's match
    Given a match attached by a different game
    When the authenticated game writes or reads a hidden view on that match
    Then Turnur rejects the request

  Scenario: Hidden views stay on their match
    Given a second match has also been attached
    And the authenticated game has written a hidden view on the first match
    When the authenticated game reads hidden views on the second match
    Then the second match does not include the first match's hidden views

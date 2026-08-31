Feature: Match turns and move submit
  As a game pack developer authenticated with an SDK key
  I want to designate the current seat and submit on-turn moves
  So that Turnur is turn authority without running game rules or auto-advancing

  # Out of this ticket: GET /moves, hidden-view write/read, append-only
  # rewrite rejection, SDK methods, integrator docs, signed result,
  # player/host auth, a game-rule engine, auto-advance, engine-side
  # extra-turn/skip helpers.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: Game designates whose turn it is
    Given the authenticated game has created two seats on the match
    When the authenticated game designates the first seat as the current turn
    Then Turnur reports the current turn as that seat

  Scenario: GET turn returns null when none designated
    Given the authenticated game has created two seats on the match
    And no seat has been designated as the current turn
    When the authenticated game reads the current turn
    Then Turnur reports currentSeat as null

  Scenario: Designating an unknown seat is rejected
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game designates a seat that does not exist on the match
    Then Turnur rejects the request as seat not found
    And the current turn is unchanged

  Scenario: Designating without a seat is rejected as an invalid request
    Given the authenticated game has created two seats on the match
    When the authenticated game designates a turn without a seat
    Then Turnur rejects the request as invalid
    And the current turn is unchanged

  Scenario: Off-turn move is rejected
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the second seat
    Then Turnur rejects the move as an illegal turn
    And the current turn is unchanged
    And the match move log is unchanged

  Scenario: Move is rejected when no seat is designated
    Given the authenticated game has created two seats on the match
    And no seat has been designated as the current turn
    When the authenticated game submits a move for a seat
    Then Turnur rejects the move as an illegal turn
    And the current turn is still null
    And the match move log is unchanged

  Scenario: On-turn move is accepted without game-rule checks
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat
    Then Turnur accepts the move because it is that seat's turn
    And the move is appended to the match move log
    And Turnur does not evaluate whether the move is legal under the game's rules
    And the current turn is unchanged until the game designates again

  Scenario: Further on-turn move is accepted without a new designate
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    And the authenticated game has submitted an accepted move for the first seat
    When the authenticated game submits another move for the first seat
    Then Turnur accepts the move
    And the current turn is still the first seat

  Scenario: Extra-turn is the game redesignating the same seat
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    And the authenticated game has submitted an accepted move for the first seat
    When the authenticated game designates the first seat as the current turn again
    Then Turnur reports the current turn as the first seat
    And a further move for the first seat is accepted

  Scenario: Pass is the game designating another seat
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    And the authenticated game has submitted an accepted move for the first seat
    When the authenticated game designates the second seat as the current turn
    Then Turnur reports the current turn as the second seat

  Scenario: Missing seat or payload is rejected as an invalid request
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move without a seat or without a payload
    Then Turnur rejects the request as invalid
    And the current turn is unchanged
    And the match move log is unchanged

  Scenario: Unknown seat on a move is rejected as seat not found
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for a seat that does not exist on the match
    Then Turnur rejects the request as seat not found
    And the current turn is unchanged
    And the match move log is unchanged

  Scenario: Missing or invalid SDK key is rejected
    When a caller reads or sets the turn or submits a move without a valid SDK key
    Then Turnur rejects the request

  Scenario: A game cannot read or change turn or submit moves on another game's match
    Given a match attached by a different game
    When the authenticated game reads or sets the turn or submits a move on that match
    Then Turnur rejects the request

  Scenario: Turn and moves stay on their match
    Given a second match has also been attached
    And the authenticated game has designated a turn and submitted a move on the first match
    When the authenticated game reads the turn on the second match
    Then the second match does not include the first match's current turn or move log

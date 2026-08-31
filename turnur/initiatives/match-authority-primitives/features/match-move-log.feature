Feature: Append-only move log read
  As a game pack developer authenticated with an SDK key
  I want to read the match move log
  So that accepted moves are complete and ordered and history cannot be rewritten

  # Out of this ticket: SDK methods, integrator docs, signed result,
  # player/host auth, a game-rule engine, cursor pagination,
  # a rewrite/mutate API, adding moves to the match probe.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: Accepted moves appear in the log in order
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat
    And the authenticated game designates the second seat as the current turn
    And the authenticated game submits a move for the second seat
    Then the match move log contains both accepted moves in the order they were accepted
    And every accepted move on the match is present
    And no rejected move is present

  Scenario: Empty log on an owned match is an empty list
    Given the match has no accepted moves
    When the authenticated game reads the match move log
    Then the match move log is an empty list
    And the match is not reported as missing

  Scenario: Rejected moves are not in the log
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    And the authenticated game has submitted an accepted move for the first seat
    When the authenticated game submits a move for the second seat
    Then Turnur rejects the move as an illegal turn
    And the match move log contains only the accepted move
    And the rejected move is not present

  Scenario: GET includes the stored payload
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    And the authenticated game has submitted an accepted move for the first seat
    When the authenticated game reads the match move log
    Then each log entry includes the payload that was submitted
    And the payload is unchanged from accept

  Scenario: Move log is append-only
    Given the match move log contains an accepted move
    When the authenticated game attempts to change or remove that log entry
    Then Turnur rejects the attempt
    And the match move log still contains the original entry unchanged

  Scenario: Shared match reads omit hidden views
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    And the match move log contains an accepted move
    When the authenticated game reads the match move log
    Then the response does not include any seat's hidden view

  Scenario: Missing or invalid SDK key is rejected
    When a caller reads the match move log without a valid SDK key
    Then Turnur rejects the request

  Scenario: A game cannot read another game's move log
    Given a match attached by a different game
    When the authenticated game reads the move log on that match
    Then Turnur rejects the request

  Scenario: Authority primitives stay on their match
    Given a second match has also been attached
    And the authenticated game has created seats and a move log on the first match
    When the authenticated game reads the move log on the second match
    Then the second match does not include the first match's move log

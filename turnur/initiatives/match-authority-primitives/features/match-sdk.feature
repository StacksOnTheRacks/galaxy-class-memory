Feature: Match authority SDK methods
  As a game pack developer authenticated with an SDK key
  I want SDK methods for seats, turn, moves, views, and the move log
  So that the game can treat Turnur as match-state authority without hand-rolling HTTP

  # Out of this ticket: HTTP routes and Lambdas, integrator docs,
  # signed result, player/host auth, chat/rooms/media, a game-rule
  # engine, player-facing clients holding production keys,
  # npm publish, browser bundle.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: SDK creates seats on an attached match
    When the authenticated game creates two seats through the SDK
    Then the SDK returns a distinct seatId for each seat
    And currentSeat is null

  Scenario: SDK lists the public roster without hidden views
    Given the authenticated game has created two seats through the SDK
    And the first seat has a hidden view
    When the authenticated game lists seats through the SDK
    Then the SDK returns the public roster and currentSeat
    And the response does not include any seat's hidden view

  Scenario: SDK lists seats before any seat is created
    When the authenticated game lists seats through the SDK
    Then the roster is empty
    And currentSeat is null

  Scenario: SDK gets and sets the current turn
    Given the authenticated game has created two seats through the SDK
    When the authenticated game designates the first seat as the current turn through the SDK
    Then the SDK reports the current turn as that seat
    When the authenticated game reads the current turn through the SDK
    Then the SDK reports the current turn as that seat

  Scenario: SDK reports null turn when none designated
    Given the authenticated game has created two seats through the SDK
    And no seat has been designated as the current turn
    When the authenticated game reads the current turn through the SDK
    Then the SDK reports currentSeat as null

  Scenario: SDK submits an on-turn move and lists the log
    Given the authenticated game has created two seats through the SDK
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat through the SDK
    And the authenticated game designates the second seat as the current turn through the SDK
    And the authenticated game submits a move for the second seat through the SDK
    Then the SDK move log contains both accepted moves in the order they were accepted
    And every accepted move includes the payload that was submitted
    And the submit response does not echo payload

  Scenario: SDK lists an empty move log
    Given the match has no accepted moves
    When the authenticated game lists the move log through the SDK
    Then the SDK returns an empty list
    And the match is not reported as missing

  Scenario: SDK writes and reads a seat hidden view
    Given the authenticated game has created two seats through the SDK
    When the authenticated game writes a hidden view for the first seat through the SDK
    Then the SDK stores that payload as the first seat's hidden view
    When the authenticated game reads the hidden view for the first seat through the SDK
    Then the SDK returns the first seat's hidden view
    And the response does not include the second seat's hidden view

  Scenario: SDK reads an unset view as null
    Given the authenticated game has created two seats through the SDK
    And no hidden view has been written for the first seat
    When the authenticated game reads the hidden view for the first seat through the SDK
    Then the view is null

  Scenario: SDK shared reads omit hidden views
    Given the authenticated game has created two seats through the SDK
    And the first seat has a hidden view
    When the authenticated game lists seats, reads the current turn, or lists the move log through the SDK
    Then those reads do not include any seat's hidden view

  Scenario: Auth and ownership failures surface as the SDK error type
    When a caller uses a match-authority SDK method without a valid SDK key
    Then the SDK rejects the call as the existing SDK error type
    And the failure is not a raw transport dump
    Given a match attached by a different game
    When the authenticated game uses a match-authority SDK method on that match
    Then the SDK rejects the call as the existing SDK error type
    And the failure is not a raw transport dump

  Scenario: Illegal turn and invalid writes surface as the SDK error type
    Given the authenticated game has created two seats through the SDK
    And the current turn is the first seat
    When the authenticated game submits a move for the second seat through the SDK
    Then the SDK rejects the move as an illegal turn
    And the rejection is the existing SDK error type
    And the rejection is not a raw transport dump
    When the authenticated game designates a seat that does not exist through the SDK
    Then the SDK rejects the call as seat not found
    And the rejection is the existing SDK error type
    When the authenticated game submits a move without a seat or without a payload through the SDK
    Then the SDK rejects the call as invalid
    And the rejection is the existing SDK error type

  Scenario: SDK does not log secrets or hidden views
    When the authenticated game uses any match-authority SDK method
    Then the SDK does not log the SDK key
    And the SDK does not log hidden-view payloads

  Scenario: SDK authority methods stay on their match
    Given a second match has also been attached
    And the authenticated game has created seats, a turn, a hidden view, and a move log on the first match through the SDK
    When the authenticated game reads seats, turn, views, and the move log on the second match through the SDK
    Then the second match does not include the first match's seats, current turn, hidden views, or move log

  Scenario: Shipped attach methods stay available
    When the authenticated game attaches and probes a match through the SDK
    Then those shipped methods still succeed
    And they still use the same SDK-key auth as match-authority methods

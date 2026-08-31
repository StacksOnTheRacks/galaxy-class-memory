Feature: Match seats
  As a game pack developer authenticated with an SDK key
  I want Turnur to own seats on an attached match
  So that seatIds are the authoritative roster and the host maps them to players

  # Out of this ticket: turn designate, moves, hidden-view write/read, move-log,
  # SDK methods, integrator docs, signed result, player/host auth, max/min seats.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: Game creates seats that Turnur owns
    When the authenticated game creates two seats on the match
    Then Turnur returns a distinct seatId for each seat
    And those seatIds are the authoritative roster of who sits where on the match

  Scenario: Seats do not carry player identity
    When the authenticated game creates a seat on the match
    Then the seat is owned by Turnur
    And the seat does not include a player identity
    And mapping that seatId to a player remains the host's job

  Scenario: Creating a seat does not designate a turn
    When the authenticated game creates one or more seats on the match
    Then currentSeat is null
    And this ticket does not designate a turn

  Scenario: GET seats returns the public roster without hidden views
    Given the authenticated game has created two seats on the match
    When the authenticated game reads the match seats
    Then the response includes the public roster and currentSeat
    And the response does not include any seat's hidden view

  Scenario: GET seats before any seat is created
    When the authenticated game reads the match seats
    Then the roster is empty
    And currentSeat is null

  Scenario: Missing or invalid SDK key is rejected
    When a caller creates or reads seats without a valid SDK key
    Then Turnur rejects the request

  Scenario: A game cannot read or create seats on another game's match
    Given a match attached by a different game
    When the authenticated game creates or reads seats on that match
    Then Turnur rejects the request

  Scenario: Seats stay on their match
    Given a second match has also been attached
    And the authenticated game has created seats on the first match
    When the authenticated game reads seats on the second match
    Then the second match does not include the first match's seats

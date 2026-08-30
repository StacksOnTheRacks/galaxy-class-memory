Feature: Match authority primitives
  As a game pack developer authenticated with an SDK key
  I want Turnur to own seats, turn order, seat-scoped hidden views, and an append-only move log on an attached match
  So that the game can treat Turnur as match-state authority while the host maps seatIds to players and the game supplies rules

  # Out of this initiative: signed result; player or host authentication;
  # chat, rooms, or media; a first-party game; real-time or action gameplay.

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

  Scenario: Game designates whose turn it is
    Given the authenticated game has created two seats on the match
    When the authenticated game designates the first seat as the current turn
    Then Turnur reports the current turn as that seat

  Scenario: Off-turn move is rejected
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the second seat
    Then Turnur rejects the move as an illegal turn
    And the current turn is unchanged
    And the match move log is unchanged

  Scenario: On-turn move is accepted without game-rule checks
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat
    Then Turnur accepts the move because it is that seat's turn
    And the move is appended to the match move log
    And Turnur does not evaluate whether the move is legal under the game's rules
    And the current turn is unchanged until the game designates again

  Scenario: Game writes a hidden view for one seat
    Given the authenticated game has created two seats on the match
    When the authenticated game writes a hidden view for the first seat
    Then Turnur stores that payload as the first seat's hidden view

  Scenario: Hidden view does not leak to another seat
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    And the second seat has a different hidden view
    When the authenticated game reads the hidden view for the first seat
    Then the response includes the first seat's hidden view
    And the response does not include the second seat's hidden view

  Scenario: Shared match reads omit hidden views
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    When the authenticated game reads the match seats, current turn, or move log
    Then those reads do not include any seat's hidden view

  Scenario: Accepted moves appear in the log in order
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat
    And the authenticated game designates the second seat as the current turn
    And the authenticated game submits a move for the second seat
    Then the match move log contains both accepted moves in the order they were accepted
    And every accepted move on the match is present
    And no rejected move is present

  Scenario: Move log is append-only
    Given the match move log contains an accepted move
    When the authenticated game attempts to change or remove that log entry
    Then Turnur rejects the attempt
    And the match move log still contains the original entry unchanged

  Scenario: Authority primitives stay on their match
    Given a second match has also been attached
    And the authenticated game has created seats and a move log on the first match
    When the authenticated game reads the second match
    Then the second match does not include the first match's seats, current turn, hidden views, or move log

Feature: Apply on-turn NLHE actions against MatchStore
  As a seated player on turn
  I want to submit legal NLHE actions via HTTP
  So that MatchStore and the in-process rules library advance the hand

  # Out of this ticket: identity UI, MatchStore module creation, shared play URL,
  # Sit at Table, display name, WS module creation, hole/board view wiring,
  # hand complete, side pots / all-in runout.

  Background:
    Given a player is seated with a Riffle bearer bound to matchId and seatId
    And MatchStore is the match authority
    And the in-process NLHE rules library legalizes and applies actions

  Scenario: On-turn seat submits a legal action
    Given it is that seat's turn
    When the seat submits a legal NLHE action
    Then the runtime legalizes and applies the action via the rules library
    And a move is appended to the move log

  Scenario: Off-turn or illegal action is rejected
    When a seat submits an off-turn or illegal action
    Then the action is rejected

  Scenario: Concurrent illegal turn returns 409
    When two concurrent turn mutations race illegally
    Then the illegal concurrent turn is rejected with 409

  Scenario: HTTP mutations are authoritative over WS notify
    Given WS notify is connected
    When an action is submitted
    Then accept/reject is determined by HTTP response
    And WS push does not count as accept

  Scenario: Host identity cannot submit seat actions
    When a caller presents only host identity without the seat occupant bearer
    Then the action is rejected

  Scenario: Client-supplied stack, pot, or deal is rejected
    When a client supplies stack, pot, or deal values with an action
    Then the mutation is rejected

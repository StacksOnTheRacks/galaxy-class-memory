Feature: Apply on-turn NLHE actions via Turnur turns and moves
  As a seated player whose turn it is
  I want to fold, check, call, bet, or raise through the table UI
  So that the runtime legalizes in-process, submits the opaque move to Turnur, and updates play-chip stacks and pot

  # Out of this ticket: street deal, showdown award, side pots, all-in,
  # disconnect/rejoin, signed result.

  Background:
    Given a hand is in progress on Turnur
    And the Riffle runtime uses the in-process NLHE library to legalize actions
    And turn submits require a verified host seat capability

  Scenario: Runtime designates the current seat
    Given it is one seat's turn under NLHE rules
    When the runtime designates the current seat on Turnur
    Then Turnur's current turn reflects that seat

  Scenario: On-turn legal action is legalized, submitted, and logged
    Given it is one seat's turn
    When that seat submits a legal NLHE action (fold, check, call, bet, or raise) through the table UI
    Then the Riffle runtime validates the action against in-process NLHE rules
    And the authenticated game submits the corresponding move to Turnur for that seat
    And Turnur accepts the on-turn move and appends it to the match move log

  Scenario: Stacks and pot update after an accepted action
    Given an on-turn legal action has been accepted by Turnur
    Then play-chip stacks and the pot update according to the accepted action

  Scenario: Off-turn or illegal action is rejected without advancing Turnur
    Given a hand is in progress and it is one seat's turn
    When another seat attempts an action, or the turn seat submits an illegal NLHE action
    Then the Riffle runtime rejects the action under in-process NLHE rules
    And Turnur's current turn and move log are unchanged by that attempt

  Scenario: Turn submit requires a verified seat capability
    When a client attempts a turn submit for a seat
    Then the runtime requires a verified host seat capability for that matchId and seatId

  Scenario: Concurrent illegal turn is reconciled from the move log
    When Turnur returns 409 illegal_turn for a concurrent illegal turn
    Then the runtime reconciles from the move log or cursor
    And the iframe is not treated as match authority

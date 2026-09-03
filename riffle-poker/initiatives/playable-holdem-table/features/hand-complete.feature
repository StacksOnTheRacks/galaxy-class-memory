Feature: Complete a hand by fold-to-one or non-all-in showdown
  As a seated player
  I want a seated table to finish a no-limit Hold'em hand in play chips
  So that the Now-slice completeness bar is fold-to-one or non-all-in showdown without side pots or all-in runout

  # Out of this ticket: signed result, side pots, all-in runout,
  # disconnect/rejoin, spectator polish.

  Background:
    Given a seated table can play a no-limit Hold'em hand on Turnur
    And the Riffle runtime uses the in-process NLHE library
    And Turnur remains authority for seats, turns, hidden views, and the move log

  Scenario: Hand completes by fold-to-one without showdown
    Given a hand is in progress with no player all-in
    When all but one seat fold under NLHE rules
    Then the remaining seat wins the pot in play chips
    And the hand is complete
    And Turnur's move log reflects the accepted actions for that hand

  Scenario: Hand completes at non-all-in single-pot showdown
    Given a hand reaches river with at least two seats still in and no player all-in
    When betting completes and remaining seats show down
    Then the Riffle runtime ranks hands under NLHE rules
    And the pot is awarded in play chips to the winning seat or seats for that single pot
    And the hand is complete

  Scenario: Shown hole cards are revealed only as allowed at showdown
    Given a hand completes at showdown
    When hole cards required for shown hands are revealed
    Then those cards are revealed only as allowed at showdown
    And unshown hole cards stay hidden

  Scenario: Turnur remains match authority and move log reflects the hand
    Given a hand has completed by fold-to-one or showdown
    Then Turnur remains authority for seats, turns, hidden views, and the move log
    And the move log reflects the accepted actions for that hand

  Scenario: Side pots, all-in runout, disconnect/rejoin, and spectator polish are out of this ticket
    Given a seated table can finish a hand by fold-to-one or by non-all-in showdown
    Then side pots, all-in board runout, disconnect/rejoin, and spectator polish are out of scope for this ticket

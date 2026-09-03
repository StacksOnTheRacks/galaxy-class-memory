Feature: Advance the public board through flop, turn, and river
  As a seated player
  I want the public board to advance through streets after action completes
  So that every seated player sees the same flop, turn, and river as shared table state

  # Out of this ticket: all-in runout, side pots, betting controls, showdown
  # ranking, signed result.

  Background:
    Given a hand is in progress past preflop with action complete for the street
    And the Riffle runtime uses the in-process NLHE library to deal streets
    And hole cards remain seat-scoped hidden views

  Scenario: Flop is dealt to the public board after preflop action completes
    When the Riffle runtime deals the flop under NLHE rules
    Then the public board updates with the flop for all seated players

  Scenario: Turn and river deal as applicable
    Given the flop is already on the public board and street action is complete
    When the Riffle runtime deals the next street under NLHE rules
    Then the public board updates for turn, then river as applicable

  Scenario: All seated players see the same public board
    Given the public board has advanced
    When any seated player reads table state available to that seat
    Then every seated player sees the same public board

  Scenario: Public board is not a seat hidden view
    When the public board is stored or read
    Then the public board is not stored as a seat hidden view
    And hole cards remain seat-scoped while the board is public

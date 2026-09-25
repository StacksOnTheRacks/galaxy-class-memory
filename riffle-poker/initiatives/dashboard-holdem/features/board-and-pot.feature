Feature: Show Board slots, pot, and players in hand
  As a seated player
  I want a readable public board and pot
  So that I can follow the hand through every street

  Scenario: Board advances through flop turn and river
    Given a hand is in progress
    Then the Board shows flop, turn, and river slots, pot amount, and players still in the hand

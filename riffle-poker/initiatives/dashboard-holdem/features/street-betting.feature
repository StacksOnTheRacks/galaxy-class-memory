Feature: Advance legal betting through flop, turn, and river
  As seated players
  I want full-street NLHE betting
  So that hands can reach fold-out or showdown

  Scenario: Betting rounds advance the board
    Given a hand is in progress
    When a betting round completes with two or more players still in
    Then the next street is dealt onto the Board and updates propagate to players

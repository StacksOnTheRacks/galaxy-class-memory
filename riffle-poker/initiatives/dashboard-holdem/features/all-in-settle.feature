Feature: Settle all-in with side pots when required, showdown or fold-out, and update stacks
  As seated players
  I want correct all-in and side-pot settlement
  So that stacks reflect NLHE outcomes

  Scenario: Unequal all-in stacks form side pots
    Given players are all-in for unequal amounts
    When the hand reaches settlement
    Then main and side pots are awarded to eligible winners and stacks update

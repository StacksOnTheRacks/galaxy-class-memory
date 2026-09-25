Feature: Show My Hand pocket, bank, session delta, committed, strength, outs, and action log
  As the local player
  I want private and session context in My Hand
  So that I can decide my actions

  Scenario: My Hand shows seat-scoped private context
    Given I am seated in a hand
    Then My Hand shows my pocket cards, bank, session delta, committed amount, hand strength, outs, and action log

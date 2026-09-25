Feature: Sit at table, post blinds, deal hole cards, and open betting
  As a player
  I want to sit and start a hand
  So that the game can begin from an open table

  Scenario: Two seated players start a hand
    Given I sit at an open seat
    When enough players are seated and a hand starts
    Then blinds are posted, hole cards are dealt seat-scoped, and betting opens

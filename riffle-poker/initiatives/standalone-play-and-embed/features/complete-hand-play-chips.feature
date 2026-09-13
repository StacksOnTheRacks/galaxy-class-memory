Feature: Complete a play-chip hand on standalone and embed
  As seated players
  I want to finish a no-limit Hold'em hand in play chips
  So that standalone and embed-mode both prove Riffle owns the full hand lifecycle

  # Out of this ticket: identity UI, MatchStore creation, shared play URL attach only,
  # Sit at Table alone, display name, WS module alone, individual action/board tickets,
  # play-lab rewrite, side pots / all-in runout / disconnect-rejoin / spectator polish,
  # real money / cashier / KYC.

  Background:
    Given Riffle owns seats, turns, hidden hole cards, and the move log
    And stacks and pots are play chips only
    And Turnur is not match authority for this path

  Scenario: Standalone table completes a play-chip hand
    Given at least two players are seated at the same standalone table
    When they play a no-limit Hold'em hand through deal to fold-to-one or non-all-in showdown
    Then the hand completes in play chips
    And Riffle owns match state for that hand

  Scenario: Embed-mode table completes a play-chip hand
    Given a host has loaded the play surface via the shared play URL
    And at least two guests have clicked Sit at Table
    When they play a no-limit Hold'em hand through deal to fold-to-one or non-all-in showdown
    Then the hand completes in play chips
    And chat, rooms, and media remain on the host

  Scenario: Side pots, all-in runout, and disconnect recovery are not required
    Given a seated table can finish by fold-to-one or non-all-in showdown
    Then side pots, all-in board runout, disconnect/rejoin, and spectator polish are out of scope

  Scenario: No real-money surfaces
    When players complete a hand
    Then there is no cashier, rake, or KYC surface

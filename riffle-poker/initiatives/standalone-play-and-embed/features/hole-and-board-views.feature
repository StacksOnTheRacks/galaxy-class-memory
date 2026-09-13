Feature: Hole cards stay seat-scoped and the public board is shared
  As a seated player
  I want seat-scoped hole cards and a shared public board
  So that hidden information stays private while everyone sees the same board

  # Out of this ticket: identity UI, MatchStore creation, shared play URL,
  # Sit at Table, display name, WS module, betting actions, hand complete,
  # spectator polish, Turnur hidden views.

  Background:
    Given MatchStore holds seat-scoped hidden views and public board state
    And hole cards are fetched via seat-scoped HTTP
    And public WS frames must not carry unauthorized hidden views

  Scenario: Seat sees only its own hole cards
    Given at least two players are seated and a hand is dealt
    When one seat views its cards
    Then that seat sees only its own hole cards

  Scenario: Another seat or public path must not receive foreign holes
    When another seat, spectator path, public DTO, error body, or public WS frame is inspected
    Then it must not include another seat's hole cards except legal showdown reveal

  Scenario: Public board is shared after preflop
    Given a hand is in progress past preflop
    When the public board advances
    Then every seated player sees the same public board

  Scenario: Carry forward existing /play hole and board UI
    When seated players view the table
    Then existing /play hole and board UI reads from MatchStore
    And not from Turnur hidden views

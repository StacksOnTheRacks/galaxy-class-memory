Feature: Riffle MatchStore owns seats, turns, hidden views, and the move log
  As the Riffle runtime
  I want a Riffle-owned MatchStore
  So that new play does not use Turnur as match authority

  # Out of this ticket: identity sessions, shared play URL, Sit at Table UI,
  # display name, WS notify, betting actions, hole/board UI, hand complete,
  # play-lab rewrite, runtime hosting / durable persistence.

  Background:
    Given Riffle owns match state for new work
    And the in-process NLHE rules library remains the rules evaluator
    And new work does not call @turnur/sdk or extend frozen host-key HTTP

  Scenario: MatchStore persists match, seats, turn, hidden views, move log, and shoe
    When the runtime writes match state to MatchStore
    Then seats include seatId, playerSubject, displayName, and stack
    And currentSeat, seat-scoped hidden views, append-only move log, and an in-process shoe are stored

  Scenario: Illegal concurrent turn is rejected
    When two concurrent turn mutations race for the same match
    Then the illegal concurrent turn is rejected with 409

  Scenario: Client-supplied stack, pot, or deal is rejected
    When a client supplies stack, pot, or deal values
    Then the mutation is rejected
    And stacks and pots remain play chips only

  Scenario: Public match state omits other-seat hole cards
    When public match state is read
    Then other-seat hole cards are omitted

  Scenario: Process-local store is sufficient
    Given no durable persistence backend is chosen
    Then a process-local MatchStore is enough to start

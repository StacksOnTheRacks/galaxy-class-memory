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
    Then a match record is stored
    And seats include seatId, playerSubject, displayName, and stack
    And currentSeat, seat-scoped hidden views, an append-only move log, and an in-process shoe are stored
    And the move log accepts payload kinds hand_open, action, street_deal, and hand_complete

  Scenario: Occupant fields exist without sitting a player
    Given MatchStore holds seats
    Then each seat can store playerSubject and displayName
    And this ticket does not bind a session to a seat or issue identity

  Scenario: Move log is append-only
    Given a match already has move log entries
    When the runtime records a later move
    Then the new entry is appended
    And prior entries are not rewritten or deleted

  Scenario: Illegal concurrent turn is rejected
    Given a match already has a currentSeat / turn in progress
    When two concurrent turn mutations race for the same match
    Then the illegal concurrent turn is rejected with 409

  Scenario: Client-supplied stack, pot, or deal is rejected
    When a client supplies stack, pot, or deal values
    Then the mutation is rejected
    And only the runtime, rules library, or in-process shoe write those values
    And stacks and pots remain play chips only

  Scenario: Public match state omits other-seat hole cards
    Given at least two seats have hole cards in seat-scoped hidden views
    When public match state is read
    Then other-seat hole cards are omitted
    And a seat-scoped hidden view does not include another seat's hole cards

  Scenario: Process-local store is sufficient
    Given no durable persistence backend is chosen
    Then a process-local MatchStore is enough to start
    And runtime hosting is not required for this ticket

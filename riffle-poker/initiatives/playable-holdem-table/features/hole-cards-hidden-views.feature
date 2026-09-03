Feature: Deal hole cards as seat-scoped Turnur hidden views
  As a seated player
  I want my hole cards stored as my seat's Turnur hidden view
  So that I see only my own cards and other seats cannot read them

  # Out of this ticket: showdown reveal, public board streets, betting controls,
  # signed result.

  Background:
    Given the Riffle runtime is authenticated to Turnur
    And at least two seats are seated at the table
    And seat-scoped reads require a verified host seat capability
    And hole cards are dealt via the in-process NLHE library

  Scenario: Deal writes hole cards as seat-scoped hidden views
    When the Riffle runtime deals a no-limit Hold'em hand
    Then the runtime PUTs each seat's hole cards as that seat's Turnur hidden view
    And Turnur owns the hidden views

  Scenario: Seat sees only its own hole cards
    Given a hand is in progress with hole cards dealt
    When one seat reads its hidden view or table state available to that seat
    Then that seat sees only its own hole cards

  Scenario: Other seats' hole cards do not appear in public or shared state
    Given a hand is in progress with hole cards dealt
    When public or shared table state is read
    Then that state does not include any seat's hole cards

  Scenario: Seat-scoped view read requires a verified seat capability
    When a client attempts a seat-scoped hidden-view read
    Then the runtime requires a verified host seat capability for that matchId and seatId

  Scenario: Hidden cards are not logged
    When hole cards are written or read as hidden views
    Then hole cards and hidden-view payloads are not logged

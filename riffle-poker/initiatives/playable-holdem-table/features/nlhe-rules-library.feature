Feature: In-process NLHE rules library (deal, legalize, streets, showdown)
  As the Riffle runtime
  I want a pure in-process NLHE rules library with no I/O
  So that deal, legalize, street advance, fold-to-one, and non-all-in showdown live in the runtime without a dedicated rules service or client-side authority

  # Out of this ticket: Turnur I/O, iframe UI, dedicated rules service,
  # client-side rules, side pots, all-in runout, disconnect/rejoin, signed result,
  # product stack/blinds defaults, hole-card views, Turnur turns/moves,
  # public board via Turnur, hand-complete orchestration.

  Background:
    Given poker rules execute as an in-process library inside the Riffle runtime
    And the library has no I/O and does not call Turnur
    And the library is not the iframe authority
    And seats, stacks, blinds, button, and an injectable RNG are caller-supplied inputs
    And the library does not choose product stack or blinds defaults
    And this slice accepts 2–9 seated players

  Scenario: Library deals hole cards and later streets without I/O
    Given 2–9 seats with caller-supplied stacks strictly greater than the big blind
    And the caller supplies blinds, a button seat, and an injectable RNG
    When the library deals a no-limit Hold'em hand
    Then it posts blinds into a single pot and deals two hole cards per seat
    And later it can deal a three-card flop, one-card turn, and one-card river from that deck
    And one card is burned before each street
    And hole cards and board cards are disjoint with no duplicates
    And the deal performs no I/O and does not call Turnur

  Scenario: Library legalizes on-turn fold, check, call, bet, and raise
    Given a hand is in progress and it is one seat's turn
    When that seat submits a legal NLHE action for the facing bet
    Then the library accepts the action as legal for the current seat
    And stacks and the single pot update for that action

  Scenario: Library rejects off-turn or illegal actions
    Given a hand is in progress and it is one seat's turn
    When another seat attempts an action, or the turn seat submits an illegal NLHE action
    Then the library rejects the action without changing current seat, street, pot, stacks, board, or hole cards

  Scenario: Library advances the public board when a street is complete
    Given street betting is complete with at least two seats still in and no player all-in
    When the library advances the street
    Then the public board becomes the flop after preflop, then the turn, then the river
    And the board does not advance until that street's betting is complete

  Scenario: Library completes a hand by fold-to-one
    Given a hand is in progress with no player all-in
    When all but one seat fold under NLHE rules
    Then the library completes the hand with the remaining seat winning the single pot
    And no showdown ranking runs

  Scenario: Library ranks a non-all-in single-pot showdown
    Given a hand reaches river with at least two seats still in and no player all-in
    When betting completes and remaining seats show down
    Then the library ranks standard Hold'em hands and awards the single pot
    And a tie splits that pot among the tied seats

  Scenario: Side pots, all-in runout, and disconnect are out of this ticket
    Given the library supports fold-to-one and non-all-in showdown
    Then side pots, all-in board runout, and disconnect/rejoin are not implemented
    And an action that would put a seat all-in or create a side pot is rejected

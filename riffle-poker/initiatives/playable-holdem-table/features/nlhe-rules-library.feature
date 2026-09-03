Feature: In-process NLHE rules library (deal, legalize, streets, showdown)
  As the Riffle runtime
  I want a pure in-process NLHE rules library with no I/O
  So that deal, legalize, street advance, fold-to-one, and non-all-in showdown live in the runtime without a dedicated rules service or client-side authority

  # Out of this ticket: Turnur I/O, iframe UI, dedicated rules service,
  # client-side rules, side pots, all-in runout, disconnect/rejoin, signed result.

  Background:
    Given poker rules execute as an in-process library inside the Riffle runtime
    And the library has no I/O and does not call Turnur
    And the library is not the iframe authority

  Scenario: Library deals hole cards and later streets without I/O
    When the library deals a no-limit Hold'em hand
    Then it produces hole cards and later street boards without I/O

  Scenario: Library legalizes on-turn fold, check, call, bet, and raise
    Given a hand is in progress and it is one seat's turn
    When that seat submits a legal NLHE action
    Then the library accepts the action as legal for the current seat

  Scenario: Library rejects off-turn or illegal actions
    Given a hand is in progress and it is one seat's turn
    When another seat attempts an action, or the turn seat submits an illegal NLHE action
    Then the library rejects the action without advancing authority

  Scenario: Library completes a hand by fold-to-one
    Given a hand is in progress with no player all-in
    When all but one seat fold under NLHE rules
    Then the library completes the hand with the remaining seat winning the pot

  Scenario: Library ranks a non-all-in single-pot showdown
    Given a hand reaches river with at least two seats still in and no player all-in
    When betting completes and remaining seats show down
    Then the library ranks hands and awards a single pot

  Scenario: Side pots, all-in runout, and disconnect are out of this ticket
    Given the library supports fold-to-one and non-all-in showdown
    Then side pots, all-in board runout, and disconnect/rejoin are not implemented

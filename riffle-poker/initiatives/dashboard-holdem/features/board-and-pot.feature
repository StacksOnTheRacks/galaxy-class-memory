Feature: Show Board slots, pot, and players in hand
  As a seated player
  I want a readable public board and pot
  So that I can follow the hand through every street

  Scenario: Board mounts in the dashboard region
    Given the dashboard table shell is rendered
    Then Board content renders inside data-region="board"

  Scenario: Desktop and tablet show street-labeled slots and pot chrome
    Given the dashboard breakpoint is desktop or tablet
    Then Board shows Flop, Turn, and River groups with those labels
    And Pot shows a Pot label, optional amount, optional players-in-hand line, and optional Action on you

  Scenario: Phone shows Board header and five slots without street chrome
    Given the dashboard breakpoint is phone
    Then Board shows a Board header and Pot label with optional amount on one row
    And five community slots appear in one row
    And Board has no street labels, no players-in-hand line, and no Action on you

  Scenario: Streets fill in order without inventing cards
    Given a supplied community board of 0, 3, 4, or 5 cards
    Then empty boards show all slots empty
    And a 3-card board fills Flop only
    And a 4-card board fills Flop and Turn with River empty
    And a 5-card board fills all slots
    And Board never invents cards beyond the supplied list

  Scenario: Community faces are accessible; empty slots are not cards
    Given community cards are supplied
    Then each face has an accessible name with rank and suit
    And each empty Desktop or Tablet slot is named Empty Flop, Empty Turn, or Empty River
    And each empty Phone slot is named Empty board card
    And the visible "?" is not the accessible name

  Scenario: Hole cards never appear on the Board
    Given a fixture that also carries hole cards
    Then Board shows only public community cards
    And no hole-card ranks or suits appear in Board

  Scenario: Pot amount formatting and omit when absent
    Given a pot amount is supplied
    Then Board shows that play-chip amount with a leading $ and grouping
    Given no pot amount is supplied
    Then Board omits the pot amount

  Scenario: Players in hand on desktop and tablet only
    Given the dashboard breakpoint is desktop or tablet
    And a players-in-hand count is supplied
    Then Board shows "N players in the hand" and pluralizes 1 as "1 player in the hand"
    Given no count is supplied
    Then Board omits the players-in-hand line
    Given the dashboard breakpoint is phone
    Then Board has no players-in-hand line

  Scenario: Action on you is a supplied flag on desktop and tablet only
    Given the dashboard breakpoint is desktop or tablet
    And action-on-you is supplied true
    Then Board shows the fixed copy Action on you
    Given action-on-you is supplied false or absent
    Then Board omits Action on you
    Given the dashboard breakpoint is phone
    Then Board has no Action on you

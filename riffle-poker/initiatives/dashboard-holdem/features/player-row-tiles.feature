Feature: Show player row tiles with stack, cards, action, positions, and turn timer
  As a seated player
  I want to read everyone at the table
  So that I can follow the hand without live media

  Scenario: Seat tiles show avatar or initials and poker state
    Given players are seated at the dashboard table
    Then each occupied tile shows a display name and stack with a leading $
    And a seat with an avatar shows that image
    And a seat without an avatar shows initials derived from the display name
    And no tile shows video, audio, Mic, Camera, or Muted controls

  Scenario: Desktop and tablet opponent tiles show card backs or folded state
    Given the dashboard breakpoint is desktop or tablet
    And opponents are seated
    Then an in-hand opponent shows two card backs and no rank or suit
    And a folded opponent shows no card backs and the word Fold
    And the local seat labeled You shows no card backs in the player row

  Scenario: Position markers and last action appear on the correct seat
    Given players are seated with dealer, small blind, and big blind assigned
    Then the dealer seat shows a D marker with accessible name Dealer
    And the small blind seat shows SB with accessible name Small blind
    And the big blind seat shows BB with accessible name Big blind
    And each tile shows last action text when supplied

  Scenario: Desktop and tablet show street commitment and local turn timer when acting
    Given the dashboard breakpoint is desktop or tablet
    And the local seat is acting with remaining turn time
    Then the local tile shows remaining time as m:ss text and a timer bar
    And a live region announces the turn
    And a seat with chips committed this street shows an amount in line
    When the local seat is not acting
    Then the local tile has no turn timer

  Scenario: Phone opponents region lists other seats without backs or timer
    Given the dashboard breakpoint is phone
    And other players are seated
    Then the opponents region lists other occupied seats only
    And each opponent shows avatar or initials, name, stack, last action, and position when applicable
    And the opponents region has no card backs, no You tile, and no turn timer

  Scenario: Display names are rendered as text
    Given a seated player has a display name containing HTML markup
    Then the tile shows that name as escaped text, not injected markup

Feature: Show player row tiles with stack, cards, action, positions, and turn timer
  As a seated player
  I want to read everyone at the table
  So that I can follow the hand without live media

  Scenario: Seat tiles show avatar or initials and poker state
    Given players are seated
    Then each tile shows stack, card backs or folded state, last action, and position markers when applicable

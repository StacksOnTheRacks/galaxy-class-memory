Feature: Show chip artwork at pot and seat stacks
  As a player at a Riffle-hosted poker table
  I want clean-flat chip artwork at the pot and seat stacks
  So that stacks look like Riffle Poker while numbers stay authoritative

  # Out of this ticket: Figma source authoring, card faces, felt tokens,
  # Canva kit, side-pot chrome, chip animations, gameplay changes.

  Background:
    Given chip assets are served from the Riffle origin
    And art direction is clean flat vector — bold suits, minimal texture, modern app feel

  Scenario: Chip artwork appears at pot and seat stacks
    When a player views the pot or seat stack display
    Then clean flat chip artwork is visible at the pot and/or seat stacks
    And numeric stack values remain authoritative for game state

  Scenario: Chip stacks are not color-alone
    Then chip stacks are distinguishable by visible label/value, not color alone

  Scenario: Artwork does not change gameplay or host contracts
    When Riffle chip art ships
    Then NLHE rules, pot math, and stack math are unchanged

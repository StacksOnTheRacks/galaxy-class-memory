Feature: Apply Riffle felt and table chrome tokens
  As a player at a Riffle-hosted poker table
  I want Riffle felt and table rail styling
  So that the seated table reads as Riffle instead of a generic CSS gradient

  # Out of this ticket: card faces, chips, asset pipeline, Canva kit,
  # lab chrome redesign, RiffSync host reskin, gameplay changes.

  Background:
    Given the bound Figma file is Riffle Poker Design
    And art direction is clean flat vector — bold suits, minimal texture, modern app feel

  Scenario: Felt and table chrome use Riffle identity
    When a player views the seated table
    Then the felt and table rail use Riffle palette and flat vector styling
    And the felt is not a generic CSS gradient placeholder alone

  Scenario: Action control contrast is preserved
    Then contrast on felt for action controls is unchanged or improved vs the placeholder

  Scenario: Play lab harness chrome may stay dark
    Then play-lab harness chrome may remain a dark operator theme

  Scenario: Artwork does not change gameplay or host contracts
    When Riffle felt and chrome ship
    Then NLHE rules and host contracts are unchanged

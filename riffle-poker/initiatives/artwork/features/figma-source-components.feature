Feature: Define Riffle Figma source components for cards, chips, and felt
  As a designer on Riffle Poker
  I want first-party card, chip, and felt components in the bound Figma file
  So that exports and reskins share one clean-flat visual kit

  # Out of this ticket: asset pipeline, play-surface wiring, Canva kit,
  # new screens, gameplay, host contracts.

  Background:
    Given the bound Figma file is Riffle Poker Design
    And art direction is clean flat vector — bold suits, minimal texture, modern app feel
    And rules card notation remains As, Kh, Td, 2c, etc.

  Scenario: Card face component set matches rules notation
    Then the bound Figma file contains a 52-card face component set whose ranks and suits match rules notation

  Scenario: Card back artwork is defined and exportable
    Then card back artwork is defined in Figma and exportable

  Scenario: Chip and felt components exist
    Then chip denomination components exist as clean-flat play-chip art
    And a Table Felt (Riffle) component exists with the Riffle palette

  Scenario: Seated-table frame structure is unchanged
    Then seated-table and play-lab frame structure is unchanged
    And faces, back, and chips are export-ready as SVG

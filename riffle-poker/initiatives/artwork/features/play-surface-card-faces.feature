Feature: Render Riffle card faces on hole, board, and showdown
  As a player at a Riffle-hosted poker table
  I want Riffle card-face artwork on hole cards and the community board
  So that the play surface looks like Riffle Poker instead of text spans alone

  # Out of this ticket: Figma source authoring, asset pipeline, felt/chips,
  # Canva kit, new hidden-card UI, gameplay changes.

  Background:
    Given the asset pipeline and cardAssetUrl are available
    And the bound Figma file is Riffle Poker Design

  Scenario: Seated play surface shows Riffle card face artwork
    When a player views hole cards or the community board on the play surface
    Then each card is rendered with Riffle card face artwork
    And cards are not rendered as rank-and-suit text spans alone

  Scenario: Play lab inherits play-surface artwork
    Given the play lab embeds two Riffle-origin /play iframes
    When an operator runs a lab session
    Then both iframes show the reskinned play surface artwork

  Scenario: Accessibility is preserved with artwork
    When card face artwork is shown
    Then each card retains a programmatic name with rank and suit
    And suits and win/lose states are not encoded by color alone

  Scenario: Artwork does not change gameplay or host contracts
    When Riffle card faces ship
    Then NLHE rules and host bootstrap/seat-capability contracts are unchanged
    And card notation in rules and payloads remains As, Kh, Td, 2c, etc.

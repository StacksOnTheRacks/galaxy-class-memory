Feature: Riffle artwork and visual identity
  As a player at a Riffle-hosted poker table
  I want first-party card, chip, and felt artwork
  So that the play surface looks like Riffle Poker instead of a generic placeholder

  # Out of this initiative:
  # - RiffSync host reskin or host-platform chrome
  # - Public marketing website (Web Site is a separate Next item)
  # - Real-money cashier, rake, or KYC artwork
  # - Additional poker variants, tournaments, or new gameplay rules
  # - Turnur integration, host contracts, or seat-capability changes
  # - Side pots, all-in runout, disconnect/rejoin, or spectator polish

  Background:
    Given the playable no-limit Hold'em table and play lab are shipped in riffle-poker
    And the bound Figma file is Riffle Poker Design
    And art direction is clean flat vector — bold suits, minimal texture, modern app feel
    And rules card notation remains As, Kh, Td, 2c, etc.

  Scenario: Seated play surface shows Riffle card face artwork
    When a player views hole cards or the community board on the play surface
    Then each card is rendered with Riffle card face artwork
    And cards are not rendered as rank-and-suit text spans alone

  Scenario: Card back artwork exists for future hidden states
    Given Riffle card back artwork is defined in Figma and exported
    Then a card back asset is available for future hidden-card UI
    And wiring the card back in the running app may be deferred to LLD if no hidden-card UI exists yet

  Scenario: Felt and table chrome use Riffle identity
    When a player views the seated table
    Then the felt and table rail use Riffle palette and flat vector styling
    And the felt is not a generic CSS gradient placeholder alone

  Scenario: Chip artwork appears at pot and seat stacks
    When a player views the pot or seat stack display
    Then clean flat chip artwork is visible at the pot and/or seat stacks
    And numeric stack values remain authoritative for game state

  Scenario: Play lab inherits play-surface artwork
    Given the play lab embeds two Riffle-origin /play iframes
    When an operator runs a lab session
    Then both iframes show the reskinned play surface artwork
    And the lab harness chrome may remain a dark operator theme

  Scenario: Canva kit exists for non-product surfaces
    When marketing needs logo lockups or social templates
    Then a Canva kit exists with logo lockups, at least one social template, and a one-pager
    And the Canva kit is derived from the same Riffle identity as the Figma artwork

  Scenario: Artwork does not change gameplay or host contracts
    When Riffle artwork ships
    Then NLHE rules, Turnur integration, and host bootstrap/seat-capability contracts are unchanged
    And card notation in rules and Turnur payloads remains As, Kh, Td, 2c, etc.

  Scenario: Accessibility is preserved with artwork
    When card face artwork is shown
    Then each card retains a programmatic name with rank and suit
    And suits and win/lose states are not encoded by color alone

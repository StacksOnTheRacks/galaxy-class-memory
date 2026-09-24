Feature: Serve first-party artwork via GET /assets/* and cardAssetUrl
  As the Riffle runtime
  I want a same-origin asset pipeline and card URL mapper
  So that play-surface render tickets resolve first-party artwork without hotlinks

  # Out of this ticket: Figma authoring, card face rendering, felt tokens,
  # chip UI, Canva kit, Turnur or host API changes.

  Background:
    Given exported artwork lives under public/assets/
    And rules card notation remains As, Kh, Td, 2c, etc.

  Scenario: Cards and back are served from the Riffle origin
    When a client requests card assets
    Then GET /assets/* serves 52 face SVGs and back.svg from the Riffle origin

  Scenario: cardAssetUrl maps rules notation to asset URLs
    When cardAssetUrl is called for a rules Card
    Then it returns a same-origin URL for that card's face artwork

  Scenario: Card back is available for future hidden-card UI
    Then a card back asset is available via the same pipeline

  Scenario: Production bundles do not hotlink external art
    Then production play bundles do not hotlink external image URLs
    And CSP img-src 'self' data: is unchanged

  Scenario: SVGs are reviewed before commit
    Then SVGs committed to the repo are reviewed for script injection
    And export metadata is stripped

Feature: Publish Canva kit from the same Riffle identity
  As marketing for Riffle Poker
  I want a Canva kit derived from the same identity as Figma artwork
  So that non-product surfaces can use Riffle branding without runtime assets

  # Out of this ticket: runtime asset pipeline, play-surface wiring,
  # public marketing website (Web Site is a separate Next item).

  Background:
    Given the bound Figma file is Riffle Poker Design
    And art direction is clean flat vector — bold suits, minimal texture, modern app feel

  Scenario: Canva kit exists for non-product surfaces
    When marketing needs logo lockups or social templates
    Then a Canva kit exists with logo lockups, at least one social template, and a one-pager
    And the Canva kit is derived from the same Riffle identity as the Figma artwork

  Scenario: Canva kit is not served by the runtime
    Then the kit lives outside the runtime repo
    And it is not served by GET /assets/*

  Scenario: Licenses are documented
    When the kit is published
    Then template and font licenses are documented

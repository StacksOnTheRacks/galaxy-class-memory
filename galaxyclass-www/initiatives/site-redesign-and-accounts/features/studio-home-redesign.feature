Feature: Redesign studio home and navigation
  As a visitor to Galaxy Class Gaming
  I want a redesigned studio home with Riffle featured
  So that I learn about the studio and can play Riffle via an external destination

  Background:
    Given the studio site is a static Next.js export
    And the public hostname is https://galaxyclass.app

  Scenario: Visitor loads the redesigned studio home on the apex host
    When a visitor opens https://galaxyclass.app/
    Then they see the redesigned Galaxy Class studio home
    And the page presents the studio story and functional fun positioning
    And Riffle is featured as the first game with an external play destination
    And atmospheric motion honors prefers-reduced-motion

  Scenario: Navigation reflects session state
    When a signed-out visitor views the site
    Then navigation shows Sign in and Sign up
    When a signed-in visitor views the site
    Then navigation shows Account and Sign out

  Scenario: Play CTAs route externally without in-site gameplay
    When a visitor uses play CTAs for Riffle from the studio site
    Then they leave the studio site for the game's play destination
    And no playable table or match state runs on galaxyclass.app

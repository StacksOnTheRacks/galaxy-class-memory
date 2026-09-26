Feature: Redesign studio home and navigation
  As a visitor to Galaxy Class Gaming
  I want a redesigned studio home with Riffle featured
  So that I learn about the studio and can play Riffle at /riffle on galaxyclass.app

  Background:
    Given the studio site is a static Next.js export
    And the public hostname is https://galaxyclass.app

  Scenario: Visitor loads the redesigned studio home on the apex host
    When a visitor opens https://galaxyclass.app/
    Then they see the redesigned Galaxy Class studio home
    And the page presents the studio story and functional fun positioning
    And Riffle is featured as the first game with a Play Riffle CTA linking to /riffle
    And atmospheric motion honors prefers-reduced-motion

  Scenario: Nav shows sign-in entry points for signed-out visitors
    When a signed-out visitor views the site
    Then navigation shows a Sign in link to /sign-in
    And navigation shows a Sign up link to /sign-up

  Scenario: Play Riffle CTA navigates to /riffle without embedding gameplay on the home page
    When a visitor uses the Play Riffle CTA from the studio home
    Then they navigate to /riffle on galaxyclass.app
    And the studio home does not embed or run Riffle table or match state

  Scenario: Host embed and in-page Riffle gameplay are absent
    When a visitor opens the studio home
    Then the page does not include a For hosts or embed-mode section
    And the page does not load an iframe or otherwise run Riffle table or match state

  Scenario: Play Riffle CTA is path /riffle on galaxyclass.app
    When a visitor inspects the Play Riffle CTA on the studio home
    Then its href is /riffle
    And it is not an external hostname and not an iframe target

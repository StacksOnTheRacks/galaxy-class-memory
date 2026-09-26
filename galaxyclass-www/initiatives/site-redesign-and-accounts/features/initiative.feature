Feature: Site redesign and Galaxy Class accounts
  As a visitor to Galaxy Class Gaming
  I want a redesigned studio site at galaxyclass.app with Galaxy Class accounts
  So that I can learn about the studio and games, sign up or sign in for cross-game identity, and play Riffle as the first featured game

  # Out of this initiative:
  # - Riffle JWT / token integration (follow-up initiative)
  # - Leaderboards backend on the studio site
  # - Cognito Hosted UI or OAuth social IdP (Google/Apple) at launch
  # - Real money, rake, cashier, or KYC
  # - Game runtime, table UI, or in-site gameplay
  # - Anonymous-to-account upgrade inside Riffle
  # - Turnur, embed-mode, or RiffSync host attach on the studio site
  # - Riffle first-party identity store as account source of truth

  Background:
    Given the studio site is a static Next.js export on S3 behind CloudFront
    And the public hostname is https://galaxyclass.app
    And www.galaxyclass.app redirects to the apex host preserving path and query
    And Galaxy Class accounts use a Cognito user pool with custom auth UI via Amplify Auth SRP
    And sign-up and sign-in are email and password only at launch
    And the site deploys via GitHub Actions OIDC and AWS CDK with no long-lived AWS keys in the repo

  Scenario: Visitor loads the redesigned studio home on the apex host
    When a visitor opens https://galaxyclass.app/
    Then they see the redesigned Galaxy Class studio home
    And the page presents the studio story and functional, fun positioning
    And Riffle is featured as the first game with an external play destination
    And atmospheric motion honors prefers-reduced-motion

  Scenario: www host redirects to apex
    When a visitor opens https://www.galaxyclass.app/sign-in
    Then the browser is redirected to https://galaxyclass.app/sign-in

  Scenario: Visitor signs up with email and password on custom UI
    When a visitor completes sign-up on the custom UI at /sign-up with a valid email and password
    Then they are not sent to Cognito Hosted UI
    And Cognito sends a verification message to that email
    And they can confirm their account and sign in on the custom UI

  Scenario: Visitor signs in and views their Galaxy Class account
    Given a visitor has a confirmed Galaxy Class account
    When they sign in on the custom UI at /sign-in
    Then they reach /account showing their Galaxy Class identity
    And they see their account email
    And they can sign out from the account page or navigation

  Scenario: Signed-out visitor cannot access account without signing in
    When a signed-out visitor opens /account
    Then they are redirected to sign-in with a return path to /account

  Scenario: Visitor completes forgot-password and reset-password on custom UI
    When a visitor requests password reset at /forgot-password for a registered email
    And they submit the confirmation code and new password at /reset-password
    Then they can sign in with the new password on the custom UI
    And they are not sent to Cognito Hosted UI

  Scenario: Site deploys to galaxyclass.app via GitHub Actions and CDK
    When the production deploy workflow runs on the main branch
    Then GitHub Actions assumes an OIDC deploy role
    And CDK deploys the Cognito auth stack and the static site stack
    And the built static export is published to the CloudFront origin
    And the site is reachable at https://galaxyclass.app

  Scenario: Studio site routes to games externally without in-site gameplay
    When a visitor uses play CTAs for Riffle or future games from the studio site
    Then they leave the studio site for the game's play destination
    And no playable table or match state runs on galaxyclass.app

  Scenario: Riffle integration and legacy identity stay out of ship criteria
    When the studio site and Galaxy Class accounts ship under this initiative
    Then Riffle does not consume Galaxy Class JWTs yet
    And the Riffle first-party identity store is not the account source of truth
    And Turnur is not used for authentication on the studio site

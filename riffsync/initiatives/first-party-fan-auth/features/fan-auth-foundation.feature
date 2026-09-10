Feature: Fan auth SRP foundation, layout, and routes
  As a RiffSync engineer
  I want shared SRP auth infrastructure and auth route shells
  So that first-party fan auth pages can ship incrementally without duplicating Cognito wiring

  # Out of this ticket: full auth page UI (#463, #462, #464),
  # in-app CTA migration (#465), staff Hosted UI, new backend Lambdas.

  Background:
    Given the fan Cognito user pool keeps self-sign-up enabled with COGNITO-only IdP
    And fan tokens stay in the riffsync.fan* localStorage namespace
    And first-party fan auth routes are /auth/sign-in, /auth/sign-up, /auth/verify-email, /auth/forgot-password, /auth/reset-password, and /auth/change-password
    And /auth/callback remains for legacy Hosted UI OAuth returns

  Scenario: SRP sign-in stores tokens via fanTokens boundary
    When fanSrpAuth completes USER_SRP_AUTH with valid credentials
    Then normalized access and refresh tokens are passed to setFanTokenBundle
    And no client secret or IAM keys are present in the SPA bundle

  Scenario: Auth routes resolve with FanAuthLayout
    When a visitor navigates to any first-party fan auth route
    Then FanAuthLayout renders with standalone logo and centered card chrome
    And page bodies may be stubs until page tickets ship

  Scenario: returnTo rejects auth handoff and external paths
    When a visitor opens /auth/sign-in?returnTo=https://evil.example/phish
    Then returnTo normalizes to a safe default fan path such as /catalog
    When they open /auth/sign-in?returnTo=/auth/callback
    Then returnTo normalizes to the safe default
    And successful auth never lands on /auth/callback except for legacy OAuth completion

  Scenario: Legacy Hosted UI callback still completes fan OAuth at /auth/callback
    Given fanOAuthToken was extracted from fanHostedUiPkce without changing PKCE behavior
    When Cognito redirects to /auth/callback with an authorization code
    Then the SPA completes PKCE exchange using existing fan callback handling
    And fan tokens match the same riffsync.fan* storage shape as first-party sign-in

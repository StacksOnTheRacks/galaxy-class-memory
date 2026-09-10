Feature: First-party fan auth
  As a RiffSync fan
  I want to sign in, sign up, verify email, and manage my password on riffsync.tv
  So that I never leave first-party HTML for routine fan authentication

  # Out of this initiative:
  # - Staff Cognito Hosted UI (/admin/login, /admin/auth/callback unchanged)
  # - Federated / Facebook login (Icebox: Federated login for hosts)
  # - Changing fan token issuance, scopes, or JWT.sub === room.hostSub authority
  # - Hard-cutting *.amazoncognito.com (soft fallback for legacy links only)
  # - Board tickets (created later in LLD grooming)
  # - Binding auth chrome to site-redesign Figma frames (designer HLD; auth logic ships first-party regardless)

  Background:
    Given the fan Cognito user pool keeps self-sign-up enabled with COGNITO-only IdP
    And fan tokens stay in the riffsync.fan* localStorage namespace with existing refresh behavior
    And first-party fan auth routes are /auth/sign-in, /auth/sign-up, /auth/verify-email, /auth/forgot-password, /auth/reset-password, and /auth/change-password
    And /auth/callback remains for legacy Hosted UI OAuth returns
    And in-app fan CTAs navigate only to first-party auth routes, never to *.amazoncognito.com
    And staff operator sign-in continues to use Cognito Hosted UI at /admin/login

  Scenario: In-app Sign in CTA opens first-party sign-in with returnTo
    Given a visitor is on a fan route such as /catalog/movies
    When they choose Sign in from the site header, catalog tile, or account gate
    Then the browser navigates to /auth/sign-in with returnTo set to the current path and query
    And the visitor is not redirected to Cognito Hosted UI

  Scenario: Fan completes sign-in and returns to returnTo
    Given a visitor opened /auth/sign-in?returnTo=/account
    When they submit valid fan credentials and Cognito confirms the session
    Then fan access and refresh tokens are stored in the riffsync.fan* namespace
    And the browser navigates to /account
    And room host authority still keys off JWT.sub on fan tokens only

  Scenario: Sign-in blocks unverified email and routes to verify-email
    Given a fan account exists but email is not verified
    When they submit valid credentials on /auth/sign-in
    Then they are guided to /auth/verify-email with returnTo preserved
    And they are not left on *.amazoncognito.com

  Scenario: Fan signs up on first-party sign-up
    When a visitor opens /auth/sign-up
    And they submit a new email and password that meet pool policy
    Then Cognito creates the fan user in the existing fan pool
    And the visitor is guided to /auth/verify-email to confirm the address
    And no Hosted UI redirect occurs

  Scenario: Fan verifies email on first-party verify-email
    Given a fan signed up and Cognito sent a verification code or link
    When they open /auth/verify-email or follow a first-party verify link with returnTo
    And they submit the verification code or complete the linked confirm step
    Then Cognito marks the email verified
    And on success they can continue to sign-in or returnTo when already authenticated

  Scenario: Fan starts forgot-password on first-party forgot-password
    Given a visitor opened /auth/forgot-password with optional returnTo
    When they submit the account email
    Then Cognito sends the existing SES recovery message
    And the visitor sees confirmation to check email on riffsync.tv
    And they are not sent to Hosted UI forgot-password

  Scenario: Fan completes reset confirm on first-party reset-password
    Given Cognito emailed a reset code or deep link for the fan pool
    When the visitor opens /auth/reset-password with the code parameters Cognito expects
    And they submit a new password that meets pool policy
    Then Cognito confirms the password reset
    And the visitor can sign in on /auth/sign-in with returnTo honored after success

  Scenario: Signed-in fan changes password on first-party change-password
    Given a fan holds a valid fan access token
    When they open /auth/change-password from account settings
    And they submit current password and a new password that meets pool policy
    Then Cognito updates the password
    And existing fan tokens remain valid or refresh per current client behavior
    And the fan stays on riffsync.tv

  Scenario: returnTo rejects auth handoff and external paths
    When a visitor opens /auth/sign-in?returnTo=https://evil.example/phish
    Then returnTo normalizes to a safe default fan path such as /catalog
    When they open /auth/sign-in?returnTo=/auth/callback
    Then returnTo normalizes to the safe default
    And successful auth never lands on /auth/callback except for legacy OAuth completion

  Scenario: Auth pages expose recoverable errors for assistive tech
    When sign-in, sign-up, verify-email, forgot-password, reset-password, or change-password fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry and cross-links (for example sign-up from sign-in) stay keyboard reachable

  Scenario: Legacy Hosted UI callback still completes fan OAuth at /auth/callback
    Given a visitor arrives from a bookmarked or emailed *.amazoncognito.com authorize or forgotPassword URL
    When Cognito redirects to /auth/callback with an authorization code
    Then the SPA completes PKCE exchange using existing fan callback handling
    And the visitor lands on the stored returnTo or a safe default
    And fan tokens match the same riffsync.fan* storage shape as first-party sign-in

  Scenario: Soft Hosted UI fallback does not replace in-app CTAs
    Given Hosted UI remains reachable for legacy links and bookmarks
    When a visitor uses any in-app Sign in, Sign up, or Forgot password entry point added or updated by this initiative
    Then that entry point targets a first-party /auth/* route
    And it does not deep-link to *.amazoncognito.com

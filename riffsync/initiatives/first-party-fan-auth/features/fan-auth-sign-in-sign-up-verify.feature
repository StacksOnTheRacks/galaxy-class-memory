Feature: Sign-in, sign-up, and verify-email pages
  As a RiffSync fan
  I want to sign in, create an account, and verify my email on riffsync.tv
  So that I never leave first-party HTML for account onboarding

  # Out of this ticket: forgot/reset (#462), change-password (#464),
  # CTA migration (#465), staff auth, foundation modules (#461).

  Background:
    Given fan auth SRP foundation and FanAuthLayout are shipped (#461)
    And Figma Auth / Sign In (1617:6584), Sign Up (1617:6621), Verify Email (1617:6660) are the visual defaults

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

  Scenario: Auth pages expose recoverable errors for assistive tech
    When sign-in, sign-up, or verify-email fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry and cross-links (for example sign-up from sign-in) stay keyboard reachable

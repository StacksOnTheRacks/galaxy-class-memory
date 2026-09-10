Feature: Sign-in, sign-up, and verify-email pages
  As a RiffSync fan
  I want to sign in, create an account, and verify my email on riffsync.tv
  So that I never leave first-party HTML for account onboarding

  # Out of this ticket: forgot/reset (#462), change-password (#464),
  # CTA migration (#465), staff auth, foundation modules (#461),
  # /auth/set-new-password, marketing/terms checkbox, CDK email templates,
  # srp-only-enforcement CDK.

  Background:
    Given fan auth SRP foundation and FanAuthLayout are shipped (#461)
    And Figma Auth / Sign In (1617:6584), Sign Up (1617:6621), Verify Email (1617:6660) are the visual defaults
    And the account identifier is email

  Scenario: Fan completes sign-in and returns to returnTo
    Given a visitor opened /auth/sign-in?returnTo=/account
    When they submit valid fan credentials and Cognito confirms the session via USER_SRP_AUTH
    Then fan access and refresh tokens are stored in the riffsync.fan* namespace via setFanTokenBundle
    And the browser navigates to /account
    And room host authority still keys off JWT.sub on fan tokens only
    And the visitor is not sent to *.amazoncognito.com

  Scenario: Sign-in blocks unverified email and routes to verify-email
    Given a fan account exists but email is not verified
    When they submit valid credentials on /auth/sign-in
    Then they are guided to /auth/verify-email with returnTo preserved
    And tokens are not written
    And riffsync.fanVerifyUsername stores the email for verify and resend
    And they are not left on *.amazoncognito.com

  Scenario: Sign-in NEW_PASSWORD_REQUIRED is a recoverable error
    When Cognito returns NEW_PASSWORD_REQUIRED on /auth/sign-in
    Then the page shows a recoverable inline error
    And no /auth/set-new-password route is added
    And tokens are not written

  Scenario: Fan signs up on first-party sign-up
    When a visitor opens /auth/sign-up
    And they submit a new email and matching passwords that meet pool policy
    Then Cognito creates the fan user in the existing fan pool
    And the visitor is guided to /auth/verify-email to confirm the address
    And no Hosted UI redirect occurs
    And the form has no marketing or terms checkbox

  Scenario: Fan verifies email on first-party verify-email with typed code
    Given a fan signed up and Cognito sent a verification code
    When they open /auth/verify-email with the email already known from sign-up or unverified sign-in
    And they type the verification code
    Then Cognito marks the email verified
    And on success they continue to /auth/sign-in with returnTo, or to returnTo when getFanAccessToken is non-null

  Scenario: Verify code is prefilled from URL then stripped after read
    Given a verification code appears in the verify-email URL as code or confirmation_code
    When the page reads the code for form prefill
    Then history.replaceState removes the code and username/email params from the visible URL and the current history entry
    And the prefilled code remains in the form field so the visitor can submit
    And sanitized returnTo remains when present

  Scenario: Fan resends the verification code
    Given the visitor is on /auth/verify-email with a known email
    When they choose Resend code
    Then Cognito ResendConfirmationCode is called
    And the page announces that a new code is on the way without leaving riffsync.tv

  Scenario: Auth pages expose recoverable errors for assistive tech
    When sign-in, sign-up, or verify-email fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry and cross-links stay keyboard reachable

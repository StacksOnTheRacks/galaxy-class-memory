Feature: Forgot-password and reset-password pages
  As a RiffSync fan
  I want to recover my password on riffsync.tv
  So that I never leave first-party HTML for password reset

  # Out of this ticket: sign-in/sign-up/verify (#463), change-password (#464),
  # CTA migration (#465), staff auth, foundation modules (#461), email-template/CDK.

  Background:
    Given fan auth SRP foundation and FanAuthLayout are shipped (#461)
    And Figma Auth / Forgot Password (1617:6693) and Reset Password (1617:6724) are the visual defaults
    And the account identifier is email

  Scenario: Fan starts forgot-password on first-party forgot-password
    Given a visitor opened /auth/forgot-password with optional returnTo
    When they submit the account email
    Then Cognito sends the existing SES recovery message when the account exists
    And the visitor sees the same non-enumerating check-email confirmation on riffsync.tv whether or not the email is registered
    And the confirmation includes a keyboard-reachable control to /auth/reset-password that preserves sanitized returnTo
    And they are not sent to Hosted UI forgot-password

  Scenario: Fan completes reset confirm on first-party reset-password with typed code
    Given Cognito emailed a reset code for the fan pool
    When the visitor opens /auth/reset-password with no code in the URL
    And they type email, the emailed code, and a new password that meets pool policy
    Then Cognito ConfirmForgotPassword succeeds
    And the visitor is not signed in automatically
    And the visitor can sign in on /auth/sign-in with returnTo honored after success

  Scenario: Reset code is prefilled from URL then stripped after read
    Given a reset code appears in the reset-password URL query string as code or confirmation_code
    When the page reads the code for form prefill
    Then history.replaceState removes the code from the visible URL and the current history entry
    And the prefilled code remains in the form field so the visitor can submit
    And sanitized returnTo remains when present

  Scenario: Auth pages expose recoverable errors for assistive tech
    When forgot-password or reset-password fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry and back-to-sign-in links stay keyboard reachable

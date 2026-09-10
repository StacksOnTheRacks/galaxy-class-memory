Feature: Change-password page
  As a signed-in RiffSync fan
  I want to change my password on riffsync.tv
  So that I manage credentials without Cognito Hosted UI

  # Out of this ticket: sign-in/sign-up/verify (#463), forgot/reset pages (#462),
  # CTA migration (#465), staff auth, foundation modules (#461).
  # Account "Reset password" + "Log out" stay Hosted UI until #465.

  Background:
    Given fan auth SRP foundation and FanAuthLayout are shipped (#461)
    And Figma Auth / Change Password (1617:6763) is the visual default
    And after ChangePassword the current session is kept (no GlobalSignOut)

  Scenario: Signed-in fan changes password on first-party change-password
    Given a fan holds a valid fan access token
    When they open /auth/change-password from account settings
    And they submit current password and matching new/confirm passwords that meet pool policy
    Then Cognito ChangePassword updates the password
    And GlobalSignOut is not called
    And existing fan tokens remain in riffsync.fan* or refresh via existing keep-alive
    And the fan stays signed in on riffsync.tv
    And they navigate to /account?passwordReset=1

  Scenario: Account settings adds change-password without replacing Reset password
    Given a signed-in fan opens /account
    When they choose Change password
    Then navigation targets /auth/change-password
    And no Change password control opens *.amazoncognito.com
    And Reset password still starts Hosted UI forgot-password
    And Log out is unchanged
    And /account still has exactly one visible h1

  Scenario: Unauthenticated visitor is redirected off change-password
    Given getFanAccessToken() is null
    When they open /auth/change-password
    Then the change-password form is not shown
    And they are redirected first-party to /auth/sign-in?returnTo=/account
    And they are not sent to Hosted UI

  Scenario: Auth pages expose recoverable errors for assistive tech
    When change-password fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry and Back to account stay keyboard reachable

Feature: Change-password page
  As a signed-in RiffSync fan
  I want to change my password on riffsync.tv
  So that I manage credentials without Cognito Hosted UI

  # Out of this ticket: sign-in/sign-up/verify (#463), forgot/reset (#462),
  # CTA migration (#465), staff auth, foundation modules (#461).

  Background:
    Given fan auth SRP foundation and FanAuthLayout are shipped (#461)
    And Figma Auth / Change Password (1617:6763) is the visual default
    And a fan holds a valid fan access token

  Scenario: Signed-in fan changes password on first-party change-password
    When they open /auth/change-password from account settings
    And they submit current password and a new password that meets pool policy
    Then Cognito updates the password
    And existing fan tokens remain valid or refresh per current client behavior
    And the fan stays on riffsync.tv

  Scenario: Account settings links to first-party change-password
    Given a signed-in fan opens account settings
    When they choose to change password
    Then navigation targets /auth/change-password
    And no link opens *.amazoncognito.com

  Scenario: Auth pages expose recoverable errors for assistive tech
    When change-password fails validation or Cognito rejects the request
    Then the page shows a recoverable inline error
    And the error is announced to assistive technology
    And primary retry stays keyboard reachable

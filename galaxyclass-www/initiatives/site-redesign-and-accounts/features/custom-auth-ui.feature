Feature: Galaxy Class custom auth UI
  As a visitor to galaxyclass.app
  I want email and password sign-up sign-in and account management on custom UI
  So that I am never sent to Cognito Hosted UI

  Background:
    Given Galaxy Class accounts use Amplify Auth SRP against a Cognito user pool
    And sign-up and sign-in are email and password only at launch

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

  Scenario: Auth forms meet accessibility baseline
    When a visitor uses sign-up sign-in confirm or reset flows
    Then every form field has an explicit label
    And errors are linked via aria-describedby
    And keyboard navigation completes each flow without relying on color alone

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

  Scenario: Navigation reflects session state
    When a signed-out visitor views the site
    Then navigation shows Sign in and Sign up
    When a signed-in visitor views the site
    Then navigation shows Account and Sign out
    And sign-out clears the session

  Scenario: Auth forms meet accessibility baseline
    When a visitor uses sign-up sign-in confirm or reset flows
    Then every form field has an explicit label
    And errors are linked via aria-describedby
    And keyboard navigation completes each flow without relying on color alone

  Scenario: Sign-up check-email uses verification code wording and links to confirm
    Given a visitor has just completed sign-up on /sign-up
    When they see the check-email state
    Then the copy refers to a verification code (not a verification link)
    And a link to /confirm is available
    And they are not sent to Cognito Hosted UI

  Scenario: Confirm accepts a code and can resend
    Given a visitor is on /confirm with email remembered from sign-up
    When they submit a verification code
    Then their account can be confirmed on the custom UI
    And Resend code is available without leaving the custom UI
    When they open /confirm without a remembered email
    Then the form also asks for email so they can finish

  Scenario: Sign-in errors do not enumerate accounts
    When a visitor signs in with an unknown email or a wrong password
    Then they see "Incorrect email or password."
    When a visitor signs in with an unconfirmed account
    Then they see "Confirm your email before signing in."
    When a visitor signs up with an email that is already registered
    Then the UI does not say the email is already registered

  Scenario: Forgot check-email is always generic and links to reset
    When a visitor submits /forgot-password for any email
    Then they see "If an account exists, a reset code was sent."
    And a link to /reset-password is available

  Scenario: Reset collects code and new password without putting password in the URL
    Given a visitor is on /reset-password
    When they submit a code and a new password that meets the password rule
    Then they can sign in with the new password on the custom UI
    And the password never appears in the URL
    When they open /reset-password without a remembered email
    Then the form also asks for email so they can finish

  Scenario: Unresolved session does not reveal account email
    When a visitor opens /account while the session is still unresolved
    Then the page does not show an account email

  Scenario: Sign-in page links to forgot-password and sign-up
    When a visitor views /sign-in
    Then they can navigate to /forgot-password
    And they can navigate to /sign-up

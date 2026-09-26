Feature: Author GalaxyClassAuth-prod Cognito stack
  As the Galaxy Class studio platform
  I want a CDK auth stack that provisions email and password Cognito with SRP
  So that custom auth UI can sign players up and in without Hosted UI

  Background:
    Given the CDK stack name is GalaxyClassAuth-prod
    And the stack is authored for us-east-1
    And sign-up and sign-in are email and password only at launch
    And the SES sender configured on the pool is noreply@galaxyclass.app
    And closing this ticket does not require a live AWS deploy

  Scenario: User pool supports self sign-up with email verification
    When the auth stack is synthesized
    Then the template defines a Cognito user pool named galaxyclass-players-prod
    And self sign-up is enabled
    And email is the sign-in alias
    And email verification is required before sign-in

  Scenario: Password policy matches launch rules
    When the auth stack is synthesized
    Then the user pool password policy requires at least 8 characters
    And it requires uppercase, lowercase, and a number
    And it does not require symbols

  Scenario: App client uses SRP without Hosted UI
    When the auth stack is synthesized
    Then an app client allows USER_SRP_AUTH and refresh tokens
    And no OAuth flows or Hosted UI domain are configured at launch

  Scenario: SES sender is wired for verification and reset mail
    When the auth stack is synthesized
    Then the user pool email is configured via SES for noreply@galaxyclass.app
    And verification and reset messages use that sender
    And live SES domain verification is not required to close this ticket

  Scenario: Stack outputs feed build-time Cognito config
    When the auth stack is synthesized
    Then outputs include UserPoolId UserPoolClientId and Region
    And a later build can inject NEXT_PUBLIC_COGNITO_* from those outputs

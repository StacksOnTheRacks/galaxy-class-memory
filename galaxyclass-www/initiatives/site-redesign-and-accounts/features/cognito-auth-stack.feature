Feature: Deploy GalaxyClassAuth-prod Cognito stack
  As a Galaxy Class visitor
  I want a Cognito user pool for email and password accounts
  So that sign-up and sign-in use custom SRP UI instead of Hosted UI

  Background:
    Given the CDK stack name is GalaxyClassAuth-prod
    And sign-up and sign-in are email and password only at launch
    And the SES sender is noreply@galaxyclass.app

  Scenario: User pool supports self sign-up with email verification
    When the auth stack is deployed
    Then a Cognito user pool exists with self sign-up enabled
    And email is the sign-in alias
    And email verification is required before sign-in

  Scenario: App client uses SRP without Hosted UI
    When the auth stack is deployed
    Then an app client allows USER_SRP_AUTH and refresh tokens
    And no OAuth or Hosted UI domain is configured at launch

  Scenario: Stack outputs feed build-time Cognito config
    When the auth stack is deployed
    Then outputs include UserPoolId UserPoolClientId and Region
    And the build can inject NEXT_PUBLIC_COGNITO_* from those outputs

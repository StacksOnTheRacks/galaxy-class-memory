Feature: Verify SES domain galaxyclass.app
  As the Galaxy Class studio platform
  I want galaxyclass.app verified in SES in us-east-1
  So that Cognito can send verification and reset mail as noreply@galaxyclass.app

  Background:
    Given the SES region is us-east-1
    And the sending domain is galaxyclass.app
    And the Route53 hosted zone is Z02927871LCJW2KMZGKOP
    And the intended From address is noreply@galaxyclass.app

  Scenario: Domain identity is verified
    When the operator creates and verifies the SES domain identity
    Then SES reports galaxyclass.app as Verified in us-east-1
    And DKIM records for that identity are published in the hosted zone
    And DKIM status is successful

  Scenario: Sender address is authorized for Cognito mail
    Given the domain identity is verified
    When Cognito later sends verification or password-reset mail
    Then mail may be sent as noreply@galaxyclass.app
    And SES does not reject the sender as an unverified identity

  Scenario: Sandbox does not silently block launch recipients
    When SES account sending status is checked
    Then either production access is granted
    Or the operator records that only verified recipient addresses can receive mail until production access is approved

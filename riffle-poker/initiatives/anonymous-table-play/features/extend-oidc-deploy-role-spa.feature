Feature: Extend OIDC deploy role for SPA hosting
  As the Riffle platform
  I want GitHub Actions OIDC to deploy S3 and CloudFront for the play SPA
  So that the anonymous table play surface ships without long-lived AWS keys

  Scenario: Production OIDC role covers S3 and CloudFront deploy
    Given the existing production GitHub OIDC deploy role for the match runtime stack
    When the role is extended for this initiative's S3 and CloudFront resources
    Then CI can deploy the SPA hosting surface via OIDC
    And no long-lived AWS access keys are introduced in CI or the client
    And the role remains least-privilege for this initiative's S3 and CloudFront scope

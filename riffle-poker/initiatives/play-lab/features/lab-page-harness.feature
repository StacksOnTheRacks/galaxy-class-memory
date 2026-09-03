Feature: First-party play lab page with two embedded /play iframes
  As a Riffle operator
  I want a first-party play lab page with Start session and Deal controls
  So that I can embed two capability-bound /play iframes without RiffSync or a consumer lobby

  # Out of this ticket: live Turnur manual success bar, redesign of seated-table
  # iframe surfaces, RiffSync, identity/chat/rooms, runtime hosting / IaC,
  # next-hand loop, remint UX.

  Background:
    Given GET /lab is served from the Riffle origin same as /play
    And RIFFLE_FRAME_ANCESTORS stays self
    And the lab page is an operator harness not a lobby or room list
    And table poker actions stay inside each iframe

  Scenario: Operator sees idle lab harness
    When an operator opens /lab with no session
    Then Start session and two labeled empty iframe slots are shown
    And no SDK key, host key, bootstrap, or capability tokens are visible in chrome

  Scenario: Start session embeds two play iframes
    When the operator clicks Start session successfully
    Then both iframes load Riffle-origin playUrls with bt fragment
    And each iframe receives only its own capability via targeted postMessage

  Scenario: Deal opens a hand on both iframes
    Given both iframes are attached
    When the operator clicks Deal
    Then the lab deal orchestrator runs
    And iframes show existing felt states without redesign

  Scenario: Harness error is distinct from iframe embed-error
    When session or capability mint fails before iframe redeem
    Then the lab harness error surface is shown on the operator page

  Scenario: Harness controls are accessible
    Then Start session and Deal have visible labels and keyboard operable controls
    And seat columns are distinguishable by text label not color alone

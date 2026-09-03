Feature: Two lab seats complete a hand against live Turnur
  As a Riffle operator
  I want to drive two lab iframes through a complete hand on live Turnur
  So that the play lab initiative success bar is met beyond fake Turnur CI alone

  # Out of this ticket: CI against live Turnur, Turnur cluster provisioning,
  # side pots, all-in runout, disconnect/rejoin, next-hand loop, RiffSync attach,
  # signed results, deployed lab URL / IaC.

  Background:
    Given the lab stack from host match create through lab page harness is available
    And live Turnur is configured via environment on the runtime
    And completing a hand only against the in-memory fake Turnur does not satisfy this ticket

  Scenario: Operator completes a hand on live Turnur
    Given the operator started a lab session and dealt on live Turnur
    When the operator plays both seats through the existing table UI until fold-to-one or non-all-in showdown
    Then the hand is complete on live Turnur
    And Turnur remains authority for seats, turns, hidden views, and the move log

  Scenario: Hole cards stay seat-scoped during live play
    Given a hand is in progress on live Turnur in the lab
    Then seat A's browsing context cannot read seat B's hole cards or capability token

  Scenario: Live run exposes no server secrets in the browser
    When the operator uses the lab against live Turnur
    Then the lab page, play URL, iframe bundles, and browser-accessible config do not include TURNUR_SDK_KEY or RIFFLE_HOST_API_KEY

  Scenario: CI still passes on fake Turnur without live network
    Given vitest runs with fake Turnur
    Then the automated lab test suite passes without contacting live Turnur

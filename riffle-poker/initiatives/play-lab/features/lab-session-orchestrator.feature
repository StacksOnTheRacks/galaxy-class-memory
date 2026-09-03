Feature: Lab session orchestrator mints match, seats, bootstrap, and capabilities
  As a Riffle operator using the play lab
  I want POST /v1/lab/session to create a full attach package server-side
  So that two /play iframes can embed without the browser holding host or SDK keys

  # Out of this ticket: lab page UI, deal/open betting, capability postMessage
  # receiver in /play, live Turnur manual verification, RiffSync, identity accounts.

  Background:
    Given the playable no-limit Hold'em table is available in the Riffle runtime
    And the lab browser never receives RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY
    And GET /lab must not create matches or mint tokens as a side effect

  Scenario: Lab session returns match and two seated attach packages
    When an authorized client calls POST /v1/lab/session
    Then the response includes matchId and two seats
    And each seat has seatId, playUrl with bt fragment, capabilityToken, and playerSubject lab:{seatId}

  Scenario: Lab session does not deal or open betting
    Given POST /v1/lab/session succeeded
    Then deal and betting open were not invoked

  Scenario: Unauthorized session start is rejected
    When an unauthorized client attempts POST /v1/lab/session
    Then the request is rejected
    And no Turnur match is created

  Scenario: Orchestrator uses in-process host functions
    Given POST /v1/lab/session succeeds
    Then match.create, two seat.create, two bootstrap mints, and two capability mints occurred server-side
    And the browser did not call host-key HTTP routes directly

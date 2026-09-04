Feature: Lab session orchestrator mints match, seats, bootstrap, and capabilities
  As a Riffle operator using the play lab
  I want POST /v1/lab/session to create a full attach package server-side
  So that two /play iframes can embed without the browser holding host or SDK keys

  # Out of this ticket: lab page UI (GET /lab is #23), deal/open betting,
  # capability postMessage receiver in /play, live Turnur manual verification,
  # RiffSync, identity accounts, a new shared lab secret.

  Background:
    Given the playable no-limit Hold'em table is available in the Riffle runtime
    And the lab browser never receives RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY
    And session start is POST-only and this route has no GET side effect
    And lab session authz is RIFFLE_LAB_ENABLED default-off plus refuse non-loopback clients

  Scenario: Lab session returns match and two seated attach packages
    Given RIFFLE_LAB_ENABLED is on
    And the caller is a loopback client
    When the client calls POST /v1/lab/session
    Then the response is 201 with matchId and two seats
    And each seat has seatId, playUrl with bt fragment, capabilityToken, and playerSubject lab:{seatId}
    And the request did not send a host API key or SDK key

  Scenario: Lab session does not deal or open betting
    Given POST /v1/lab/session succeeded
    Then deal and betting open were not invoked

  Scenario: Disabled or absent lab flag rejects session start
    Given RIFFLE_LAB_ENABLED is absent or falsy
    When a loopback client attempts POST /v1/lab/session
    Then the request is rejected
    And no Turnur match is created

  Scenario: Non-loopback client is refused
    Given RIFFLE_LAB_ENABLED is on
    When a non-loopback client attempts POST /v1/lab/session
    Then the request is rejected
    And no Turnur match is created

  Scenario: GET of the session route has no side effect
    When a client sends GET /v1/lab/session
    Then no Turnur match is created
    And no bootstrap or capability tokens are minted

  Scenario: Orchestrator uses in-process host functions
    Given POST /v1/lab/session succeeds
    Then match.create, two seat.create, two bootstrap mints, and two capability mints occurred server-side
    And the browser did not call host-key HTTP routes directly

Feature: Play-lab session subscribes server-side on match attach
  As a Riffle operator using the play lab
  I want the server-side orchestrator to subscribe to Turnur WS when a lab session starts
  So that push events are available during lab play without browser WebSocket

  # Out of this ticket: WS client factory, subscription registry implementation, poll refactors.

  Background:
    Given TURNUR_WS_URL is configured
    And the play-lab browser never receives the Turnur SDK key

  Scenario: Lab session triggers server-side subscribe after match create
    When the operator starts a play-lab session via POST /v1/lab/session
    Then a match is attached via HTTP
    And ensureTurnurWsSubscription is called for that matchId on the server

  Scenario: Lab browser does not open WebSocket
    When the operator starts a play-lab session
    Then the play-lab page does not open a WebSocket
    And the response does not include TURNUR_WS_URL or SDK key material

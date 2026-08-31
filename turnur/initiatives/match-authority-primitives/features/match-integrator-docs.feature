Feature: Match authority integrator docs
  As a game pack developer authenticated with an SDK key
  I want the README to continue from host attach through match authority
  So that I can integrate seats, turns, views, and the move log without guessing the contract

  # Out of this ticket: implementing HTTP routes or Lambdas (#30–#33),
  # implementing SDK methods (#34), signed result, player/host auth,
  # chat/rooms/media, a game-rule engine, key provisioning, npm publish,
  # browser bundle, cursor pagination, atomic move+views, match status
  # lifecycle.

  Background:
    Given host attach onboarding docs already exist
    And the game authenticates to Turnur with an SDK key
    And identity, chat, rooms, and media stay on the host

  Scenario: Docs continue from host attach through match authority
    Given the integrator can already attach and probe a match from the docs
    When they read match authority onboarding
    Then the docs continue from host attach
    And they can follow seats, turn designation, moves, hidden views, and the move log without reading source
    And the docs state what stays on the host

  Scenario: Docs describe creating seats
    When an integrator reads match authority onboarding
    Then the docs describe creating a seat with a server-issued seatId
    And the docs state a seat carries no player identity
    And the docs state the host maps seatId to players
    And the docs state creating a seat does not designate a turn

  Scenario: Docs describe listing seats
    When an integrator reads match authority onboarding
    Then the docs describe listing the public roster and currentSeat
    And the docs state an empty roster is an empty list, not a missing match
    And the docs state the roster does not include hidden views

  Scenario: Docs describe game-designated currentSeat
    When an integrator reads match authority onboarding
    Then the docs describe the game designating currentSeat
    And the docs state Turnur does not auto-advance after an accepted move
    And the docs state Turnur does not run game rules
    And the docs state extra-turn is redesignating the same seat
    And the docs state pass is designating another seat

  Scenario: Docs describe on-turn accept versus illegal-turn reject
    When an integrator reads match authority onboarding
    Then the docs describe an on-turn move as accepted
    And the docs state an accepted move appends to the log
    And the docs state accept does not change currentSeat
    And the docs describe an off-turn or undesignated move as an illegal-turn reject
    And the docs state a rejected move is not appended

  Scenario: Docs describe seat-scoped hidden views
    When an integrator reads match authority onboarding
    Then the docs describe writing and reading a hidden view for one seat
    And the docs state an unset view is null
    And the docs state a view read does not include another seat's view
    And the docs state shared reads omit hidden views

  Scenario: Docs describe the append-only move log
    When an integrator reads match authority onboarding
    Then the docs describe the move log as append-only
    And the docs state the log is public to the owning game
    And the docs state accepted items include payload
    And the docs state an empty log is an empty list, not a missing match
    And the docs state there is no rewrite or delete of log entries

  Scenario: Docs describe SDK-key auth and key placement
    When an integrator reads match authority onboarding
    Then the docs repeat that callers send the SDK key as Bearer
    And the docs state production SDK keys stay off player-facing game packs
    And the docs reuse the existing auth and ownership failures

  Scenario: Docs add HTTP rows and copy-pasteable examples
    When an integrator reads the CDK README
    Then the HTTP API table includes the match-authority routes
    And the new section includes copy-pasteable curl examples that reuse the host-attach placeholders

  Scenario: Root README points at match authority onboarding
    When an integrator reads the repository README
    Then it links to match authority onboarding in the CDK README

  Scenario: Docs do not present later slices as this slice
    When an integrator reads match authority onboarding
    Then the docs do not present signed result as available
    And the docs do not present player or host login as available
    And the docs do not present chat, rooms, or media as Turnur features
    And the docs do not present a game-rule engine as this slice
    And signed result remains on the not-yet-implemented list

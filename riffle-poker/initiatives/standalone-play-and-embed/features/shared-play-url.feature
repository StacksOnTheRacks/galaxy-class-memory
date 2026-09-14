Feature: Shared play URL attach for standalone and host embed
  As a host or standalone player
  I want a shared Riffle-origin play URL
  So that attach is a locator and not mint/redeem or seat authority

  # Out of this ticket: identity sign-up/sign-in, MatchStore internals,
  # Sit at Table binding, display name, WS notify, betting, hole/board views,
  # hand complete, production lobby, join-code alias, bootstrap mint/redeem,
  # #bt= as a grant on new attach.

  Background:
    Given Riffle uses a shared play URL for standalone and host iframe attach
    And the canonical attach URL is {origin}/play/{matchId}
    And a join-code alias is out of scope
    And there is no production lobby or match-picker in v1
    And chat, rooms, and media stay on the host in embed-mode
    And historical GET /play plus #bt= redeem stays frozen

  Scenario: Standalone navigates to the matchId play URL
    Given a match exists in MatchStore
    When a standalone player opens that match
    Then they navigate to {origin}/play/{matchId}
    And they see unseated felt
    And they are not seated

  Scenario: Host iframe loads the same shared play URL
    Given a match exists in MatchStore
    And a host room exists with chat, rooms, and media owned by the host
    When the host sets iframe.src to {origin}/play/{matchId}
    Then guests see the same Riffle play surface as standalone
    And the host does not own match state or evaluate poker rules

  Scenario: Optional embed=1 is chrome only
    Given a match exists in MatchStore
    When the play URL includes ?embed=1
    Then attach still locates the same match
    And embed=1 does not grant a seat or change CSP
    And the surface uses embed chrome

  Scenario: No bootstrap mint/redeem or #bt= fragment for new attach
    When attach uses /play/{matchId}
    Then no bootstrap mint/redeem is required
    And no #bt= fragment is used as a grant
    And the shared URL is not seat authority or a hidden-view grant

  Scenario: Historical GET /play hash redeem stays frozen
    When a client opens GET /play with a #bt= fragment
    Then historical redeem still works
    And new /play/{matchId} attach does not depend on #bt=

  Scenario: Missing or invalid matchId shows embed-error
    When the play URL has a missing or unknown matchId
    Then the surface shows embed-error
    And the title is "Couldn't open this table"

  Scenario: Loading uses shared-URL copy
    When the play surface is loading a /play/{matchId} attach
    Then loading shows "Loading table…"
    And the supporting copy is "Opening play link · no actions yet"

  Scenario: CSP frame-ancestors is an allowlist
    When the shared play URL sets CSP frame-ancestors
    Then it includes 'self' plus registered host origins from RIFFLE_FRAME_ANCESTORS
    And frame-ancestors is never *
    And frame-ancestors is not 'none'
    And CSP does not change because of ?embed=1

  Scenario: Hostile framing is blocked
    When a non-allowlisted origin iframes the shared play URL
    Then CSP blocks that framing
    And top-level navigation to the same URL is standalone attach only

  Scenario: postMessage is UX-only
    When the host page sends postMessage to the iframe
    Then postMessage may resize or toast only
    And the origin is allowlisted and the schema is closed
    And postMessage must not attach, sit, or grant seats

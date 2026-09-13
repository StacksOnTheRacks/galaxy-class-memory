Feature: Shared play URL attach for standalone and host embed
  As a host or standalone player
  I want a shared Riffle-origin play URL
  So that attach is a locator and not mint/redeem or seat authority

  # Out of this ticket: identity sign-up/sign-in, MatchStore internals,
  # Sit at Table binding, display name, WS notify, betting, hole/board views,
  # hand complete, production lobby, bootstrap mint/redeem, #bt= fragment.

  Background:
    Given Riffle uses a shared play URL for standalone and host iframe attach
    And there is no production lobby or match-picker in v1
    And chat, rooms, and media stay on the host in embed-mode

  Scenario: Standalone navigates to the shared play URL
    When a standalone player opens a match
    Then they navigate to {origin}/play/{matchId} or a join-code alias

  Scenario: Host iframe loads the same shared play URL
    Given a host room exists with chat, rooms, and media owned by the host
    When the host sets iframe.src to the shared play URL
    Then guests see the same Riffle play surface as standalone
    And the host does not own match state or evaluate poker rules

  Scenario: No bootstrap mint/redeem or #bt= fragment for new work
    When attach uses the shared play URL
    Then no bootstrap mint/redeem is required
    And no #bt= fragment is used
    And the shared URL is not seat authority or a hidden-view grant

  Scenario: Loading and embed-error use shared-URL copy
    When the play surface is loading or the link is invalid
    Then loading shows "Loading table…" or equivalent shared-URL copy
    And embed-error shows "Couldn't open this table" or equivalent

  Scenario: CSP frame-ancestors is an allowlist
    When the play surface sets CSP frame-ancestors
    Then standalone uses 'none' or 'self'
    And embed may add registered host origins only
    And frame-ancestors is never *

  Scenario: postMessage is UX-only
    When the host page sends postMessage to the iframe
    Then postMessage may resize or toast only
    And postMessage must not attach, sit, or grant seats

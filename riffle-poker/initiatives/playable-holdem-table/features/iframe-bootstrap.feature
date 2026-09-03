Feature: Host iframe attach via bootstrap mint → URL → redeem
  As a seated player in a host room (RiffSync first)
  I want the host to load the Riffle play surface in an iframe via mint → URL → redeem
  So that I see the table shell without the host becoming match authority or receiving a Turnur SDK key

  # Out of this ticket: seat capability, Turnur auth, rules library, seats,
  # hole cards, betting, public board streets, hand complete, RiffSync
  # host-path polish, signed result, runtime hosting, production console.

  Background:
    Given a host room exists with identity, chat, rooms, and media owned by the host
    And Riffle Poker is the registered Turnur game
    And the browser never receives the Turnur SDK key
    And an in-repo fixture host credential is enough for mint authentication

  Scenario: Host mints a bootstrap token and loads the play URL in an iframe
    When the authenticated host mints an opaque short-lived bootstrap token for a match
    Then the host receives a Riffle-origin play URL carrying that token
    And the host can load that URL in an iframe for the room's match

  Scenario: Loading while redeem is in flight
    Given the host has loaded the play URL with a valid unused bootstrap token
    When the iframe has started redeem but has not yet bound match attach context
    Then the loading surface is shown
    And no actionable turn controls are available
    And the bootstrap token is not visible

  Scenario: Valid unused token redeems and binds match attach
    Given the host has loaded the play URL with a valid unused bootstrap token
    When the iframe redeems the token at the Riffle runtime
    Then the redeem binds match attach context
    And players in the host room see the Riffle table shell inside the iframe
    And the table shell does not require live seats, hole cards, betting, or streets

  Scenario: Surfaces compose at desktop and narrow host-panel widths
    Given the Riffle play surface is attached via iframe
    Then loading, table shell, and embed-error compose at a desktop embed width
    And the same surfaces compose at a narrow host-panel width
    And Riffle does not assume full-viewport app chrome

  Scenario: Missing, expired, or already-used token shows embed-error
    When the iframe attempts to redeem a missing, expired, or already-used bootstrap token
    Then the redeem is rejected
    And the embed-error surface is shown

  Scenario: Host remains identity owner and is not match authority
    Given the Riffle play surface is attached via iframe
    Then identity, chat, rooms, and media remain on the host
    And the host does not become Turnur match authority

  Scenario: Bootstrap token is not seat authority
    Given the Riffle play surface is attached via iframe
    Then the bootstrap token is not seat authority
    And postMessage is not the primary bootstrap

  Scenario: Play surface never receives a Turnur SDK key
    When the host loads or the iframe redeems the bootstrap token
    Then the play URL, iframe bundles, and browser-accessible config do not include a Turnur SDK key

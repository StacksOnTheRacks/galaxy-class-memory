Feature: Play lab embed harness
  As a Riffle operator
  I want a first-party play lab in riffle-poker that implements the existing host contract
  So that two browser seats can finish a hand against live Turnur without waiting on RiffSync, and without making Riffle a host, lobby, identity, chat, or rooms product

  # Out of this initiative:
  # - RiffSync attach or RiffSync host-path polish (RiffSync remains the first product host; unused here)
  # - Making Riffle a host, lobby, identity, chat, rooms, presence, or media product
  # - Standalone consumer client, lobby, or matchmaking (roadmap Later / non-goal)
  # - Remote two-person rooms or multi-operator play
  # - CI against live Turnur, or any CI program (CI stays on the in-memory fake Turnur)
  # - Runtime hosting / IaC, or provisioning a Turnur cluster
  # - Real money, rake, cashier, or KYC
  # - New poker rules; side pots, all-in runout, disconnect/rejoin, spectator polish
  # - Signed result issuance or verification
  # - Turnur SDK key in the browser or lab page

  Background:
    Given the playable no-limit Hold'em table is available in the Riffle runtime
    And Riffle Poker is the registered Turnur game
    And the Riffle runtime holds the Turnur SDK key and uses @turnur/sdk
    And the browser never receives the Turnur SDK key
    And the play lab is a first-party harness in riffle-poker that implements the existing host contract
    And RiffSync is not the host for this path
    And a live Turnur is available via environment configuration

  Scenario: Lab is a host harness and not a host product
    When an operator opens the play lab
    Then the lab can mint a bootstrap token, embed the Riffle-origin play iframe, create seats, issue seat capabilities, deal a hand, and open betting
    And the lab does not add player identity, chat, rooms, presence, or media
    And the lab does not become Turnur match authority
    And RiffSync remains the first product host and is unused by this path

  Scenario: Operator reaches two seated iframes from the lab alone
    When an operator opens the play lab with live Turnur configured
    Then the lab can attach a match and present two capability-bound play iframes without RiffSync or another host product

  Scenario: Single operator drives two seats
    Given the operator has opened the play lab
    When the lab creates two play-chip NLHE seats on a live Turnur match
    Then both seats are driven by that single operator
    And the lab does not create remote two-person rooms or invite a second operator

  Scenario: Lab embeds the existing play surface via bootstrap mint, fragment, and redeem
    Given the lab has minted an opaque short-lived bootstrap token for a match
    When the lab loads the Riffle-origin play URL with the token in the #bt= fragment in an iframe
    Then the iframe redeems the token at the Riffle runtime and binds match attach
    And seated play uses the existing Riffle play surface, not a new standalone client
    And the bootstrap token is not seat authority
    And postMessage is not the primary bootstrap

  Scenario: Lab issues a host seat capability for each of two seats
    Given two seats exist on the attached match
    When the lab, acting as host, mints a short-lived seat capability for each seat
    Then each seat's play context presents that capability for seat-scoped operations
    And a capability for one seat cannot act as the other seat
    And postMessage is not seat authority
    And bootstrap and play-session attach are not seat authority

  Scenario: Lab deals and opens betting as the host
    Given two seats have host-issued capabilities on the attached match
    When the lab deals a no-limit Hold'em hand and opens betting
    Then each seat receives hole cards only for its own seat
    And betting is open on live Turnur
    And the iframe does not deal or open betting

  Scenario: Two lab seats complete a hand against live Turnur
    Given a hand is open for two seats in the lab against live Turnur
    When the operator plays both seats through the existing table UI until the hand finishes by fold-to-one or non-all-in showdown
    Then the hand is complete on live Turnur
    And Turnur remains authority for seats, turns, hidden views, and the move log
    And completing a hand only against the in-memory fake Turnur does not satisfy this initiative

  Scenario: Turnur SDK key never reaches the lab or play browser
    When the operator uses the lab to mint, embed, seat, or play
    Then the lab page, play URL, iframe bundles, and browser-accessible config do not include a Turnur SDK key
    And the SDK key remains only on the Riffle runtime

  Scenario: This initiative does not change CI or become a hosting program
    Given Riffle CI already runs against an in-memory fake Turnur
    Then this initiative does not require CI to use live Turnur
    And this initiative does not provision a Turnur cluster
    And runtime hosting of the lab or Riffle process remains out of scope

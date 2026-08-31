Feature: MatchState and MatchMoveLog storage
  As a game pack developer authenticated with an SDK key
  I want dedicated match-state and move-log storage
  So that later tickets can persist seats, turns, views, and moves without overloading MatchRegistry

  Background:
    Given host attach has already shipped
    And MatchRegistry already stores match metadata only

  Scenario: Dedicated MatchState storage exists
    When dedicated match-state storage is provisioned
    Then MatchState exists as a dedicated table keyed by match
    And that table can later hold a turn cursor, seats, and per-seat hidden views
    And this ticket has not written any MatchState items

  Scenario: Dedicated MatchMoveLog storage exists
    When dedicated move-log storage is provisioned
    Then MatchMoveLog exists as a dedicated table keyed by match and sequence
    And later tickets can append to and query that log only
    And this ticket has not written any MatchMoveLog items

  Scenario: MatchRegistry stays metadata-only
    When dedicated match-state and move-log storage is provisioned
    Then MatchRegistry still stores only matchId, gameId, status, and createdAt
    And MatchRegistry does not store seats, a turn cursor, hidden views, or moves

  Scenario: Storage slice adds no match-state API
    When dedicated match-state and move-log storage is provisioned
    Then no new HTTP routes are added
    And no new handlers are added
    And no new SDK methods are added

  Scenario: State for one match is not another match's state
    Given two attached matches
    When match-state or move-log storage is read for the second match
    Then that read does not include the first match's state
    And that read does not include the first match's move log

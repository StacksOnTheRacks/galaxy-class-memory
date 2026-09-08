Feature: GET /v1/rooms/mine and Your Parties page
  As a signed-in host
  I want to list and resume watch parties I own
  So that I can reuse parties instead of always starting from a title card

  # Out of this ticket: Load Media modal (#450), host theater reskin (#452),
  # AppShell rebuild (#445), channel pages, production Dynamo backfill.

  Background:
    Given the host is signed in with a valid fan Cognito JWT
    And the AppShell profile menu links to /your-parties
    And Home / Your Parties (1450:10247) is the visual source

  Scenario: rooms/mine returns only rooms the caller hosts
    When they GET /v1/rooms/mine
    Then the server queries HostSubRoomsIndex with hostSub equal to JWT.sub
    And rooms hosted by other fans are not returned
    And system Live rooms (live-* roomIds) are not returned
    And both public and private owned rooms are returned
    And results are sorted by lastActivityAt descending

  Scenario: rooms/mine DTO omits host identity
    When they GET /v1/rooms/mine
    Then each room has roomId, displayTitle, catalogEpisodeId, lastActivityAt, and visibility
    And hostSub and Dynamo internal keys are omitted

  Scenario: rooms/mine requires fan JWT
    When a caller has no fan JWT
    Then GET /v1/rooms/mine is 401 with code fan_auth_required
    And the list is not returned

  Scenario: Your Parties lists rooms the signed-in host owns
    When they open Your Parties
    Then they see WatchPartyCards for rooms they host in API order
    And they do not see rooms hosted by other fans
    And system Live rooms are not listed as owned parties
    And a host with no rooms sees the Your Parties hero and zero cards

  Scenario: WatchPartyCard matches Figma and opens the room
    Given the host has an existing room on Your Parties
    When they activate that card or its Join URL
    Then they land in the room at /room/{roomId}
    And the room retains its current catalogEpisodeId until Load Media changes it
    And Copy URL copies the first-party /room/{roomId} URL without navigating

  Scenario: Profile menu opens the real Your Parties page
    When the signed-in host chooses Your Parties in the profile menu
    Then they land on /your-parties
    And the page calls GET /v1/rooms/mine

  Scenario: Signed-out Your Parties starts Sign In
    Given the visitor is signed out
    When they hit /your-parties
    Then they start the existing fan Sign In flow
    And GET /v1/rooms/mine is not called

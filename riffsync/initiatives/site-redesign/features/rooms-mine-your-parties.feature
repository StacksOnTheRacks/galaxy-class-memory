Feature: GET /v1/rooms/mine and Your Parties page
  As a signed-in host
  I want to list and resume watch parties I own
  So that I can reuse parties instead of always starting from a title card

  # Out of this ticket: Load Media modal, channel pages beyond navigation link, host theater reskin.

  Background:
    Given the host is signed in with a valid fan Cognito JWT
    And the AppShell profile menu links to Your Parties

  Scenario: Your Parties lists rooms the signed-in host owns
    When they open Your Parties
    Then they see watch parties they host sorted by recent activity
    And they do not see rooms hosted by other fans
    And system Live rooms are not listed as owned parties

  Scenario: Host resumes an owned party from Your Parties
    Given the host has an existing room on Your Parties
    When they open that party
    Then they land in the room at /room/{roomId}
    And the room retains its current catalogEpisodeId until Load Media changes it

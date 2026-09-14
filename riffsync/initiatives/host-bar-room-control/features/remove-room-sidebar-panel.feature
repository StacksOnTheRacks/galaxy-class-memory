Feature: Remove Room sidebar panel and playlist chrome
  As a participant in a watch party
  I want the chat sidebar without the legacy Room panel
  So that room admin lives in Watch Party Settings and chat tabs stay focused

  # Out of this ticket: Watch Party Settings dialog (#472); playlist return;
  # new Leave Party control; Finish the Host Chrome Extension.

  Background:
    Given I am on a watch-party room route /room/:roomId
    And Watch Party Settings consolidates host room-admin functions

  Scenario: Room panel playlist and host-help actions are removed
    When the room sidebar renders
    Then there is no Room button at the top of the chat section
    And the Room panel is not present
    And Next Up playlist and catalog-queue controls are not present
    And Install Host Extension is not present
    And Hosting Guide is not present
    And Leave Party is not present in the sidebar or Room panel

  Scenario: Chat People and Friends remain
    When the room sidebar renders
    Then Chat and People tabs remain
    And Friends remains available for signed-in fans

  Scenario: Live channel sidebar is unchanged
    Given I am on a live channel route that uses the shared room sidebar
    When the live sidebar renders
    Then Chat and People tabs remain
    And Friends remains available for signed-in fans
    And there is no Room button or Room panel

  Scenario: Leftover Room tab selection shows Chat
    Given I am on a watch-party room route /room/:roomId
    And the sidebar tab state is room
    When the room sidebar renders
    Then Chat is shown
    And the Room panel is not present

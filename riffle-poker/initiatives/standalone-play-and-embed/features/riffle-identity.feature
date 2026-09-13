Feature: First-party Riffle account and anonymous bearer session
  As a player at a Riffle table
  I want a first-party Riffle session (account or anonymous)
  So that seat authority is a Riffle bearer and not Cognito, host identity, or an ambient cookie

  # Out of this ticket: Sit at Table seat binding, MatchStore, shared play URL,
  # embed attach, display name, WS notify, table actions, hole/board views,
  # hand complete, anonymous-to-account upgrade, Cognito / RiffSync auth copy.

  Background:
    Given Riffle Poker uses first-party Riffle identity (not Cognito)
    And session transport is bearer-only on standalone and embed
    And historical riffle_play HttpOnly cookie is not the forward channel
    And new work lives in identity/ and does not wrap Turnur

  Scenario: Player signs up and receives an account bearer session
    When a player signs up for a Riffle account
    Then they receive a bearer session whose playerSubject is that account id

  Scenario: Player signs in with an existing account
    Given a player has a Riffle account
    When they sign in
    Then they receive a bearer session whose playerSubject is that account id

  Scenario: Anonymous session store can issue anon:{jti}
    When the identity module issues an anonymous session
    Then the session playerSubject is anon:{jti}
    And the token is unguessable

  Scenario: Bearer token does not appear in URL query strings
    When a session is issued
    Then the bearer token is not placed in URL query strings

  Scenario: Standalone entry offers Play without account
    When a player views standalone entry
    Then they see Sign in and Create account paths
    And they see a text-distinguishable Play without account path

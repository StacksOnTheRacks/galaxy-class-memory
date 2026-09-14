Feature: First-party Riffle account and anonymous bearer session
  As a player at a Riffle table
  I want a first-party Riffle session (account or anonymous)
  So that seat authority is a Riffle bearer and not Cognito, host identity, or an ambient cookie

  # Out of this ticket: Sit at Table seat binding, MatchStore, shared play URL,
  # embed attach, display name edit, WS notify, table actions, hole/board views,
  # hand complete, email verification, forgot/reset, anonymous-to-account upgrade,
  # Cognito / RiffSync auth copy.

  Background:
    Given Riffle Poker uses first-party Riffle identity (not Cognito)
    And session transport is bearer-only on standalone and embed
    And historical riffle_play HttpOnly cookie is not the forward channel
    And new work lives in identity/ and does not wrap Turnur

  Scenario: Player signs up and receives an account bearer immediately
    When a player creates a Riffle account with email, password, and confirm password
    Then they receive a bearer session whose playerSubject is that account id
    And they are not asked to verify email before the session is issued

  Scenario: Player signs in with an existing account
    Given a player has a Riffle account
    When they sign in with email and password
    Then they receive a bearer session whose playerSubject is that account id

  Scenario: Play without account issues anon:{jti}
    When a player chooses Play without account
    Then the identity module issues an unguessable anonymous session
    And the session playerSubject is anon:{jti}

  Scenario: Success paths land on signed-in chrome without a play URL
    When a player signs in, creates an account, or chooses Play without account
    Then they land on standalone signed-in chrome
    And they do not need a play URL or match

  Scenario: Sign out ends the bearer session
    Given a player is on standalone signed-in chrome
    When they choose Sign out
    Then the bearer session ends
    And they return to standalone signed-out or entry chrome

  Scenario: Bearer-only transport and no query-string token
    When a session is issued
    Then it is presented as Authorization or equivalent
    And it is not stored or sent as an ambient cookie
    And the bearer token is not placed in URL query strings

  Scenario: Standalone entry offers three text-distinguishable paths
    When a player views standalone entry
    Then they see Sign in and Create account paths
    And they see a text-distinguishable Play without account path

  Scenario: Auth forms show validation, failure, and submitting states
    When sign-in or create-account fields are invalid or credentials fail
    Then errors are visible and associated with fields
    And submitting replaces the submit control with progress copy

  Scenario: Embed iframe does not show Riffle login chrome
    When a player is on the embed or play iframe surface
    Then they do not see Sign in, Create account, or Play without account
    And the identity module can still issue anon:{jti} for later Sit at Table

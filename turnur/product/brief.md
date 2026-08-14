# Product

Turnur is a backend state provider for turn-based matches. A host (RiffSync or anything like it) loads a game into a room; users join the game; the game authenticates to Turnur with an SDK key. Turnur then owns match state: seats, turns, hidden views, the move log, and a signed result. Games supply gameplay and rules. Identity, chat, rooms, and media stay on the host. Turnur authenticates games, not players. Repo: https://github.com/StacksOnTheRacks/turnur

# Problem

A host can load a game into a room, but the game has no trusted way to talk to a match authority. Without game authentication, any client could claim to be a game and mutate match state. Players and hosts are the wrong principals — the game is. Until a game can authenticate to Turnur with an SDK key, seats, turns, hidden views, the move log, and a signed result cannot be offered safely.

# Who it's for

- Games that use Turnur as a backend state provider and authenticate with an SDK key
- Host platforms (RiffSync first; any similar room/identity/chat/media host) that load a game into a room so users can join it
- Players who join through the host and game client — Turnur does not authenticate them
- Not for people seeking identity, chat, rooms, media, or a first-party Turnur game

# Goals

- A game authenticates to Turnur with an SDK key and can talk to it as a backend state provider
- Turnur authenticates games, not players
- After auth: Turnur owns seats, turns, hidden views, the move log, and a signed result
- Games supply gameplay and rules; Turnur does not ship a first-party game
- Host-agnostic attach path: RiffSync is the first expected host, not the only one
- Identity, chat, rooms, and media stay on the host

# Non-goals

- Player or host identity on Turnur
- A first-party game as v1
- Chat, rooms, presence, or media/playback
- Real-time / action games (not turn-based)
- Deciding how a signed result is verified (crypto vs transport) as a first-goal

# Success metrics

- A game with a valid SDK key can authenticate and talk to Turnur
- Missing or invalid SDK keys are rejected
- Players and hosts cannot authenticate as games
- After auth exists: an authenticated game can run a match that yields seats, turns, hidden views, a move log, and a signed result
- Quantified targets TBD (greenfield; no instrumentation yet)

# Current focus

Game authentication: an SDK key so a game can talk to Turnur as a backend state provider. Board is empty of issues; no code beyond the README.

# System

Turnur is an authoritative turn-based match engine. A host loads a game; the room loads that game’s client per user; users join the game; the game uses Turnur as a backend state provider. Turnur authenticates the **game** with an SDK key, then owns seats, turns, hidden views, the move log, and a signed result. Identity, chat, rooms, and media stay on the host. This sketch is current intent, not a locked ADR.

# Context

Hosts (RiffSync or anything like it) remain the social and media surface. The game supplies rules and is Turnur’s client. Players arrive through the host and join the game; Turnur does not authenticate them. The `turnur` repo is greenfield (README only; no code or ADRs). Sister product RiffSync is a watch-party host — Turnur does not inherit its control-plane or media-plane shape.

# Major components

Logical sketch (current intent, not implementation):

- **Host** — loads a game into a room; owns identity, chat, rooms, and media.
- **Game / game client** — loaded per user by the room; supplies rules; talks to Turnur as the backend state provider.
- **SDK-key auth** — Turnur authenticates the game, not the player.
- **Match** — the authoritative instance Turnur runs after the game is authenticated.
- **Seats** — who occupies which seat for the match.
- **Turn clock** — whose turn it is and when a turn is due or expired.
- **Hidden views** — per-seat private state the host must not invent or leak as authority.
- **Move log** — append-only record of accepted moves.
- **Signed result** — terminal outcome Turnur attests when the match ends (mechanism not locked).

# Data flow

1. The host loads a game.
2. The room loads the game client per user; users join the game.
3. The game authenticates to Turnur with an SDK key.
4. The authenticated game uses Turnur as the backend state provider; Turnur seats players, advances turns, applies hidden views, and accepts or rejects moves.
5. Accepted moves append to the move log.
6. The match ends; Turnur emits a signed result (how it is signed is undecided).
7. The host continues to own identity, chat, rooms, and media around that match.

# Deployment shape

-

# Current focus

First slice: **game authentication** (SDK keys). No runtime, API, or deploy target is chosen. Signed-result mechanism is not locked.

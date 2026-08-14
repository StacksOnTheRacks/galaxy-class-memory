# Themes

- Game authentication: SDK key so a game can talk to Turnur
- Backend state provider: games supply gameplay and rules; Turnur owns match state
- Match authority after auth: seats, turns, hidden views, move log, signed result
- Stay out of identity, chat, rooms, and media; authenticate games, not players

# Now

- Game authentication / SDK key so a game can talk to Turnur as a backend state provider
- RiffSync path this unlocks: host loads a game → room loads the game client for each user → users join the game → game authenticates to Turnur
- Greenfield: https://github.com/StacksOnTheRacks/turnur — public, README only, empty issue board

# Next

- Authenticated-game match authority: seats, turns, hidden views, and the move log so a game that already has an SDK key can run a match
- Host path polish (RiffSync or equivalent): load game into room, users join, game talks to Turnur — without Turnur owning rooms or identity

# Later

- Signed result as a capability (verification mechanism undecided)
- Additional host platforms beyond the first attach
- Additional games / game packs that reuse the same auth and state-provider contract

# Not planning

- A first-party Turnur game as v1
- Player or host authentication on Turnur
- Identity, chat, rooms, or media on Turnur
- Becoming a social, lobby, or watch-party product
- Real-time / action (non-turn-based) gameplay

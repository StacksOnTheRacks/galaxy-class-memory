# Hard constraints

- Games authenticate to Turnur with an SDK key. Turnur authenticates games, not players.
- Turnur does not own player identity. Identity, chat, rooms, and media stay on the host.
- After a game is authenticated, Turnur is state authority (seats, turns, hidden views, move log, signed result). The host does not become match authority.
- Games supply rules. Turnur is not a game catalog or a social app, and must not grow rooms, presence, chat, media, or a game store of its own.

# Soft constraints

- Stay host-agnostic: RiffSync is one host, not the only host.
- Keep the game attach surface thin — authenticate the game, then provide match state, not a second product UI.
- Defer runtime, cloud, protocol, and signing-mechanism choices until there is a reason to lock them.

# Out of bounds

- Player login, accounts, or identity as a Turnur concern.
- Becoming a watch-party, lobby, chat, catalog, or identity product.
- Re-hosting or redistributing host media.
- Copying RiffSync’s AWS / CDK / SFU / Cognito stack as Turnur’s default shape.
- Treating this sketch’s logical components or signed-result mechanism as locked ADRs.

# Assumptions

- A host can load a game and a room can load that game’s client per user.
- Users join the game on the host; the game then calls Turnur with an SDK key.
- How a result is signed, and how a host or game verifies it, is undecided.

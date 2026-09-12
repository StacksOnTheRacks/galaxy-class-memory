---
doc: product.insights
schema_version: 1
updated: 2026-09-11
themes:
  - "Dual-sided attach: host owns social surface; game owns rules/UI; Turnur owns match authority"
  - "Game-authenticated integration — SDK key for games, not player accounts on Turnur"
  - "Operator-locked Next initiative queue: Integrate WebSockets (examine); Signed result; Authoritative writes"
  - "Play-lab latency is operator evidence that HTTP polling is too slow for seated play — examine WebSockets, do not lock an ADR yet"
evidence:
  - "product/roadmap.md Next — operator-locked whiteboard merge"
  - "Control plane, game auth, and host attach shipped; primitives #29–#35 shipped (closed)"
  - "Sister riffle-poker play lab completes hands against live Turnur and is too slow for instant communication"
  - "Signed-result verification mechanism still undecided"
open_questions:
  - "Signed-result verification — mechanism and who verifies (host, game, or both)"
  - "Is a Turnur WebSocket a match-event push on the existing game-auth contract, or a new channel?"
implications:
  - "Do not invent tickets from the Next queue — /forge.new-initiative first"
  - "WebSockets examine is not action/realtime gameplay and must not copy RiffSync chat or SFU stacks"
  - "Riffle remains the first game pack; RiffSync Watch Party Game Mode is the first host path"
---

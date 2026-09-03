---
doc: architecture.decisions
schema_version: 1
updated: 2026-09-02
active_decisions:
  - "ADR-iframe-embed — Host embed = iframe at Riffle origin; opaque match/room context; identity stays on host"
  - "ADR-rules-in-process — Rules = in-process library in Riffle runtime; SDK key server-side only; path Host→iframe→runtime→rules→@turnur/sdk→Turnur"
  - "ADR-host-seat-capability — Host issues short-lived seat capability (player↔match↔seat); Riffle verifies before seat-scoped Turnur ops; postMessage is not seat authority"
  - "ADR-host-iframe-bootstrap — Opaque short-lived bootstrap token in iframe URL; host mints at Riffle, iframe redeems at runtime for match attach; seat capability separate channel; SDK key never in browser; signed-URL / postMessage-only / third-party-cookie session not primary"
superseded: []
---

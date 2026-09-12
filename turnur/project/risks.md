---
doc: project.risks
schema_version: 1
updated: 2026-09-11
risks:
  - "Play-lab latency may push WebSockets ahead of a locked transport ADR — examine first, do not copy RiffSync chat/SFU stacks"
issues: []
dependencies:
  - "Primitives #29–#35 shipped (PRs #36–#42); WebSockets examine gate is open — /forge.new-initiative, not LLD or tickets"
  - "Signed result and authoritative writes wait on /forge.new-initiative after primitives"
assumptions:
  - "HTTP remains authority until an ADR locks a push channel"
  - "Next queue is operator-locked; do not invent tickets from Icebox"
---

See `architecture/risks.md` and `security/threat-model.md` as the stack grows.

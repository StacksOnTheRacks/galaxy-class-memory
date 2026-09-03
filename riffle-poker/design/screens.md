---
doc: design.screens
schema_version: 1
updated: 2026-09-03
screens:
  - name: Seated table / loading — desktop
    figma_node_id: "4004:15"
    app: riffle-poker
    states: [loading]
    responsive: [desktop]
  - name: Seated table / loading — narrow-iframe
    figma_node_id: "4004:20"
    app: riffle-poker
    states: [loading]
    responsive: [narrow-iframe]
  - name: Seated table / waiting-for-deal — desktop
    figma_node_id: "4004:31"
    app: riffle-poker
    states: [waiting-for-deal]
    responsive: [desktop]
  - name: Seated table / waiting-for-deal — narrow-iframe
    figma_node_id: "4004:50"
    app: riffle-poker
    states: [waiting-for-deal]
    responsive: [narrow-iframe]
  - name: Seated table / hand-in-progress — desktop
    figma_node_id: "4004:69"
    app: riffle-poker
    states: ["hand-in-progress (not my turn)"]
    responsive: [desktop]
  - name: Seated table / hand-in-progress — narrow-iframe
    figma_node_id: "4004:100"
    app: riffle-poker
    states: ["hand-in-progress (not my turn)"]
    responsive: [narrow-iframe]
  - name: Seated table / my-turn — desktop
    figma_node_id: "4005:2"
    app: riffle-poker
    states: [my-turn]
    responsive: [desktop]
  - name: Seated table / my-turn — narrow-iframe
    figma_node_id: "4005:40"
    app: riffle-poker
    states: [my-turn]
    responsive: [narrow-iframe]
  - name: Seated table / hand-in-progress (river) — desktop
    figma_node_id: "4010:2"
    app: riffle-poker
    states: ["hand-in-progress (river, not my turn)"]
    responsive: [desktop]
  - name: Seated table / hand-in-progress (river) — narrow-iframe
    figma_node_id: "4010:39"
    app: riffle-poker
    states: ["hand-in-progress (river, not my turn)"]
    responsive: [narrow-iframe]
  - name: Seated table / my-turn (river) — desktop
    figma_node_id: "4010:76"
    app: riffle-poker
    states: ["my-turn (river)"]
    responsive: [desktop]
  - name: Seated table / my-turn (river) — narrow-iframe
    figma_node_id: "4010:117"
    app: riffle-poker
    states: ["my-turn (river)"]
    responsive: [narrow-iframe]
  - name: Seated table / showdown — desktop
    figma_node_id: "4005:78"
    app: riffle-poker
    states: [showdown]
    responsive: [desktop]
  - name: Seated table / showdown — narrow-iframe
    figma_node_id: "4005:112"
    app: riffle-poker
    states: [showdown]
    responsive: [narrow-iframe]
  - name: Seated table / hand-complete — desktop
    figma_node_id: "4005:158"
    app: riffle-poker
    states: [hand-complete]
    responsive: [desktop]
  - name: Seated table / hand-complete — narrow-iframe
    figma_node_id: "4005:184"
    app: riffle-poker
    states: [hand-complete]
    responsive: [narrow-iframe]
  - name: Embed / session error — desktop
    figma_node_id: "4005:210"
    app: riffle-poker
    states: [embed-error]
    responsive: [desktop]
  - name: Embed / session error — narrow-iframe
    figma_node_id: "4005:215"
    app: riffle-poker
    states: [embed-error]
    responsive: [narrow-iframe]
  - name: Play lab / idle — desktop
    figma_node_id: "4012:52"
    app: riffle-poker
    states: [lab-idle]
    responsive: [desktop-operator]
  - name: Play lab / session ready — desktop
    figma_node_id: "4012:70"
    app: riffle-poker
    states: [lab-ready]
    responsive: [desktop-operator]
  - name: Play lab / two seats live — desktop
    figma_node_id: "4012:89"
    app: riffle-poker
    states: [lab-two-seats]
    responsive: [desktop-operator]
  - name: Play lab / harness error — desktop
    figma_node_id: "4012:142"
    app: riffle-poker
    states: [lab-harness-error]
    responsive: [desktop-operator]
---

Inventoried from Figma Screens / Flows. Seated-table frames after first design-spike; play-lab shell frames after play-lab design-spike (2026-09-03). Node ids copied from MCP; do not invent.

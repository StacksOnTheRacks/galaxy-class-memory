---
doc: design.screens
schema_version: 1
updated: 2026-09-12
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
  - name: Standalone app chrome / signed-out
    figma_node_id: "4038:28"
    app: riffle-poker
    states: [signed-out]
    responsive: [desktop]
  - name: Standalone entry / choose-path
    figma_node_id: "4038:35"
    app: riffle-poker
    states: [standalone-entry]
    responsive: [desktop]
  - name: Standalone app chrome / signed-in
    figma_node_id: "4038:49"
    app: riffle-poker
    states: [signed-in]
    responsive: [desktop]
  - name: Auth / sign-in — default
    figma_node_id: "4038:56"
    app: riffle-poker
    states: [auth-sign-in]
    responsive: [desktop]
  - name: Auth / sign-in — validation-error
    figma_node_id: "4038:73"
    app: riffle-poker
    states: [auth-validation-error]
    responsive: [desktop]
  - name: Auth / sign-in — auth-failure
    figma_node_id: "4038:91"
    app: riffle-poker
    states: [auth-failure]
    responsive: [desktop]
  - name: Auth / sign-in — submitting
    figma_node_id: "4038:109"
    app: riffle-poker
    states: [auth-submitting]
    responsive: [desktop]
  - name: Auth / sign-up — default
    figma_node_id: "4038:125"
    app: riffle-poker
    states: [auth-sign-up]
    responsive: [desktop]
  - name: Auth / sign-up — validation-error
    figma_node_id: "4038:145"
    app: riffle-poker
    states: [auth-validation-error]
    responsive: [desktop]
  - name: Auth / sign-up — auth-failure
    figma_node_id: "4038:166"
    app: riffle-poker
    states: [auth-failure]
    responsive: [desktop]
  - name: Auth / sign-up — submitting
    figma_node_id: "4038:187"
    app: riffle-poker
    states: [auth-submitting]
    responsive: [desktop]
  - name: Table / open — unseated — desktop
    figma_node_id: "4038:206"
    app: riffle-poker
    states: [unseated]
    responsive: [desktop]
  - name: Table / open — unseated — narrow-iframe
    figma_node_id: "4038:217"
    app: riffle-poker
    states: [unseated]
    responsive: [narrow-iframe]
  - name: Table / sit-at-table — submitting — desktop
    figma_node_id: "4038:228"
    app: riffle-poker
    states: [sit-submitting]
    responsive: [desktop]
  - name: Table / sit-at-table — submitting — narrow-iframe
    figma_node_id: "4038:232"
    app: riffle-poker
    states: [sit-submitting]
    responsive: [narrow-iframe]
  - name: Display name / edit — default — desktop
    figma_node_id: "4038:236"
    app: riffle-poker
    states: [display-name-edit]
    responsive: [desktop]
  - name: Display name / edit — default — narrow-iframe
    figma_node_id: "4038:245"
    app: riffle-poker
    states: [display-name-edit]
    responsive: [narrow-iframe]
  - name: Display name / edit — validation-error — desktop
    figma_node_id: "4038:254"
    app: riffle-poker
    states: [display-name-validation-error]
    responsive: [desktop]
  - name: Display name / edit — validation-error — narrow-iframe
    figma_node_id: "4038:264"
    app: riffle-poker
    states: [display-name-validation-error]
    responsive: [narrow-iframe]
  - name: Display name / edit — saving — desktop
    figma_node_id: "4038:274"
    app: riffle-poker
    states: [display-name-saving]
    responsive: [desktop]
  - name: Display name / edit — saving — narrow-iframe
    figma_node_id: "4038:282"
    app: riffle-poker
    states: [display-name-saving]
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

Inventoried from Figma Screens / Flows (`3:4`). Seated-table frames after first design-spike; play-lab after play-lab design-spike (2026-09-03). Standalone entry/auth/unseated/display-name frames after standalone-play-and-embed design-spike (2026-09-12) at y>11000. Loading (`4004:15`/`4004:20`) and embed-error (`4005:210`/`4005:215`) copy refreshed to shared-URL language. Node ids from MCP; do not invent.

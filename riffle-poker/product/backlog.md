---
doc: product.backlog
schema_version: 1
updated: 2026-09-25
in_progress: []
ready:
  - "[#59 Host interactive match runtime on API Gateway WebSocket + Lambda + DynamoDB](https://github.com/StacksOnTheRacks/riffle-poker/issues/59)"
  - "[#60 Render dashboard table shell for Desktop, Tablet, and Phone](https://github.com/StacksOnTheRacks/riffle-poker/issues/60)"
  - "[#61 Show player row tiles with stack, cards, action, positions, and turn timer](https://github.com/StacksOnTheRacks/riffle-poker/issues/61)"
  - "[#62 Show My Hand pocket, bank, session delta, committed, strength, outs, and action log](https://github.com/StacksOnTheRacks/riffle-poker/issues/62)"
  - "[#63 Show Board slots, pot, and players in hand](https://github.com/StacksOnTheRacks/riffle-poker/issues/63)"
  - "[#64 Ship Fold/Check/Call/Raise controls with raise presets, slider, and phone action sheet](https://github.com/StacksOnTheRacks/riffle-poker/issues/64)"
  - "[#65 Sit at table, post blinds, deal hole cards, and open betting](https://github.com/StacksOnTheRacks/riffle-poker/issues/65)"
  - "[#68 Configure AWS OIDC deploy role and GitHub environment for serverless match runtime](https://github.com/StacksOnTheRacks/riffle-poker/issues/68)"
refinement:
  - "[#66 Advance legal betting through flop, turn, and river](https://github.com/StacksOnTheRacks/riffle-poker/issues/66)"
  - "[#67 Settle all-in with side pots when required, showdown or fold-out, and update stacks](https://github.com/StacksOnTheRacks/riffle-poker/issues/67)"
blocked: []
done:
  - "[#36 First-party Riffle account and anonymous bearer session](https://github.com/StacksOnTheRacks/riffle-poker/issues/36)"
  - "[#37 Riffle MatchStore owns seats, turns, hidden views, and the move log](https://github.com/StacksOnTheRacks/riffle-poker/issues/37)"
  - "[#38 Shared play URL attach for standalone and host embed](https://github.com/StacksOnTheRacks/riffle-poker/issues/38)"
  - "[#39 Sit at Table binds a Riffle session to a seat](https://github.com/StacksOnTheRacks/riffle-poker/issues/39)"
  - "[#40 Anonymous player can change in-game display name](https://github.com/StacksOnTheRacks/riffle-poker/issues/40)"
  - "[#41 Browser WebSocket notify-only for public table updates](https://github.com/StacksOnTheRacks/riffle-poker/issues/41)"
  - "[#42 Apply on-turn NLHE actions against MatchStore](https://github.com/StacksOnTheRacks/riffle-poker/issues/42)"
  - "[#43 Hole cards stay seat-scoped and the public board is shared](https://github.com/StacksOnTheRacks/riffle-poker/issues/43)"
  - "[#1 Host iframe attach via bootstrap mint → URL → redeem](https://github.com/StacksOnTheRacks/riffle-poker/issues/1)"
  - "[#2 Riffle runtime authenticates to Turnur with a server-side SDK key](https://github.com/StacksOnTheRacks/riffle-poker/issues/2)"
  - "[#3 Verify host-issued seat capability before seat-scoped Turnur ops](https://github.com/StacksOnTheRacks/riffle-poker/issues/3)"
  - "[#4 Create play-chip NLHE seats on the attached Turnur match](https://github.com/StacksOnTheRacks/riffle-poker/issues/4)"
  - "[#5 In-process NLHE rules library (deal, legalize, streets, showdown)](https://github.com/StacksOnTheRacks/riffle-poker/issues/5)"
  - "[#6 Deal hole cards as seat-scoped Turnur hidden views](https://github.com/StacksOnTheRacks/riffle-poker/issues/6)"
  - "[#7 Apply on-turn NLHE actions via Turnur turns and moves](https://github.com/StacksOnTheRacks/riffle-poker/issues/7)"
  - "[#8 Advance the public board through flop, turn, and river](https://github.com/StacksOnTheRacks/riffle-poker/issues/8)"
  - "[#9 Complete a hand by fold-to-one or non-all-in showdown](https://github.com/StacksOnTheRacks/riffle-poker/issues/9)"
  - "[#19 Host-facing POST /v1/matches wraps Turnur match.create](https://github.com/StacksOnTheRacks/riffle-poker/issues/19)"
  - "[#20 Play iframe accepts host seat capability via postMessage](https://github.com/StacksOnTheRacks/riffle-poker/issues/20)"
  - "[#21 Lab session orchestrator mints match, seats, bootstrap, and capabilities](https://github.com/StacksOnTheRacks/riffle-poker/issues/21)"
  - "[#22 Lab deal orchestrator deals and opens betting for two seats](https://github.com/StacksOnTheRacks/riffle-poker/issues/22)"
  - "[#23 First-party play lab page with two embedded /play iframes](https://github.com/StacksOnTheRacks/riffle-poker/issues/23)"
  - "[#24 Two lab seats complete a hand against live Turnur](https://github.com/StacksOnTheRacks/riffle-poker/issues/24)"
  - "[#31 Add TURNUR_WS_URL env gate and Turnur WS client factory](https://github.com/StacksOnTheRacks/riffle-poker/issues/31) — closed not planned (Turnur mothballed)"
  - "[#32 Add match subscription registry and waitForMatchEvent](https://github.com/StacksOnTheRacks/riffle-poker/issues/32) — closed not planned"
  - "[#33 Wire play-lab session to subscribe server-side on match attach](https://github.com/StacksOnTheRacks/riffle-poker/issues/33) — closed not planned"
  - "[#34 Refactor submit and advance post-mutation polls to WS notify](https://github.com/StacksOnTheRacks/riffle-poker/issues/34) — closed not planned"
  - "[#35 Refactor remaining orchestration poll sites and verify poll reduction](https://github.com/StacksOnTheRacks/riffle-poker/issues/35) — closed not planned"
  - "[#44 Complete a play-chip hand on standalone and embed](https://github.com/StacksOnTheRacks/riffle-poker/issues/44) — closed not planned (superseded by dashboard-holdem)"
  - "[#53 Define Riffle Figma source components for cards, chips, and felt](https://github.com/StacksOnTheRacks/riffle-poker/issues/53) — closed not planned"
  - "[#54 Serve first-party artwork via GET /assets/* and cardAssetUrl](https://github.com/StacksOnTheRacks/riffle-poker/issues/54) — closed not planned"
  - "[#55 Render Riffle card faces on hole, board, and showdown](https://github.com/StacksOnTheRacks/riffle-poker/issues/55) — closed not planned"
  - "[#56 Apply Riffle felt and table chrome tokens](https://github.com/StacksOnTheRacks/riffle-poker/issues/56) — closed not planned"
  - "[#57 Show chip artwork at pot and seat stacks](https://github.com/StacksOnTheRacks/riffle-poker/issues/57) — closed not planned"
  - "[#58 Publish Canva kit from the same Riffle identity](https://github.com/StacksOnTheRacks/riffle-poker/issues/58) — closed not planned"
icebox:
  - "Web Site (Next; /forge.new-initiative before tickets)"
  - "Multi-Hand Session (Next; /forge.new-initiative before tickets)"
  - "Room-guest spectator view (public board only)"
  - "Disconnect/rejoin"
  - "Additional poker variants (Omaha, Stud, mixed)"
  - "Tournaments / sit-and-go"
---

Board/SCM wins — #44 and #53–#58 closed not planned (superseded by dashboard-holdem). Milestone/6 Dashboard Hold'em: #59, #60, #61, #62, #63, #64, #65, #68 Ready; #66–#67 In Refinement. Icebox is coarse outcomes only; do not treat as tickets.

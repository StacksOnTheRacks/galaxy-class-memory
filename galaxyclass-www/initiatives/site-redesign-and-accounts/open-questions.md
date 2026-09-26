---
doc: product.open_questions
schema_version: 1
updated: 2026-09-26
questions:
  - id: figma-bind-vs-code
    question: "Design in code first — evolve existing Next.js/Tailwind site; Figma bind later."
    blocking: false
    status: answered
    owner: designer
  - id: apex-vs-www
    question: "Apex galaxyclass.app is canonical; www.galaxyclass.app redirects to apex preserving path and query."
    blocking: false
    status: answered
    owner: architect
  - id: social-sign-in
    question: "Email and password only at launch; Google/Apple deferred to a later initiative."
    blocking: false
    status: answered
    owner: po
  - id: cognito-feature-plan
    question: "Recommend Cognito Essentials (MFA optional later without plan migration). Confirm at implement if pricing/features change."
    blocking: false
    status: open
    owner: architect
  - id: email-sender
    question: "Recommend SES noreply@galaxyclass.app via UserPoolEmail.withSES. Verify galaxyclass.app in SES during implement."
    blocking: false
    status: open
    owner: architect
  - id: cross-game-session
    question: "Defer subdomain handoff. This initiative stores Amplify session on parent domain galaxyclass.app only; *.galaxyclass.app token sharing waits for Riffle integration initiative."
    blocking: false
    status: deferred
    owner: architect
  - id: anonymous-upgrade
    question: "Defer to Riffle follow-up initiative — can anonymous players upgrade to Galaxy Class account while keeping history?"
    blocking: false
    status: deferred
    owner: po
---

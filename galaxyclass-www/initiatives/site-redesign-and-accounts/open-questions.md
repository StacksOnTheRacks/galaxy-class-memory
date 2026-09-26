---
doc: product.open_questions
schema_version: 1
updated: 2026-09-26
questions:
  - id: riffle-subpath-routing
    question: "galaxyclass.app/riffle/* served via /riffle/* CloudFront behavior on GalaxyClassSite-prod → Riffle S3 origin (bucket from SSM /galaxyclass/riffle/play-origin-bucket, written by riffle-poker). Riffle SPA basePath /riffle. galaxyclass-www owns distribution + behavior; riffle-poker owns origin bucket + SPA. Same origin; Riffle does not read Amplify storage; token handoff deferred."
    blocking: false
    status: answered
    owner: architect
  - id: figma-bind-vs-code
    question: "Bind a Figma file for galaxyclass-www before Ready for user-facing tickets (#5, #6). Bound to Galaxy-Class-Web (0ByUrA0pS5qXyzcUsDstby). Figma is SoT for #5 and #6."
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
    question: "Cognito Essentials locked for HLD exit (MFA optional later without plan migration)."
    blocking: false
    status: answered
    owner: architect
  - id: email-sender
    question: "SES noreply@galaxyclass.app via UserPoolEmail.withSES locked for HLD exit; verify galaxyclass.app in SES during implement."
    blocking: false
    status: answered
    owner: architect
  - id: cross-game-session
    question: "Defer token handoff. Riffle at /riffle is same-origin but does not consume Amplify session; explicit token sharing waits for Riffle integration initiative."
    blocking: false
    status: deferred
    owner: architect
  - id: anonymous-upgrade
    question: "Defer to Riffle follow-up initiative — can anonymous players upgrade to a Galaxy Class account while keeping history?"
    blocking: false
    status: deferred
    owner: po
---

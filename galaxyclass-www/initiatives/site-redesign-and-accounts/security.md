---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-26
summary: "Static untrusted SPA plus Cognito as auth boundary. Custom UI sends credentials over TLS to Cognito via Amplify SRP; no backend Lambda in v1. Play-chip social positioning only — no real money or KYC on the studio site."
threats:
  - "XSS on static origin stealing Amplify/Cognito tokens from browser storage"
  - "Weak password policy allowing easily guessed credentials"
  - "Credential stuffing and brute-force against sign-in"
  - "S3 bucket public list/write or misconfigured OAC exposing write access"
  - "Over-privileged GitHub OIDC deploy role beyond S3/CloudFront/Route53/Cognito/ACM for these stacks"
  - "Verification or reset email spoofing if SES domain is not verified"
  - "CSP bypass allowing injected scripts on the static site"
  - "Account enumeration via distinct sign-up or sign-in error messages"
  - "Session fixation or failure to clear session on sign-out"
mitigations:
  - "Strict CSP and security headers on CloudFront (HSTS, frame-ancestors, baseline script-src)"
  - "Cognito password policy: min 8 chars, upper, lower, number"
  - "Rely on Cognito built-in rate limiting; generic auth error copy where feasible"
  - "S3 block all public access; CloudFront OAC as sole read path"
  - "OIDC deploy role least-privilege scoped to galaxyclass-www stacks and artifact bucket"
  - "SES verified galaxyclass.app domain for noreply@galaxyclass.app sender"
  - "No AWS secrets or client secrets in the static bundle — public pool ID and client ID only"
  - "HTTPS only; redirect HTTP to HTTPS at CloudFront"
  - "Sign-out clears Amplify session and local auth state"
  - "Email verification required before full account access"
requirements:
  - "Custom UI only — no Cognito Hosted UI or OAuth redirect surface at launch"
  - "No PII beyond email stored in the static artifact"
  - "MFA and passkeys deferred — document as later hardening on Essentials plan"
  - "No real-money, cashier, or KYC flows on galaxyclass.app"
  - "Riffle and game subdomains must not trust studio-site tokens until explicit integration initiative"
open_questions: []
---

Deploy-time SES domain verification and initial ACM DNS validation are operator-sensitive steps; least-privilege OIDC role must not grant blanket account access. Token storage follows Amplify defaults (browser storage); XSS remains the primary client-side risk — CSP and dependency hygiene are release gates.

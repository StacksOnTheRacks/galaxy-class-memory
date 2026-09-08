---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-07
summary: "HLD security for site reskin, GET /v1/rooms/mine, and Load Media. No new trust boundaries; fan JWT host authority and ADR-001 extension bind unchanged."
threats:
  - "GET /v1/rooms/mine IDOR — caller enumerates or reads another host's private room metadata"
  - "Load Media PATCH by non-host — guest or wrong fan mutates catalogEpisodeId"
  - "Global search dropdown surfaces non-public catalog rows (custom-host, live source rows, staff-only buckets)"
  - "Extension bridge invoked from unbound party tab or wrong origin navigates media tab without host authority"
  - "Your Parties response leaks hostSub or internal Dynamo keys"
  - "Open redirect or javascript: URL via Load Media new-tab path if URL resolution is loosened"
mitigations:
  - "GET /v1/rooms/mine requires fan JWT; query HostSubRoomsIndex with hostSub = JWT.sub only; never accept hostSub from client; response DTO omits hostSub and internal keys; exclude live-* system rooms"
  - "Load Media apply uses existing PATCH /v1/rooms/{roomId} gate (JWT.sub === room.hostSub); body { catalogEpisodeId } only; 403 for non-host"
  - "Global search v1 filters with same client rules as public browse (catalogEntriesVisibleInPublicBrowse + channel filters); no private room titles in search results"
  - "Extension: preserve C1 bind (/room/:roomId on https://riffsync.tv or localhost dev origin); unbound refuses PATCH navigate and JWT request; resolveHostSourceTabUrl stays HTTPS/lawful origins only"
  - "Load Media new-tab and extension paths both use resolveHostSourceTabUrl — no arbitrary URL paste in Load Media v1 (catalog picker only; pasted URLs remain Next Up / existing host console paths if retained)"
  - "Rate-limit /v1/rooms/mine consistent with other authenticated reads; no cross-host batch endpoints"
requirements:
  - "GET /v1/rooms/mine MUST require a valid fan Cognito JWT and MUST return only rooms where hostSub equals JWT.sub"
  - "GET /v1/rooms/mine MUST NOT return system Live rooms (live-* roomIds) as owned host parties"
  - "GET /v1/rooms/mine response MUST NOT include hostSub or Dynamo internal attributes"
  - "Load Media room mutation MUST use authenticated host PATCH with body { catalogEpisodeId } only"
  - "Non-host PATCH attempts MUST return 403 and MUST NOT navigate the extension media tab as success"
  - "Global search v1 MUST NOT surface catalog rows excluded from public browse policy"
  - "Extension media-tab open/navigate MUST remain bound to the active party tab per ADR-001 C1"
  - "Load Media MUST NOT introduce extension capture, tabCapture, or host_screen from extension APIs"
  - "Reskin MUST NOT remove or bypass existing security checklist items for host bridge, room PATCH, or SFU token gates"
open_questions: []
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

HLD security for site-redesign. Primary new surface is `/v1/rooms/mine` (read IDOR). Load Media consolidates existing host PATCH + extension navigate — no new server trust boundary if implementation keeps catalog-only selection and existing URL resolver. Residual: compromised fan JWT still mutates only that fan's hosted rooms (accepted MVP model). LLD tickets must carry sliced security AC from this doc in forge-tech-spec comments at refinement.

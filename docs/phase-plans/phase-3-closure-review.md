# Phase 3 Closure Review

Phase 3 is complete from the Person B workflow-surface side when the evidence
and claim layer is understandable, auditable, and bounded.

## Completed Workflow Surface

Phase 3 defines this path:

```text
source packet anchor
-> evidence selection
-> claim candidate
-> supported, contested, unsupported, stale, or needs-review
-> wiki construction and compare gate handoff
```

Completed Person B outputs:

- main Phase 3 plan in `docs/phase-plans/phase-3-evidence-claim-workflow.md`
- source-packet-to-evidence rule
- evidence-to-claim rule
- claim review routing rule
- workspace claim/evidence map template
- workspace review queue template
- claim-audit tool behavior prose
- updates to distillation and wiki handoff rules

## Design Review

| Design principle | Phase 3 result |
| --- | --- |
| VSCode/Git-first | All Phase 3 surfaces are plain repo-local Markdown files and templates. |
| Agent-first | Rules state inputs, outputs, forbidden shortcuts, review triggers, and handoff behavior. |
| Portable | No Obsidian, desktop app, hosted API, GPU, MCP, or extractor dependency is required. |
| Incremental | Claims are extracted from selected packet anchors during planned rounds, not all at once. |
| Avoid model self-evaluation | Important claims need evidence anchors or review routing; agents cannot accept unsupported claims by self-judgment alone. |
| Raw-wiki alignment | Claims cite `<source_id>#<anchor_id>` evidence so later wiki pages can be checked against source packets. |
| Artifact economy | Claim/evidence maps are concise audit reports, not second source packets or second wiki pages. |
| Source/chapter default | Phase 3 keeps chapter-oriented wiki construction as the default reading path. |
| Generated-content visibility | OCR, captions, chart summaries, table repairs, formula recognition, and agent notes remain visible and can trigger review. |
| Person A/B boundary | Schema and validator needs are listed as handoff proposals; `contracts/schemas/**` remains unchanged. |

## Review Findings

1. Phase 3 should not create a large default `claims/` or `evidence/` reading
   tree yet.

   Reason: for large document and PPT corpora, source and chapter pages remain
   the primary knowledge surface. Claim/evidence artifacts are better treated
   as reports or generated audit maps until tools and compare gates stabilize.

2. Claim extraction must be selective.

   Reason: extracting every sentence as a claim creates noise and weakens
   readability. Phase 3 defines claims as reusable, checkable knowledge
   statements that affect later wiki, compare, review, or executable work.

3. Generated evidence can be useful but should not silently become source
   truth.

   Reason: this preserves the Phase 2 generated-field boundary and prevents
   agent-generated captions or summaries from becoming unsupported wiki claims.

4. The current schema drafts are sufficient as read-only reference but need
   Person A hardening before tool validation.

   Reason: Person B workflow needs include claim type, generated-evidence
   provenance, review linkage, and stricter support checks.

## Person A Handoff

Recommended Person A review areas:

- evidence record support for source references in `<source_id>#<anchor_id>`
  form
- claim record support for `claim_type` or equivalent workflow category
- generated-evidence provenance on evidence or claim records
- `review_item` linkage to `evidence_ids`
- validator rule: `supported` claims require at least one evidence reference
- validator rule: generated-evidence claims require review state or accepted
  review decision
- fixture: direct text claim from a source packet anchor
- fixture: OCR or caption-derived claim routed to review
- fixture: contested claim with two source packet anchors
- fixture: unsupported claim that cannot pass claim audit

## Remaining Non-Goals

Phase 3 closure does not start:

- raw source conversion
- source packet generation
- schema implementation
- validator implementation
- fixture creation
- wiki page generation
- compare gate implementation
- downstream executable `skill + tool` work

## Next Phase Boundary

The next Person B workflow phase should be Phase 4: wiki construction.

Phase 4 should consume source packets and the Phase 3 claim/evidence layer to
define how source and chapter pages are created or updated. It should keep the
default wiki readable by agents and humans, preserve source/chapter structure,
and use claim/evidence records as traceability support rather than as the
primary reading surface.

# First Round Plan

## Goal

Describe the first document/PPT corpus distillation target in one paragraph.
The goal should be small enough to finish and commit.

## Corpus Scope

- Raw sources in scope:
- Source groups or deck sections in scope:
- Sources intentionally out of scope:

## Expected Outputs

- Source inventory:
- Source packets:
- Claim/evidence map:
- Wiki construction analysis:
- Wiki overview or overview update:
- Source pages:
- Chapter pages:
- Reports or validation notes:

## Round Steps

1. Check `git status --short --branch`.
2. Confirm `purpose.md` and `schema.md` are usable for this corpus.
3. Add or verify raw files under `raw/sources/`.
4. Write or update the source inventory.
5. Create source packets with stable anchors.
6. Map important source-backed claims to packet anchors when claims are in
   scope.
7. Route generated-derived, unsupported, contested, or judgment-heavy claims to
   review.
8. Apply page routing for overview, source pages, chapter pages, reports, and
   optional synthesis/research pages.
9. Write wiki construction analysis with create/update/merge/report-only
   decisions.
10. Create or update `wiki/overview.md` and `wiki/index.md`.
11. Write source and chapter pages from source packets and accepted
   claim/evidence context.
12. Record validation in `reports/`.
13. Update `wiki/log.md` and `plan/log.md`.
14. Commit the accepted round.

## Validation

- Source inventory has stable `source_id` values.
- Each processed source has a source packet or an explicit extraction gap.
- Important claims cite source packet anchors in `<source_id>#<anchor_id>` form
  or appear in the review queue.
- Wiki construction analysis records routing decisions and target page actions.
- Wiki pages cite source packet anchors, evidence records, or review items when
  they contain source-backed claims.
- `wiki/index.md` links every accepted page.
- `wiki/log.md` records created, updated, merged, deferred, or unchanged pages.
- Compare status is recorded as `compare gate not enabled` unless a real
  compare check exists.

## Review Items

- Open extraction gaps:
- Unsupported or weak claims:
- Human decisions needed:

## Commit Intent

Commit with message:

```text
Complete first workspace distillation round
```

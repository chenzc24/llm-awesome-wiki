# Claim Audit Tool

Future tool family for checking whether important claims remain traceable to
source packet evidence.

This is a construction tool surface. It is not implemented in Phase 3 and it is
not a downstream domain `skill + tool` artifact.

## Purpose

Answer:

```text
Do important claims cite evidence, and does unresolved judgment stay visible?
```

## Intended Inputs

- claim/evidence maps under `reports/review/`
- claim records when the workspace uses structured records
- evidence records or source references in `<source_id>#<anchor_id>` form
- wiki pages that list `claim_ids` or source-backed claims
- review queue reports

## Intended Outputs

- claim audit report
- unsupported claim list
- generated-evidence claim list
- contested or stale claim list
- review items that must carry forward

## Minimum Future Behavior

- read claim/evidence maps or structured claim records
- require at least one evidence link for `supported` claims
- flag claims whose evidence is generated-derived and lacks review state
- flag unsupported, stale, contested, or missing-evidence claims
- keep human review separate from deterministic validation
- avoid rewriting wiki pages directly

## Status Meanings

- `pass`: every in-scope supported claim has evidence and no blocking review.
- `fail`: required evidence links are missing, malformed, or contradicted.
- `needs-review`: evidence exists but human judgment is required.

## Non-Goals

The claim-audit tool should not:

- extract claims from raw files
- create source packets
- decide semantic truth by model self-evaluation
- resolve contested claims without review
- generate final wiki prose

Phase 3 defines this behavior prose only. Implementation, validators, schemas,
and fixtures belong to later coordinated work.

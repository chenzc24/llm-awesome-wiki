# Phase 6.5 Report Surface Checker

Phase 6.5 validates the Markdown report surfaces that carry compare, review,
claim/evidence, and validation-note state across distillation rounds.

It checks report structure and obvious status consistency. It does not decide
semantic truth, extract claims, rewrite reports, or close rounds.

## Scope

Phase 6.5 owns:

- `report-check command`
- `workspace-check --mode reports` integration
- compare report section and check-matrix validation
- claim/evidence map table validation
- review queue lifecycle and blocking-level validation
- validation-note status and closure-field validation

Phase 6.5 does not own:

- semantic claim review
- automatic claim extraction from wiki pages
- compare report generation
- review queue resolution
- round closure decisions
- wiki page generation
- downstream `skill + tool` generation

## Deterministic Checks

`report-check` should fail when:

- a classified report is missing required sections
- a compare report status is outside `pass`, `fail`, or `needs-review`
- a compare check result/category/blocking value is invalid
- compare status `pass` conflicts with failed, review-required, not-enabled, or
  blocking checks
- `compare gate not enabled` is paired with `pass`
- a claim/evidence map has malformed source refs
- a supported claim has no evidence IDs
- review queue lifecycle status or blocking level is invalid
- blocking carried-forward review does not block pass
- validation note closure decision is invalid
- `close-pass` is used without compare `pass`

## Review Findings

`report-check` should return `needs-review` when the report surface is
structurally usable but unresolved judgment remains visible:

- no relevant report files exist yet
- claim/evidence rows still look like placeholders
- weak, unsupported, contested, generated-derived, needs-review, or stale
  claims do not yet route clearly to review item IDs
- active review items have placeholder decision text

## Workspace Integration

`workspace-check --mode reports` invokes:

```text
report-check
```

`workspace-check --mode all` runs schema, source, wiki, and report checks, then
reports round closure and fixture validation as not implemented until their
phases land.

## Completion Criteria

Phase 6.5 is complete when:

- the Phase 6.5 phase plan exists
- `report-check command` exists and emits Phase 6 reports and exit codes
- `workspace-check --mode reports` invokes report checking
- README and Phase 6 docs describe checker-only behavior
- a temporary smoke workspace with compare, claim/evidence, review queue, and
  validation-note reports passes `report-check` and `workspace-check --mode
  reports`
- no claim extraction, semantic truth resolution, or round closure automation is
  introduced

## Next Phase

Phase 6.6 should validate round closure decisions across compare, review,
validation note, index, overview, and wiki log state.

# Phase 5.1 Compare Report Foundation

Phase 5.1 starts the compare gate and review workflow by defining the default
round-level compare report.

This stage answers: what must a compare report contain before it can be used as
a quality gate?

## Scope

Phase 5.1 owns:

- report purpose and audience
- default report path
- required report sections
- status semantics
- check categories
- carried-forward review requirements
- validation-note integration
- report template placement

Phase 5.1 does not own:

- source coverage algorithms
- claim coverage algorithms
- link checker implementation
- schema or validator changes
- fixtures
- wiki page rewrites
- downstream executable artifacts

## Report Position

The compare report sits after wiki construction and before round advancement:

```text
wiki construction analysis
-> accepted wiki page changes
-> overview, index, and log maintenance
-> compare report
-> validation note
-> review resolution, commit, or next round
```

The report consumes accepted workspace artifacts. It should not silently edit
those artifacts.

## Default Report Path

Use:

```text
reports/compare/<round-id>-compare-report.md
```

For a very small workspace, the report can be a single file. For a larger
workspace, it may link to detailed reports under `reports/coverage/`,
`reports/lint/`, or `reports/review/`, but the compare report remains the
round decision surface.

## Required Sections

A default compare report should include:

- round scope
- status summary
- input artifacts
- check matrix
- source coverage
- source packet and anchor coverage
- wiki page coverage
- claim coverage
- modality coverage
- link, index, overview, and log checks
- omissions and weak coverage
- contradictions and unsupported statements
- review items
- carried-forward review
- decision and next actions

## Check Categories

Use these categories:

- `deterministic`: a mechanical check can decide, even if the tool is not
  implemented yet.
- `manual-protocol`: a human or agent follows a fixed checklist and records
  evidence.
- `human-review`: semantic judgment is required.

If a check is not implemented yet, say so. Do not convert missing automation
into `pass`.

## Status Rules

`pass` requires:

- all required artifacts for the round are present
- deterministic or manual-protocol checks in scope pass
- important wiki claims have source anchors, claim/evidence support, or
  accepted review decisions
- no blocking review item remains
- carried-forward nonblocking review items have a reason, owner or next action,
  and target round or condition

`needs-review` means:

- required artifacts are present
- no blocking structural failure prevents review
- at least one semantic or generated-content issue needs human judgment
- the review queue records the issue, source reference, decision needed, and
  next action

`fail` means:

- required artifacts are missing
- source coverage, claim coverage, index integrity, link integrity, or report
  structure is materially broken
- an important wiki claim has no source support and no review routing
- a generated interpretation is treated as source-derived truth
- the report cannot justify the status it records

## Anti-Self-Evaluation Rules

- Do not write `pass` because an agent says the wiki looks complete.
- Do not write `pass` when the compare gate is not enabled.
- Do not clear review items without a recorded decision.
- Do not turn generated chart, image, OCR, or table interpretations into
  source-derived evidence without review.
- Do not silently rewrite wiki pages as part of compare. Create findings and
  next actions instead.

## Person A Handoff

Potential Person A needs after Phase 5.1:

- compare report schema
- status enum and check category enum
- required table shapes for source coverage, claim coverage, modality coverage,
  link/index checks, and review items
- validator rule that `pass` cannot coexist with blocking findings
- validator rule that carried-forward review items require reason and next
  action
- fixture for `compare gate not enabled` in a validation note
- fixture for generated chart summary routed to `needs-review`

Person B should keep this as workflow prose until Person A accepts schema and
validator ownership.

## Completion Criteria

Phase 5.1 is complete when:

- `rules/compare-gate-contract.md` defines report shape and status semantics
- `templates/workspace-kernel/reports/compare-report.template.md` exists
- report README points to compare reports as the default decision surface
- review queue and validation note templates can carry compare findings forward
- the main Phase 5 plan lists later coverage, claim, modality, review, and
  closure subphases

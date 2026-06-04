# Compare Gate Contract

The compare gate checks whether distilled wiki knowledge still aligns with the
source material, source packet anchors, claim/evidence records, and review
state.

It is a construction quality gate. It is not a wiki rewrite step, not a
downstream `skill + tool` generator, and not a model self-evaluation prompt.

This rule owns the compare report decision surface and the `pass`, `fail`, and
`needs-review` meanings. Specialized semantics are owned by these modules:

- source/wiki coverage: `source-wiki-coverage-protocol.md`
- claim support, generated evidence, modality, unsupported statements, and
  contradictions: `claim-modality-contradiction-review-protocol.md`
- review item lifecycle and blocking levels: `review-queue-workflow.md`
- round closure decisions: `round-closure-workflow.md`

## Purpose

The gate should make round quality visible.

It should answer:

- what was in scope for this round?
- which source packets and anchors were checked?
- which wiki pages changed or were inspected?
- which important claims have source or evidence support?
- which modalities were extracted, generated, skipped, or deferred?
- which links, index entries, overview notes, or log entries are stale?
- which omissions, contradictions, unsupported statements, or review items
  block advancement?
- may the round advance as `pass`, `fail`, or `needs-review`?

## Gate Inputs

- round plan
- source inventory
- source packets and packet metadata
- source packet anchors
- claim and evidence records when available
- wiki construction analysis
- current wiki pages
- `wiki/overview.md`
- `wiki/index.md`
- `wiki/log.md`
- current review queue
- validation note from the round

If an expected input does not exist yet, the report must record that fact. Do
not treat a missing input as implicitly passing.

## Gate Outputs

The gate writes one default decision report:

```text
reports/compare/<round-id>-compare-report.md
```

The report may link to detailed coverage, lint, claim-audit, or review reports,
but the compare report remains the round decision surface.

The report should include:

- round scope
- status summary
- input artifacts
- check matrix
- source coverage
- source packet and anchor coverage
- wiki page coverage
- anchor disposition
- claim coverage
- modality coverage
- scope exclusions
- link, index, overview, and log checks
- omissions and weak coverage
- contradictions and unsupported statements
- review items
- carried-forward review
- decision and next actions

## Check Categories

Each check should declare one category:

- `deterministic`: a mechanical check can decide, even if the tool is not
  implemented yet.
- `manual-protocol`: a human or agent follows an explicit checklist and records
  evidence.
- `human-review`: semantic judgment is required.

Use these categories to avoid pretending that a model summary is deterministic
validation.

## Status Semantics

Use only:

- `pass`
- `fail`
- `needs-review`

`pass` means:

- required artifacts for the round are present
- deterministic or manual-protocol checks in scope pass
- important wiki claims have source anchors, claim/evidence support, or
  accepted review decisions
- no blocking review item remains
- carried-forward nonblocking review items have a reason, owner or next action,
  and target round or condition

`needs-review` means:

- required artifacts are present
- no blocking structural failure prevents review
- at least one semantic, generated-content, modality, omission, or
  contradiction issue needs human judgment
- review queue items record the source reference, affected target, decision
  needed, and next action

`fail` means:

- required artifacts are missing
- source coverage, claim coverage, index integrity, link integrity, or report
  structure is materially broken
- an important wiki claim has no source support and no review routing
- generated or model-assisted interpretation is treated as source-derived truth
- unresolved blocking review is missing from the review queue
- the report cannot justify the status it records

`compare gate not enabled` is not `pass`.

Model self-evaluation is not `pass`.

## Minimum Checks

Every compare report should address these checks, even when the result is
`not-enabled`, `not-in-scope`, or `needs-review`:

- source inventory exists or missing state is recorded
- source packets in the round exist or missing state is recorded
- source packet anchors in scope are listed or coverage gaps are recorded
- processed source packets are represented in source pages, chapter pages,
  explicit omissions, or review items
- important wiki claims cite source anchors, claim/evidence records, accepted
  review decisions, or review items
- generated OCR, captions, chart summaries, table repairs, formula recognition,
  and visual descriptions are marked
- skipped or unsupported modalities are listed
- `wiki/index.md` links for accepted pages resolve or failures are listed
- `wiki/overview.md` refresh status is recorded
- `wiki/log.md` update status is recorded
- unresolved review items are listed, resolved, or carried forward
- report status is one of `pass`, `fail`, or `needs-review`

## Delegated Semantics

Coverage does not mean every source sentence becomes wiki prose. It means the
report can explain what happened to source material. Follow
`source-wiki-coverage-protocol.md` for coverage units, disposition values,
importance values, omission reasons, source coverage tables, anchor disposition
tables, wiki page coverage tables, and coverage status impact.

Important claims in scope must have support, review routing, or explicit
not-in-scope status. Follow
`claim-modality-contradiction-review-protocol.md` for claim support statuses,
generated evidence states, modality states, unsupported statement findings,
contradiction findings, and claim/modality status impact.

Review items keep unresolved judgment visible across rounds. Follow
`review-queue-workflow.md` for lifecycle states, blocking levels, required
review item fields, opening or updating review items, resolution, dismissal,
carry-forward, stale review, and re-entry.

For document and PPT corpora, preserve the source/chapter default. Do not use
compare findings as a reason to create fragmented concept/entity pages unless
the workspace explicitly needs them.

## Anti-Self-Evaluation Rule

The agent may summarize compare findings, but it must not be the only judge of
coverage quality.

Prefer:

- source-to-wiki tables
- claim-to-source tables
- explicit missing coverage lists
- modality coverage notes
- link/index checks
- human review queues

Avoid:

- "looks complete" as status evidence
- model-only coverage judgments
- deleting claims without a recorded reason
- silently rewriting wiki pages from compare findings

## Non-Goals

- Do not generate domain skills or tools.
- Do not silently rewrite wiki pages.
- Do not delete claims without recording the source and reason.
- Do not require Obsidian or graph visualization.
- Do not treat the compare report as a final synthesis page.

## Acceptance Rule

A distillation round may advance only when:

- compare status is `pass`, or
- compare status is `needs-review` and the plan explicitly allows advancing
  with carried-forward review items, each with a reason and next action.

A round with compare status `fail` must not advance until the blocking findings
are fixed or the scope is changed and logged.

A round with `blocking` carried-forward review must not advance as `pass`.

## Round Closure Integration

Compare status is an input to round closure. It is not the whole closure
decision.

Follow `round-closure-workflow.md` after a compare report is produced:

- compare `pass` can support `close-pass` only when validation note, index,
  overview, wiki log, and review state are also acceptable
- compare `needs-review` can support `close-with-review` only when carried
  review items have reason, owner or next action, target round or condition,
  and blocking level
- compare `fail` maps to `do-not-close` unless the scope is changed and logged
- `compare gate not enabled` cannot support `close-pass`

The compare report should hand off:

- final compare status
- blocking findings
- review items to resolve
- review items carried forward
- active report or review queue links
- required fixes before closure

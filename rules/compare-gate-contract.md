# Compare Gate Contract

The compare gate checks whether distilled wiki knowledge still aligns with the
source material, source packet anchors, claim/evidence records, and review
state.

It is a construction quality gate. It is not a wiki rewrite step, not a
downstream `skill + tool` generator, and not a model self-evaluation prompt.

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
- claim coverage
- modality coverage
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

## Coverage Expectations

Coverage does not mean every source sentence becomes wiki prose.

Coverage means the report can explain what happened to source material:

- represented in a source page
- represented in a chapter page
- represented in optional synthesis or research page
- preserved only in source packet
- omitted intentionally
- deferred to a later round
- routed to review
- blocked by extraction or modality gap

For document and PPT corpora, preserve the source/chapter default. Do not use
compare findings as a reason to create fragmented concept/entity pages unless
the workspace explicitly needs them.

## Review Rules

Carried-forward review items must include:

- review item id
- source references when available
- affected wiki or report target
- reason for carry-forward
- blocking level
- owner or next action
- target round or condition for resolution

Do not silently clear review items.

Do not convert unresolved semantic judgment into `pass`.

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

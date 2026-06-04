# Compare Gate Contract

The compare gate checks whether distilled wiki knowledge still aligns with
source material, source packet anchors, claim/evidence records, and review
state.

This rule owns the compare decision surface and `pass`, `fail`, and
`needs-review` meanings. It is not a wiki rewrite step, downstream
`skill + tool` generator, or model self-evaluation prompt.

Specialized semantics are delegated to:

- source/wiki coverage: `source-wiki-coverage-protocol.md`
- claim support, generated evidence, modality, unsupported statements, and
  contradictions: `claim-modality-contradiction-review-protocol.md`
- review lifecycle and blocking levels: `review-queue-workflow.md`
- round closure decisions: `round-closure-workflow.md`

## Minimum Path

```text
round artifacts
-> compare report
-> pass, fail, or needs-review
-> closure decision
```

## Gate Questions

The compare report should answer:

- what was in scope?
- which source packets and anchors were checked?
- which wiki pages changed or were inspected?
- which important claims have source or evidence support?
- which modalities were extracted, generated, skipped, or deferred?
- which links, index entries, overview notes, or log entries are stale?
- which omissions, contradictions, unsupported statements, or review items
  block advancement?
- may the round advance as `pass`, `fail`, or `needs-review`?

## Inputs

- round plan
- source inventory
- source packets, metadata, and anchors
- claim and evidence records when available
- wiki construction analysis
- current wiki pages
- `wiki/overview.md`
- `wiki/index.md`
- `wiki/log.md`
- current review queue
- validation note from the round

If an expected input is missing, record that fact. Missing input is not an
implicit pass.

## Output

Default report path:

```text
reports/compare/<round-id>-compare-report.md
```

The compare report is the round decision surface. It may link detailed
coverage, lint, claim-audit, or review reports.

Minimum report sections:

- round scope
- status summary
- input artifacts
- check matrix
- source and anchor coverage
- wiki page coverage
- claim and modality coverage
- link, index, overview, and log checks
- omissions, contradictions, unsupported statements, and weak coverage
- review items and carried-forward review
- decision and next actions

## Check Categories

Each check should declare one category:

- `deterministic`: mechanical check can decide, even if tooling is not
  implemented yet
- `manual-protocol`: human or agent follows an explicit checklist and records
  evidence
- `human-review`: semantic judgment is required

These categories prevent model summaries from pretending to be deterministic
validation.

## Status Semantics

Use only:

- `pass`
- `fail`
- `needs-review`

`pass` means required artifacts are present, deterministic or manual-protocol
checks pass, important claims have support or accepted review, no blocking
review remains, and any nonblocking carried-forward review has reason, owner or
next action, and target round or condition.

`needs-review` means required artifacts are present and structurally reviewable,
but semantic, generated-content, modality, omission, or contradiction issues
need human judgment with explicit review queue state.

`fail` means required artifacts are missing or materially broken, important
claims lack support and review routing, generated interpretation is treated as
source-derived truth, blocking review is not visible, or the report cannot
justify its status.

`compare gate not enabled` is not `pass`. Model self-evaluation is not `pass`.

## Minimum Checks

Every compare report should address these, even as `not-enabled`,
`not-in-scope`, or `needs-review`:

- source inventory exists or missing state is recorded
- round source packets exist or missing state is recorded
- in-scope anchors are listed or coverage gaps recorded
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

For document/PPT corpora, preserve the source/chapter default. Do not use
compare findings to create fragmented concept/entity pages unless the workspace
explicitly needs them.

## Anti-Self-Evaluation Rule

Prefer source-to-wiki tables, claim-to-source tables, missing coverage lists,
modality notes, link/index checks, and human review queues.

Avoid "looks complete" as status evidence, model-only coverage judgments,
deleting claims without a recorded reason, or silently rewriting wiki pages
from compare findings.

## Non-Goals

- Do not generate domain skills or tools.
- Do not silently rewrite wiki pages.
- Do not delete claims without recording source and reason.
- Do not require Obsidian or graph visualization.
- Do not treat the compare report as final synthesis.

## Acceptance Rule

A distillation round may advance only when:

- compare status is `pass`, or
- compare status is `needs-review` and the plan explicitly allows advancement
  with carried-forward review items, each with reason and next action.

A `fail` round must not advance until blocking findings are fixed or scope is
changed and logged. A round with `blocking` carried-forward review must not
advance as `pass`.

## Round Closure Integration

Compare status is an input to closure, not the whole closure decision. Follow
`round-closure-workflow.md`.

- compare `pass` can support `close-pass` only when validation note, index,
  overview, wiki log, and review state are acceptable
- compare `needs-review` can support `close-with-review` only when carried
  review has reason, owner or next action, target round or condition, and
  blocking level
- compare `fail` maps to `do-not-close` unless scope is changed and logged
- `compare gate not enabled` cannot support `close-pass`

The compare report should hand off final status, blocking findings, review
items to resolve or carry forward, active report links, and required fixes
before closure.

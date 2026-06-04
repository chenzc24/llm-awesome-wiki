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

For detailed source/wiki coverage semantics, follow
`source-wiki-coverage-protocol.md`.

For claim, generated evidence, modality, unsupported statement, and
contradiction review semantics, follow
`claim-modality-contradiction-review-protocol.md`.

For review queue lifecycle and carried-forward semantics, follow
`review-queue-workflow.md`.

## Disposition Values

Use these source/wiki coverage dispositions:

| disposition | meaning |
| --- | --- |
| `covered` | represented in accepted wiki pages or reports at the right level of detail |
| `weak` | represented, but too shallow, overgeneralized, poorly sourced, or risky |
| `deferred` | intentionally left for a later planned round |
| `omitted` | intentionally excluded from wiki construction for a recorded reason |
| `out-of-scope` | outside the round's fixed input or workspace purpose |
| `review` | routed to human review before wiki acceptance |
| `blocked` | cannot be judged because required input, extraction, anchor, or context is missing |

Do not use `covered` merely because content exists in `source.md`. The compare
gate checks source-to-wiki alignment, not packet existence alone.

## Omission And Scope Rules

An omitted or out-of-scope source unit needs a reason.

Acceptable omission reasons include:

- `decorative`
- `duplicate`
- `out-of-scope`
- `low-value`
- `deferred`
- `blocked`
- `superseded`

Unsafe omissions include:

- important source content omitted without reason
- source content omitted because the agent skipped it
- omitted chart, table, formula, or visual material that supports an accepted
  wiki claim
- generated interpretation kept while the source anchor is omitted
- omitted material that contradicts accepted wiki prose without review routing

Scope exclusions are allowed only when the round plan, workspace purpose, or
compare report says why the material is out of scope.

## Review Rules

Review items keep unresolved judgment visible across rounds.

Use these lifecycle states:

| status | meaning |
| --- | --- |
| `open` | decision still needed |
| `in-review` | owner or reviewer is actively deciding |
| `resolved` | decision recorded and affected artifacts updated or scheduled |
| `dismissed` | concern no longer applies and reason is recorded |
| `carried-forward` | unresolved but explicitly kept visible for a later round |
| `blocked` | cannot be resolved until another artifact or review exists |
| `stale` | previous decision may no longer be valid |

Use these blocking levels:

| blocking_level | meaning |
| --- | --- |
| `blocking` | affected round cannot advance as `pass` |
| `nonblocking` | round may advance only with explicit carry-forward reason and next action |
| `informational` | tracked context that does not affect advancement |

Carried-forward review items must include:

- review item id
- source references when available
- affected wiki or report target
- reason for carry-forward
- blocking level
- owner or next action
- target round or condition for resolution

Resolved review items must include a decision and affected artifacts.

Dismissed review items must include a dismissal reason.

Stale review items must re-enter compare when the affected source packet,
claim, wiki page, or review decision changes.

Do not silently clear review items.

Do not convert unresolved semantic judgment into `pass`.

## Claim And Modality Rules

Important claims in scope must have support, review routing, or explicit
not-in-scope status.

Use these claim support statuses:

| status | meaning |
| --- | --- |
| `supported` | cited evidence supports the actual claim wording |
| `weak` | evidence partially supports the claim or wording is too broad |
| `unsupported` | no cited evidence supports the claim |
| `contested` | sources, claims, or wiki sections disagree |
| `generated-derived` | claim depends on generated or model-assisted evidence |
| `reviewed-generated` | generated evidence was explicitly reviewed and accepted |
| `needs-review` | human judgment is required before acceptance |
| `not-in-scope` | outside this compare round |

Use these modality states:

| modality_state | meaning |
| --- | --- |
| `source-derived` | source-visible content is represented directly |
| `extracted-with-tool` | deterministic or named extraction produced the content |
| `generated` | model-assisted interpretation produced the content |
| `reviewed-generated` | generated content was reviewed and accepted |
| `skipped` | modality was intentionally skipped with reason |
| `failed` | extraction or interpretation failed visibly |
| `unsupported-or-unknown` | state is unclear or untrusted |

Generated-derived important claims require review routing or accepted review.
Do not treat generated chart summaries, OCR cleanup, table repairs, formula
recognition, or image captions as source-derived truth.

## Unsupported And Contradiction Rules

Unsupported statements and contradictions are compare findings, not silent edit
instructions.

Record unsupported statements when important wiki or claim-map statements lack
adequate support.

Record contradictions when accepted source anchors, claim records, wiki
sections, or review decisions cannot all remain true as written.

Contradiction types include:

- `source-vs-source`
- `source-vs-wiki`
- `claim-vs-claim`
- `wiki-vs-wiki`
- `generated-vs-source`
- `old-review-vs-new-source`

Do not choose a winner by model preference. Use an accepted source priority
rule or route to review.

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

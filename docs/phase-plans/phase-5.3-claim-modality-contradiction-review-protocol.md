# Phase 5.3 Claim Modality Contradiction Review Protocol

Phase 5.3 defines how compare reports record claim support, generated
evidence, modality coverage, unsupported statements, contradictions, and
semantic review routing.

This stage answers: when the wiki says something important, how does the
workspace show whether that statement is supported, generated-derived,
unsupported, contested, or requires human judgment?

## Scope

Phase 5.3 owns:

- claim support status in compare reports
- generated evidence handling in compare reports
- modality coverage review language
- unsupported statement recording
- contradiction recording
- semantic review routing fields needed by compare reports
- validation-note summary expectations for claim/modality/contradiction findings

Phase 5.3 does not own:

- claim extraction workflow redesign
- review queue workflow closure
- carried-forward review lifecycle details
- source/wiki coverage semantics from Phase 5.2
- link or frontmatter lint
- claim-audit CLI implementation
- compare CLI implementation
- schema or validator changes
- fixtures
- wiki page generation or rewriting

## Core Principle

Important wiki statements need support or review.

A statement is not safe just because it reads cleanly. The compare report
should distinguish:

- source-derived claims
- extracted-with-tool evidence
- generated evidence
- reviewed-generated evidence
- unsupported or unknown evidence
- contested claims
- semantic review needs

Generated evidence can be useful, especially for charts, images, OCR, formulas,
tables, and diagrams. It cannot silently become source-derived truth.

## Claim Support Questions

For each important claim in scope, the report should answer:

- where is the claim recorded?
- does the claim appear in a claim/evidence map?
- does the wiki page cite supporting source anchors?
- does the evidence support the actual wording of the claim?
- does the claim add values, causality, ordering, comparison, or interpretation
  not present in the source?
- does the claim depend on OCR, caption, chart summary, table repair, formula
  recognition, or agent notes?
- is the claim supported, weak, unsupported, contested, generated-derived, or
  routed to review?

Not every sentence needs a claim row. The compare report should focus on
important claims: definitions, formulas, procedures, design rules, parameter
values, comparisons, limitations, requirements, contradictions, and statements
with downstream engineering impact.

## Claim Support Status

Use these workflow statuses in compare reports:

- `supported`: cited evidence supports the actual claim wording
- `weak`: evidence exists but only partially supports the claim or needs
  narrower wording
- `unsupported`: no cited evidence supports the claim
- `contested`: sources or anchors disagree
- `generated-derived`: claim depends on generated or model-assisted evidence
- `reviewed-generated`: generated evidence was explicitly reviewed and accepted
  for the claim wording
- `needs-review`: human judgment is required before acceptance
- `not-in-scope`: claim is outside this compare round

Do not mark `generated-derived` as `supported` unless the review decision is
explicit.

## Modality Review

Modality coverage records whether non-plain-text source material has been
handled safely.

Relevant modalities include:

- text
- OCR text
- chart
- table
- image
- diagram
- formula
- code
- audio or video
- layout or reading order

Use modality states:

- `source-derived`: directly extracted or transcribed source-visible content
- `extracted-with-tool`: produced by a deterministic or named extraction tool
- `generated`: model-assisted caption, chart summary, formula reading, table
  repair, or visual interpretation
- `reviewed-generated`: generated output accepted by explicit review
- `skipped`: intentionally skipped with reason
- `failed`: extraction or interpretation failed visibly
- `unsupported-or-unknown`: state cannot be trusted yet

Important generated modality outputs should usually create review items unless
the workspace has an accepted review decision.

## Unsupported Statements

An unsupported statement is any important wiki or claim-map statement that lacks
adequate source, evidence, or review support.

Unsupported statements should record:

- statement id or page path
- claim id when available
- source references inspected
- why support is missing or insufficient
- whether wording can be narrowed
- whether the statement should be removed, revised, deferred, or reviewed
- status impact

Do not silently delete unsupported statements during compare. Record findings
and next actions.

## Contradictions

A contradiction exists when two or more source anchors, claims, wiki sections,
or review decisions cannot all be accepted as written.

Contradiction records should include:

- issue id
- conflicting claims, wiki pages, or source anchors
- conflict type
- source references on each side
- current wiki impact
- decision needed
- status impact
- next action

Conflict types may include:

- `source-vs-source`
- `source-vs-wiki`
- `claim-vs-claim`
- `wiki-vs-wiki`
- `generated-vs-source`
- `old-review-vs-new-source`

Do not choose a winner without review unless the round has an explicit accepted
source priority rule.

## Status Impact

Use `pass` only when important claims in scope are supported, accepted, or
nonblocking with explicit carry-forward.

Use `needs-review` when:

- claim support depends on generated evidence
- chart, table, formula, OCR, image, or diagram interpretation matters
- evidence partially supports the claim but wording might need narrowing
- sources disagree and a human decision is required
- a contradiction has no accepted resolution yet

Use `fail` when:

- an important wiki claim has no source support and no review item
- generated evidence is treated as source-derived truth
- unsupported statements appear in accepted wiki prose without review routing
- contradictions materially affect accepted wiki knowledge and are not recorded
- claim/evidence map is missing when important claims are in scope and no
  alternate support record exists

## Artifact Economy

The default compare report should carry claim, modality, and contradiction
findings. Do not create separate claim, modality, and contradiction reports by
default.

Create detailed reports only when:

- there are too many findings for one concise compare report
- a future deterministic tool produces claim or modality audit output
- multiple rounds need to share the same finding set
- the compare report links to the detailed report and keeps the final decision
  summary

## Person A Handoff

Potential Person A needs after Phase 5.3:

- claim support status enum
- modality state enum
- contradiction type enum
- unsupported statement table validation
- generated evidence validation in compare reports
- validator rule that `supported` claims include evidence or accepted review
- validator rule that `generated-derived` important claims require review
- validator rule that contradictions cannot coexist with `pass` unless they are
  resolved or explicitly nonblocking
- fixture for unsupported wiki claim
- fixture for generated chart summary routed to review
- fixture for reviewed-generated chart claim
- fixture for source-vs-source contradiction
- fixture for wiki claim narrowed after weak evidence

Person B should keep these as workflow needs until Person A accepts schema and
validator ownership.

## Completion Criteria

Phase 5.3 is complete when:

- the phase plan defines claim, modality, contradiction, and unsupported
  statement semantics
- a claim/modality/contradiction review rule exists
- compare gate rule includes claim support, generated evidence, modality, and
  contradiction semantics
- compare report template has explicit claim support, modality review,
  unsupported statement, and contradiction fields
- claim/evidence map and review queue templates can carry generated evidence
  and contradiction review handoff
- validation note template summarizes claim/modality/contradiction findings
- Phase 5 main plan identifies Phase 5.4 as the next review queue lifecycle
  target

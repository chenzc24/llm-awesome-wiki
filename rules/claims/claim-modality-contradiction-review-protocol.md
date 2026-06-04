# Claim Modality Contradiction Review Protocol

This rule defines how compare reports record claim support, generated evidence,
modality coverage, unsupported statements, and contradictions.

Use it during Phase 5 compare work after source/wiki coverage has identified
which source packets, anchors, and wiki pages are in scope.

This is a workflow protocol. It is not a claim-audit tool, schema, validator,
or wiki rewrite command.

## Purpose

The compare gate should prevent important wiki knowledge from advancing without
source support or review.

It should make these states visible:

- supported claims
- weak claims
- unsupported claims
- contested claims
- generated-derived claims
- reviewed-generated claims
- modality gaps
- contradictions
- semantic review needs

## Required Inputs

- compare report round scope
- source packet anchors
- claim/evidence map when important claims are in scope
- wiki pages changed or inspected by the round
- review queue when unresolved judgment exists
- generated fields and known gaps from packet metadata
- source/wiki coverage findings from `rules/wiki/source-wiki-coverage-protocol.md`

If a claim/evidence map is missing while important claims are in scope, record
that as a compare finding. Do not infer support from polished wiki prose.

## Important Claims

Focus compare effort on important claims, not every sentence.

Important claims include:

- definitions
- formulas
- parameter values
- procedures
- design rules
- comparisons
- limitations
- warnings
- requirements
- causal or mechanism statements
- statements that affect downstream engineering work

Contextual prose may remain out of the claim table unless it becomes important
for review, compare, or downstream execution.

## Claim Support Status

Use these statuses in compare reports:

| status | meaning |
| --- | --- |
| `supported` | cited evidence supports the actual claim wording |
| `weak` | evidence partially supports the claim or the wording is too broad |
| `unsupported` | no cited evidence supports the claim |
| `contested` | sources, claims, or wiki sections disagree |
| `generated-derived` | claim depends on generated or model-assisted evidence |
| `reviewed-generated` | generated evidence was explicitly reviewed and accepted |
| `needs-review` | human judgment is required before acceptance |
| `not-in-scope` | outside this compare round |

Do not use `supported` when evidence supports only a weaker or narrower claim.
Narrow the claim or route it to review.

## Generated Evidence States

Use generated evidence states consistently:

| generated_state | meaning |
| --- | --- |
| `source-derived` | directly visible or extracted source content |
| `extracted-with-tool` | produced by a deterministic or named extraction tool |
| `generated` | model-assisted caption, summary, repair, or interpretation |
| `reviewed-generated` | generated output accepted by explicit review |
| `unsupported-or-unknown` | provenance or support cannot be trusted yet |

Generated evidence may be useful, but important generated-derived claims need
review routing unless already accepted by explicit review.

## Modality States

Use modality states in compare reports:

| modality_state | meaning |
| --- | --- |
| `source-derived` | source-visible content is represented directly |
| `extracted-with-tool` | deterministic or named extraction produced the content |
| `generated` | model-assisted interpretation produced the content |
| `reviewed-generated` | generated content was reviewed and accepted |
| `skipped` | modality was intentionally skipped with reason |
| `failed` | extraction or interpretation failed visibly |
| `unsupported-or-unknown` | state is unclear or untrusted |

Relevant modalities include text, OCR text, chart, table, image, diagram,
formula, code, audio, video, and layout or reading order.

## Unsupported Statement Findings

Record an unsupported statement when an important wiki or claim-map statement
lacks adequate support.

Recommended fields:

| field | purpose |
| --- | --- |
| `item_id` | compare finding id |
| `statement_ref` | wiki path, heading, claim id, or generated note |
| `statement_summary` | concise statement being challenged |
| `source_refs_checked` | source anchors inspected |
| `support_gap` | missing, partial, generated-only, stale, or contradictory |
| `proposed_action` | revise, remove, narrow, review, defer, or add evidence |
| `status_impact` | `pass`, `needs-review`, `fail`, or `none` |

Do not silently delete unsupported statements during compare.

## Contradiction Findings

Record a contradiction when accepted statements cannot all remain true as
written.

Recommended fields:

| field | purpose |
| --- | --- |
| `issue_id` | compare finding id |
| `conflict_type` | contradiction category |
| `side_a` | first source, claim, wiki section, or review decision |
| `side_b` | second source, claim, wiki section, or review decision |
| `source_refs` | source anchors on each side when available |
| `wiki_impact` | affected wiki page or claim |
| `decision_needed` | human or rule decision needed |
| `status_impact` | `needs-review`, `fail`, or `none` |

Conflict types:

- `source-vs-source`
- `source-vs-wiki`
- `claim-vs-claim`
- `wiki-vs-wiki`
- `generated-vs-source`
- `old-review-vs-new-source`

Do not resolve contradictions by model preference. Use an accepted source
priority rule or route to review.

## Status Impact

Use `pass` only when important claims are supported, accepted by review, or
explicitly nonblocking.

Use `needs-review` when:

- generated evidence supports an important claim
- OCR, chart, table, formula, image, diagram, or layout interpretation matters
- claim wording is broader than evidence
- sources disagree
- contradiction resolution needs judgment
- modality state is `unsupported-or-unknown`

Use `fail` when:

- important claim has no support and no review item
- generated evidence is treated as source-derived truth
- unsupported statements remain accepted without review routing
- contradiction materially affects accepted wiki knowledge and is not recorded
- claim/evidence map is absent when the round has important claims and no
  alternate support record

## Acceptance Criteria

- important wiki claims in scope have claim support rows or explicit
  not-in-scope reasons
- generated-derived important claims route to review or accepted review
  decisions
- modality-dependent important claims record modality state
- unsupported statements are findings, not silent edits
- contradictions are visible and routed to review or accepted source priority
- compare status does not rely on model self-evaluation

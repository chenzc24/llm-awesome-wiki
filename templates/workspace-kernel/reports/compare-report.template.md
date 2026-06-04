# Compare Report

## Round Scope

- Round plan:
- Date:
- Compare report id:
- Status: `pass`, `needs-review`, or `fail`
- Distillation depth: `full-round`, `selective`, or `overview-only`
- Scope statement:
- Source packets in scope:
- Source range in scope:
- Out of scope:
- Scope exclusion reason:

## Status Summary

- Decision:
- Blocking findings:
- Needs human review:
- Knowledge coverage status:
- Semantic draft richness status:
- Grounding status:
- Modality review status:
- Formula/derivation coverage status:
- Carried forward:
- Closure handoff:
- Next action:

Do not use `pass` when the compare gate was not actually run. Use the
validation note phrase `compare gate not enabled` when no compare report exists.

## Input Artifacts

| artifact | path | status | notes |
| --- | --- | --- | --- |
| source inventory | raw/source-inventory.md | present/missing/not-in-scope |  |
| source packet | raw/derived/source-id/source.md | present/missing/not-in-scope |  |
| raw/rendered/external reading notes | reports/wiki-construction-analysis.md or raw/derived/source-id/media/ | present/missing/not-in-scope |  |
| claim/evidence map | reports/review/claim-evidence-map.md | present/missing/not-in-scope |  |
| wiki construction analysis | reports/wiki-construction-analysis.md | present/missing/not-in-scope |  |
| wiki overview | wiki/overview.md | present/missing/not-in-scope |  |
| wiki index | wiki/index.md | present/missing/not-in-scope |  |
| wiki log | wiki/log.md | present/missing/not-in-scope |  |
| validation note | reports/validation/replace-me.md | present/missing/not-in-scope |  |
| review queue | reports/review/review-queue.md | present/missing/not-in-scope |  |

## Check Matrix

| check | category | result | blocking | evidence |
| --- | --- | --- | --- | --- |
| source coverage | deterministic/manual-protocol | pass/fail/needs-review/not-enabled | yes/no |  |
| semantic draft richness | manual-protocol/human-review | pass/fail/needs-review/not-enabled | yes/no |  |
| grounding pass | manual-protocol/human-review | pass/fail/needs-review/not-enabled | yes/no |  |
| claim coverage | deterministic/manual-protocol/human-review | pass/fail/needs-review/not-enabled | yes/no |  |
| modality coverage | manual-protocol/human-review | pass/fail/needs-review/not-enabled | yes/no |  |
| link and index integrity | deterministic/manual-protocol | pass/fail/needs-review/not-enabled | yes/no |  |
| omission review | human-review/manual-protocol | pass/fail/needs-review/not-enabled | yes/no |  |
| contradiction review | human-review | pass/fail/needs-review/not-enabled | yes/no |  |

Categories:

- `deterministic`: mechanical check can decide.
- `manual-protocol`: fixed checklist was followed and recorded.
- `human-review`: semantic judgment is required.

## Source Coverage

Coverage is not copying. Use this section to explain the disposition of source
material, not to force every paragraph, slide, or table into wiki prose.

| source_id | packet_path | source_scope | coverage_unit | wiki_coverage | disposition | reason | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| source-id | raw/derived/source-id/source.md | slides/pages/sections | slide/page/group | wiki/chapters/replace-me.md | covered/weak/deferred/omitted/out-of-scope/review/blocked |  | pass/needs-review/fail/none |  |

Disposition values:

- `covered`: represented in accepted wiki pages or reports at the right level
  of detail.
- `weak`: represented, but too shallow, overgeneralized, poorly sourced, or
  risky.
- `deferred`: intentionally left for a later planned round.
- `omitted`: intentionally excluded from wiki construction for a recorded
  reason.
- `out-of-scope`: outside the round's fixed input or workspace purpose.
- `review`: routed to human review before wiki acceptance.
- `blocked`: cannot be judged because required input, extraction, anchor, or
  context is missing.

## Anchor Disposition

Use `<source_id>#<anchor_id>` references.

| source_ref | location | content_kind | importance | disposition | wiki_target | report_or_review_target | reason | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | slide/page/section | text/chart/table/image | core/supporting/reference/decorative/unknown | covered/weak/deferred/omitted/out-of-scope/review/blocked | wiki/chapters/replace-me.md | reports/review/review-queue.md |  | pass/needs-review/fail/none |  |

For large PPT or document sources, decorative or repeated anchors may be
grouped. Core chart, table, formula, diagram, or claim-bearing anchors should
not be hidden inside a group without a reason.

For `full-round` document/PPT distillation, core material that is only covered
by a broad range summary should be marked `weak` or `review`, not `covered`.

## Wiki Page Coverage

| wiki_page | page_type | declared_source_scope | actual_source_refs | coverage_gaps | disposition | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| wiki/chapters/replace-me.md | chapter | source-id slides/pages/anchors | source-id#anchor-id |  | covered/weak/review/blocked | pass/needs-review/fail/none |  |

## Semantic Draft Coverage

Use this section when the round produced a semantic draft or high-density
reading notes. Important draft units should not disappear silently just because
the final wiki page is shorter.

| draft_unit | draft_ref | source_refs | wiki_target | grounding_state | reason | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| formula/derivation/example/table/definition | reports/wiki-construction-analysis.md#replace-me | source-id#anchor-id | wiki/chapters/replace-me.md | grounded/candidate-derived/reviewed/deferred/rejected |  | pass/needs-review/fail/none |  |

## Claim Coverage

Focus on important claims, not every sentence.

| claim_id | claim_summary | claim_type | evidence_refs | wiki_target | support_status | generated_state | review_item_id | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| cl-001 | Replace this row. | definition/design-rule/formula/comparison | source-id#anchor-id or ev-001 | wiki/chapters/replace-me.md | supported/weak/unsupported/contested/generated-derived/reviewed-generated/needs-review/not-in-scope | source-derived/extracted-with-tool/generated/reviewed-generated/unsupported-or-unknown |  | pass/needs-review/fail/none |  |

Do not mark a claim `supported` only because the wiki prose is clean. Evidence
must support the actual claim wording.

For technical sources, important formulas, equations, variables, and derivation
steps should appear here as formula or design-rule claims when they support the
accepted wiki knowledge. If they are unreadable, omitted, or only visually
routed, mark support as `weak`, `needs-review`, or `unsupported`.

## Modality Coverage

| source_ref | modality | modality_state | generated_field | wiki_or_report_handling | related_claims | review_required | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | text/ocr_text/chart/table/image/diagram/formula/code/layout | source-derived/extracted-with-tool/generated/reviewed-generated/skipped/failed/unsupported-or-unknown | chart_summary/image_caption/table_repair/formula_recognition | wiki/report/review/deferred | cl-001 | yes/no | pass/needs-review/fail/none |  |

Generated or model-assisted modality output that supports an important claim
usually needs review unless an accepted review decision exists.

Formula recognition and derivation reconstruction are modality issues only
when they do not affect accepted knowledge. If accepted wiki prose depends on
them, reflect the gap in Claim Coverage and Knowledge coverage status too.

## Link, Index, Overview, And Log Checks

- Index entries checked:
- Broken links:
- Stale index entries:
- Overview refresh status:
- Wiki log status:
- Active reports linked from index:
- Notes:

## Omissions And Weak Coverage

Acceptable omission reasons include `decorative`, `duplicate`,
`out-of-scope`, `low-value`, `deferred`, `blocked`, and `superseded`.

| source_ref | issue | importance | omission_reason | why_it_matters | disposition | status_impact | next_action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | omitted/weak/deferred/out-of-scope | core/supporting/reference/decorative/unknown | decorative/duplicate/out-of-scope/low-value/deferred/blocked/superseded | Replace this row. | fix/review/carry-forward/not-in-scope | pass/needs-review/fail/none |  |

Unsafe omissions:

- no reason recorded
- core or unknown source material omitted without review
- generated interpretation kept while the source anchor is omitted
- omitted material contradicts accepted wiki prose

## Contradictions And Unsupported Statements

### Unsupported Statements

| item_id | statement_ref | statement_summary | source_refs_checked | support_gap | proposed_action | status_impact |
| --- | --- | --- | --- | --- | --- | --- |
| cmp-001 | cl-001 or wiki/chapters/replace-me.md#heading | Replace this row. | source-id#anchor-id | missing/partial/generated-only/stale/contradictory | revise/remove/narrow/review/defer/add-evidence | needs-review/fail/none |

### Contradictions

| issue_id | conflict_type | side_a | side_b | source_refs | wiki_impact | decision_needed | status_impact | next_action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ctr-001 | source-vs-source/source-vs-wiki/claim-vs-claim/wiki-vs-wiki/generated-vs-source/old-review-vs-new-source |  |  | source-id#anchor-id | wiki/chapters/replace-me.md | Replace this row. | needs-review/fail/none |  |

Do not resolve contradictions by model preference. Use an accepted source
priority rule or route to review.

## Review Items

| review_item_id | type | origin | source_refs | affected_target | status | blocking_level | decision_needed | owner_or_next_action | target_round_or_condition |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| rv-001 | generated-chart-summary | cmp-001 or this report | source-id#anchor-id | wiki/chapters/replace-me.md | open/in-review/resolved/dismissed/carried-forward/blocked/stale | blocking/nonblocking/informational | Replace this row. |  |  |

## Review Lifecycle Summary

- Open review items:
- In-review items:
- Resolved this round:
- Dismissed this round:
- Carried-forward blocking:
- Carried-forward nonblocking:
- Stale review items:
- Review items re-entered from earlier rounds:
- Blocking level changes:

## Carried-Forward Review

| review_item_id | reason | blocking_level | owner_or_next_action | target_round_or_condition | blocks_pass | affected_artifacts |
| --- | --- | --- | --- | --- | --- | --- |
| rv-001 | Replace this row. | blocking/nonblocking/informational |  |  | yes/no |  |

Blocking carried-forward review prevents `pass`. Nonblocking carried-forward
review needs a reason and next action before the round may advance.

## Round Closure Handoff

- Suggested closure decision: `close-pass`, `close-with-review`, or `do-not-close`
- Validation note:
- Knowledge coverage supports closure: yes/no
- Semantic draft richness supports closure: yes/no
- Grounding supports closure: yes/no
- Modality review supports closure: yes/no
- Formula/derivation coverage supports closure: yes/no
- Index update or no-change reason:
- Overview update or no-change reason:
- Wiki log entry:
- Active reports or review queues to link from index:
- Required fixes before closure:
- Next round may accept carried-forward review: yes/no

## Decision And Next Actions

- Final status:
- May round advance:
- Closure decision:
- Required fixes before advance:
- Review items to resolve:
- Review items carried forward:
- Follow-up round:

## Notes

This report is a quality gate artifact. It is not a wiki page, source packet,
or instruction to silently rewrite accepted knowledge.

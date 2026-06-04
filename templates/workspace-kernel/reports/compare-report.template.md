# Compare Report

## Round Scope

- Round plan:
- Date:
- Compare report id:
- Status: `pass`, `needs-review`, or `fail`
- Scope statement:
- Source packets in scope:
- Source range in scope:
- Out of scope:
- Scope exclusion reason:

## Status Summary

- Decision:
- Blocking findings:
- Needs human review:
- Carried forward:
- Next action:

Do not use `pass` when the compare gate was not actually run. Use the
validation note phrase `compare gate not enabled` when no compare report exists.

## Input Artifacts

| artifact | path | status | notes |
| --- | --- | --- | --- |
| source inventory | raw/source-inventory.md | present/missing/not-in-scope |  |
| source packet | raw/derived/source-id/source.md | present/missing/not-in-scope |  |
| claim/evidence map | reports/review/claim-evidence-map.md | present/missing/not-in-scope |  |
| wiki construction analysis | reports/wiki-construction-analysis.md | present/missing/not-in-scope |  |
| wiki overview | wiki/overview.md | present/missing/not-in-scope |  |
| wiki index | wiki/index.md | present/missing/not-in-scope |  |
| wiki log | wiki/log.md | present/missing/not-in-scope |  |

## Check Matrix

| check | category | result | blocking | evidence |
| --- | --- | --- | --- | --- |
| source coverage | deterministic/manual-protocol | pass/fail/needs-review/not-enabled | yes/no |  |
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

## Source Packet And Anchor Coverage

Use `<source_id>#<anchor_id>` references.

| source_ref | location | content_kind | importance | disposition | wiki_target | report_or_review_target | reason | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | slide/page/section | text/chart/table/image | core/supporting/reference/decorative/unknown | covered/weak/deferred/omitted/out-of-scope/review/blocked | wiki/chapters/replace-me.md | reports/review/review-queue.md |  | pass/needs-review/fail/none |  |

For large PPT or document sources, decorative or repeated anchors may be
grouped. Core chart, table, formula, diagram, or claim-bearing anchors should
not be hidden inside a group without a reason.

## Wiki Page Coverage

| wiki_page | page_type | declared_source_scope | actual_source_refs | coverage_gaps | disposition | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| wiki/chapters/replace-me.md | chapter | source-id slides/pages/anchors | source-id#anchor-id |  | covered/weak/review/blocked | pass/needs-review/fail/none |  |

## Claim Coverage

| claim_id | claim summary | evidence_refs | wiki_target | status | notes |
| --- | --- | --- | --- | --- | --- |
| cl-001 | Replace this row. | source-id#anchor-id or ev-001 | wiki/chapters/replace-me.md | supported/unsupported/contested/needs-review |  |

## Modality Coverage

| source_ref | modality | extraction state | wiki or report handling | generated | review_required | notes |
| --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | text/chart/table/image/formula | extracted/generated/skipped/failed | wiki/report/review/deferred | yes/no | yes/no |  |

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

| item_id | claim_or_page | source_refs | issue | status | next_action |
| --- | --- | --- | --- | --- | --- |
| cmp-001 | cl-001 or wiki page path | source-id#anchor-id | contradiction/unsupported/uncertain | needs-review/fail |  |

## Review Items

| review_item_id | type | source_refs | affected_target | decision_needed | blocking | next_action |
| --- | --- | --- | --- | --- | --- | --- |
| rv-001 | generated-chart-summary | source-id#anchor-id | wiki/chapters/replace-me.md | Replace this row. | yes/no |  |

## Carried-Forward Review

| review_item_id | reason | blocking_level | owner_or_next_action | target_round_or_condition |
| --- | --- | --- | --- | --- |
| rv-001 | Replace this row. | blocking/nonblocking |  |  |

## Decision And Next Actions

- Final status:
- May round advance:
- Required fixes before advance:
- Review items to resolve:
- Review items carried forward:
- Follow-up round:

## Notes

This report is a quality gate artifact. It is not a wiki page, source packet,
or instruction to silently rewrite accepted knowledge.

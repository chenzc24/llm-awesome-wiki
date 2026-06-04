# Compare Report

## Round Scope

- Round plan:
- Date:
- Compare report id:
- Status: `pass`, `needs-review`, or `fail`
- Scope statement:
- Out of scope:

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

| source_id | packet_path | source scope | wiki coverage | status | notes |
| --- | --- | --- | --- | --- | --- |
| source-id | raw/derived/source-id/source.md | slides/pages/sections | wiki/chapters/replace-me.md | covered/deferred/omitted/needs-review/fail |  |

## Source Packet And Anchor Coverage

Use `<source_id>#<anchor_id>` references.

| source_ref | source location | content kind | wiki target or disposition | status | notes |
| --- | --- | --- | --- | --- | --- |
| source-id#anchor-id | slide/page/section | text/chart/table/image | wiki/chapters/replace-me.md | covered/deferred/omitted/needs-review/fail |  |

## Wiki Page Coverage

| wiki_page | page_type | source_refs | claim_refs | status | notes |
| --- | --- | --- | --- | --- | --- |
| wiki/chapters/replace-me.md | chapter | source-id#anchor-id | cl-001 | covered/weak/unsupported/needs-review |  |

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

| source_ref | issue | why it matters | disposition | blocking |
| --- | --- | --- | --- | --- |
| source-id#anchor-id | omitted/weak/deferred | Replace this row. | fix/review/carry-forward/not-in-scope | yes/no |

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

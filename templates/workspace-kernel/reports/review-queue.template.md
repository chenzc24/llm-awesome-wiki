# Review Queue

## Scope

- Round plan:
- Date:
- Owner:
- Related compare report:
- Queue status: `active`, `needs-review`, `blocked`, or `closed`
- Last compare report inspected:

## Lifecycle Semantics

Statuses:

- `open`: decision still needed
- `in-review`: owner or reviewer is actively deciding
- `resolved`: decision recorded and affected artifacts updated or scheduled
- `dismissed`: concern no longer applies and reason is recorded
- `carried-forward`: unresolved but explicitly kept visible for a later round
- `blocked`: cannot be resolved until another artifact or review exists
- `stale`: previous decision may no longer be valid

Blocking levels:

- `blocking`: affected round cannot advance as `pass`
- `nonblocking`: round may advance only with explicit carry-forward reason and
  next action
- `informational`: tracked context that does not affect advancement

## Open Review Items

| review_item_id | type | origin | claim_id | source_refs | affected_target | status | blocking_level | decision_needed | owner_or_next_action | target_round_or_condition | opened_in_round | last_seen_in_compare |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| rv-001 | confirm | compare-report or finding id | cl-001 | source-id#anchor-id | wiki/chapters/replace-me.md | open/in-review/blocked/stale | blocking/nonblocking/informational | Replace this row. | Human review. |  |  |  |

## Generated Evidence Review

| review_item_id | generated_field | modality | source_ref | current_claim | decision_needed | status |
| --- | --- | --- | --- | --- | --- | --- |
| rv-002 | ocr_text/chart_summary/image_caption/table_repair/formula_recognition | text/chart/image/table/formula | source-id#anchor-id | Replace this row. | Confirm generated evidence. | open |

## Contradiction Review

| review_item_id | conflict_type | side_a | side_b | source_refs | decision_needed | status |
| --- | --- | --- | --- | --- | --- | --- |
| rv-004 | source-vs-source/source-vs-wiki/claim-vs-claim/wiki-vs-wiki/generated-vs-source/old-review-vs-new-source |  |  | source-id#anchor-id | Replace this row. | open |

## Resolved This Round

| review_item_id | decision | reviewer_or_decision_source | source_refs_reviewed | affected_artifacts | affected_claims | affected_wiki_pages | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| rv-003 | accepted/rejected/narrowed/deferred |  | source-id#anchor-id |  | cl-002 | wiki/chapters/replace-me.md |  |

## Dismissed This Round

| review_item_id | dismissal_reason | affected_artifacts | notes |
| --- | --- | --- | --- |
| rv-005 | duplicate/out-of-scope/incorrect-reference/superseded/informational-only/no-longer-relevant |  |  |

## Carried Forward

| review_item_id | reason | blocking_level | owner_or_next_action | target_round_or_condition | affected_artifacts | blocks_pass |
| --- | --- | --- | --- | --- | --- | --- |
| rv-001 | Replace this row. | blocking/nonblocking/informational |  |  |  | yes/no |

## Stale Or Re-Entered

| review_item_id | stale_or_reentry_reason | changed_artifact | new_compare_finding | next_action |
| --- | --- | --- | --- | --- |
| rv-006 | source packet changed / claim wording changed / wiki page changed / target round passed |  | cmp-001 |  |

## Notes

Keep this queue short. Put readable explanations in wiki chapters and detailed
support relationships in the claim/evidence map.

Do not clear a review item just because the wiki prose looks complete. A
carried-forward item needs a reason and next action.

Blocking carried-forward items prevent `pass`.
